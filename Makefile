CC = gcc
CFLAGS = -Wall -Wextra -pedantic -O3 -fno-asynchronous-unwind-tables -fno-unwind-tables -march=native -flto -ffast-math -fomit-frame-pointer -ffunction-sections -fdata-sections -Os -DAUDIO_SCRIPT="\"$(shell pwd)/audio.sh\""
LDFLAGS = -lX11 -lm -lc -Wl,--gc-sections -Wl,--as-needed -Wl,-O1
TARGET = mwm
SRC = main.c
PREFIX = /usr/local
DESTDIR =

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

install: $(TARGET)
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 755 $(TARGET) $(DESTDIR)$(PREFIX)/bin/

install_compressed: $(TARGET)
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	$(MAKE) compress
	install -m 755 $(TARGET).upx $(DESTDIR)$(PREFIX)/bin/

compress: $(TARGET)
	@if command -v upx > /dev/null 2>&1; then \
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
	rm -f $(DESTDIR)$(PREFIX)/bin/$(TARGET)
	rm -f $(DESTDIR)$(PREFIX)/bin/$(TARGET).upx

clean:
	rm -f $(TARGET) $(TARGET).upx

.PHONY: all install install_compressed compress uninstall clean
