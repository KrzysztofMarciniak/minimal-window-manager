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
#define MAX_DESKTOPS 9
#define MAX_WINDOWS_PER_DESKTOP 6
#define MOD_KEY Mod4Mask

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
  _Bool isMapped[MAX_WINDOWS_PER_DESKTOP];
} Desktop;
static Display *dpy;
static _Bool IsSwitching = False;
static Window root;
static Desktop desktops[MAX_DESKTOPS];
static unsigned char currentDesktop  = 0;
static volatile sig_atomic_t running = 1;
static unsigned short screen_width, screen_height;
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
static void switchDesktop(int desktop);
static void moveWindowToDesktop(Window win, unsigned char desktop);
static void grabKeys(void);
static void sigHandler(int);
static int xerrorstart(Display *, XErrorEvent *);
static int xerror(Display *, XErrorEvent *);
static void killFocusedWindow(void);
static void focusCycleWindow(int);
static void handleMapNotify(XEvent *e);
inline static void die(const char *msg);
static inline int detachWindow(Window w, Window *windows, unsigned char *windowCount,
                               unsigned char *focusedIdx, _Bool *isMapped);

static short resizeDelta = 0;
int main(void) {
  signal(SIGTERM, sigHandler);
  signal(SIGINT, sigHandler);
  setup();
  run();
  cleanup();
}
inline static void die(const char *msg) {
  fprintf(stderr, "mwm: %s\n", msg);
  exit(EXIT_FAILURE);
}
static void sigHandler(int sig) {
  (void)sig;
  running = 0;
}
static int xerrorstart(Display *dpy __attribute__((unused)),
                       XErrorEvent *ee __attribute__((unused))) {
  die("another window manager is already running");
  return -1;
}
static int xerror(Display *dpy, XErrorEvent *ee) {
  (void)dpy;
  (void)ee;
  return 0;
}
static void setup(void) {
  if (!getenv("DISPLAY")) die("DISPLAY not set");
  if (!(dpy = XOpenDisplay(NULL))) die("cannot open display");
  root = DefaultRootWindow(dpy);
  for (unsigned char i = 0; i < MAX_DESKTOPS; i++) {
    desktops[i].windowCount = 0;
    desktops[i].focusedIdx  = 0;
    for (unsigned char j = 0; j < MAX_WINDOWS_PER_DESKTOP; j++) {
      desktops[i].windows[j]  = None;
      desktops[i].isMapped[j] = 0;
    }
  }
  XWindowAttributes attr;
  XGetWindowAttributes(dpy, root, &attr);
  screen_width  = attr.width;
  screen_height = attr.height;
  XSetErrorHandler(xerrorstart);
  XSelectInput(dpy, root, SubstructureRedirectMask | SubstructureNotifyMask | StructureNotifyMask);
  Cursor cursor = XCreateFontCursor(dpy, 68);
  XDefineCursor(dpy, root, cursor);
  XSync(dpy, False);
  XSetErrorHandler(xerror);
  grabKeys();
  XSync(dpy, False);
}
static void grabKeys(void) {
  const unsigned int modifiers[] = {MOD_KEY, MOD_KEY | ShiftMask};
  const unsigned char modCount   = sizeof(modifiers) / sizeof(modifiers[0]);
  KeyCode keycodes[40];
  int k = 0;
  for (unsigned char i = 0; i < MAX_DESKTOPS; i++) {
    keycodes[k++] = XKeysymToKeycode(dpy, XK_1 + i);
  }
  KeySym specialKeys[] = {XK_q, XK_j, XK_k, XK_h, XK_l};
  for (size_t i = 0; i < sizeof(specialKeys) / sizeof(specialKeys[0]); i++) {
    keycodes[k++] = XKeysymToKeycode(dpy, specialKeys[i]);
  }
  for (int i = 0; i < k; i++) {
    if (keycodes[i] == 0) continue;
    for (unsigned char j = 0; j < modCount; j++) {
      XGrabKey(dpy, keycodes[i], modifiers[j], root, True, GrabModeAsync, GrabModeAsync);
    }
  }
  const size_t launcherCount = sizeof(launchers) / sizeof(launchers[0]);
  for (size_t i = 0; i < launcherCount; i++) {
    KeyCode code = XKeysymToKeycode(dpy, launchers[i].keysym);
    if (code != 0) {
      XGrabKey(dpy, code, MOD_KEY, root, True, GrabModeAsync, GrabModeAsync);
    }
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
  Atom *p;
  int n;
  Atom del = XInternAtom(dpy, "WM_DELETE_WINDOW", False);
  if (XGetWMProtocols(dpy, win, &p, &n)) {
    while (n--)
      if (p[n] == del) goto send;
    XKillClient(dpy, win);
    XFree(p);
    return;
  }
  XEvent ev;
send:
  for (long unsigned int i = 0; i < sizeof(ev) / sizeof(long); i++) {
    ((long *)&ev)[i] = 0;
  }
  ev.type                 = ClientMessage;
  ev.xclient.window       = win;
  ev.xclient.message_type = XInternAtom(dpy, "WM_PROTOCOLS", False);
  ev.xclient.format       = 32;
  ev.xclient.data.l[0]    = del;
  ev.xclient.data.l[1]    = CurrentTime;
  XSendEvent(dpy, win, False, NoEventMask, &ev);
  XFree(p);
  XFlush(dpy);
}
static void focusCycleWindow(int direction) {
  Desktop *d = &desktops[currentDesktop];
  if (d->windowCount > 1) {
    d->focusedIdx = (d->focusedIdx + direction + d->windowCount) % d->windowCount;
    focusWindow(d->windows[d->focusedIdx]);
  }
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
    focusCycleWindow(keysym == XK_j ? 1 : -1);
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
  const size_t launcherCount = sizeof(launchers) / sizeof(launchers[0]);
  for (size_t i = 0; i < launcherCount; i++) {
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
static inline int detachWindowFromDesktop(Window w, Desktop *d) {
  if (!d) return 0;
  if (currentDesktop >= MAX_DESKTOPS || d->windowCount > MAX_WINDOWS_PER_DESKTOP) return 0;
  return detachWindow(w, d->windows, &d->windowCount, &d->focusedIdx, d->isMapped);
}
static inline int detachWindow(Window w, Window *windows, unsigned char *windowCount,
                               unsigned char *focusedIdx, _Bool *isMapped) {
  if (!windows || !windowCount || !focusedIdx) return 0;
  unsigned char count = *windowCount;
  if (count == 0 || count > MAX_WINDOWS_PER_DESKTOP) return 0;
  for (unsigned char i = 0; i < count; i++) {
    if (windows[i] == w) {
      if (i < count - 1) {
        for (unsigned char j = i; j < count - 1; j++) {
          windows[j] = windows[j + 1];
          if (isMapped) {
            isMapped[j] = isMapped[j + 1];
          }
        }
      }
      *windowCount = count - 1;
      if (*focusedIdx >= *windowCount) {
        *focusedIdx = *windowCount ? (*windowCount - 1) : 0;
      }
      return 1;
    }
  }
  return 0;
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
  _Bool wasMapped = current->isMapped[windowIdx];
  if (!detachWindowFromDesktop(win, current)) return;
  int newIdx               = target->windowCount;
  target->windows[newIdx]  = win;
  target->isMapped[newIdx] = wasMapped;
  target->windowCount++;
  XUnmapWindow(dpy, win);
  tileWindows();
}
inline static void focusWindow(Window w) { XSetInputFocus(dpy, w, RevertToParent, CurrentTime); }
static void handleUnmapNotify(XEvent *e) {
  if (IsSwitching) return;
  Window win = e->xunmap.window;
  Desktop *d = &desktops[currentDesktop];
  for (unsigned char i = 0; i < d->windowCount; i++) {
    if (d->windows[i] == win) {
      d->isMapped[i] = 0;
      XUnmapWindow(dpy, win);
      if (i == d->focusedIdx && d->windowCount > 1) {
        d->focusedIdx = (i + 1) % d->windowCount;
        focusWindow(d->windows[d->focusedIdx]);
      }
      for (unsigned char j = i; j < d->windowCount - 1; j++) {
        d->windows[j]  = d->windows[j + 1];
        d->isMapped[j] = d->isMapped[j + 1];
      }
      d->windowCount--;
      tileWindows();
      return;
    }
  }
}
static void handleDestroyNotify(XEvent *e) {
  Window win = e->xdestroywindow.window;
  Desktop *d = &desktops[currentDesktop];
  for (unsigned char i = 0; i < d->windowCount; i++) {
    if (d->windows[i] == win) {
      d->isMapped[i] = 0;
      d->windowCount--;
      for (unsigned char j = i; j < d->windowCount; j++) {
        d->windows[j]  = d->windows[j + 1];
        d->isMapped[j] = d->isMapped[j + 1];
      }
      tileWindows();
      break;
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
  Desktop *d          = &desktops[currentDesktop];
  unsigned char count = d->windowCount;
  if (count == 0) return;
  unsigned char masterCount = count > 1 ? 1 : 0;
  unsigned char stackCount  = count - masterCount;
  int masterWidth           = (screen_width + (resizeDelta << 1)) >> 1;
  if (masterWidth < 100) masterWidth = 100;
  if (masterWidth > screen_width - 100) masterWidth = screen_width - 100;
  int stackWidth   = screen_width - masterWidth;
  int masterHeight = screen_height / masterCount;
  int stackHeight  = screen_height / stackCount;
  if (count == 1) {
    XMoveResizeWindow(dpy, d->windows[0], 0, 0, screen_width, screen_height);
    XRaiseWindow(dpy, d->windows[0]);
    return;
  }
  if (masterCount > 0) {
    XMoveResizeWindow(dpy, d->windows[0], 0, 0, masterWidth, masterHeight);
  }
  for (unsigned char i = 0; i < stackCount; i++) {
    XMoveResizeWindow(dpy, d->windows[i + masterCount], masterWidth, i * stackHeight, stackWidth,
                      stackHeight);
  }
  XRaiseWindow(dpy, d->windows[0]);
}
static void mapWindowToDesktop(Window win) {
  Desktop *d = &desktops[currentDesktop];
  if (d->windowCount < MAX_WINDOWS_PER_DESKTOP) {
    int idx          = d->windowCount;
    d->windows[idx]  = win;
    d->isMapped[idx] = 1;
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
    if (d->windows[i] == ev->window && !d->isMapped[i]) {
      d->isMapped[i] = 1;
      tileWindows();
      break;
    }
  }
}static void switchDesktop(int desktop) {
  if (desktop == currentDesktop || desktop < 0 || desktop >= MAX_DESKTOPS) return;
  if (IsSwitching) return;
  IsSwitching = 1;
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