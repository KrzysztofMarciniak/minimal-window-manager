# Minimal Window Manager (MWM)

MWM (Minimal Window Manager) is a lightweight, minimalistic window manager written in **C**.
 
It was designed with the following guiding principles:
* < 500 lines of code (clang-formatted).
* High Performance.
* No status bar, Borders or Gaps. [(if you want them, use mwm+)](https://github.com/KrzysztofMarciniak/minimal-window-manager-plus)
* No floating windows.
* No compiler warnings, clean builds only.
* One file.

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
   text	   data	    bss	    dec	    hex	filename
   9561	   1044	    568	  11173	   2ba5	mwm
```
* bloaty:
```
    FILE SIZE        VM SIZE    
 --------------  -------------- 
  35.2%  8.85Ki   0.0%       0    [Unmapped]
  13.8%  3.48Ki  29.1%  3.42Ki    .text
   7.6%  1.91Ki   0.0%       0    .symtab
   5.2%  1.31Ki   3.4%     411    [16 Others]
   4.7%  1.19Ki   9.6%  1.12Ki    .dynsym
   4.4%  1.10Ki   0.0%       0    .strtab
   4.1%  1.02Ki   8.2%     984    .rela.plt
   3.1%     801   6.7%     801    [LOAD #2 [R]]
   2.9%     736   5.6%     672    .plt
   2.8%     720   5.5%     656    .plt.sec
   2.8%     711   5.4%     647    .dynstr
   2.5%     640   4.8%     576    .eh_frame
   2.2%     576   4.3%     512    .dynamic
   0.0%       0   4.7%     568    .bss
   2.0%     504   3.7%     440    .rodata
   1.8%     464   3.3%     400    .got
   1.7%     448   3.2%     384    .rela.dyn
   1.3%     340   0.0%       0    .shstrtab
   0.7%     188   1.0%     124    .eh_frame_hdr
   0.6%     160   0.8%      96    .data.rel.ro
   0.6%     160   0.8%      96    .gnu.version
 100.0%  25.2Ki 100.0%  11.7Ki    TOTAL
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
