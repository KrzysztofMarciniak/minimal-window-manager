# Minimal Window Manager (MWM)

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
```
### statistics:
#### uncompressed:
* size:
```
   text    data     bss     dec     hex filename
   9111    1072      40   10223    27ef mwm
```
* bloaty:
```
    FILE SIZE        VM SIZE    
 --------------  -------------- 
  36.6%  9.27Ki   0.0%       0    [Unmapped]
  13.3%  3.36Ki  30.6%  3.30Ki    .text
   7.8%  1.98Ki   0.0%       0    .symtab
   4.8%  1.21Ki  10.6%  1.15Ki    .dynsym
   4.7%  1.18Ki   0.0%       0    .strtab
   4.5%  1.13Ki   2.8%     314    [15 Others]
   4.1%  1.05Ki   9.1%    1008    .rela.plt
   3.1%     804   7.3%     804    [LOAD #2 [R]]
   2.9%     752   6.2%     688    .plt
   2.8%     738   6.1%     674    .dynstr
   2.8%     736   6.1%     672    .plt.sec
   2.3%     592   4.8%     528    .dynamic
   2.1%     556   4.4%     492    .rodata
   1.8%     472   3.7%     408    .got
   1.7%     448   3.5%     384    .rela.dyn
   1.3%     340   0.0%       0    .shstrtab
   0.9%     224   1.4%     160    .eh_frame
   0.6%     162   0.9%      98    .gnu.version
   0.6%     160   0.9%      96    .data.rel.ro
   0.6%     160   0.9%      96    .gnu.version_r
   0.6%     144   0.7%      80    .note.gnu.property
 100.0%  25.3Ki 100.0%  10.8Ki    TOTAL
```
#### compressed:
* size (broke):
```
   text	   data	    bss	    dec	    hex	filename
      0	      0	      0	      0	      0	mwm.upx
```
* bloaty:
```
    FILE SIZE        VM SIZE    
 --------------  -------------- 
  33.1%  4.00Ki  70.7%  24.6Ki    [LOAD #0 [RW]]
  51.2%  6.18Ki  29.3%  10.2Ki    [LOAD #1 [RX]]
  15.7%  1.90Ki   0.0%       0    [Unmapped]
 100.0%  12.1Ki 100.0%  34.8Ki    TOTAL
```
