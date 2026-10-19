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
INSTALL ?= install
INSTALL_PROGRAM ?= $(INSTALL) -m 755
RM ?= rm -f

# PWD is provided by POSIX shells and avoids GNU make's non-portable
# $(shell ...) function. Override AUDIO_SCRIPT for a different location.
AUDIO_SCRIPT ?= $(PWD)/audio.sh
CPPFLAGS += -DAUDIO_SCRIPT=\"$(AUDIO_SCRIPT)\"

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $(SRC) $(LDLIBS)

audio: audio.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ audio.c

install: $(TARGET)
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	$(INSTALL_PROGRAM) $(TARGET) $(DESTDIR)$(PREFIX)/bin/$(TARGET)

install_compressed: $(TARGET)
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

.PHONY: all install install_compressed compress uninstall clean
