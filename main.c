#include <X11/XF86keysym.h>
#include <X11/XKBlib.h>
#include <X11/Xlib.h>
#include <X11/keysym.h>
#include <errno.h>
#include <signal.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/select.h>
#include <unistd.h>
#define RESIZE_STEP 50
#define MAX_DESKTOPS 9            // 256 limit
#define MAX_WINDOWS_PER_DESKTOP 12// 256 limit
#define P_CURRENT_DESKTOP (&desktops[currentDesktop])
#define P_DESKTOPS (&desktops[MAX_DESKTOPS])
#define MOD_KEY Mod4Mask
#ifndef AUDIO_SCRIPT
#define AUDIO_SCRIPT ""
#endif
typedef struct {
        KeySym keysym;
        const char *command;
} AppLauncher;
static AppLauncher launchers[6] = {{XK_Return, "st"},
                                   {XK_p,
                                    "dmenu_run -m '0' -nb '#000000' -nf '#ffffff' -sb "
                                    "'#ffffff' -sf '#000000'"},
                                   {XF86XK_AudioRaiseVolume, AUDIO_SCRIPT " +"},
                                   {XF86XK_AudioLowerVolume, AUDIO_SCRIPT " -"},
                                   {XF86XK_AudioMicMute, AUDIO_SCRIPT " mic"},
                                   {XF86XK_AudioMute, AUDIO_SCRIPT " aud"}};
