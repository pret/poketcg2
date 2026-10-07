.PHONY: all clean

CC := gcc
CFLAGS := -O3 -std=gnu23 -Wall -Wextra -pedantic

tools := scan_includes gfx card_gfx

all: $(tools)
	@:

clean:
	rm -f $(tools)

card_gfx: card_gfx.c common.h lodepng/lodepng.c lodepng/lodepng.h
	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^)

gfx: common.h
%: %.c
	$(CC) $(CFLAGS) -o $@ $<
