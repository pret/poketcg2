rom := poketcg2.gbc

rom_obj := \
	src/main.o \
	src/home.o \
	src/gfx.o \
	src/text.o \
	src/audio.o \
	src/wram.o \
	src/hram.o


### Build tools

ifeq (,$(shell which sha1sum))
SHA1 := shasum
else
SHA1 := sha1sum
endif

RGBDS ?=
RGBASM  ?= $(RGBDS)rgbasm
RGBFIX  ?= $(RGBDS)rgbfix
RGBGFX  ?= $(RGBDS)rgbgfx
RGBLINK ?= $(RGBDS)rgblink


### Build targets

.SUFFIXES:
.SECONDEXPANSION:
.PRECIOUS:
.SECONDARY:
.PHONY: all tcg2 clean tidy compare tools

all: $(rom) compare
tcg2: $(rom) compare

clean: tidy
	find src/gfx \
	     \( -iname '*.1bpp' \
	        -o -iname '*.2bpp' \
	        -o -iname '*.pal' \) \
	     -delete

tidy:
	$(RM) $(rom) \
	      $(rom:.gbc=.sym) \
	      $(rom:.gbc=.map) \
	      $(rom_obj) \
	      src/rgbdscheck.o
	$(MAKE) clean -C tools/

compare: $(rom)
	@$(SHA1) -c rom.sha1

tools:
	$(MAKE) -C tools/


RGBASMFLAGS = -hL -I src/ -Weverything
# Create a sym/map for debug purposes if `make` run with `DEBUG=1`
ifeq ($(DEBUG),1)
RGBASMFLAGS += -E
endif

src/rgbdscheck.o: src/rgbdscheck.asm
	$(RGBASM) -o $@ $<

# Build tools when building the rom.
# This has to happen before the rules are processed, since that's when scan_includes is run.
ifeq (,$(filter clean tidy tools,$(MAKECMDGOALS)))

$(info $(shell $(MAKE) -C tools))

# The dep rules have to be explicit or else missing files won't be reported.
# As a side effect, they're evaluated immediately instead of when the rule is invoked.
# It doesn't look like $(shell) can be deferred so there might not be a better way.
define DEP
$1: $2 $$(shell tools/scan_includes -s -I src/ $2) | src/rgbdscheck.o
	$$(RGBASM) $$(RGBASMFLAGS) -o $$@ $$<
endef

# Dependencies for objects
$(foreach obj, $(rom_obj), $(eval $(call DEP,$(obj),$(obj:.o=.asm))))

endif


%.asm: ;


opts = -Cv -k 2P -l 0x33 -m 0x1b -p 0xff -r 03 -t "POKEMON-CG2" -i BP7J

$(rom): $(rom_obj) src/layout.link
	$(RGBLINK) -p 0xff -m $(rom:.gbc=.map) -n $(rom:.gbc=.sym) -l src/layout.link -O baserom.gbc -o $@ $(filter %.o,$^)
	$(RGBFIX) $(opts) $@


### Misc file-specific graphics rules

src/gfx/coins/%.2bpp: rgbgfx += -x 1

src/gfx/booster_packs/beginning_pack.2bpp: rgbgfx += -x 2
src/gfx/booster_packs/legendary_pack.2bpp: rgbgfx += -x 1
src/gfx/booster_packs/fossil_pack.2bpp: rgbgfx += -x 2
src/gfx/booster_packs/psychic_pack.2bpp: rgbgfx += -x 1
src/gfx/booster_packs/ambition_pack.2bpp: rgbgfx += -x 2
src/gfx/booster_packs/present_pack.2bpp: rgbgfx += -x 2
src/gfx/booster_packs/pack_oam.2bpp: rgbgfx += -x 1
src/gfx/titlescreen/title_screen.2bpp: rgbgfx += -x 4
src/gfx/titlescreen/gb_error.2bpp: rgbgfx += -x 10
src/gfx/black_box/black_box_bg.2bpp: rgbgfx += -x 5
src/gfx/link/card_pop_scene.2bpp: rgbgfx += -x 9
src/gfx/link/link_scene.2bpp: rgbgfx += -x 7

### Catch-all graphics rules

%.png: ;

%.pal: ;

%.2bpp: %.png
	$(RGBGFX) $(rgbgfx) -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) -o $@ $@)

%.1bpp: %.png
	$(RGBGFX) $(rgbgfx) -d1 -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) -d1 -o $@ $@)
