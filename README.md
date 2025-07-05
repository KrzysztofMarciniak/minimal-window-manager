# Minimal Window Manager (MWM)

<img src="https://github.com/user-attachments/assets/b6e484eb-5b16-4d88-b6f6-e14f968e2d1d" alt="MWM" width="250" height="250">

MWM (Minimal Window Manager) is a lightweight, minimalistic window manager written in **C**.
 
It was designed with the following guiding principles:
* < 500 lines of code (clang-formatted).
* 9 Desktops.
* High Performance.
* No status bar, Borders or Gaps. [(if you want them, use mwm+)](https://github.com/KrzysztofMarciniak/minimal-window-manager-plus)
* No floating windows.
* No compiler warnings, clean builds only.
* One file.

![screenshot](screenshot.png)
## Stats

```bash
        linux-vdso.so.1 (0x00007ffd11bb1000)
        libX11.so.6 => /usr/lib64/libX11.so.6 (0x00007f8c0f5ad000)
        libc.so.6 => /usr/lib64/libc.so.6 (0x00007f8c0f3c1000)
        libxcb.so.1 => /usr/lib64/libxcb.so.1 (0x00007f8c0f394000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f8c0f72a000)
        libXau.so.6 => /usr/lib64/libXau.so.6 (0x00007f8c0f38e000)
        libXdmcp.so.6 => /usr/lib64/libXdmcp.so.6 (0x00007f8c0f386000)
    FILE SIZE        VM SIZE
 --------------  --------------
  32.3%  5.85Ki   0.0%       0    [Unmapped]
  19.3%  3.50Ki  30.6%  3.44Ki    .text
   5.9%  1.07Ki   9.0%  1.01Ki    .dynsym
   0.0%       0   9.3%  1.05Ki    .bss
   5.6%  1.01Ki   2.5%     293    [14 Others]
   5.1%     952   7.7%     888    .rela.plt
   4.3%     800   7.0%     800    [LOAD #2 [R]]
   3.6%     672   5.3%     608    .plt
   3.6%     666   5.2%     602    .dynstr
   3.5%     656   5.1%     592    .plt.sec
   3.1%     576   4.5%     512    .dynamic
   2.3%     424   3.1%     360    .got
   2.3%     424   3.1%     360    .rela.dyn
   2.3%     424   3.1%     360    .rodata
   1.7%     324   0.0%       0    .shstrtab
   1.2%     224   1.4%     160    .eh_frame
   0.9%     160   0.8%      96    .data.rel.ro
   0.8%     150   0.7%      86    .gnu.version
   0.8%     144   0.7%      80    .gnu.version_r
   0.8%     144   0.7%      80    .note.gnu.property
   0.7%     128   0.0%       0    [ELF Headers]
 100.0%  18.1Ki 100.0%  11.2Ki    TOTAL
```

## Getting Started

### Media Keys
Below are two examples for handling media keys. You can modify these to suit your needs. To use them out of the box, you will need [herbe](https://github.com/dudik/herbe), or modify (`notifications_daemon="/usr/local/bin/herbe"` - .sh) or (`#define NOTIFICATIONS_DAEMON "/usr/local/bin/herbe"` - .c)
Makefile:
```bash
-DAUDIO_SCRIPT="\"$(shell pwd)/audio.sh\""
```
or (after compiling `gcc audio.c -o audio`):
```bash
-DAUDIO_SCRIPT="\"$(shell pwd)/audio\""
```

### Keyboard Shortcuts

#### Window Management
- **Mod + Enter**: Launch terminal
- **Mod + q**: Close focused window
- **Mod + Shift + q**: Exit MWM
- **Mod + j**: Focus left window
- **Mod + k**: Focus right window
- **Mod + Shift + l**: Increase window size
- **Mod + Shift + h**: Decrease window size

#### Desktop Navigation
- **Mod + [0-9]**: Switch to desktop [0-9]
- **Mod + Shift + [0-9]**: Move focused window to desktop [0-9]

#### Application Launcher
- **Mod + p**: Launch dmenu (application menu)

## Prerequisites
To build and run MWM, you'll need:
- A C compiler (e.g., `gcc`).
- `make` for building the project.
- A Linux-based environment with X11 support.

Optional, but recommended:
- `st` (simple terminal).
- `dmenu` (for launching applications).

### Building the Project
#### default (`recommended`) (lower in runtime memory but bigger disk size.):
1. Clone the repository:
```bash
git clone https://github.com/KrzysztofMarciniak/minimal-window-manager.git
```
2. Navigate to the project directory: 
```bash
cd minimal-window-manager
```
3. Install:
```bash
sudo make install
```
4. Add to xinitrc:

```bash
exec dbus-launch --sh-syntax --exit-with-session mwm
```
#### compressed (higher in runtime memory, smaller in disk size.):
0. You have to install [upx](https://github.com/upx/upx).
1. Clone the repository:
```bash
git clone https://github.com/KrzysztofMarciniak/minimal-window-manager.git
```
2. Navigate to the project directory: 
```bash
cd minimal-window-manager
```
3. Install the compressed version:
```bash
sudo make install_compressed
```
4. Add to xinitrc:
```bash
exec dbus-launch --sh-syntax --exit-with-session mwm.upx
```   text	   data	    bss	    dec	    hex	filename
