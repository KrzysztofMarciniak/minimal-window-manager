#include <X11/XF86keysym.h>
#include <X11/XKBlib.h>
#include <X11/Xlib.h>
#include <X11/keysym.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/select.h>
#include <unistd.h>
#define RESIZE_STEP 50
#define MAX_DESKTOPS 9           // 256 limit
#define MAX_WINDOWS_PER_DESKTOP 6// 256 limit
#define MOD_KEY Mod4Mask
#define ARRAY_LEN(arr) (sizeof(arr) / sizeof((arr)[0]))
typedef struct {
        KeySym keysym;
        const char *command;
} AppLauncher;
static const AppLauncher launchers[] = {{XK_Return, "st"},
                                        {XK_p,
                                         "dmenu_run -m '0' -nb '#000000' -nf '#ffffff' -sb "
                                         "'#ffffff' -sf '#000000'"},
                                        {XF86XK_AudioRaiseVolume, AUDIO_SCRIPT " +"},
                                        {XF86XK_AudioLowerVolume, AUDIO_SCRIPT " -"},
                                        {XF86XK_AudioMicMute, AUDIO_SCRIPT " mic"},
                                        {XF86XK_AudioMute, AUDIO_SCRIPT " aud"}};
typedef struct {
        Window windows[MAX_WINDOWS_PER_DESKTOP];
        unsigned char windowCount;
        unsigned char focusedIdx;
} Desktop;
static Display *dpy;
static Bool IsSwitching = False;
static Window root;
static Desktop desktops[MAX_DESKTOPS];
static unsigned char currentDesktop  = 0;
static volatile sig_atomic_t running = 1;
// screen resolution fits within 0–65,535 range, too large for unsigned char
// (0–255) but safe in unsigned short
static unsigned short screen_width, screen_height;

