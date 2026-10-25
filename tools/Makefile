.PHONY: all clean

CC := gcc
CFLAGS := -O3 -std=c17 -Wall -Wextra -pedantic

tools := alt_tiles card_attributes gfx scan_includes

all: $(tools)
	@:

clean:
	rm -f $(tools)

gfx: common.h
card_attributes: common.h card_gfx.h
alt_tiles: common.h card_gfx.h
%: %.c
	$(CC) $(CFLAGS) -o $@ $<