typedef struct {// if we use 4 : bits on each, it will rise 0.2Ki
        Window windows[MAX_WINDOWS_PER_DESKTOP];
        unsigned char windowCount;
        unsigned char focusedIdx;
} Desktop;
static Display *dpy;
#define ARRAY_LEN(arr) (sizeof(arr) / sizeof((arr)[0]))
static _Bool IsSwitching = False;
static Desktop *desktops = NULL;
static Window root;
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
static void handleDestroyNotify(XEvent *e);
static void handleConfigureNotify(XEvent *e);
static void handleMapNotify(XEvent *e);
inline static void focusWindow(Window w);
static void tileWindows(void);
static void switchDesktop(unsigned char desktop);
static void moveWindowToDesktop(Window win, unsigned char desktop);
static void grabKeys(void);
static void sigHandler(Bool);// Bool = int, provided by x11
// Must return int because XSetErrorHandler requires this signature
static int xerror(Display *, XErrorEvent *);
static void killFocusedWindow(void);
inline static void focusCycleWindow(_Bool);// 1 bit
static void removeWindowFromDesktop(Window win, Desktop *d);
inline static void die(void);
inline static void initDesktops(void);
inline static void cleanupDesktops(void);
inline static void adjustFocusAfterRemoval(Desktop *d);
int main(void) {
        signal(SIGTERM, sigHandler);
        signal(SIGINT, sigHandler);
        setup();
        run();
        cleanup();
}
inline static void initDesktops(void) {
        desktops = mmap(NULL, sizeof(Desktop) * MAX_DESKTOPS, PROT_READ | PROT_WRITE,
                        MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
        if (desktops == MAP_FAILED) {
                __attribute__((unused)) ssize_t _ = write(2, "mwm:error mmap\n", 14);
                _exit(1);
        }
}
static inline void cleanupDesktops() { munmap(desktops, sizeof(Desktop) * MAX_DESKTOPS); }
inline static void die(void) {
        __attribute__((unused)) ssize_t _ = write(2, "mwm:error\n", 10);
        _exit(1);
}
static void sigHandler(Bool sig) {
        (void)sig;
        running = 0;
}
static int xerror(Display *dpy, XErrorEvent *ee) {
        static _Bool startup = True;
        if (startup) {
                startup = False;
                die();
                return -1;
        }
        (void)dpy;
        (void)ee;
        return 0;
}
static void setup(void) {
        if (!getenv("DISPLAY")) die();
        dpy = XOpenDisplay(NULL);
        if (!dpy) die();
        root = DefaultRootWindow(dpy);
        initDesktops();
        XWindowAttributes attr;
        if (!XGetWindowAttributes(dpy, root, &attr)) die();
        screen_width  = attr.width;
        screen_height = attr.height;
        XSetErrorHandler(xerror);
        XSelectInput(dpy, root,
                     SubstructureRedirectMask | SubstructureNotifyMask | StructureNotifyMask);
        Cursor cursor = XCreateFontCursor(dpy, 68);
        if (cursor == None) die();
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
        static const KeySym wmKeys[] = {XK_q, XK_j, XK_k, XK_h, XK_l};
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
                while (XPending(
                    dpy)) {// switches cost 0.01ki in .text, probably generating jump table.
                        XNextEvent(dpy, &e);
                        if (e.type == KeyPress)
                                handleKeyPress(&e);
                        else if (e.type == MapRequest)
                                handleMapRequest(&e);
                        else if (e.type == MapNotify)
                                handleMapNotify(&e);
                        else if (e.type == UnmapNotify) {
                                if (IsSwitching) return;
                                removeWindowFromDesktop(e.xunmap.window, P_CURRENT_DESKTOP);
                                tileWindows();
                        } else if (e.type == DestroyNotify)
                                handleDestroyNotify(&e);
                        else if (e.type == ConfigureNotify)
                                handleConfigureNotify(&e);
                }
                FD_ZERO(&fds);
                FD_SET(xfd, &fds);
                if (select(xfd + 1, &fds, NULL, NULL, NULL) == -1 && errno != EINTR) break;
        }
}
static void handleConfigureNotify(XEvent *e) {
        if (e->xconfigure.window != root) return;
        screen_width  = e->xconfigure.width;
        screen_height = e->xconfigure.height;
        tileWindows();
}
static void killFocusedWindow(void) {
        if (P_CURRENT_DESKTOP->windowCount <= 0) return;
        Window win = P_CURRENT_DESKTOP->windows[P_CURRENT_DESKTOP->focusedIdx];
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
inline static void focusCycleWindow(_Bool forward) {
        if (P_CURRENT_DESKTOP->windowCount <= 1) return;
        short idx = P_CURRENT_DESKTOP->focusedIdx + (forward ? 1 : -1);
        idx += P_CURRENT_DESKTOP->windowCount * (idx < 0);
        idx -= P_CURRENT_DESKTOP->windowCount * (idx >= P_CURRENT_DESKTOP->windowCount);
        P_CURRENT_DESKTOP->focusedIdx = idx;
        focusWindow(P_CURRENT_DESKTOP->windows[idx]);
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
        for (unsigned int i = 0; i < ARRAY_LEN(launchers); i++) {
                if (keysym == launchers[i].keysym && state == MOD_KEY) {
                        if (fork() == 0) {
                                setsid();
                                for (int fd = 0; fd <= 2; fd++) close(fd);
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
        short windowIdx = -1;
        for (unsigned char i = 0; i < P_CURRENT_DESKTOP->windowCount; i++) {
                if (P_CURRENT_DESKTOP->windows[i] == win) {
                        windowIdx = i;
                        break;
                }
        }
        if (windowIdx == -1) return;
        removeWindowFromDesktop(win, P_CURRENT_DESKTOP);
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
                        adjustFocusAfterRemoval(d);
                        break;
                }
        }
}
inline static void adjustFocusAfterRemoval(Desktop *d) {
        if (d->windowCount == 0) {
                return;
        }
        if (d->focusedIdx >= d->windowCount) {
                d->focusedIdx = d->windowCount - 1;
        }
        focusWindow(d->windows[d->focusedIdx]);
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
        cleanupDesktops();
        for (unsigned char d = 0; d < MAX_DESKTOPS; d++) {
                for (unsigned char i = 0; i < desktops[d].windowCount; i++) {
                        XUnmapWindow(dpy, desktops[d].windows[i]);
                }
        }
        XCloseDisplay(dpy);
}
static void tileWindows(void) {
        if (P_CURRENT_DESKTOP->windowCount == 0) return;
        if (P_CURRENT_DESKTOP->windowCount == 1) {
                XMoveResizeWindow(dpy, P_CURRENT_DESKTOP->windows[0], 0, 0, screen_width,
                                  screen_height);
                XRaiseWindow(dpy, P_CURRENT_DESKTOP->windows[0]);
                return;
        }
        unsigned short masterWidth = (screen_width + (resizeDelta << 1)) >> 1;
        masterWidth                = (masterWidth < 100)                  ? 100
                                     : (masterWidth > screen_width - 100) ? screen_width - 100
                                                                          : masterWidth;
        unsigned short stackWidth  = screen_width - masterWidth;
        unsigned short stackHeight = screen_height / (P_CURRENT_DESKTOP->windowCount - 1);
        XMoveResizeWindow(dpy, P_CURRENT_DESKTOP->windows[0], 0, 0, masterWidth, screen_height);
        for (unsigned char i = 1; i < P_CURRENT_DESKTOP->windowCount; i++) {
                XMoveResizeWindow(dpy, P_CURRENT_DESKTOP->windows[i], masterWidth,
                                  (i - 1) * stackHeight, stackWidth, stackHeight);
        }
        XRaiseWindow(dpy, P_CURRENT_DESKTOP->windows[P_CURRENT_DESKTOP->focusedIdx]);
}
static void mapWindowToDesktop(Window win) {
        if (P_CURRENT_DESKTOP->windowCount < MAX_WINDOWS_PER_DESKTOP) {
                unsigned char idx               = P_CURRENT_DESKTOP->windowCount;
                P_CURRENT_DESKTOP->windows[idx] = win;
                P_CURRENT_DESKTOP->windowCount++;
                P_CURRENT_DESKTOP->focusedIdx = idx;
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
        for (unsigned char i = 0; i < P_CURRENT_DESKTOP->windowCount; i++) {
                if (P_CURRENT_DESKTOP->windows[i] == ev->window) {
                        tileWindows();
                        break;
                }
        }
}
static void switchDesktop(unsigned char desktop) {
        if (desktop == currentDesktop || desktop >= MAX_DESKTOPS) return;
        if (IsSwitching) return;
        IsSwitching = 1;
        for (unsigned char i = 0; i < P_CURRENT_DESKTOP->windowCount; i++) {
                XUnmapWindow(dpy, P_CURRENT_DESKTOP->windows[i]);
        }
        currentDesktop = desktop;
        for (unsigned char i = 0; i < P_CURRENT_DESKTOP->windowCount; i++) {
                XMapWindow(dpy, P_CURRENT_DESKTOP->windows[i]);
        }
        tileWindows();
        if (P_CURRENT_DESKTOP->windowCount > 0) {
                focusWindow(P_CURRENT_DESKTOP->windows[P_CURRENT_DESKTOP->focusedIdx]);
        }
        IsSwitching = 0;
}