// 'resizeDelta' stores pixel offsets in tileWindows.
// 'char' (-128 to 127) is too small to hold needed values,
// but 'short' (-32,768 to 32,767) provides sufficient range.
static short resizeDelta = 0;
static void setup(void);
static void run(void);
static void cleanup(void);
static void handleKeyPress(XEvent *e);
static void handleMapRequest(XEvent *e);
static void handleUnmapNotify(XEvent *e);
static void handleDestroyNotify(XEvent *e);
static void handleConfigureNotify(XEvent *e);
inline static void focusWindow(Window w);
static void tileWindows(void);
static void switchDesktop(unsigned char desktop);
static void moveWindowToDesktop(Window win, unsigned char desktop);
static void grabKeys(void);
static void sigHandler(Bool);
// Must return int because XSetErrorHandler requires this signature
static int xerror(Display *, XErrorEvent *);
static void killFocusedWindow(void);
inline static void focusCycleWindow(Bool);
static void handleMapNotify(XEvent *e);
static void removeWindowFromDesktop(Window win, Desktop *d);
inline static void die(const char *msg);
int main(void) {
        signal(SIGTERM, sigHandler);
        signal(SIGINT, sigHandler);
        setup();
        run();
        cleanup();
}
inline static void die(const char *msg) {
        fprintf(stderr, "mwm: %s\n", msg);
        // Can't use write() here because it requires the message length,
        // which would force us to include string.h for strlen().
        // Also, we can't set a fixed buffer size since messages vary in length.
        exit(EXIT_FAILURE);
}
static void sigHandler(Bool sig) {
        (void)sig;
        running = 0;
}
static int xerror(Display *dpy, XErrorEvent *ee) {
        static Bool startup = True;
        if (startup) {
                startup = False;
                die("another window manager is already running");
                return -1;
        }
        (void)dpy;
        (void)ee;
        return 0;
}
static void setup(void) {
        if (!getenv("DISPLAY")) die("DISPLAY not set");
        dpy = XOpenDisplay(NULL);
        if (!dpy) die("cannot open display");
        root = DefaultRootWindow(dpy);
        XWindowAttributes attr;
        if (!XGetWindowAttributes(dpy, root, &attr)) die("cannot get root window attributes");
        screen_width  = attr.width;
        screen_height = attr.height;
        XSetErrorHandler(xerror);
        XSelectInput(dpy, root,
                     SubstructureRedirectMask | SubstructureNotifyMask | StructureNotifyMask);
        Cursor cursor = XCreateFontCursor(dpy, 68);
        if (cursor == None) die("failed to create cursor");
        XDefineCursor(dpy, root, cursor);
        XSetErrorHandler(xerror);
        grabKeys();
        XSync(dpy, False);
}
static void grabKey(KeySym keysym, unsigned int modifiers, Bool with_shift) {
        KeyCode code = XKeysymToKeycode(dpy, keysym);
        if (!code) return;
        XGrabKey(dpy, code, modifiers, root, True, GrabModeAsync, GrabModeAsync);
        if (with_shift) {
                XGrabKey(dpy, code, modifiers | ShiftMask, root, True, GrabModeAsync,
                         GrabModeAsync);
        }
}
static void grabKeys(void) {
        for (unsigned char i = 0; i < MAX_DESKTOPS; ++i) {
                grabKey(XK_1 + i, MOD_KEY, True);
        }
        KeySym wmKeys[] = {XK_q, XK_j, XK_k, XK_h, XK_l};
        for (unsigned char i = 0; i < ARRAY_LEN(wmKeys); ++i) {
                grabKey(wmKeys[i], MOD_KEY, True);
        }
        for (unsigned char i = 0; i < ARRAY_LEN(launchers); ++i) {
                grabKey(launchers[i].keysym, MOD_KEY, False);
        }
}
static void run(void) {
        XEvent e;
        fd_set fds;
        int xfd = ConnectionNumber(dpy);
        while (running) {
                while (XPending(dpy)) {
                        XNextEvent(dpy, &e);
                        switch (e.type) {
                                case KeyPress:
                                        handleKeyPress(&e);
                                        break;
                                case MapRequest:
                                        handleMapRequest(&e);
                                        break;
                                case MapNotify:
                                        handleMapNotify(&e);
                                        break;
                                case UnmapNotify:
                                        handleUnmapNotify(&e);
                                        break;
                                case DestroyNotify:
                                        handleDestroyNotify(&e);
                                        break;
                                case ConfigureNotify:
                                        handleConfigureNotify(&e);
                                        break;
                        }
                }
                FD_ZERO(&fds);
                FD_SET(xfd, &fds);
                if (select(xfd + 1, &fds, NULL, NULL, NULL) == -1 && errno != EINTR) break;
        }
}
static void handleConfigureNotify(XEvent *e) {
        XConfigureEvent *ev = &e->xconfigure;
        if (ev->window == root) {
                screen_width  = ev->width;
                screen_height = ev->height;
                tileWindows();
        }
}
static void killFocusedWindow(void) {
        Desktop *d = &desktops[currentDesktop];
        if (d->windowCount <= 0) return;
        Window win = d->windows[d->focusedIdx];
        if (win == None || win == root) return;
        Atom del        = XInternAtom(dpy, "WM_DELETE_WINDOW", False);
        Atom *protocols = NULL;
        int count;
        if (XGetWMProtocols(dpy, win, &protocols, &count)) {
                for (int i = 0; i < count; ++i) {
                        if (protocols[i] == del) {
                                XEvent ev;
                                for (unsigned int j = 0; j < sizeof(ev); ++j)
                                        ((unsigned char *)&ev)[j] = 0;
                                ev.type                 = ClientMessage;
                                ev.xclient.window       = win;
                                ev.xclient.message_type = XInternAtom(dpy, "WM_PROTOCOLS", False);
                                ev.xclient.format       = 32;
                                ev.xclient.data.l[0]    = del;
                                ev.xclient.data.l[1]    = CurrentTime;
                                XSendEvent(dpy, win, False, NoEventMask, &ev);
                                XFree(protocols);
                                XFlush(dpy);
                                return;
                        }
                }
                XFree(protocols);
        }
        XKillClient(dpy, win);
        XFlush(dpy);
}
inline static void focusCycleWindow(Bool forward) {
        Desktop *d      = &desktops[currentDesktop];
        unsigned char c = d->windowCount;
        if (c <= 1) return;
        short idx = d->focusedIdx + (forward ? 1 : -1);
        idx += c * (idx < 0);
        idx -= c * (idx >= c);
        d->focusedIdx = idx;
        focusWindow(d->windows[idx]);
}
static void handleKeyPress(XEvent *e) {
        XKeyEvent *ev      = &e->xkey;
        KeySym keysym      = XkbKeycodeToKeysym(dpy, ev->keycode, 0, 0);
        unsigned int state = ev->state;
        if (keysym == XK_q && state == (MOD_KEY | ShiftMask)) {
                running = 0;
                return;
        }
        if ((keysym == XK_h || keysym == XK_l) && state == (MOD_KEY | ShiftMask)) {
                resizeDelta += (keysym == XK_l) ? RESIZE_STEP : -RESIZE_STEP;
                tileWindows();
                return;
        }
        if (keysym == XK_q && state == MOD_KEY) {
                killFocusedWindow();
                return;
        }
        if ((keysym == XK_j || keysym == XK_k) && state == MOD_KEY) {
                focusCycleWindow(keysym == XK_j ? True : False);
                return;
        }
        if (keysym >= XK_1 && keysym <= XK_9) {
                unsigned char num = keysym - XK_1;
                Window focused;
                int revert_to;
                XGetInputFocus(dpy, &focused, &revert_to);
                if (state == MOD_KEY) {
                        switchDesktop(num);
                } else if (state == (MOD_KEY | ShiftMask) && focused != None && focused != root) {
                        moveWindowToDesktop(focused, num);
                }
                return;
        }
        const unsigned int launcherCount = sizeof(launchers) / sizeof(launchers[0]);
        for (unsigned int i = 0; i < launcherCount; i++) {
                if (keysym == launchers[i].keysym && state == MOD_KEY) {
                        if (fork() == 0) {
                                setsid();
                                close(0);
                                close(1);
                                close(2);
                                int devnull = open("/dev/null", O_RDWR);
                                if (devnull >= 0) {
                                        dup2(devnull, STDIN_FILENO);
                                        dup2(devnull, STDOUT_FILENO);
                                        dup2(devnull, STDERR_FILENO);
                                        if (devnull > 2) close(devnull);
                                }
                                execl("/bin/sh", "sh", "-c", launchers[i].command, NULL);
                                _exit(EXIT_FAILURE);
                        }
                        return;
                }
        }
}
static void moveWindowToDesktop(Window win, unsigned char desktop) {
        if (desktop >= MAX_DESKTOPS || desktop == currentDesktop) return;
        Desktop *target = &desktops[desktop];
        if (target->windowCount >= MAX_WINDOWS_PER_DESKTOP) return;
        Desktop *current = &desktops[currentDesktop];
        short windowIdx  = -1;
        for (unsigned char i = 0; i < current->windowCount; i++) {
                if (current->windows[i] == win) {
                        windowIdx = i;
                        break;
                }
        }
        if (windowIdx == -1) return;
        removeWindowFromDesktop(win, current);
        unsigned char newIdx    = target->windowCount;
        target->windows[newIdx] = win;
        target->windowCount++;
        XUnmapWindow(dpy, win);
        tileWindows();
}
inline static void focusWindow(Window w) { XSetInputFocus(dpy, w, RevertToParent, CurrentTime); }
static void removeWindowFromDesktop(Window win, Desktop *d) {
        for (unsigned char i = 0; i < d->windowCount; i++) {
                if (d->windows[i] == win) {
                        for (unsigned char j = i; j < d->windowCount - 1; j++) {
                                d->windows[j] = d->windows[j + 1];
                        }
                        d->windowCount--;
                        if (d->focusedIdx >= d->windowCount && d->windowCount > 0) {
                                d->focusedIdx = d->windowCount - 1;
                        }
                        break;
                }
        }
}
static void handleUnmapNotify(XEvent *e) {
        if (IsSwitching) return;
        Window win = e->xunmap.window;
        Desktop *d = &desktops[currentDesktop];
        for (unsigned char i = 0; i < d->windowCount; i++) {
                if (d->windows[i] == win) {
                        if (i == d->focusedIdx && d->windowCount > 1) {
                                d->focusedIdx = (i + 1) % d->windowCount;
                                focusWindow(d->windows[d->focusedIdx]);
                        }
                        removeWindowFromDesktop(win, d);
                        tileWindows();
                        return;
                }
        }
}
static void handleDestroyNotify(XEvent *e) {
        Window win = e->xdestroywindow.window;
        for (unsigned char d_idx = 0; d_idx < MAX_DESKTOPS; d_idx++) {
                removeWindowFromDesktop(win, &desktops[d_idx]);
                if (d_idx == currentDesktop) {
                        tileWindows();
                }
        }
}
static void cleanup(void) {
        for (unsigned char d = 0; d < MAX_DESKTOPS; d++) {
                for (unsigned char i = 0; i < desktops[d].windowCount; i++) {
                        XUnmapWindow(dpy, desktops[d].windows[i]);
                }
        }
        XCloseDisplay(dpy);
}
static void tileWindows(void) {
        Desktop *d = &desktops[currentDesktop];
        if (d->windowCount == 0) return;
        if (d->windowCount == 1) {
                XMoveResizeWindow(dpy, d->windows[0], 0, 0, screen_width, screen_height);
                XRaiseWindow(dpy, d->windows[0]);
                return;
        }
        unsigned short masterWidth = (screen_width + (resizeDelta << 1)) >> 1;
        masterWidth                = (masterWidth < 100)                  ? 100
                                     : (masterWidth > screen_width - 100) ? screen_width - 100
                                                                          : masterWidth;
        unsigned short stackWidth  = screen_width - masterWidth;
        unsigned short stackHeight = screen_height / (d->windowCount - 1);
        XMoveResizeWindow(dpy, d->windows[0], 0, 0, masterWidth, screen_height);
        for (unsigned char i = 1; i < d->windowCount; i++) {
                XMoveResizeWindow(dpy, d->windows[i], masterWidth, (i - 1) * stackHeight,
                                  stackWidth, stackHeight);
        }
        XRaiseWindow(dpy, d->windows[d->focusedIdx]);
}
static void mapWindowToDesktop(Window win) {
        Desktop *d = &desktops[currentDesktop];
        if (d->windowCount < MAX_WINDOWS_PER_DESKTOP) {
                unsigned char idx = d->windowCount;
                d->windows[idx]   = win;
                d->windowCount++;
                d->focusedIdx = idx;
                XMapWindow(dpy, win);
                focusWindow(win);
                tileWindows();
        } else {
                XKillClient(dpy, win);
                XFlush(dpy);
        }
}
static void handleMapRequest(XEvent *e) {
        XMapRequestEvent *ev = &e->xmaprequest;
        mapWindowToDesktop(ev->window);
}
static void handleMapNotify(XEvent *e) {
        XMapEvent *ev = &e->xmap;
        Desktop *d    = &desktops[currentDesktop];
        for (unsigned char i = 0; i < d->windowCount; i++) {
                if (d->windows[i] == ev->window) {
                        tileWindows();
                        break;
                }
        }
}
static void switchDesktop(unsigned char desktop) {
        if (desktop == currentDesktop || desktop >= MAX_DESKTOPS) return;
        if (IsSwitching) return;
        IsSwitching      = 1;
        Desktop *current = &desktops[currentDesktop];
        for (unsigned char i = 0; i < current->windowCount; i++) {
                XUnmapWindow(dpy, current->windows[i]);
        }
        currentDesktop  = desktop;
        Desktop *target = &desktops[currentDesktop];
        for (unsigned char i = 0; i < target->windowCount; i++) {
                XMapWindow(dpy, target->windows[i]);
        }
        tileWindows();
        if (target->windowCount > 0) {
                focusWindow(target->windows[target->focusedIdx]);
        }
        IsSwitching = 0;
}