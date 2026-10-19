CC ?= cc
CFLAGS ?= -O2
CFLAGS += -Wall -Wextra -pedantic
CPPFLAGS ?=
LDFLAGS ?=
LDLIBS ?= -lX11

TARGET ?= mwm
SRC ?= main.c
PREFIX ?= /usr/local
DESTDIR ?=
DEPS_DIR ?= .deps
SUDO ?= sudo
INSTALL ?= install
INSTALL_PROGRAM ?= $(INSTALL) -m 755
RM ?= rm -f

# PWD is provided by POSIX shells and avoids GNU make's non-portable
# $(shell ...) function. Override AUDIO_SCRIPT for a different location.
AUDIO_SCRIPT ?= $(PWD)/audio.sh
CPPFLAGS += -DAUDIO_SCRIPT=\"$(AUDIO_SCRIPT)\"

all:
	$(MAKE) check-tools
	$(MAKE) $(TARGET)

check-tools:
	@if command -v st >/dev/null 2>&1 && command -v dmenu >/dev/null 2>&1; then \
		:; \
	else \
		printf "st and/or dmenu are missing. Install them from suckless.org? [y/N] "; \
		read answer; \
		case "$$answer" in \
			y|Y|yes|YES) \
				for app in st dmenu; do \
					if ! command -v "$$app" >/dev/null 2>&1; then \
						if [ "$$app" = st ]; then \
							if ! command -v tic >/dev/null 2>&1; then \
								printf "Cannot install st: install the terminfo compiler (tic, usually provided by ncurses utilities) first.\n" >&2; \
								exit 1; \
							fi; \
							if ! command -v pkg-config >/dev/null 2>&1 || \
								! pkg-config --exists xft fontconfig freetype2; then \
								printf "Cannot build st: install pkg-config and the Xft, fontconfig, and freetype development files first.\n" >&2; \
								exit 1; \
							fi; \
						elif [ "$$app" = dmenu ] && \
							{ ! command -v pkg-config >/dev/null 2>&1 || \
							! pkg-config --exists xinerama; }; then \
							printf "Cannot build dmenu: install the Xinerama development files (header and library) first.\n" >&2; \
							exit 1; \
						fi; \
						dir="$(DEPS_DIR)/$$app"; \
						if [ ! -d "$$dir/.git" ]; then \
							mkdir -p "$(DEPS_DIR)" && \
							git clone "https://git.suckless.org/$$app" "$$dir" || exit 1; \
						fi; \
						$(MAKE) -C "$$dir" PREFIX="$(PREFIX)" && \
						$(SUDO) $(MAKE) -C "$$dir" PREFIX="$(PREFIX)" install || exit 1; \
					fi; \
				done ;; \
			*) printf "Skipping st and dmenu installation.\n" ;; \
		esac; \
	fi

$(TARGET): $(SRC)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $(SRC) $(LDLIBS)

audio: audio.sh
	$(INSTALL_PROGRAM) audio.sh $@

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	$(INSTALL_PROGRAM) $(TARGET) $(DESTDIR)$(PREFIX)/bin/$(TARGET)

install_compressed: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	$(MAKE) compress
	$(INSTALL_PROGRAM) $(TARGET).upx $(DESTDIR)$(PREFIX)/bin/$(TARGET).upx

compress: $(TARGET)
	@if command -v upx >/dev/null 2>&1; then \
		if upx -t $(TARGET) > /dev/null 2>&1; then \
			echo "$(TARGET) is already packed, skipping compression."; \
		else \
			cp $(TARGET) $(TARGET).upx; \
			upx -9 -v $(TARGET).upx; \
		fi; \
	else \
		echo "You have to install UPX to compress the binary."; \
		echo "Install UPX from https://github.com/upx/upx"; \
		exit 1; \
	fi

uninstall:
	$(RM) $(DESTDIR)$(PREFIX)/bin/$(TARGET)
	$(RM) $(DESTDIR)$(PREFIX)/bin/$(TARGET).upx

clean:
	$(RM) $(TARGET) $(TARGET).upx audio

.PHONY: all audio check-tools install install_compressed compress uninstall clean
