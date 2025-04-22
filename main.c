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
  Window *windows;
  unsigned char windowCount;
  unsigned char focusedIdx;
  _Bool *isMapped;
} Desktop;
static Desktop *desktops[MAX_DESKTOPS] = {NULL};
static Display *dpy;
static Window root;
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
static void switchDesktop(unsigned char idx);
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
static Desktop *getDesktop(unsigned char idx);
static void addWindowToDesktop(Desktop *d, Window w);
static void removeWindowFromDesktop(Desktop *d, unsigned char idx);
void unmapCurrentDesktop(void);
void mapNewDesktop(unsigned char idx);
int hasWindows(unsigned char idx);
void deleteDesktopIfNeeded(unsigned char idx);
static inline int detachWindowFromDesktop(Window w, Desktop *d);
static void mapWindowToDesktop(Window win);
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
static Desktop *getDesktop(unsigned char idx) {
  if (idx >= MAX_DESKTOPS) die("desktop index out of range");
  if (!desktops[idx]) {
    desktops[idx] = calloc(1, sizeof(Desktop));
    if (!desktops[idx]) die("Out of memory allocating desktop");
  }
  return desktops[idx];
}
static void addWindowToDesktop(Desktop *d, Window w) {
  unsigned char n    = d->windowCount;
  Window *newWindows = realloc(d->windows, (n + 1) * sizeof(Window));
  if (!newWindows) {
    die("Out of memory!");
  }
  _Bool *newIsMapped = realloc(d->isMapped, (n + 1) * sizeof(_Bool));
  if (!newIsMapped) {
    free(newWindows);
    die("Out of memory!");
  }
  d->windows     = newWindows;
  d->isMapped    = newIsMapped;
  d->windows[n]  = w;
  d->isMapped[n] = 1;
  d->focusedIdx  = n;
  d->windowCount = n + 1;
}
static void removeWindowFromDesktop(Desktop *d, unsigned char idx) {
  unsigned char n = d->windowCount;
  if (idx >= n) return;
  for (unsigned char i = idx; i < n - 1; i++) {
    d->windows[i]  = d->windows[i + 1];
    d->isMapped[i] = d->isMapped[i + 1];
  }
  d->windowCount--;

  if (d->windowCount > 0) {
    Window *newWindows = realloc(d->windows, d->windowCount * sizeof(Window));
    _Bool *newIsMapped = realloc(d->isMapped, d->windowCount * sizeof(_Bool));
    if (!newWindows || !newIsMapped) {
      free(newWindows);
      free(newIsMapped);
      die("Out of memory!");
    }
    d->windows  = newWindows;
    d->isMapped = newIsMapped;
    if (d->focusedIdx >= d->windowCount) d->focusedIdx = d->windowCount - 1;
  } else {
    free(d->windows);
    free(d->isMapped);
    d->windows    = NULL;
    d->isMapped   = NULL;
    d->focusedIdx = 0;
  }
}
static void sigHandler(int sig) {
  (void)sig;
  running = 0;
}
void unmapCurrentDesktop() {
  Desktop *d = desktops[currentDesktop];
  if (d) {
    for (unsigned char i = 0; i < d->windowCount; i++) {
      XUnmapWindow(dpy, d->windows[i]);
    }
  }
}
void mapNewDesktop(unsigned char idx) {
  Desktop *d = desktops[idx];
  if (d) {
    for (unsigned char i = 0; i < d->windowCount; i++) {
      if (d->isMapped[i]) {
        XMapWindow(dpy, d->windows[i]);
      }
    }
    tileWindows();
  }
}
int hasWindows(unsigned char idx) {
  Desktop *d = desktops[idx];
  return (d && d->windowCount > 0);
}
void deleteDesktopIfNeeded(unsigned char idx) {
  Desktop *d = desktops[idx];
  if (d && d->windowCount == 0) {
    if (d->windows) {
      free(d->windows);
    }
    if (d->isMapped) {
      free(d->isMapped);
    }
    free(d);
    desktops[idx] = NULL;
  }
}
void switchDesktop(unsigned char idx) {
  if (idx >= MAX_DESKTOPS) {
    return;
  }
  if (currentDesktop == idx) {
    return;
  }
  unmapCurrentDesktop();
  deleteDesktopIfNeeded(currentDesktop);
  currentDesktop = idx;
  if (!hasWindows(currentDesktop)) {
    desktops[currentDesktop]              = malloc(sizeof(Desktop));
    desktops[currentDesktop]->windows     = malloc(sizeof(Window) * MAX_WINDOWS_PER_DESKTOP);
    desktops[currentDesktop]->windowCount = 0;
    desktops[currentDesktop]->focusedIdx  = 0;
    desktops[currentDesktop]->isMapped    = malloc(sizeof(_Bool) * MAX_WINDOWS_PER_DESKTOP);
  }
  mapNewDesktop(currentDesktop);
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
  Desktop *d = desktops[currentDesktop];
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
  Desktop *d = desktops[currentDesktop];
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
  return detachWindow(w, d->windows, &d->windowCount, &d->focusedIdx, NULL);
}
void moveWindowToDesktop(Window win, unsigned char dest) {
  if (dest >= MAX_DESKTOPS || dest == currentDesktop) return;
  Desktop *cur = desktops[currentDesktop];
  if (!cur) return;
  short idx = -1;
  for (unsigned char i = 0; i < cur->windowCount; i++) {
    if (cur->windows[i] == win) { 
      idx = i; 
      break; 
    }
  }
  if (idx < 0) return;
  _Bool wasMapped = cur->isMapped[idx];
  detachWindowFromDesktop(win, cur);
  if (hasWindows(currentDesktop)) {
    mapNewDesktop(currentDesktop);
  }
  Desktop *dst = getDesktop(dest);
  if (!dst) return;
  if (dst->windows == NULL) {
    dst->windows = calloc(MAX_WINDOWS_PER_DESKTOP, sizeof(Window));
    dst->isMapped = calloc(MAX_WINDOWS_PER_DESKTOP, sizeof(_Bool));
  }
  if (dst->windowCount >= MAX_WINDOWS_PER_DESKTOP) return;
  dst->windows[dst->windowCount] = win;
  dst->isMapped[dst->windowCount] = wasMapped;
  dst->windowCount++;
  XUnmapWindow(dpy, win);
 if (wasMapped) {
    XMapWindow(dpy, win);
  }
}
inline static void focusWindow(Window w) { XSetInputFocus(dpy, w, RevertToParent, CurrentTime); }
static void handleUnmapNotify(XEvent *e) {
  Window win = e->xunmap.window;
  Desktop *d = desktops[currentDesktop];
  for (unsigned char i = 0; i < d->windowCount; i++) {
    if (d->windows[i] == win) {
      removeWindowFromDesktop(d, i);
      XUnmapWindow(dpy, win);
      tileWindows();
      return;
    }
  }
}
static void handleDestroyNotify(XEvent *e) {
  Window win = e->xdestroywindow.window;
  Desktop *d = desktops[currentDesktop];
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
  for (unsigned char i = 0; i < MAX_DESKTOPS; i++) {
    Desktop *d = desktops[i];
    if (!d) continue;
    free(d->windows);
    free(d->isMapped);
    free(d);
  }
  XCloseDisplay(dpy);
}
static void tileWindows(void) {
  Desktop *d          = desktops[currentDesktop];
  unsigned char count = d->windowCount;
  if (count == 0) return;
  unsigned char masterCount = count > 1 ? 1 : 0;
  unsigned char stackCount  = count - masterCount;
  int masterWidth           = (screen_width + (resizeDelta << 1)) >> 1;
  if (masterWidth < 100) masterWidth = 100;
  if (masterWidth > screen_width - 100) masterWidth = screen_width - 100;
  int stackWidth   = screen_width - masterWidth;
  int masterHeight = masterCount ? screen_height / masterCount : screen_height;
  int stackHeight  = stackCount ? screen_height / stackCount : screen_height;
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
  Desktop *d = getDesktop(currentDesktop);
  addWindowToDesktop(d, win);
  XMapWindow(dpy, win);
  focusWindow(win);
  tileWindows();
}
static void handleMapRequest(XEvent *e) {
  XMapRequestEvent *ev = &e->xmaprequest;
  mapWindowToDesktop(ev->window);
}
static inline int detachWindow(Window w, Window *windows, unsigned char *windowCount,
                               unsigned char *focusedIdx, _Bool *isMapped) {
  for (unsigned char i = 0; i < *windowCount; i++) {
    if (windows[i] == w) {
      if (i < *windowCount - 1) {
        for (unsigned char j = i; j < *windowCount - 1; j++) {
          windows[j]  = windows[j + 1];
          isMapped[j] = isMapped[j + 1];
        }
      }
      (*windowCount)--;
      if (*focusedIdx >= *windowCount) *focusedIdx = *windowCount ? *windowCount - 1 : 0;
      return 1;
    }
  }
  return 0;
}
static void handleMapNotify(XEvent *e) {
  XMapEvent *ev = &e->xmap;
  Desktop *d    = desktops[currentDesktop];
  for (unsigned char i = 0; i < d->windowCount; i++) {
    if (d->windows[i] == ev->window && !d->isMapped[i]) {
      d->isMapped[i] = 1;
      tileWindows();
      break;
    }
  }
}
