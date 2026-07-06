SECTION "Card Gfx 1", ROMX

; structure:
; - <Name>CardGfx:
;   - 3 GBC palettes <name>.pal.asm, rgb macro
;   - tile descriptors <name>.desc.asm, byte per tile:
;     - bits 6-7: palette index (0, 1, 2)
;     - bits 0-5: printer-only alt-tile offset for LoadCardGfx_PrinterAlt,
;                 offset = 48 + (cur alt tile index) - (cur tile index),
;                 0 if no alt
;   - <name>.2bpp: 8x6 tiles grayscale portrait in column-major order,
;                  built from <name>.png
; - <Name>CardGfxExtra: printer-only alt tiles in <name>_extra.2bpp
; banks padded with $0 instead of $ff
; TODO: revamp the brute-force tools/derive_*_tiles.py workflow
; to allow the use of tile descriptor macros
CardGraphics::

GrassEnergyCardGfx::
	INCLUDE "gfx/cards/grass_energy.pal.asm"
	INCLUDE "gfx/cards/grass_energy.desc.asm"
	INCBIN "gfx/cards/grass_energy.2bpp"
GrassEnergyCardGfxExtra::
	INCBIN "gfx/cards/grass_energy_extra.2bpp"

FireEnergyCardGfx::
	INCLUDE "gfx/cards/fire_energy.pal.asm"
	INCLUDE "gfx/cards/fire_energy.desc.asm"
	INCBIN "gfx/cards/fire_energy.2bpp"
FireEnergyCardGfxExtra::
	INCBIN "gfx/cards/fire_energy_extra.2bpp"

WaterEnergyCardGfx::
	INCLUDE "gfx/cards/water_energy.pal.asm"
	INCLUDE "gfx/cards/water_energy.desc.asm"
	INCBIN "gfx/cards/water_energy.2bpp"
WaterEnergyCardGfxExtra::
	INCBIN "gfx/cards/water_energy_extra.2bpp"

LightningEnergyCardGfx::
	INCLUDE "gfx/cards/lightning_energy.pal.asm"
	INCLUDE "gfx/cards/lightning_energy.desc.asm"
	INCBIN "gfx/cards/lightning_energy.2bpp"
LightningEnergyCardGfxExtra::
	INCBIN "gfx/cards/lightning_energy_extra.2bpp"

FightingEnergyCardGfx::
	INCLUDE "gfx/cards/fighting_energy.pal.asm"
	INCLUDE "gfx/cards/fighting_energy.desc.asm"
	INCBIN "gfx/cards/fighting_energy.2bpp"
FightingEnergyCardGfxExtra::
	INCBIN "gfx/cards/fighting_energy_extra.2bpp"

PsychicEnergyCardGfx::
	INCLUDE "gfx/cards/psychic_energy.pal.asm"
	INCLUDE "gfx/cards/psychic_energy.desc.asm"
	INCBIN "gfx/cards/psychic_energy.2bpp"
PsychicEnergyCardGfxExtra::
	INCBIN "gfx/cards/psychic_energy_extra.2bpp"

DoubleColorlessEnergyCardGfx::
	INCLUDE "gfx/cards/double_colorless_energy.pal.asm"
	INCLUDE "gfx/cards/double_colorless_energy.desc.asm"
	INCBIN "gfx/cards/double_colorless_energy.2bpp"
DoubleColorlessEnergyCardGfxExtra::
	INCBIN "gfx/cards/double_colorless_energy_extra.2bpp"

PotionEnergyCardGfx::
	INCLUDE "gfx/cards/potion_energy.pal.asm"
	INCLUDE "gfx/cards/potion_energy.desc.asm"
	INCBIN "gfx/cards/potion_energy.2bpp"
PotionEnergyCardGfxExtra::
	INCBIN "gfx/cards/potion_energy_extra.2bpp"

FullHealEnergyCardGfx::
	INCLUDE "gfx/cards/full_heal_energy.pal.asm"
	INCLUDE "gfx/cards/full_heal_energy.desc.asm"
	INCBIN "gfx/cards/full_heal_energy.2bpp"

RainbowEnergyCardGfx::
	INCLUDE "gfx/cards/rainbow_energy.pal.asm"
	INCLUDE "gfx/cards/rainbow_energy.desc.asm"
	INCBIN "gfx/cards/rainbow_energy.2bpp"

BulbasaurLv13CardGfx::
	INCLUDE "gfx/cards/bulbasaur_lv13.pal.asm"
	INCLUDE "gfx/cards/bulbasaur_lv13.desc.asm"
	INCBIN "gfx/cards/bulbasaur_lv13.2bpp"

IvysaurLv20CardGfx::
	INCLUDE "gfx/cards/ivysaur_lv20.pal.asm"
	INCLUDE "gfx/cards/ivysaur_lv20.desc.asm"
	INCBIN "gfx/cards/ivysaur_lv20.2bpp"
IvysaurLv20CardGfxExtra::
	INCBIN "gfx/cards/ivysaur_lv20_extra.2bpp"

VenusaurLv64CardGfx::
	INCLUDE "gfx/cards/venusaur_lv64.pal.asm"
	INCLUDE "gfx/cards/venusaur_lv64.desc.asm"
	INCBIN "gfx/cards/venusaur_lv64.2bpp"
VenusaurLv64CardGfxExtra::
	INCBIN "gfx/cards/venusaur_lv64_extra.2bpp"

VenusaurLv67CardGfx::
	INCLUDE "gfx/cards/venusaur_lv67.pal.asm"
	INCLUDE "gfx/cards/venusaur_lv67.desc.asm"
	INCBIN "gfx/cards/venusaur_lv67.2bpp"

CaterpieCardGfx::
	INCLUDE "gfx/cards/caterpie.pal.asm"
	INCLUDE "gfx/cards/caterpie.desc.asm"
	INCBIN "gfx/cards/caterpie.2bpp"

MetapodLv21CardGfx::
	INCLUDE "gfx/cards/metapod_lv21.pal.asm"
	INCLUDE "gfx/cards/metapod_lv21.desc.asm"
	INCBIN "gfx/cards/metapod_lv21.2bpp"

	ds $90

SECTION "Card Gfx 2", ROMX

ButterfreeCardGfx::
	INCLUDE "gfx/cards/butterfree.pal.asm"
	INCLUDE "gfx/cards/butterfree.desc.asm"
	INCBIN "gfx/cards/butterfree.2bpp"
ButterfreeCardGfxExtra::
	INCBIN "gfx/cards/butterfree_extra.2bpp"

WeedleLv12CardGfx::
	INCLUDE "gfx/cards/weedle_lv12.pal.asm"
	INCLUDE "gfx/cards/weedle_lv12.desc.asm"
	INCBIN "gfx/cards/weedle_lv12.2bpp"

KakunaLv23CardGfx::
	INCLUDE "gfx/cards/kakuna_lv23.pal.asm"
	INCLUDE "gfx/cards/kakuna_lv23.desc.asm"
	INCBIN "gfx/cards/kakuna_lv23.2bpp"

BeedrillCardGfx::
	INCLUDE "gfx/cards/beedrill.pal.asm"
	INCLUDE "gfx/cards/beedrill.desc.asm"
	INCBIN "gfx/cards/beedrill.2bpp"
BeedrillCardGfxExtra::
	INCBIN "gfx/cards/beedrill_extra.2bpp"

EkansLv10CardGfx::
	INCLUDE "gfx/cards/ekans_lv10.pal.asm"
	INCLUDE "gfx/cards/ekans_lv10.desc.asm"
	INCBIN "gfx/cards/ekans_lv10.2bpp"
EkansLv10CardGfxExtra::
	INCBIN "gfx/cards/ekans_lv10_extra.2bpp"

ArbokLv27CardGfx::
	INCLUDE "gfx/cards/arbok_lv27.pal.asm"
	INCLUDE "gfx/cards/arbok_lv27.desc.asm"
	INCBIN "gfx/cards/arbok_lv27.2bpp"
ArbokLv27CardGfxExtra::
	INCBIN "gfx/cards/arbok_lv27_extra.2bpp"

NidoranFLv13CardGfx::
	INCLUDE "gfx/cards/nidoran_f_lv13.pal.asm"
	INCLUDE "gfx/cards/nidoran_f_lv13.desc.asm"
	INCBIN "gfx/cards/nidoran_f_lv13.2bpp"
NidoranFLv13CardGfxExtra::
	INCBIN "gfx/cards/nidoran_f_lv13_extra.2bpp"

NidorinaLv24CardGfx::
	INCLUDE "gfx/cards/nidorina_lv24.pal.asm"
	INCLUDE "gfx/cards/nidorina_lv24.desc.asm"
	INCBIN "gfx/cards/nidorina_lv24.2bpp"
NidorinaLv24CardGfxExtra::
	INCBIN "gfx/cards/nidorina_lv24_extra.2bpp"

NidoqueenCardGfx::
	INCLUDE "gfx/cards/nidoqueen.pal.asm"
	INCLUDE "gfx/cards/nidoqueen.desc.asm"
	INCBIN "gfx/cards/nidoqueen.2bpp"

NidoranMLv20CardGfx::
	INCLUDE "gfx/cards/nidoran_m_lv20.pal.asm"
	INCLUDE "gfx/cards/nidoran_m_lv20.desc.asm"
	INCBIN "gfx/cards/nidoran_m_lv20.2bpp"
NidoranMLv20CardGfxExtra::
	INCBIN "gfx/cards/nidoran_m_lv20_extra.2bpp"

NidorinoLv25CardGfx::
	INCLUDE "gfx/cards/nidorino_lv25.pal.asm"
	INCLUDE "gfx/cards/nidorino_lv25.desc.asm"
	INCBIN "gfx/cards/nidorino_lv25.2bpp"

NidokingCardGfx::
	INCLUDE "gfx/cards/nidoking.pal.asm"
	INCLUDE "gfx/cards/nidoking.desc.asm"
	INCBIN "gfx/cards/nidoking.2bpp"

ZubatLv10CardGfx::
	INCLUDE "gfx/cards/zubat_lv10.pal.asm"
	INCLUDE "gfx/cards/zubat_lv10.desc.asm"
	INCBIN "gfx/cards/zubat_lv10.2bpp"

GolbatLv29CardGfx::
	INCLUDE "gfx/cards/golbat_lv29.pal.asm"
	INCLUDE "gfx/cards/golbat_lv29.desc.asm"
	INCBIN "gfx/cards/golbat_lv29.2bpp"

OddishLv8CardGfx::
	INCLUDE "gfx/cards/oddish_lv8.pal.asm"
	INCLUDE "gfx/cards/oddish_lv8.desc.asm"
	INCBIN "gfx/cards/oddish_lv8.2bpp"

GloomCardGfx::
	INCLUDE "gfx/cards/gloom.pal.asm"
	INCLUDE "gfx/cards/gloom.desc.asm"
	INCBIN "gfx/cards/gloom.2bpp"

VileplumeCardGfx::
	INCLUDE "gfx/cards/vileplume.pal.asm"
	INCLUDE "gfx/cards/vileplume.desc.asm"
	INCBIN "gfx/cards/vileplume.2bpp"

ParasLv8CardGfx::
	INCLUDE "gfx/cards/paras_lv8.pal.asm"
	INCLUDE "gfx/cards/paras_lv8.desc.asm"
	INCBIN "gfx/cards/paras_lv8.2bpp"
ParasLv8CardGfxExtra::
	INCBIN "gfx/cards/paras_lv8_extra.2bpp"

	ds $120

SECTION "Card Gfx 3", ROMX

ParasectLv28CardGfx::
	INCLUDE "gfx/cards/parasect_lv28.pal.asm"
	INCLUDE "gfx/cards/parasect_lv28.desc.asm"
	INCBIN "gfx/cards/parasect_lv28.2bpp"
ParasectLv28CardGfxExtra::
	INCBIN "gfx/cards/parasect_lv28_extra.2bpp"

VenonatLv12CardGfx::
	INCLUDE "gfx/cards/venonat_lv12.pal.asm"
	INCLUDE "gfx/cards/venonat_lv12.desc.asm"
	INCBIN "gfx/cards/venonat_lv12.2bpp"

VenomothLv28CardGfx::
	INCLUDE "gfx/cards/venomoth_lv28.pal.asm"
	INCLUDE "gfx/cards/venomoth_lv28.desc.asm"
	INCBIN "gfx/cards/venomoth_lv28.2bpp"

BellsproutLv11CardGfx::
	INCLUDE "gfx/cards/bellsprout_lv11.pal.asm"
	INCLUDE "gfx/cards/bellsprout_lv11.desc.asm"
	INCBIN "gfx/cards/bellsprout_lv11.2bpp"

WeepinbellLv28CardGfx::
	INCLUDE "gfx/cards/weepinbell_lv28.pal.asm"
	INCLUDE "gfx/cards/weepinbell_lv28.desc.asm"
	INCBIN "gfx/cards/weepinbell_lv28.2bpp"

VictreebelCardGfx::
	INCLUDE "gfx/cards/victreebel.pal.asm"
	INCLUDE "gfx/cards/victreebel.desc.asm"
	INCBIN "gfx/cards/victreebel.2bpp"

GrimerLv17CardGfx::
	INCLUDE "gfx/cards/grimer_lv17.pal.asm"
	INCLUDE "gfx/cards/grimer_lv17.desc.asm"
	INCBIN "gfx/cards/grimer_lv17.2bpp"

MukCardGfx::
	INCLUDE "gfx/cards/muk.pal.asm"
	INCLUDE "gfx/cards/muk.desc.asm"
	INCBIN "gfx/cards/muk.2bpp"

ExeggcuteCardGfx::
	INCLUDE "gfx/cards/exeggcute.pal.asm"
	INCLUDE "gfx/cards/exeggcute.desc.asm"
	INCBIN "gfx/cards/exeggcute.2bpp"
ExeggcuteCardGfxExtra::
	INCBIN "gfx/cards/exeggcute_extra.2bpp"

ExeggutorCardGfx::
	INCLUDE "gfx/cards/exeggutor.pal.asm"
	INCLUDE "gfx/cards/exeggutor.desc.asm"
	INCBIN "gfx/cards/exeggutor.2bpp"
ExeggutorCardGfxExtra::
	INCBIN "gfx/cards/exeggutor_extra.2bpp"

KoffingLv13CardGfx::
	INCLUDE "gfx/cards/koffing_lv13.pal.asm"
	INCLUDE "gfx/cards/koffing_lv13.desc.asm"
	INCBIN "gfx/cards/koffing_lv13.2bpp"

WeezingLv27CardGfx::
	INCLUDE "gfx/cards/weezing_lv27.pal.asm"
	INCLUDE "gfx/cards/weezing_lv27.desc.asm"
	INCBIN "gfx/cards/weezing_lv27.2bpp"
WeezingLv27CardGfxExtra::
	INCBIN "gfx/cards/weezing_lv27_extra.2bpp"

TangelaLv8CardGfx::
	INCLUDE "gfx/cards/tangela_lv8.pal.asm"
	INCLUDE "gfx/cards/tangela_lv8.desc.asm"
	INCBIN "gfx/cards/tangela_lv8.2bpp"
TangelaLv8CardGfxExtra::
	INCBIN "gfx/cards/tangela_lv8_extra.2bpp"

TangelaLv12CardGfx::
	INCLUDE "gfx/cards/tangela_lv12.pal.asm"
	INCLUDE "gfx/cards/tangela_lv12.desc.asm"
	INCBIN "gfx/cards/tangela_lv12.2bpp"

ScytherLv25CardGfx::
	INCLUDE "gfx/cards/scyther_lv25.pal.asm"
	INCLUDE "gfx/cards/scyther_lv25.desc.asm"
	INCBIN "gfx/cards/scyther_lv25.2bpp"

PinsirLv24CardGfx::
	INCLUDE "gfx/cards/pinsir_lv24.pal.asm"
	INCLUDE "gfx/cards/pinsir_lv24.desc.asm"
	INCBIN "gfx/cards/pinsir_lv24.2bpp"

CharmanderLv10CardGfx::
	INCLUDE "gfx/cards/charmander_lv10.pal.asm"
	INCLUDE "gfx/cards/charmander_lv10.desc.asm"
	INCBIN "gfx/cards/charmander_lv10.2bpp"
CharmanderLv10CardGfxExtra::
	INCBIN "gfx/cards/charmander_lv10_extra.2bpp"

CharmeleonCardGfx::
	INCLUDE "gfx/cards/charmeleon.pal.asm"
	INCLUDE "gfx/cards/charmeleon.desc.asm"
	INCBIN "gfx/cards/charmeleon.2bpp"
CharmeleonCardGfxExtra::
	INCBIN "gfx/cards/charmeleon_extra.2bpp"

	ds $250

SECTION "Card Gfx 4", ROMX

CharizardLv76CardGfx::
	INCLUDE "gfx/cards/charizard_lv76.pal.asm"
	INCLUDE "gfx/cards/charizard_lv76.desc.asm"
	INCBIN "gfx/cards/charizard_lv76.2bpp"

VulpixLv11CardGfx::
	INCLUDE "gfx/cards/vulpix_lv11.pal.asm"
	INCLUDE "gfx/cards/vulpix_lv11.desc.asm"
	INCBIN "gfx/cards/vulpix_lv11.2bpp"

NinetalesLv32CardGfx::
	INCLUDE "gfx/cards/ninetales_lv32.pal.asm"
	INCLUDE "gfx/cards/ninetales_lv32.desc.asm"
	INCBIN "gfx/cards/ninetales_lv32.2bpp"

NinetalesLv35CardGfx::
	INCLUDE "gfx/cards/ninetales_lv35.pal.asm"
	INCLUDE "gfx/cards/ninetales_lv35.desc.asm"
	INCBIN "gfx/cards/ninetales_lv35.2bpp"
NinetalesLv35CardGfxExtra::
	INCBIN "gfx/cards/ninetales_lv35_extra.2bpp"

GrowlitheLv18CardGfx::
	INCLUDE "gfx/cards/growlithe_lv18.pal.asm"
	INCLUDE "gfx/cards/growlithe_lv18.desc.asm"
	INCBIN "gfx/cards/growlithe_lv18.2bpp"

ArcanineLv34CardGfx::
	INCLUDE "gfx/cards/arcanine_lv34.pal.asm"
	INCLUDE "gfx/cards/arcanine_lv34.desc.asm"
	INCBIN "gfx/cards/arcanine_lv34.2bpp"
ArcanineLv34CardGfxExtra::
	INCBIN "gfx/cards/arcanine_lv34_extra.2bpp"

ArcanineLv45CardGfx::
	INCLUDE "gfx/cards/arcanine_lv45.pal.asm"
	INCLUDE "gfx/cards/arcanine_lv45.desc.asm"
	INCBIN "gfx/cards/arcanine_lv45.2bpp"

PonytaLv10CardGfx::
	INCLUDE "gfx/cards/ponyta_lv10.pal.asm"
	INCLUDE "gfx/cards/ponyta_lv10.desc.asm"
	INCBIN "gfx/cards/ponyta_lv10.2bpp"
PonytaLv10CardGfxExtra::
	INCBIN "gfx/cards/ponyta_lv10_extra.2bpp"

RapidashLv33CardGfx::
	INCLUDE "gfx/cards/rapidash_lv33.pal.asm"
	INCLUDE "gfx/cards/rapidash_lv33.desc.asm"
	INCBIN "gfx/cards/rapidash_lv33.2bpp"
RapidashLv33CardGfxExtra::
	INCBIN "gfx/cards/rapidash_lv33_extra.2bpp"

MagmarLv24CardGfx::
	INCLUDE "gfx/cards/magmar_lv24.pal.asm"
	INCLUDE "gfx/cards/magmar_lv24.desc.asm"
	INCBIN "gfx/cards/magmar_lv24.2bpp"

MagmarLv31CardGfx::
	INCLUDE "gfx/cards/magmar_lv31.pal.asm"
	INCLUDE "gfx/cards/magmar_lv31.desc.asm"
	INCBIN "gfx/cards/magmar_lv31.2bpp"

FlareonLv22CardGfx::
	INCLUDE "gfx/cards/flareon_lv22.pal.asm"
	INCLUDE "gfx/cards/flareon_lv22.desc.asm"
	INCBIN "gfx/cards/flareon_lv22.2bpp"

FlareonLv28CardGfx::
	INCLUDE "gfx/cards/flareon_lv28.pal.asm"
	INCLUDE "gfx/cards/flareon_lv28.desc.asm"
	INCBIN "gfx/cards/flareon_lv28.2bpp"

MoltresLv35CardGfx::
	INCLUDE "gfx/cards/moltres_lv35.pal.asm"
	INCLUDE "gfx/cards/moltres_lv35.desc.asm"
	INCBIN "gfx/cards/moltres_lv35.2bpp"

MoltresLv40CardGfx::
	INCLUDE "gfx/cards/moltres_lv40.pal.asm"
	INCLUDE "gfx/cards/moltres_lv40.desc.asm"
	INCBIN "gfx/cards/moltres_lv40.2bpp"

SquirtleLv8CardGfx::
	INCLUDE "gfx/cards/squirtle_lv8.pal.asm"
	INCLUDE "gfx/cards/squirtle_lv8.desc.asm"
	INCBIN "gfx/cards/squirtle_lv8.2bpp"
SquirtleLv8CardGfxExtra::
	INCBIN "gfx/cards/squirtle_lv8_extra.2bpp"

WartortleLv22CardGfx::
	INCLUDE "gfx/cards/wartortle_lv22.pal.asm"
	INCLUDE "gfx/cards/wartortle_lv22.desc.asm"
	INCBIN "gfx/cards/wartortle_lv22.2bpp"

	ds $378, $00

SECTION "Card Gfx 5", ROMX

BlastoiseLv52CardGfx::
	INCLUDE "gfx/cards/blastoise_lv52.pal.asm"
	INCLUDE "gfx/cards/blastoise_lv52.desc.asm"
	INCBIN "gfx/cards/blastoise_lv52.2bpp"
BlastoiseLv52CardGfxExtra::
	INCBIN "gfx/cards/blastoise_lv52_extra.2bpp"

PsyduckLv15CardGfx::
	INCLUDE "gfx/cards/psyduck_lv15.pal.asm"
	INCLUDE "gfx/cards/psyduck_lv15.desc.asm"
	INCBIN "gfx/cards/psyduck_lv15.2bpp"
PsyduckLv15CardGfxExtra::
	INCBIN "gfx/cards/psyduck_lv15_extra.2bpp"

GolduckLv27CardGfx::
	INCLUDE "gfx/cards/golduck_lv27.pal.asm"
	INCLUDE "gfx/cards/golduck_lv27.desc.asm"
	INCBIN "gfx/cards/golduck_lv27.2bpp"
GolduckLv27CardGfxExtra::
	INCBIN "gfx/cards/golduck_lv27_extra.2bpp"

PoliwagLv13CardGfx::
	INCLUDE "gfx/cards/poliwag_lv13.pal.asm"
	INCLUDE "gfx/cards/poliwag_lv13.desc.asm"
	INCBIN "gfx/cards/poliwag_lv13.2bpp"
PoliwagLv13CardGfxExtra::
	INCBIN "gfx/cards/poliwag_lv13_extra.2bpp"

PoliwhirlLv28CardGfx::
	INCLUDE "gfx/cards/poliwhirl_lv28.pal.asm"
	INCLUDE "gfx/cards/poliwhirl_lv28.desc.asm"
	INCBIN "gfx/cards/poliwhirl_lv28.2bpp"

PoliwrathLv48CardGfx::
	INCLUDE "gfx/cards/poliwrath_lv48.pal.asm"
	INCLUDE "gfx/cards/poliwrath_lv48.desc.asm"
	INCBIN "gfx/cards/poliwrath_lv48.2bpp"

TentacoolCardGfx::
	INCLUDE "gfx/cards/tentacool.pal.asm"
	INCLUDE "gfx/cards/tentacool.desc.asm"
	INCBIN "gfx/cards/tentacool.2bpp"

TentacruelCardGfx::
	INCLUDE "gfx/cards/tentacruel.pal.asm"
	INCLUDE "gfx/cards/tentacruel.desc.asm"
	INCBIN "gfx/cards/tentacruel.2bpp"
TentacruelCardGfxExtra::
	INCBIN "gfx/cards/tentacruel_extra.2bpp"

SeelLv12CardGfx::
	INCLUDE "gfx/cards/seel_lv12.pal.asm"
	INCLUDE "gfx/cards/seel_lv12.desc.asm"
	INCBIN "gfx/cards/seel_lv12.2bpp"

DewgongLv42CardGfx::
	INCLUDE "gfx/cards/dewgong_lv42.pal.asm"
	INCLUDE "gfx/cards/dewgong_lv42.desc.asm"
	INCBIN "gfx/cards/dewgong_lv42.2bpp"

ShellderLv8CardGfx::
	INCLUDE "gfx/cards/shellder_lv8.pal.asm"
	INCLUDE "gfx/cards/shellder_lv8.desc.asm"
	INCBIN "gfx/cards/shellder_lv8.2bpp"
ShellderLv8CardGfxExtra::
	INCBIN "gfx/cards/shellder_lv8_extra.2bpp"

CloysterCardGfx::
	INCLUDE "gfx/cards/cloyster.pal.asm"
	INCLUDE "gfx/cards/cloyster.desc.asm"
	INCBIN "gfx/cards/cloyster.2bpp"

KrabbyLv20CardGfx::
	INCLUDE "gfx/cards/krabby_lv20.pal.asm"
	INCLUDE "gfx/cards/krabby_lv20.desc.asm"
	INCBIN "gfx/cards/krabby_lv20.2bpp"
KrabbyLv20CardGfxExtra::
	INCBIN "gfx/cards/krabby_lv20_extra.2bpp"

KinglerLv27CardGfx::
	INCLUDE "gfx/cards/kingler_lv27.pal.asm"
	INCLUDE "gfx/cards/kingler_lv27.desc.asm"
	INCBIN "gfx/cards/kingler_lv27.2bpp"
KinglerLv27CardGfxExtra::
	INCBIN "gfx/cards/kingler_lv27_extra.2bpp"

HorseaLv19CardGfx::
	INCLUDE "gfx/cards/horsea_lv19.pal.asm"
	INCLUDE "gfx/cards/horsea_lv19.desc.asm"
	INCBIN "gfx/cards/horsea_lv19.2bpp"

SeadraLv23CardGfx::
	INCLUDE "gfx/cards/seadra_lv23.pal.asm"
	INCLUDE "gfx/cards/seadra_lv23.desc.asm"
	INCBIN "gfx/cards/seadra_lv23.2bpp"

GoldeenCardGfx::
	INCLUDE "gfx/cards/goldeen.pal.asm"
	INCLUDE "gfx/cards/goldeen.desc.asm"
	INCBIN "gfx/cards/goldeen.2bpp"
GoldeenCardGfxExtra::
	INCBIN "gfx/cards/goldeen_extra.2bpp"

	ds $2e8

SECTION "Card Gfx 6", ROMX

SeakingCardGfx::
	INCLUDE "gfx/cards/seaking.pal.asm"
	INCLUDE "gfx/cards/seaking.desc.asm"
	INCBIN "gfx/cards/seaking.2bpp"

StaryuLv15CardGfx::
	INCLUDE "gfx/cards/staryu_lv15.pal.asm"
	INCLUDE "gfx/cards/staryu_lv15.desc.asm"
	INCBIN "gfx/cards/staryu_lv15.2bpp"
StaryuLv15CardGfxExtra::
	INCBIN "gfx/cards/staryu_lv15_extra.2bpp"

StarmieCardGfx::
	INCLUDE "gfx/cards/starmie.pal.asm"
	INCLUDE "gfx/cards/starmie.desc.asm"
	INCBIN "gfx/cards/starmie.2bpp"

MagikarpLv8CardGfx::
	INCLUDE "gfx/cards/magikarp_lv8.pal.asm"
	INCLUDE "gfx/cards/magikarp_lv8.desc.asm"
	INCBIN "gfx/cards/magikarp_lv8.2bpp"

GyaradosCardGfx::
	INCLUDE "gfx/cards/gyarados.pal.asm"
	INCLUDE "gfx/cards/gyarados.desc.asm"
	INCBIN "gfx/cards/gyarados.2bpp"
GyaradosCardGfxExtra::
	INCBIN "gfx/cards/gyarados_extra.2bpp"

LaprasLv31CardGfx::
	INCLUDE "gfx/cards/lapras_lv31.pal.asm"
	INCLUDE "gfx/cards/lapras_lv31.desc.asm"
	INCBIN "gfx/cards/lapras_lv31.2bpp"

VaporeonLv29CardGfx::
	INCLUDE "gfx/cards/vaporeon_lv29.pal.asm"
	INCLUDE "gfx/cards/vaporeon_lv29.desc.asm"
	INCBIN "gfx/cards/vaporeon_lv29.2bpp"

VaporeonLv42CardGfx::
	INCLUDE "gfx/cards/vaporeon_lv42.pal.asm"
	INCLUDE "gfx/cards/vaporeon_lv42.desc.asm"
	INCBIN "gfx/cards/vaporeon_lv42.2bpp"

OmanyteLv19CardGfx::
	INCLUDE "gfx/cards/omanyte_lv19.pal.asm"
	INCLUDE "gfx/cards/omanyte_lv19.desc.asm"
	INCBIN "gfx/cards/omanyte_lv19.2bpp"

OmastarLv32CardGfx::
	INCLUDE "gfx/cards/omastar_lv32.pal.asm"
	INCLUDE "gfx/cards/omastar_lv32.desc.asm"
	INCBIN "gfx/cards/omastar_lv32.2bpp"
OmastarLv32CardGfxExtra::
	INCBIN "gfx/cards/omastar_lv32_extra.2bpp"

ArticunoLv35CardGfx::
	INCLUDE "gfx/cards/articuno_lv35.pal.asm"
	INCLUDE "gfx/cards/articuno_lv35.desc.asm"
	INCBIN "gfx/cards/articuno_lv35.2bpp"

ArticunoLv37CardGfx::
	INCLUDE "gfx/cards/articuno_lv37.pal.asm"
	INCLUDE "gfx/cards/articuno_lv37.desc.asm"
	INCBIN "gfx/cards/articuno_lv37.2bpp"

PikachuLv12CardGfx::
	INCLUDE "gfx/cards/pikachu_lv12.pal.asm"
	INCLUDE "gfx/cards/pikachu_lv12.desc.asm"
	INCBIN "gfx/cards/pikachu_lv12.2bpp"

PikachuLv14CardGfx::
	INCLUDE "gfx/cards/pikachu_lv14.pal.asm"
	INCLUDE "gfx/cards/pikachu_lv14.desc.asm"
	INCBIN "gfx/cards/pikachu_lv14.2bpp"

PikachuLv16CardGfx::
	INCLUDE "gfx/cards/pikachu_lv16.pal.asm"
	INCLUDE "gfx/cards/pikachu_lv16.desc.asm"
	INCBIN "gfx/cards/pikachu_lv16.2bpp"
PikachuLv16CardGfxExtra::
	INCBIN "gfx/cards/pikachu_lv16_extra.2bpp"

PikachuAltLv16CardGfx::
	INCLUDE "gfx/cards/pikachu_alt_lv16.pal.asm"
	INCLUDE "gfx/cards/pikachu_alt_lv16.desc.asm"
	INCBIN "gfx/cards/pikachu_alt_lv16.2bpp"
PikachuAltLv16CardGfxExtra::
	INCBIN "gfx/cards/pikachu_alt_lv16_extra.2bpp"

FlyingPikachuLv12CardGfx::
	INCLUDE "gfx/cards/flying_pikachu_lv12.pal.asm"
	INCLUDE "gfx/cards/flying_pikachu_lv12.desc.asm"
	INCBIN "gfx/cards/flying_pikachu_lv12.2bpp"
FlyingPikachuLv12CardGfxExtra::
	INCBIN "gfx/cards/flying_pikachu_lv12_extra.2bpp"

	ds $3e8

SECTION "Card Gfx 7", ROMX

SurfingPikachuLv13CardGfx::
	INCLUDE "gfx/cards/surfing_pikachu_lv13.pal.asm"
	INCLUDE "gfx/cards/surfing_pikachu_lv13.desc.asm"
	INCBIN "gfx/cards/surfing_pikachu_lv13.2bpp"
SurfingPikachuLv13CardGfxExtra::
	INCBIN "gfx/cards/surfing_pikachu_lv13_extra.2bpp"

SurfingPikachuAltLv13CardGfx::
	INCLUDE "gfx/cards/surfing_pikachu_alt_lv13.pal.asm"
	INCLUDE "gfx/cards/surfing_pikachu_alt_lv13.desc.asm"
	INCBIN "gfx/cards/surfing_pikachu_alt_lv13.2bpp"
SurfingPikachuAltLv13CardGfxExtra::
	INCBIN "gfx/cards/surfing_pikachu_alt_lv13_extra.2bpp"

RaichuLv40CardGfx::
	INCLUDE "gfx/cards/raichu_lv40.pal.asm"
	INCLUDE "gfx/cards/raichu_lv40.desc.asm"
	INCBIN "gfx/cards/raichu_lv40.2bpp"

RaichuLv45CardGfx::
	INCLUDE "gfx/cards/raichu_lv45.pal.asm"
	INCLUDE "gfx/cards/raichu_lv45.desc.asm"
	INCBIN "gfx/cards/raichu_lv45.2bpp"

MagnemiteLv13CardGfx::
	INCLUDE "gfx/cards/magnemite_lv13.pal.asm"
	INCLUDE "gfx/cards/magnemite_lv13.desc.asm"
	INCBIN "gfx/cards/magnemite_lv13.2bpp"
MagnemiteLv13CardGfxExtra::
	INCBIN "gfx/cards/magnemite_lv13_extra.2bpp"

MagnemiteLv14CardGfx::
	INCLUDE "gfx/cards/magnemite_lv14.pal.asm"
	INCLUDE "gfx/cards/magnemite_lv14.desc.asm"
	INCBIN "gfx/cards/magnemite_lv14.2bpp"
MagnemiteLv14CardGfxExtra::
	INCBIN "gfx/cards/magnemite_lv14_extra.2bpp"

MagnetonLv28CardGfx::
	INCLUDE "gfx/cards/magneton_lv28.pal.asm"
	INCLUDE "gfx/cards/magneton_lv28.desc.asm"
	INCBIN "gfx/cards/magneton_lv28.2bpp"
MagnetonLv28CardGfxExtra::
	INCBIN "gfx/cards/magneton_lv28_extra.2bpp"

MagnetonLv35CardGfx::
	INCLUDE "gfx/cards/magneton_lv35.pal.asm"
	INCLUDE "gfx/cards/magneton_lv35.desc.asm"
	INCBIN "gfx/cards/magneton_lv35.2bpp"

VoltorbLv10CardGfx::
	INCLUDE "gfx/cards/voltorb_lv10.pal.asm"
	INCLUDE "gfx/cards/voltorb_lv10.desc.asm"
	INCBIN "gfx/cards/voltorb_lv10.2bpp"
VoltorbLv10CardGfxExtra::
	INCBIN "gfx/cards/voltorb_lv10_extra.2bpp"

ElectrodeLv35CardGfx::
	INCLUDE "gfx/cards/electrode_lv35.pal.asm"
	INCLUDE "gfx/cards/electrode_lv35.desc.asm"
	INCBIN "gfx/cards/electrode_lv35.2bpp"

ElectrodeLv42CardGfx::
	INCLUDE "gfx/cards/electrode_lv42.pal.asm"
	INCLUDE "gfx/cards/electrode_lv42.desc.asm"
	INCBIN "gfx/cards/electrode_lv42.2bpp"

ElectabuzzLv20CardGfx::
	INCLUDE "gfx/cards/electabuzz_lv20.pal.asm"
	INCLUDE "gfx/cards/electabuzz_lv20.desc.asm"
	INCBIN "gfx/cards/electabuzz_lv20.2bpp"

ElectabuzzLv35CardGfx::
	INCLUDE "gfx/cards/electabuzz_lv35.pal.asm"
	INCLUDE "gfx/cards/electabuzz_lv35.desc.asm"
	INCBIN "gfx/cards/electabuzz_lv35.2bpp"
ElectabuzzLv35CardGfxExtra::
	INCBIN "gfx/cards/electabuzz_lv35_extra.2bpp"

JolteonLv24CardGfx::
	INCLUDE "gfx/cards/jolteon_lv24.pal.asm"
	INCLUDE "gfx/cards/jolteon_lv24.desc.asm"
	INCBIN "gfx/cards/jolteon_lv24.2bpp"

JolteonLv29CardGfx::
	INCLUDE "gfx/cards/jolteon_lv29.pal.asm"
	INCLUDE "gfx/cards/jolteon_lv29.desc.asm"
	INCBIN "gfx/cards/jolteon_lv29.2bpp"

ZapdosLv40CardGfx::
	INCLUDE "gfx/cards/zapdos_lv40.pal.asm"
	INCLUDE "gfx/cards/zapdos_lv40.desc.asm"
	INCBIN "gfx/cards/zapdos_lv40.2bpp"

ZapdosLv64CardGfx::
	INCLUDE "gfx/cards/zapdos_lv64.pal.asm"
	INCLUDE "gfx/cards/zapdos_lv64.desc.asm"
	INCBIN "gfx/cards/zapdos_lv64.2bpp"
ZapdosLv64CardGfxExtra::
	INCBIN "gfx/cards/zapdos_lv64_extra.2bpp"

	ds $d8

SECTION "Card Gfx 8", ROMX

ZapdosLv68CardGfx::
	INCLUDE "gfx/cards/zapdos_lv68.pal.asm"
	INCLUDE "gfx/cards/zapdos_lv68.desc.asm"
	INCBIN "gfx/cards/zapdos_lv68.2bpp"

SandshrewLv12CardGfx::
	INCLUDE "gfx/cards/sandshrew_lv12.pal.asm"
	INCLUDE "gfx/cards/sandshrew_lv12.desc.asm"
	INCBIN "gfx/cards/sandshrew_lv12.2bpp"
SandshrewLv12CardGfxExtra::
	INCBIN "gfx/cards/sandshrew_lv12_extra.2bpp"

SandslashLv33CardGfx::
	INCLUDE "gfx/cards/sandslash_lv33.pal.asm"
	INCLUDE "gfx/cards/sandslash_lv33.desc.asm"
	INCBIN "gfx/cards/sandslash_lv33.2bpp"
SandslashLv33CardGfxExtra::
	INCBIN "gfx/cards/sandslash_lv33_extra.2bpp"

DiglettLv8CardGfx::
	INCLUDE "gfx/cards/diglett_lv8.pal.asm"
	INCLUDE "gfx/cards/diglett_lv8.desc.asm"
	INCBIN "gfx/cards/diglett_lv8.2bpp"

DugtrioLv36CardGfx::
	INCLUDE "gfx/cards/dugtrio_lv36.pal.asm"
	INCLUDE "gfx/cards/dugtrio_lv36.desc.asm"
	INCBIN "gfx/cards/dugtrio_lv36.2bpp"
DugtrioLv36CardGfxExtra::
	INCBIN "gfx/cards/dugtrio_lv36_extra.2bpp"

MankeyLv7CardGfx::
	INCLUDE "gfx/cards/mankey_lv7.pal.asm"
	INCLUDE "gfx/cards/mankey_lv7.desc.asm"
	INCBIN "gfx/cards/mankey_lv7.2bpp"
MankeyLv7CardGfxExtra::
	INCBIN "gfx/cards/mankey_lv7_extra.2bpp"

PrimeapeCardGfx::
	INCLUDE "gfx/cards/primeape.pal.asm"
	INCLUDE "gfx/cards/primeape.desc.asm"
	INCBIN "gfx/cards/primeape.2bpp"

MachopLv20CardGfx::
	INCLUDE "gfx/cards/machop_lv20.pal.asm"
	INCLUDE "gfx/cards/machop_lv20.desc.asm"
	INCBIN "gfx/cards/machop_lv20.2bpp"

MachokeLv40CardGfx::
	INCLUDE "gfx/cards/machoke_lv40.pal.asm"
	INCLUDE "gfx/cards/machoke_lv40.desc.asm"
	INCBIN "gfx/cards/machoke_lv40.2bpp"

MachampLv67CardGfx::
	INCLUDE "gfx/cards/machamp_lv67.pal.asm"
	INCLUDE "gfx/cards/machamp_lv67.desc.asm"
	INCBIN "gfx/cards/machamp_lv67.2bpp"

GeodudeLv16CardGfx::
	INCLUDE "gfx/cards/geodude_lv16.pal.asm"
	INCLUDE "gfx/cards/geodude_lv16.desc.asm"
	INCBIN "gfx/cards/geodude_lv16.2bpp"

GravelerLv29CardGfx::
	INCLUDE "gfx/cards/graveler_lv29.pal.asm"
	INCLUDE "gfx/cards/graveler_lv29.desc.asm"
	INCBIN "gfx/cards/graveler_lv29.2bpp"

GolemLv36CardGfx::
	INCLUDE "gfx/cards/golem_lv36.pal.asm"
	INCLUDE "gfx/cards/golem_lv36.desc.asm"
	INCBIN "gfx/cards/golem_lv36.2bpp"

OnixLv12CardGfx::
	INCLUDE "gfx/cards/onix_lv12.pal.asm"
	INCLUDE "gfx/cards/onix_lv12.desc.asm"
	INCBIN "gfx/cards/onix_lv12.2bpp"

CuboneLv13CardGfx::
	INCLUDE "gfx/cards/cubone_lv13.pal.asm"
	INCLUDE "gfx/cards/cubone_lv13.desc.asm"
	INCBIN "gfx/cards/cubone_lv13.2bpp"

MarowakLv26CardGfx::
	INCLUDE "gfx/cards/marowak_lv26.pal.asm"
	INCLUDE "gfx/cards/marowak_lv26.desc.asm"
	INCBIN "gfx/cards/marowak_lv26.2bpp"

MarowakLv32CardGfx::
	INCLUDE "gfx/cards/marowak_lv32.pal.asm"
	INCLUDE "gfx/cards/marowak_lv32.desc.asm"
	INCBIN "gfx/cards/marowak_lv32.2bpp"

HitmonleeLv30CardGfx::
	INCLUDE "gfx/cards/hitmonlee_lv30.pal.asm"
	INCLUDE "gfx/cards/hitmonlee_lv30.desc.asm"
	INCBIN "gfx/cards/hitmonlee_lv30.2bpp"

HitmonchanLv33CardGfx::
	INCLUDE "gfx/cards/hitmonchan_lv33.pal.asm"
	INCLUDE "gfx/cards/hitmonchan_lv33.desc.asm"
	INCBIN "gfx/cards/hitmonchan_lv33.2bpp"

	ds $18

SECTION "Card Gfx 9", ROMX

RhyhornCardGfx::
	INCLUDE "gfx/cards/rhyhorn.pal.asm"
	INCLUDE "gfx/cards/rhyhorn.desc.asm"
	INCBIN "gfx/cards/rhyhorn.2bpp"

RhydonLv48CardGfx::
	INCLUDE "gfx/cards/rhydon_lv48.pal.asm"
	INCLUDE "gfx/cards/rhydon_lv48.desc.asm"
	INCBIN "gfx/cards/rhydon_lv48.2bpp"

KabutoLv9CardGfx::
	INCLUDE "gfx/cards/kabuto_lv9.pal.asm"
	INCLUDE "gfx/cards/kabuto_lv9.desc.asm"
	INCBIN "gfx/cards/kabuto_lv9.2bpp"

KabutopsCardGfx::
	INCLUDE "gfx/cards/kabutops.pal.asm"
	INCLUDE "gfx/cards/kabutops.desc.asm"
	INCBIN "gfx/cards/kabutops.2bpp"

AerodactylLv28CardGfx::
	INCLUDE "gfx/cards/aerodactyl_lv28.pal.asm"
	INCLUDE "gfx/cards/aerodactyl_lv28.desc.asm"
	INCBIN "gfx/cards/aerodactyl_lv28.2bpp"
AerodactylLv28CardGfxExtra::
	INCBIN "gfx/cards/aerodactyl_lv28_extra.2bpp"

AbraLv10CardGfx::
	INCLUDE "gfx/cards/abra_lv10.pal.asm"
	INCLUDE "gfx/cards/abra_lv10.desc.asm"
	INCBIN "gfx/cards/abra_lv10.2bpp"
AbraLv10CardGfxExtra::
	INCBIN "gfx/cards/abra_lv10_extra.2bpp"

KadabraLv38CardGfx::
	INCLUDE "gfx/cards/kadabra_lv38.pal.asm"
	INCLUDE "gfx/cards/kadabra_lv38.desc.asm"
	INCBIN "gfx/cards/kadabra_lv38.2bpp"
KadabraLv38CardGfxExtra::
	INCBIN "gfx/cards/kadabra_lv38_extra.2bpp"

AlakazamLv42CardGfx::
	INCLUDE "gfx/cards/alakazam_lv42.pal.asm"
	INCLUDE "gfx/cards/alakazam_lv42.desc.asm"
	INCBIN "gfx/cards/alakazam_lv42.2bpp"

SlowpokeLv9CardGfx::
	INCLUDE "gfx/cards/slowpoke_lv9.pal.asm"
	INCLUDE "gfx/cards/slowpoke_lv9.desc.asm"
	INCBIN "gfx/cards/slowpoke_lv9.2bpp"
SlowpokeLv9CardGfxExtra::
	INCBIN "gfx/cards/slowpoke_lv9_extra.2bpp"

SlowpokeLv18CardGfx::
	INCLUDE "gfx/cards/slowpoke_lv18.pal.asm"
	INCLUDE "gfx/cards/slowpoke_lv18.desc.asm"
	INCBIN "gfx/cards/slowpoke_lv18.2bpp"
SlowpokeLv18CardGfxExtra::
	INCBIN "gfx/cards/slowpoke_lv18_extra.2bpp"

SlowbroLv26CardGfx::
	INCLUDE "gfx/cards/slowbro_lv26.pal.asm"
	INCLUDE "gfx/cards/slowbro_lv26.desc.asm"
	INCBIN "gfx/cards/slowbro_lv26.2bpp"
SlowbroLv26CardGfxExtra::
	INCBIN "gfx/cards/slowbro_lv26_extra.2bpp"

GastlyLv8CardGfx::
	INCLUDE "gfx/cards/gastly_lv8.pal.asm"
	INCLUDE "gfx/cards/gastly_lv8.desc.asm"
	INCBIN "gfx/cards/gastly_lv8.2bpp"

GastlyLv17CardGfx::
	INCLUDE "gfx/cards/gastly_lv17.pal.asm"
	INCLUDE "gfx/cards/gastly_lv17.desc.asm"
	INCBIN "gfx/cards/gastly_lv17.2bpp"

HaunterLv17CardGfx::
	INCLUDE "gfx/cards/haunter_lv17.pal.asm"
	INCLUDE "gfx/cards/haunter_lv17.desc.asm"
	INCBIN "gfx/cards/haunter_lv17.2bpp"

HaunterLv22CardGfx::
	INCLUDE "gfx/cards/haunter_lv22.pal.asm"
	INCLUDE "gfx/cards/haunter_lv22.desc.asm"
	INCBIN "gfx/cards/haunter_lv22.2bpp"

GengarLv38CardGfx::
	INCLUDE "gfx/cards/gengar_lv38.pal.asm"
	INCLUDE "gfx/cards/gengar_lv38.desc.asm"
	INCBIN "gfx/cards/gengar_lv38.2bpp"
GengarLv38CardGfxExtra::
	INCBIN "gfx/cards/gengar_lv38_extra.2bpp"

DrowzeeLv12CardGfx::
	INCLUDE "gfx/cards/drowzee_lv12.pal.asm"
	INCLUDE "gfx/cards/drowzee_lv12.desc.asm"
	INCBIN "gfx/cards/drowzee_lv12.2bpp"

HypnoLv36CardGfx::
	INCLUDE "gfx/cards/hypno_lv36.pal.asm"
	INCLUDE "gfx/cards/hypno_lv36.desc.asm"
	INCBIN "gfx/cards/hypno_lv36.2bpp"

	ds $240

SECTION "Card Gfx 10", ROMX

MrMimeLv28CardGfx::
	INCLUDE "gfx/cards/mr_mime_lv28.pal.asm"
	INCLUDE "gfx/cards/mr_mime_lv28.desc.asm"
	INCBIN "gfx/cards/mr_mime_lv28.2bpp"

JynxLv23CardGfx::
	INCLUDE "gfx/cards/jynx_lv23.pal.asm"
	INCLUDE "gfx/cards/jynx_lv23.desc.asm"
	INCBIN "gfx/cards/jynx_lv23.2bpp"

MewtwoLv53CardGfx::
	INCLUDE "gfx/cards/mewtwo_lv53.pal.asm"
	INCLUDE "gfx/cards/mewtwo_lv53.desc.asm"
	INCBIN "gfx/cards/mewtwo_lv53.2bpp"

MewtwoLv60CardGfx::
	INCLUDE "gfx/cards/mewtwo_lv60.pal.asm"
	INCLUDE "gfx/cards/mewtwo_lv60.desc.asm"
	INCBIN "gfx/cards/mewtwo_lv60.2bpp"

MewtwoAltLv60CardGfx::
	INCLUDE "gfx/cards/mewtwo_alt_lv60.pal.asm"
	INCLUDE "gfx/cards/mewtwo_alt_lv60.desc.asm"
	INCBIN "gfx/cards/mewtwo_alt_lv60.2bpp"
MewtwoAltLv60CardGfxExtra::
	INCBIN "gfx/cards/mewtwo_alt_lv60_extra.2bpp"

MewLv8CardGfx::
	INCLUDE "gfx/cards/mew_lv8.pal.asm"
	INCLUDE "gfx/cards/mew_lv8.desc.asm"
	INCBIN "gfx/cards/mew_lv8.2bpp"

MewLv15CardGfx::
	INCLUDE "gfx/cards/mew_lv15.pal.asm"
	INCLUDE "gfx/cards/mew_lv15.desc.asm"
	INCBIN "gfx/cards/mew_lv15.2bpp"

MewLv23CardGfx::
	INCLUDE "gfx/cards/mew_lv23.pal.asm"
	INCLUDE "gfx/cards/mew_lv23.desc.asm"
	INCBIN "gfx/cards/mew_lv23.2bpp"

PidgeyLv8CardGfx::
	INCLUDE "gfx/cards/pidgey_lv8.pal.asm"
	INCLUDE "gfx/cards/pidgey_lv8.desc.asm"
	INCBIN "gfx/cards/pidgey_lv8.2bpp"

PidgeottoLv36CardGfx::
	INCLUDE "gfx/cards/pidgeotto_lv36.pal.asm"
	INCLUDE "gfx/cards/pidgeotto_lv36.desc.asm"
	INCBIN "gfx/cards/pidgeotto_lv36.2bpp"

PidgeotLv38CardGfx::
	INCLUDE "gfx/cards/pidgeot_lv38.pal.asm"
	INCLUDE "gfx/cards/pidgeot_lv38.desc.asm"
	INCBIN "gfx/cards/pidgeot_lv38.2bpp"

PidgeotLv40CardGfx::
	INCLUDE "gfx/cards/pidgeot_lv40.pal.asm"
	INCLUDE "gfx/cards/pidgeot_lv40.desc.asm"
	INCBIN "gfx/cards/pidgeot_lv40.2bpp"

RattataLv9CardGfx::
	INCLUDE "gfx/cards/rattata_lv9.pal.asm"
	INCLUDE "gfx/cards/rattata_lv9.desc.asm"
	INCBIN "gfx/cards/rattata_lv9.2bpp"
RattataLv9CardGfxExtra::
	INCBIN "gfx/cards/rattata_lv9_extra.2bpp"

RaticateCardGfx::
	INCLUDE "gfx/cards/raticate.pal.asm"
	INCLUDE "gfx/cards/raticate.desc.asm"
	INCBIN "gfx/cards/raticate.2bpp"

SpearowLv13CardGfx::
	INCLUDE "gfx/cards/spearow_lv13.pal.asm"
	INCLUDE "gfx/cards/spearow_lv13.desc.asm"
	INCBIN "gfx/cards/spearow_lv13.2bpp"
SpearowLv13CardGfxExtra::
	INCBIN "gfx/cards/spearow_lv13_extra.2bpp"

FearowLv27CardGfx::
	INCLUDE "gfx/cards/fearow_lv27.pal.asm"
	INCLUDE "gfx/cards/fearow_lv27.desc.asm"
	INCBIN "gfx/cards/fearow_lv27.2bpp"
FearowLv27CardGfxExtra::
	INCBIN "gfx/cards/fearow_lv27_extra.2bpp"

ClefairyLv14CardGfx::
	INCLUDE "gfx/cards/clefairy_lv14.pal.asm"
	INCLUDE "gfx/cards/clefairy_lv14.desc.asm"
	INCBIN "gfx/cards/clefairy_lv14.2bpp"

ClefableCardGfx::
	INCLUDE "gfx/cards/clefable.pal.asm"
	INCLUDE "gfx/cards/clefable.desc.asm"
	INCBIN "gfx/cards/clefable.2bpp"

	ds $f0

SECTION "Card Gfx 11", ROMX

JigglypuffLv12CardGfx::
	INCLUDE "gfx/cards/jigglypuff_lv12.pal.asm"
	INCLUDE "gfx/cards/jigglypuff_lv12.desc.asm"
	INCBIN "gfx/cards/jigglypuff_lv12.2bpp"

JigglypuffLv13CardGfx::
	INCLUDE "gfx/cards/jigglypuff_lv13.pal.asm"
	INCLUDE "gfx/cards/jigglypuff_lv13.desc.asm"
	INCBIN "gfx/cards/jigglypuff_lv13.2bpp"

JigglypuffLv14CardGfx::
	INCLUDE "gfx/cards/jigglypuff_lv14.pal.asm"
	INCLUDE "gfx/cards/jigglypuff_lv14.desc.asm"
	INCBIN "gfx/cards/jigglypuff_lv14.2bpp"

WigglytuffLv36CardGfx::
	INCLUDE "gfx/cards/wigglytuff_lv36.pal.asm"
	INCLUDE "gfx/cards/wigglytuff_lv36.desc.asm"
	INCBIN "gfx/cards/wigglytuff_lv36.2bpp"

MeowthLv13CardGfx::
	INCLUDE "gfx/cards/meowth_lv13.pal.asm"
	INCLUDE "gfx/cards/meowth_lv13.desc.asm"
	INCBIN "gfx/cards/meowth_lv13.2bpp"
MeowthLv13CardGfxExtra::
	INCBIN "gfx/cards/meowth_lv13_extra.2bpp"

MeowthLv15CardGfx::
	INCLUDE "gfx/cards/meowth_lv15.pal.asm"
	INCLUDE "gfx/cards/meowth_lv15.desc.asm"
	INCBIN "gfx/cards/meowth_lv15.2bpp"
MeowthLv15CardGfxExtra::
	INCBIN "gfx/cards/meowth_lv15_extra.2bpp"

PersianCardGfx::
	INCLUDE "gfx/cards/persian.pal.asm"
	INCLUDE "gfx/cards/persian.desc.asm"
	INCBIN "gfx/cards/persian.2bpp"
PersianCardGfxExtra::
	INCBIN "gfx/cards/persian_extra.2bpp"

FarfetchdLv20CardGfx::
	INCLUDE "gfx/cards/farfetchd_lv20.pal.asm"
	INCLUDE "gfx/cards/farfetchd_lv20.desc.asm"
	INCBIN "gfx/cards/farfetchd_lv20.2bpp"
FarfetchdLv20CardGfxExtra::
	INCBIN "gfx/cards/farfetchd_lv20_extra.2bpp"

DoduoLv10CardGfx::
	INCLUDE "gfx/cards/doduo_lv10.pal.asm"
	INCLUDE "gfx/cards/doduo_lv10.desc.asm"
	INCBIN "gfx/cards/doduo_lv10.2bpp"

DodrioLv28CardGfx::
	INCLUDE "gfx/cards/dodrio_lv28.pal.asm"
	INCLUDE "gfx/cards/dodrio_lv28.desc.asm"
	INCBIN "gfx/cards/dodrio_lv28.2bpp"

LickitungLv26CardGfx::
	INCLUDE "gfx/cards/lickitung_lv26.pal.asm"
	INCLUDE "gfx/cards/lickitung_lv26.desc.asm"
	INCBIN "gfx/cards/lickitung_lv26.2bpp"

ChanseyLv55CardGfx::
	INCLUDE "gfx/cards/chansey_lv55.pal.asm"
	INCLUDE "gfx/cards/chansey_lv55.desc.asm"
	INCBIN "gfx/cards/chansey_lv55.2bpp"

KangaskhanLv40CardGfx::
	INCLUDE "gfx/cards/kangaskhan_lv40.pal.asm"
	INCLUDE "gfx/cards/kangaskhan_lv40.desc.asm"
	INCBIN "gfx/cards/kangaskhan_lv40.2bpp"

TaurosLv32CardGfx::
	INCLUDE "gfx/cards/tauros_lv32.pal.asm"
	INCLUDE "gfx/cards/tauros_lv32.desc.asm"
	INCBIN "gfx/cards/tauros_lv32.2bpp"

DittoCardGfx::
	INCLUDE "gfx/cards/ditto.pal.asm"
	INCLUDE "gfx/cards/ditto.desc.asm"
	INCBIN "gfx/cards/ditto.2bpp"
DittoCardGfxExtra::
	INCBIN "gfx/cards/ditto_extra.2bpp"

EeveeLv12CardGfx::
	INCLUDE "gfx/cards/eevee_lv12.pal.asm"
	INCLUDE "gfx/cards/eevee_lv12.desc.asm"
	INCBIN "gfx/cards/eevee_lv12.2bpp"

PorygonLv12CardGfx::
	INCLUDE "gfx/cards/porygon_lv12.pal.asm"
	INCLUDE "gfx/cards/porygon_lv12.desc.asm"
	INCBIN "gfx/cards/porygon_lv12.2bpp"

SnorlaxLv20CardGfx::
	INCLUDE "gfx/cards/snorlax_lv20.pal.asm"
	INCLUDE "gfx/cards/snorlax_lv20.desc.asm"
	INCBIN "gfx/cards/snorlax_lv20.2bpp"

	ds $2c0

SECTION "Card Gfx 12", ROMX

DratiniLv10CardGfx::
	INCLUDE "gfx/cards/dratini_lv10.pal.asm"
	INCLUDE "gfx/cards/dratini_lv10.desc.asm"
	INCBIN "gfx/cards/dratini_lv10.2bpp"

DragonairCardGfx::
	INCLUDE "gfx/cards/dragonair.pal.asm"
	INCLUDE "gfx/cards/dragonair.desc.asm"
	INCBIN "gfx/cards/dragonair.2bpp"

DragoniteLv41CardGfx::
	INCLUDE "gfx/cards/dragonite_lv41.pal.asm"
	INCLUDE "gfx/cards/dragonite_lv41.desc.asm"
	INCBIN "gfx/cards/dragonite_lv41.2bpp"
DragoniteLv41CardGfxExtra::
	INCBIN "gfx/cards/dragonite_lv41_extra.2bpp"

DragoniteLv45CardGfx::
	INCLUDE "gfx/cards/dragonite_lv45.pal.asm"
	INCLUDE "gfx/cards/dragonite_lv45.desc.asm"
	INCBIN "gfx/cards/dragonite_lv45.2bpp"

CharmanderLv9CardGfx::
	INCLUDE "gfx/cards/charmander_lv9.pal.asm"
	INCLUDE "gfx/cards/charmander_lv9.desc.asm"
	INCBIN "gfx/cards/charmander_lv9.2bpp"

DarkCharmeleonCardGfx::
	INCLUDE "gfx/cards/dark_charmeleon.pal.asm"
	INCLUDE "gfx/cards/dark_charmeleon.desc.asm"
	INCBIN "gfx/cards/dark_charmeleon.2bpp"

DarkCharizardCardGfx::
	INCLUDE "gfx/cards/dark_charizard.pal.asm"
	INCLUDE "gfx/cards/dark_charizard.desc.asm"
	INCBIN "gfx/cards/dark_charizard.2bpp"

PonytaLv15CardGfx::
	INCLUDE "gfx/cards/ponyta_lv15.pal.asm"
	INCLUDE "gfx/cards/ponyta_lv15.desc.asm"
	INCBIN "gfx/cards/ponyta_lv15.2bpp"

DarkRapidashCardGfx::
	INCLUDE "gfx/cards/dark_rapidash.pal.asm"
	INCLUDE "gfx/cards/dark_rapidash.desc.asm"
	INCBIN "gfx/cards/dark_rapidash.2bpp"

DarkFlareonCardGfx::
	INCLUDE "gfx/cards/dark_flareon.pal.asm"
	INCLUDE "gfx/cards/dark_flareon.desc.asm"
	INCBIN "gfx/cards/dark_flareon.2bpp"

SquirtleLv16CardGfx::
	INCLUDE "gfx/cards/squirtle_lv16.pal.asm"
	INCLUDE "gfx/cards/squirtle_lv16.desc.asm"
	INCBIN "gfx/cards/squirtle_lv16.2bpp"
SquirtleLv16CardGfxExtra::
	INCBIN "gfx/cards/squirtle_lv16_extra.2bpp"

DarkWartortleCardGfx::
	INCLUDE "gfx/cards/dark_wartortle.pal.asm"
	INCLUDE "gfx/cards/dark_wartortle.desc.asm"
	INCBIN "gfx/cards/dark_wartortle.2bpp"
DarkWartortleCardGfxExtra::
	INCBIN "gfx/cards/dark_wartortle_extra.2bpp"

DarkBlastoiseCardGfx::
	INCLUDE "gfx/cards/dark_blastoise.pal.asm"
	INCLUDE "gfx/cards/dark_blastoise.desc.asm"
	INCBIN "gfx/cards/dark_blastoise.2bpp"

PsyduckLv16CardGfx::
	INCLUDE "gfx/cards/psyduck_lv16.pal.asm"
	INCLUDE "gfx/cards/psyduck_lv16.desc.asm"
	INCBIN "gfx/cards/psyduck_lv16.2bpp"

DarkGolduckCardGfx::
	INCLUDE "gfx/cards/dark_golduck.pal.asm"
	INCLUDE "gfx/cards/dark_golduck.desc.asm"
	INCBIN "gfx/cards/dark_golduck.2bpp"

MagikarpLv6CardGfx::
	INCLUDE "gfx/cards/magikarp_lv6.pal.asm"
	INCLUDE "gfx/cards/magikarp_lv6.desc.asm"
	INCBIN "gfx/cards/magikarp_lv6.2bpp"

DarkGyaradosCardGfx::
	INCLUDE "gfx/cards/dark_gyarados.pal.asm"
	INCLUDE "gfx/cards/dark_gyarados.desc.asm"
	INCBIN "gfx/cards/dark_gyarados.2bpp"

DarkVaporeonCardGfx::
	INCLUDE "gfx/cards/dark_vaporeon.pal.asm"
	INCLUDE "gfx/cards/dark_vaporeon.desc.asm"
	INCBIN "gfx/cards/dark_vaporeon.2bpp"

	ds $270

SECTION "Card Gfx 13", ROMX

EkansLv15CardGfx::
	INCLUDE "gfx/cards/ekans_lv15.pal.asm"
	INCLUDE "gfx/cards/ekans_lv15.desc.asm"
	INCBIN "gfx/cards/ekans_lv15.2bpp"
EkansLv15CardGfxExtra::
	INCBIN "gfx/cards/ekans_lv15_extra.2bpp"

DarkArbokCardGfx::
	INCLUDE "gfx/cards/dark_arbok.pal.asm"
	INCLUDE "gfx/cards/dark_arbok.desc.asm"
	INCBIN "gfx/cards/dark_arbok.2bpp"
DarkArbokCardGfxExtra::
	INCBIN "gfx/cards/dark_arbok_extra.2bpp"

ZubatLv9CardGfx::
	INCLUDE "gfx/cards/zubat_lv9.pal.asm"
	INCLUDE "gfx/cards/zubat_lv9.desc.asm"
	INCBIN "gfx/cards/zubat_lv9.2bpp"

DarkGolbatCardGfx::
	INCLUDE "gfx/cards/dark_golbat.pal.asm"
	INCLUDE "gfx/cards/dark_golbat.desc.asm"
	INCBIN "gfx/cards/dark_golbat.2bpp"
DarkGolbatCardGfxExtra::
	INCBIN "gfx/cards/dark_golbat_extra.2bpp"

OddishLv21CardGfx::
	INCLUDE "gfx/cards/oddish_lv21.pal.asm"
	INCLUDE "gfx/cards/oddish_lv21.desc.asm"
	INCBIN "gfx/cards/oddish_lv21.2bpp"

DarkGloomCardGfx::
	INCLUDE "gfx/cards/dark_gloom.pal.asm"
	INCLUDE "gfx/cards/dark_gloom.desc.asm"
	INCBIN "gfx/cards/dark_gloom.2bpp"

DarkVileplumeCardGfx::
	INCLUDE "gfx/cards/dark_vileplume.pal.asm"
	INCLUDE "gfx/cards/dark_vileplume.desc.asm"
	INCBIN "gfx/cards/dark_vileplume.2bpp"

GrimerLv10CardGfx::
	INCLUDE "gfx/cards/grimer_lv10.pal.asm"
	INCLUDE "gfx/cards/grimer_lv10.desc.asm"
	INCBIN "gfx/cards/grimer_lv10.2bpp"

DarkMukCardGfx::
	INCLUDE "gfx/cards/dark_muk.pal.asm"
	INCLUDE "gfx/cards/dark_muk.desc.asm"
	INCBIN "gfx/cards/dark_muk.2bpp"

KoffingLv12CardGfx::
	INCLUDE "gfx/cards/koffing_lv12.pal.asm"
	INCLUDE "gfx/cards/koffing_lv12.desc.asm"
	INCBIN "gfx/cards/koffing_lv12.2bpp"

DarkWeezingCardGfx::
	INCLUDE "gfx/cards/dark_weezing.pal.asm"
	INCLUDE "gfx/cards/dark_weezing.desc.asm"
	INCBIN "gfx/cards/dark_weezing.2bpp"

AbraLv14CardGfx::
	INCLUDE "gfx/cards/abra_lv14.pal.asm"
	INCLUDE "gfx/cards/abra_lv14.desc.asm"
	INCBIN "gfx/cards/abra_lv14.2bpp"

DarkKadabraCardGfx::
	INCLUDE "gfx/cards/dark_kadabra.pal.asm"
	INCLUDE "gfx/cards/dark_kadabra.desc.asm"
	INCBIN "gfx/cards/dark_kadabra.2bpp"

DarkAlakazamCardGfx::
	INCLUDE "gfx/cards/dark_alakazam.pal.asm"
	INCLUDE "gfx/cards/dark_alakazam.desc.asm"
	INCBIN "gfx/cards/dark_alakazam.2bpp"
DarkAlakazamCardGfxExtra::
	INCBIN "gfx/cards/dark_alakazam_extra.2bpp"

SlowpokeLv16CardGfx::
	INCLUDE "gfx/cards/slowpoke_lv16.pal.asm"
	INCLUDE "gfx/cards/slowpoke_lv16.desc.asm"
	INCBIN "gfx/cards/slowpoke_lv16.2bpp"
SlowpokeLv16CardGfxExtra::
	INCBIN "gfx/cards/slowpoke_lv16_extra.2bpp"

DarkSlowbroCardGfx::
	INCLUDE "gfx/cards/dark_slowbro.pal.asm"
	INCLUDE "gfx/cards/dark_slowbro.desc.asm"
	INCBIN "gfx/cards/dark_slowbro.2bpp"
DarkSlowbroCardGfxExtra::
	INCBIN "gfx/cards/dark_slowbro_extra.2bpp"

DrowzeeLv10CardGfx::
	INCLUDE "gfx/cards/drowzee_lv10.pal.asm"
	INCLUDE "gfx/cards/drowzee_lv10.desc.asm"
	INCBIN "gfx/cards/drowzee_lv10.2bpp"
DrowzeeLv10CardGfxExtra::
	INCBIN "gfx/cards/drowzee_lv10_extra.2bpp"

DarkHypnoCardGfx::
	INCLUDE "gfx/cards/dark_hypno.pal.asm"
	INCLUDE "gfx/cards/dark_hypno.desc.asm"
	INCBIN "gfx/cards/dark_hypno.2bpp"

	ds $1e0

SECTION "Card Gfx 14", ROMX

DiglettLv15CardGfx::
	INCLUDE "gfx/cards/diglett_lv15.pal.asm"
	INCLUDE "gfx/cards/diglett_lv15.desc.asm"
	INCBIN "gfx/cards/diglett_lv15.2bpp"
DiglettLv15CardGfxExtra::
	INCBIN "gfx/cards/diglett_lv15_extra.2bpp"

DarkDugtrioCardGfx::
	INCLUDE "gfx/cards/dark_dugtrio.pal.asm"
	INCLUDE "gfx/cards/dark_dugtrio.desc.asm"
	INCBIN "gfx/cards/dark_dugtrio.2bpp"

MankeyLv14CardGfx::
	INCLUDE "gfx/cards/mankey_lv14.pal.asm"
	INCLUDE "gfx/cards/mankey_lv14.desc.asm"
	INCBIN "gfx/cards/mankey_lv14.2bpp"
MankeyLv14CardGfxExtra::
	INCBIN "gfx/cards/mankey_lv14_extra.2bpp"

DarkPrimeapeCardGfx::
	INCLUDE "gfx/cards/dark_primeape.pal.asm"
	INCLUDE "gfx/cards/dark_primeape.desc.asm"
	INCBIN "gfx/cards/dark_primeape.2bpp"
DarkPrimeapeCardGfxExtra::
	INCBIN "gfx/cards/dark_primeape_extra.2bpp"

MachopLv24CardGfx::
	INCLUDE "gfx/cards/machop_lv24.pal.asm"
	INCLUDE "gfx/cards/machop_lv24.desc.asm"
	INCBIN "gfx/cards/machop_lv24.2bpp"
MachopLv24CardGfxExtra::
	INCBIN "gfx/cards/machop_lv24_extra.2bpp"

DarkMachokeCardGfx::
	INCLUDE "gfx/cards/dark_machoke.pal.asm"
	INCLUDE "gfx/cards/dark_machoke.desc.asm"
	INCBIN "gfx/cards/dark_machoke.2bpp"
DarkMachokeCardGfxExtra::
	INCBIN "gfx/cards/dark_machoke_extra.2bpp"

DarkMachampCardGfx::
	INCLUDE "gfx/cards/dark_machamp.pal.asm"
	INCLUDE "gfx/cards/dark_machamp.desc.asm"
	INCBIN "gfx/cards/dark_machamp.2bpp"

RattataLv12CardGfx::
	INCLUDE "gfx/cards/rattata_lv12.pal.asm"
	INCLUDE "gfx/cards/rattata_lv12.desc.asm"
	INCBIN "gfx/cards/rattata_lv12.2bpp"

DarkRaticateCardGfx::
	INCLUDE "gfx/cards/dark_raticate.pal.asm"
	INCLUDE "gfx/cards/dark_raticate.desc.asm"
	INCBIN "gfx/cards/dark_raticate.2bpp"
DarkRaticateCardGfxExtra::
	INCBIN "gfx/cards/dark_raticate_extra.2bpp"

MeowthLv10CardGfx::
	INCLUDE "gfx/cards/meowth_lv10.pal.asm"
	INCLUDE "gfx/cards/meowth_lv10.desc.asm"
	INCBIN "gfx/cards/meowth_lv10.2bpp"

DarkPersianLv28CardGfx::
	INCLUDE "gfx/cards/dark_persian_lv28.pal.asm"
	INCLUDE "gfx/cards/dark_persian_lv28.desc.asm"
	INCBIN "gfx/cards/dark_persian_lv28.2bpp"

EeveeLv9CardGfx::
	INCLUDE "gfx/cards/eevee_lv9.pal.asm"
	INCLUDE "gfx/cards/eevee_lv9.desc.asm"
	INCBIN "gfx/cards/eevee_lv9.2bpp"
EeveeLv9CardGfxExtra::
	INCBIN "gfx/cards/eevee_lv9_extra.2bpp"

PorygonLv20CardGfx::
	INCLUDE "gfx/cards/porygon_lv20.pal.asm"
	INCLUDE "gfx/cards/porygon_lv20.desc.asm"
	INCBIN "gfx/cards/porygon_lv20.2bpp"
PorygonLv20CardGfxExtra::
	INCBIN "gfx/cards/porygon_lv20_extra.2bpp"

DratiniLv12CardGfx::
	INCLUDE "gfx/cards/dratini_lv12.pal.asm"
	INCLUDE "gfx/cards/dratini_lv12.desc.asm"
	INCBIN "gfx/cards/dratini_lv12.2bpp"

DarkDragonairCardGfx::
	INCLUDE "gfx/cards/dark_dragonair.pal.asm"
	INCLUDE "gfx/cards/dark_dragonair.desc.asm"
	INCBIN "gfx/cards/dark_dragonair.2bpp"

DarkDragoniteCardGfx::
	INCLUDE "gfx/cards/dark_dragonite.pal.asm"
	INCLUDE "gfx/cards/dark_dragonite.desc.asm"
	INCBIN "gfx/cards/dark_dragonite.2bpp"

MagnemiteLv12CardGfx::
	INCLUDE "gfx/cards/magnemite_lv12.pal.asm"
	INCLUDE "gfx/cards/magnemite_lv12.desc.asm"
	INCBIN "gfx/cards/magnemite_lv12.2bpp"

DarkMagnetonCardGfx::
	INCLUDE "gfx/cards/dark_magneton.pal.asm"
	INCLUDE "gfx/cards/dark_magneton.desc.asm"
	INCBIN "gfx/cards/dark_magneton.2bpp"
DarkMagnetonCardGfxExtra::
	INCBIN "gfx/cards/dark_magneton_extra.2bpp"

	ds $90

SECTION "Card Gfx 15", ROMX

VoltorbLv13CardGfx::
	INCLUDE "gfx/cards/voltorb_lv13.pal.asm"
	INCLUDE "gfx/cards/voltorb_lv13.desc.asm"
	INCBIN "gfx/cards/voltorb_lv13.2bpp"

DarkElectrodeCardGfx::
	INCLUDE "gfx/cards/dark_electrode.pal.asm"
	INCLUDE "gfx/cards/dark_electrode.desc.asm"
	INCBIN "gfx/cards/dark_electrode.2bpp"

DarkJolteonCardGfx::
	INCLUDE "gfx/cards/dark_jolteon.pal.asm"
	INCLUDE "gfx/cards/dark_jolteon.desc.asm"
	INCBIN "gfx/cards/dark_jolteon.2bpp"

BulbasaurLv15CardGfx::
	INCLUDE "gfx/cards/bulbasaur_lv15.pal.asm"
	INCLUDE "gfx/cards/bulbasaur_lv15.desc.asm"
	INCBIN "gfx/cards/bulbasaur_lv15.2bpp"
BulbasaurLv15CardGfxExtra::
	INCBIN "gfx/cards/bulbasaur_lv15_extra.2bpp"

CharmanderLv12CardGfx::
	INCLUDE "gfx/cards/charmander_lv12.pal.asm"
	INCLUDE "gfx/cards/charmander_lv12.desc.asm"
	INCBIN "gfx/cards/charmander_lv12.2bpp"

SquirtleLv15CardGfx::
	INCLUDE "gfx/cards/squirtle_lv15.pal.asm"
	INCLUDE "gfx/cards/squirtle_lv15.desc.asm"
	INCBIN "gfx/cards/squirtle_lv15.2bpp"

MetapodLv20CardGfx::
	INCLUDE "gfx/cards/metapod_lv20.pal.asm"
	INCLUDE "gfx/cards/metapod_lv20.desc.asm"
	INCBIN "gfx/cards/metapod_lv20.2bpp"
MetapodLv20CardGfxExtra::
	INCBIN "gfx/cards/metapod_lv20_extra.2bpp"

WeedleLv15CardGfx::
	INCLUDE "gfx/cards/weedle_lv15.pal.asm"
	INCLUDE "gfx/cards/weedle_lv15.desc.asm"
	INCBIN "gfx/cards/weedle_lv15.2bpp"
WeedleLv15CardGfxExtra::
	INCBIN "gfx/cards/weedle_lv15_extra.2bpp"

KakunaLv20CardGfx::
	INCLUDE "gfx/cards/kakuna_lv20.pal.asm"
	INCLUDE "gfx/cards/kakuna_lv20.desc.asm"
	INCBIN "gfx/cards/kakuna_lv20.2bpp"
KakunaLv20CardGfxExtra::
	INCBIN "gfx/cards/kakuna_lv20_extra.2bpp"

PidgeyLv10CardGfx::
	INCLUDE "gfx/cards/pidgey_lv10.pal.asm"
	INCLUDE "gfx/cards/pidgey_lv10.desc.asm"
	INCBIN "gfx/cards/pidgey_lv10.2bpp"
PidgeyLv10CardGfxExtra::
	INCBIN "gfx/cards/pidgey_lv10_extra.2bpp"

RattataLv15CardGfx::
	INCLUDE "gfx/cards/rattata_lv15.pal.asm"
	INCLUDE "gfx/cards/rattata_lv15.desc.asm"
	INCBIN "gfx/cards/rattata_lv15.2bpp"
RattataLv15CardGfxExtra::
	INCBIN "gfx/cards/rattata_lv15_extra.2bpp"

PikachuLv5CardGfx::
	INCLUDE "gfx/cards/pikachu_lv5.pal.asm"
	INCLUDE "gfx/cards/pikachu_lv5.desc.asm"
	INCBIN "gfx/cards/pikachu_lv5.2bpp"

NidoranFLv12CardGfx::
	INCLUDE "gfx/cards/nidoran_f_lv12.pal.asm"
	INCLUDE "gfx/cards/nidoran_f_lv12.desc.asm"
	INCBIN "gfx/cards/nidoran_f_lv12.2bpp"
NidoranFLv12CardGfxExtra::
	INCBIN "gfx/cards/nidoran_f_lv12_extra.2bpp"

NidoranMLv22CardGfx::
	INCLUDE "gfx/cards/nidoran_m_lv22.pal.asm"
	INCLUDE "gfx/cards/nidoran_m_lv22.desc.asm"
	INCBIN "gfx/cards/nidoran_m_lv22.2bpp"

ClefairyLv15CardGfx::
	INCLUDE "gfx/cards/clefairy_lv15.pal.asm"
	INCLUDE "gfx/cards/clefairy_lv15.desc.asm"
	INCBIN "gfx/cards/clefairy_lv15.2bpp"

WigglytuffLv40CardGfx::
	INCLUDE "gfx/cards/wigglytuff_lv40.pal.asm"
	INCLUDE "gfx/cards/wigglytuff_lv40.desc.asm"
	INCBIN "gfx/cards/wigglytuff_lv40.2bpp"

	ds $280

SECTION "Card Gfx 16", ROMX

ZubatLv12CardGfx::
	INCLUDE "gfx/cards/zubat_lv12.pal.asm"
	INCLUDE "gfx/cards/zubat_lv12.desc.asm"
	INCBIN "gfx/cards/zubat_lv12.2bpp"

GolbatLv25CardGfx::
	INCLUDE "gfx/cards/golbat_lv25.pal.asm"
	INCLUDE "gfx/cards/golbat_lv25.desc.asm"
	INCBIN "gfx/cards/golbat_lv25.2bpp"
GolbatLv25CardGfxExtra::
	INCBIN "gfx/cards/golbat_lv25_extra.2bpp"

ParasLv15CardGfx::
	INCLUDE "gfx/cards/paras_lv15.pal.asm"
	INCLUDE "gfx/cards/paras_lv15.desc.asm"
	INCBIN "gfx/cards/paras_lv15.2bpp"

ParasectLv29CardGfx::
	INCLUDE "gfx/cards/parasect_lv29.pal.asm"
	INCLUDE "gfx/cards/parasect_lv29.desc.asm"
	INCBIN "gfx/cards/parasect_lv29.2bpp"
ParasectLv29CardGfxExtra::
	INCBIN "gfx/cards/parasect_lv29_extra.2bpp"

PoliwagLv15CardGfx::
	INCLUDE "gfx/cards/poliwag_lv15.pal.asm"
	INCLUDE "gfx/cards/poliwag_lv15.desc.asm"
	INCBIN "gfx/cards/poliwag_lv15.2bpp"

PoliwhirlLv30CardGfx::
	INCLUDE "gfx/cards/poliwhirl_lv30.pal.asm"
	INCLUDE "gfx/cards/poliwhirl_lv30.desc.asm"
	INCBIN "gfx/cards/poliwhirl_lv30.2bpp"
PoliwhirlLv30CardGfxExtra::
	INCBIN "gfx/cards/poliwhirl_lv30_extra.2bpp"

PoliwrathLv40CardGfx::
	INCLUDE "gfx/cards/poliwrath_lv40.pal.asm"
	INCLUDE "gfx/cards/poliwrath_lv40.desc.asm"
	INCBIN "gfx/cards/poliwrath_lv40.2bpp"
PoliwrathLv40CardGfxExtra::
	INCBIN "gfx/cards/poliwrath_lv40_extra.2bpp"

AbraLv8CardGfx::
	INCLUDE "gfx/cards/abra_lv8.pal.asm"
	INCLUDE "gfx/cards/abra_lv8.desc.asm"
	INCBIN "gfx/cards/abra_lv8.2bpp"

GeodudeLv15CardGfx::
	INCLUDE "gfx/cards/geodude_lv15.pal.asm"
	INCLUDE "gfx/cards/geodude_lv15.desc.asm"
	INCBIN "gfx/cards/geodude_lv15.2bpp"
GeodudeLv15CardGfxExtra::
	INCBIN "gfx/cards/geodude_lv15_extra.2bpp"

RapidashLv30CardGfx::
	INCLUDE "gfx/cards/rapidash_lv30.pal.asm"
	INCLUDE "gfx/cards/rapidash_lv30.desc.asm"
	INCBIN "gfx/cards/rapidash_lv30.2bpp"

DoduoLv8CardGfx::
	INCLUDE "gfx/cards/doduo_lv8.pal.asm"
	INCLUDE "gfx/cards/doduo_lv8.desc.asm"
	INCBIN "gfx/cards/doduo_lv8.2bpp"

DodrioLv25CardGfx::
	INCLUDE "gfx/cards/dodrio_lv25.pal.asm"
	INCLUDE "gfx/cards/dodrio_lv25.desc.asm"
	INCBIN "gfx/cards/dodrio_lv25.2bpp"

LickitungLv20CardGfx::
	INCLUDE "gfx/cards/lickitung_lv20.pal.asm"
	INCLUDE "gfx/cards/lickitung_lv20.desc.asm"
	INCBIN "gfx/cards/lickitung_lv20.2bpp"
LickitungLv20CardGfxExtra::
	INCBIN "gfx/cards/lickitung_lv20_extra.2bpp"

ChanseyLv40CardGfx::
	INCLUDE "gfx/cards/chansey_lv40.pal.asm"
	INCLUDE "gfx/cards/chansey_lv40.desc.asm"
	INCBIN "gfx/cards/chansey_lv40.2bpp"
ChanseyLv40CardGfxExtra::
	INCBIN "gfx/cards/chansey_lv40_extra.2bpp"

MrMimeLv20CardGfx::
	INCLUDE "gfx/cards/mr_mime_lv20.pal.asm"
	INCLUDE "gfx/cards/mr_mime_lv20.desc.asm"
	INCBIN "gfx/cards/mr_mime_lv20.2bpp"
MrMimeLv20CardGfxExtra::
	INCBIN "gfx/cards/mr_mime_lv20_extra.2bpp"

PinsirLv15CardGfx::
	INCLUDE "gfx/cards/pinsir_lv15.pal.asm"
	INCLUDE "gfx/cards/pinsir_lv15.desc.asm"
	INCBIN "gfx/cards/pinsir_lv15.2bpp"
PinsirLv15CardGfxExtra::
	INCBIN "gfx/cards/pinsir_lv15_extra.2bpp"

EeveeLv5CardGfx::
	INCLUDE "gfx/cards/eevee_lv5.pal.asm"
	INCLUDE "gfx/cards/eevee_lv5.desc.asm"
	INCBIN "gfx/cards/eevee_lv5.2bpp"
EeveeLv5CardGfxExtra::
	INCBIN "gfx/cards/eevee_lv5_extra.2bpp"

	ds $1b8

SECTION "Card Gfx 17", ROMX

PorygonLv18CardGfx::
	INCLUDE "gfx/cards/porygon_lv18.pal.asm"
	INCLUDE "gfx/cards/porygon_lv18.desc.asm"
	INCBIN "gfx/cards/porygon_lv18.2bpp"
PorygonLv18CardGfxExtra::
	INCBIN "gfx/cards/porygon_lv18_extra.2bpp"

SnorlaxLv35CardGfx::
	INCLUDE "gfx/cards/snorlax_lv35.pal.asm"
	INCLUDE "gfx/cards/snorlax_lv35.desc.asm"
	INCBIN "gfx/cards/snorlax_lv35.2bpp"
SnorlaxLv35CardGfxExtra::
	INCBIN "gfx/cards/snorlax_lv35_extra.2bpp"

MewtwoLv54CardGfx::
	INCLUDE "gfx/cards/mewtwo_lv54.pal.asm"
	INCLUDE "gfx/cards/mewtwo_lv54.desc.asm"
	INCBIN "gfx/cards/mewtwo_lv54.2bpp"
MewtwoLv54CardGfxExtra::
	INCBIN "gfx/cards/mewtwo_lv54_extra.2bpp"

SpearowLv12CardGfx::
	INCLUDE "gfx/cards/spearow_lv12.pal.asm"
	INCLUDE "gfx/cards/spearow_lv12.desc.asm"
	INCBIN "gfx/cards/spearow_lv12.2bpp"

FearowLv24CardGfx::
	INCLUDE "gfx/cards/fearow_lv24.pal.asm"
	INCLUDE "gfx/cards/fearow_lv24.desc.asm"
	INCBIN "gfx/cards/fearow_lv24.2bpp"
FearowLv24CardGfxExtra::
	INCBIN "gfx/cards/fearow_lv24_extra.2bpp"

RaichuLv32CardGfx::
	INCLUDE "gfx/cards/raichu_lv32.pal.asm"
	INCLUDE "gfx/cards/raichu_lv32.desc.asm"
	INCBIN "gfx/cards/raichu_lv32.2bpp"

SandshrewLv15CardGfx::
	INCLUDE "gfx/cards/sandshrew_lv15.pal.asm"
	INCLUDE "gfx/cards/sandshrew_lv15.desc.asm"
	INCBIN "gfx/cards/sandshrew_lv15.2bpp"
SandshrewLv15CardGfxExtra::
	INCBIN "gfx/cards/sandshrew_lv15_extra.2bpp"

VenomothLv22CardGfx::
	INCLUDE "gfx/cards/venomoth_lv22.pal.asm"
	INCLUDE "gfx/cards/venomoth_lv22.desc.asm"
	INCBIN "gfx/cards/venomoth_lv22.2bpp"

MachopLv18CardGfx::
	INCLUDE "gfx/cards/machop_lv18.pal.asm"
	INCLUDE "gfx/cards/machop_lv18.desc.asm"
	INCBIN "gfx/cards/machop_lv18.2bpp"
MachopLv18CardGfxExtra::
	INCBIN "gfx/cards/machop_lv18_extra.2bpp"

MachokeLv28CardGfx::
	INCLUDE "gfx/cards/machoke_lv28.pal.asm"
	INCLUDE "gfx/cards/machoke_lv28.desc.asm"
	INCBIN "gfx/cards/machoke_lv28.2bpp"
MachokeLv28CardGfxExtra::
	INCBIN "gfx/cards/machoke_lv28_extra.2bpp"

GravelerLv28CardGfx::
	INCLUDE "gfx/cards/graveler_lv28.pal.asm"
	INCLUDE "gfx/cards/graveler_lv28.desc.asm"
	INCBIN "gfx/cards/graveler_lv28.2bpp"
GravelerLv28CardGfxExtra::
	INCBIN "gfx/cards/graveler_lv28_extra.2bpp"

MagnemiteLv15CardGfx::
	INCLUDE "gfx/cards/magnemite_lv15.pal.asm"
	INCLUDE "gfx/cards/magnemite_lv15.desc.asm"
	INCBIN "gfx/cards/magnemite_lv15.2bpp"

MagnetonLv30CardGfx::
	INCLUDE "gfx/cards/magneton_lv30.pal.asm"
	INCLUDE "gfx/cards/magneton_lv30.desc.asm"
	INCBIN "gfx/cards/magneton_lv30.2bpp"

SeelLv10CardGfx::
	INCLUDE "gfx/cards/seel_lv10.pal.asm"
	INCLUDE "gfx/cards/seel_lv10.desc.asm"
	INCBIN "gfx/cards/seel_lv10.2bpp"
SeelLv10CardGfxExtra::
	INCBIN "gfx/cards/seel_lv10_extra.2bpp"

DewgongLv24CardGfx::
	INCLUDE "gfx/cards/dewgong_lv24.pal.asm"
	INCLUDE "gfx/cards/dewgong_lv24.desc.asm"
	INCBIN "gfx/cards/dewgong_lv24.2bpp"

ShellderLv16CardGfx::
	INCLUDE "gfx/cards/shellder_lv16.pal.asm"
	INCLUDE "gfx/cards/shellder_lv16.desc.asm"
	INCBIN "gfx/cards/shellder_lv16.2bpp"
ShellderLv16CardGfxExtra::
	INCBIN "gfx/cards/shellder_lv16_extra.2bpp"

OnixLv25CardGfx::
	INCLUDE "gfx/cards/onix_lv25.pal.asm"
	INCLUDE "gfx/cards/onix_lv25.desc.asm"
	INCBIN "gfx/cards/onix_lv25.2bpp"

	ds $128

SECTION "Card Gfx 18", ROMX

KrabbyLv17CardGfx::
	INCLUDE "gfx/cards/krabby_lv17.pal.asm"
	INCLUDE "gfx/cards/krabby_lv17.desc.asm"
	INCBIN "gfx/cards/krabby_lv17.2bpp"

VoltorbLv8CardGfx::
	INCLUDE "gfx/cards/voltorb_lv8.pal.asm"
	INCLUDE "gfx/cards/voltorb_lv8.desc.asm"
	INCBIN "gfx/cards/voltorb_lv8.2bpp"

HitmonleeLv23CardGfx::
	INCLUDE "gfx/cards/hitmonlee_lv23.pal.asm"
	INCLUDE "gfx/cards/hitmonlee_lv23.desc.asm"
	INCBIN "gfx/cards/hitmonlee_lv23.2bpp"

HitmonchanLv23CardGfx::
	INCLUDE "gfx/cards/hitmonchan_lv23.pal.asm"
	INCLUDE "gfx/cards/hitmonchan_lv23.desc.asm"
	INCBIN "gfx/cards/hitmonchan_lv23.2bpp"

JynxLv18CardGfx::
	INCLUDE "gfx/cards/jynx_lv18.pal.asm"
	INCLUDE "gfx/cards/jynx_lv18.desc.asm"
	INCBIN "gfx/cards/jynx_lv18.2bpp"
JynxLv18CardGfxExtra::
	INCBIN "gfx/cards/jynx_lv18_extra.2bpp"

LaprasLv24CardGfx::
	INCLUDE "gfx/cards/lapras_lv24.pal.asm"
	INCLUDE "gfx/cards/lapras_lv24.desc.asm"
	INCBIN "gfx/cards/lapras_lv24.2bpp"
LaprasLv24CardGfxExtra::
	INCBIN "gfx/cards/lapras_lv24_extra.2bpp"

OmanyteLv20CardGfx::
	INCLUDE "gfx/cards/omanyte_lv20.pal.asm"
	INCLUDE "gfx/cards/omanyte_lv20.desc.asm"
	INCBIN "gfx/cards/omanyte_lv20.2bpp"
OmanyteLv20CardGfxExtra::
	INCBIN "gfx/cards/omanyte_lv20_extra.2bpp"

KabutoLv22CardGfx::
	INCLUDE "gfx/cards/kabuto_lv22.pal.asm"
	INCLUDE "gfx/cards/kabuto_lv22.desc.asm"
	INCBIN "gfx/cards/kabuto_lv22.2bpp"

AerodactylLv30CardGfx::
	INCLUDE "gfx/cards/aerodactyl_lv30.pal.asm"
	INCLUDE "gfx/cards/aerodactyl_lv30.desc.asm"
	INCBIN "gfx/cards/aerodactyl_lv30.2bpp"
AerodactylLv30CardGfxExtra::
	INCBIN "gfx/cards/aerodactyl_lv30_extra.2bpp"

ArticunoLv34CardGfx::
	INCLUDE "gfx/cards/articuno_lv34.pal.asm"
	INCLUDE "gfx/cards/articuno_lv34.desc.asm"
	INCBIN "gfx/cards/articuno_lv34.2bpp"
ArticunoLv34CardGfxExtra::
	INCBIN "gfx/cards/articuno_lv34_extra.2bpp"

ZapdosLv28CardGfx::
	INCLUDE "gfx/cards/zapdos_lv28.pal.asm"
	INCLUDE "gfx/cards/zapdos_lv28.desc.asm"
	INCBIN "gfx/cards/zapdos_lv28.2bpp"

MoltresLv37CardGfx::
	INCLUDE "gfx/cards/moltres_lv37.pal.asm"
	INCLUDE "gfx/cards/moltres_lv37.desc.asm"
	INCBIN "gfx/cards/moltres_lv37.2bpp"
MoltresLv37CardGfxExtra::
	INCBIN "gfx/cards/moltres_lv37_extra.2bpp"

PidgeottoLv38CardGfx::
	INCLUDE "gfx/cards/pidgeotto_lv38.pal.asm"
	INCLUDE "gfx/cards/pidgeotto_lv38.desc.asm"
	INCBIN "gfx/cards/pidgeotto_lv38.2bpp"

ArbokLv30CardGfx::
	INCLUDE "gfx/cards/arbok_lv30.pal.asm"
	INCLUDE "gfx/cards/arbok_lv30.desc.asm"
	INCBIN "gfx/cards/arbok_lv30.2bpp"

SandslashLv35CardGfx::
	INCLUDE "gfx/cards/sandslash_lv35.pal.asm"
	INCLUDE "gfx/cards/sandslash_lv35.desc.asm"
	INCBIN "gfx/cards/sandslash_lv35.2bpp"
SandslashLv35CardGfxExtra::
	INCBIN "gfx/cards/sandslash_lv35_extra.2bpp"

NidorinaLv22CardGfx::
	INCLUDE "gfx/cards/nidorina_lv22.pal.asm"
	INCLUDE "gfx/cards/nidorina_lv22.desc.asm"
	INCBIN "gfx/cards/nidorina_lv22.2bpp"

NidorinoLv23CardGfx::
	INCLUDE "gfx/cards/nidorino_lv23.pal.asm"
	INCLUDE "gfx/cards/nidorino_lv23.desc.asm"
	INCBIN "gfx/cards/nidorino_lv23.2bpp"

VulpixLv13CardGfx::
	INCLUDE "gfx/cards/vulpix_lv13.pal.asm"
	INCLUDE "gfx/cards/vulpix_lv13.desc.asm"
	INCBIN "gfx/cards/vulpix_lv13.2bpp"
VulpixLv13CardGfxExtra::
	INCBIN "gfx/cards/vulpix_lv13_extra.2bpp"

	ds $160

SECTION "Card Gfx 19", ROMX

VenonatLv15CardGfx::
	INCLUDE "gfx/cards/venonat_lv15.pal.asm"
	INCLUDE "gfx/cards/venonat_lv15.desc.asm"
	INCBIN "gfx/cards/venonat_lv15.2bpp"
VenonatLv15CardGfxExtra::
	INCBIN "gfx/cards/venonat_lv15_extra.2bpp"

GolduckLv28CardGfx::
	INCLUDE "gfx/cards/golduck_lv28.pal.asm"
	INCLUDE "gfx/cards/golduck_lv28.desc.asm"
	INCBIN "gfx/cards/golduck_lv28.2bpp"
GolduckLv28CardGfxExtra::
	INCBIN "gfx/cards/golduck_lv28_extra.2bpp"

GrowlitheLv16CardGfx::
	INCLUDE "gfx/cards/growlithe_lv16.pal.asm"
	INCLUDE "gfx/cards/growlithe_lv16.desc.asm"
	INCBIN "gfx/cards/growlithe_lv16.2bpp"

KadabraLv39CardGfx::
	INCLUDE "gfx/cards/kadabra_lv39.pal.asm"
	INCLUDE "gfx/cards/kadabra_lv39.desc.asm"
	INCBIN "gfx/cards/kadabra_lv39.2bpp"
KadabraLv39CardGfxExtra::
	INCBIN "gfx/cards/kadabra_lv39_extra.2bpp"

AlakazamLv45CardGfx::
	INCLUDE "gfx/cards/alakazam_lv45.pal.asm"
	INCLUDE "gfx/cards/alakazam_lv45.desc.asm"
	INCBIN "gfx/cards/alakazam_lv45.2bpp"

MachokeLv24CardGfx::
	INCLUDE "gfx/cards/machoke_lv24.pal.asm"
	INCLUDE "gfx/cards/machoke_lv24.desc.asm"
	INCBIN "gfx/cards/machoke_lv24.2bpp"

MachampLv54CardGfx::
	INCLUDE "gfx/cards/machamp_lv54.pal.asm"
	INCLUDE "gfx/cards/machamp_lv54.desc.asm"
	INCBIN "gfx/cards/machamp_lv54.2bpp"

BellsproutLv10CardGfx::
	INCLUDE "gfx/cards/bellsprout_lv10.pal.asm"
	INCLUDE "gfx/cards/bellsprout_lv10.desc.asm"
	INCBIN "gfx/cards/bellsprout_lv10.2bpp"

WeepinbellLv23CardGfx::
	INCLUDE "gfx/cards/weepinbell_lv23.pal.asm"
	INCLUDE "gfx/cards/weepinbell_lv23.desc.asm"
	INCBIN "gfx/cards/weepinbell_lv23.2bpp"

GravelerLv27CardGfx::
	INCLUDE "gfx/cards/graveler_lv27.pal.asm"
	INCLUDE "gfx/cards/graveler_lv27.desc.asm"
	INCBIN "gfx/cards/graveler_lv27.2bpp"

GolemLv37CardGfx::
	INCLUDE "gfx/cards/golem_lv37.pal.asm"
	INCLUDE "gfx/cards/golem_lv37.desc.asm"
	INCBIN "gfx/cards/golem_lv37.2bpp"

PonytaLv8CardGfx::
	INCLUDE "gfx/cards/ponyta_lv8.pal.asm"
	INCLUDE "gfx/cards/ponyta_lv8.desc.asm"
	INCBIN "gfx/cards/ponyta_lv8.2bpp"

SlowbroLv35CardGfx::
	INCLUDE "gfx/cards/slowbro_lv35.pal.asm"
	INCLUDE "gfx/cards/slowbro_lv35.desc.asm"
	INCBIN "gfx/cards/slowbro_lv35.2bpp"
SlowbroLv35CardGfxExtra::
	INCBIN "gfx/cards/slowbro_lv35_extra.2bpp"

GastlyLv13CardGfx::
	INCLUDE "gfx/cards/gastly_lv13.pal.asm"
	INCLUDE "gfx/cards/gastly_lv13.desc.asm"
	INCBIN "gfx/cards/gastly_lv13.2bpp"

HaunterLv26CardGfx::
	INCLUDE "gfx/cards/haunter_lv26.pal.asm"
	INCLUDE "gfx/cards/haunter_lv26.desc.asm"
	INCBIN "gfx/cards/haunter_lv26.2bpp"

HaunterLv25CardGfx::
	INCLUDE "gfx/cards/haunter_lv25.pal.asm"
	INCLUDE "gfx/cards/haunter_lv25.desc.asm"
	INCBIN "gfx/cards/haunter_lv25.2bpp"
HaunterLv25CardGfxExtra::
	INCBIN "gfx/cards/haunter_lv25_extra.2bpp"

GengarLv40CardGfx::
	INCLUDE "gfx/cards/gengar_lv40.pal.asm"
	INCLUDE "gfx/cards/gengar_lv40.desc.asm"
	INCBIN "gfx/cards/gengar_lv40.2bpp"

HypnoLv30CardGfx::
	INCLUDE "gfx/cards/hypno_lv30.pal.asm"
	INCLUDE "gfx/cards/hypno_lv30.desc.asm"
	INCBIN "gfx/cards/hypno_lv30.2bpp"
HypnoLv30CardGfxExtra::
	INCBIN "gfx/cards/hypno_lv30_extra.2bpp"

	ds $210

SECTION "Card Gfx 20", ROMX

KinglerLv33CardGfx::
	INCLUDE "gfx/cards/kingler_lv33.pal.asm"
	INCLUDE "gfx/cards/kingler_lv33.desc.asm"
	INCBIN "gfx/cards/kingler_lv33.2bpp"

CuboneLv14CardGfx::
	INCLUDE "gfx/cards/cubone_lv14.pal.asm"
	INCLUDE "gfx/cards/cubone_lv14.desc.asm"
	INCBIN "gfx/cards/cubone_lv14.2bpp"

WeezingLv26CardGfx::
	INCLUDE "gfx/cards/weezing_lv26.pal.asm"
	INCLUDE "gfx/cards/weezing_lv26.desc.asm"
	INCBIN "gfx/cards/weezing_lv26.2bpp"

RhydonLv37CardGfx::
	INCLUDE "gfx/cards/rhydon_lv37.pal.asm"
	INCLUDE "gfx/cards/rhydon_lv37.desc.asm"
	INCBIN "gfx/cards/rhydon_lv37.2bpp"
RhydonLv37CardGfxExtra::
	INCBIN "gfx/cards/rhydon_lv37_extra.2bpp"

KangaskhanLv36CardGfx::
	INCLUDE "gfx/cards/kangaskhan_lv36.pal.asm"
	INCLUDE "gfx/cards/kangaskhan_lv36.desc.asm"
	INCBIN "gfx/cards/kangaskhan_lv36.2bpp"
KangaskhanLv36CardGfxExtra::
	INCBIN "gfx/cards/kangaskhan_lv36_extra.2bpp"

HorseaLv20CardGfx::
	INCLUDE "gfx/cards/horsea_lv20.pal.asm"
	INCLUDE "gfx/cards/horsea_lv20.desc.asm"
	INCBIN "gfx/cards/horsea_lv20.2bpp"

SeadraLv26CardGfx::
	INCLUDE "gfx/cards/seadra_lv26.pal.asm"
	INCLUDE "gfx/cards/seadra_lv26.desc.asm"
	INCBIN "gfx/cards/seadra_lv26.2bpp"

StaryuLv17CardGfx::
	INCLUDE "gfx/cards/staryu_lv17.pal.asm"
	INCLUDE "gfx/cards/staryu_lv17.desc.asm"
	INCBIN "gfx/cards/staryu_lv17.2bpp"
StaryuLv17CardGfxExtra::
	INCBIN "gfx/cards/staryu_lv17_extra.2bpp"

ScytherLv23CardGfx::
	INCLUDE "gfx/cards/scyther_lv23.pal.asm"
	INCLUDE "gfx/cards/scyther_lv23.desc.asm"
	INCBIN "gfx/cards/scyther_lv23.2bpp"
ScytherLv23CardGfxExtra::
	INCBIN "gfx/cards/scyther_lv23_extra.2bpp"

MagmarLv27CardGfx::
	INCLUDE "gfx/cards/magmar_lv27.pal.asm"
	INCLUDE "gfx/cards/magmar_lv27.desc.asm"
	INCBIN "gfx/cards/magmar_lv27.2bpp"

TaurosLv35CardGfx::
	INCLUDE "gfx/cards/tauros_lv35.pal.asm"
	INCLUDE "gfx/cards/tauros_lv35.desc.asm"
	INCBIN "gfx/cards/tauros_lv35.2bpp"
TaurosLv35CardGfxExtra::
	INCBIN "gfx/cards/tauros_lv35_extra.2bpp"

OmanyteLv22CardGfx::
	INCLUDE "gfx/cards/omanyte_lv22.pal.asm"
	INCLUDE "gfx/cards/omanyte_lv22.desc.asm"
	INCBIN "gfx/cards/omanyte_lv22.2bpp"

OmastarLv36CardGfx::
	INCLUDE "gfx/cards/omastar_lv36.pal.asm"
	INCLUDE "gfx/cards/omastar_lv36.desc.asm"
	INCBIN "gfx/cards/omastar_lv36.2bpp"

MewtwoLv67CardGfx::
	INCLUDE "gfx/cards/mewtwo_lv67.pal.asm"
	INCLUDE "gfx/cards/mewtwo_lv67.desc.asm"
	INCBIN "gfx/cards/mewtwo_lv67.2bpp"

DarkPersianAltLv28CardGfx::
	INCLUDE "gfx/cards/dark_persian_alt_lv28.pal.asm"
	INCLUDE "gfx/cards/dark_persian_alt_lv28.desc.asm"
	INCBIN "gfx/cards/dark_persian_alt_lv28.2bpp"

MeowthLv14CardGfx::
	INCLUDE "gfx/cards/meowth_lv14.pal.asm"
	INCLUDE "gfx/cards/meowth_lv14.desc.asm"
	INCBIN "gfx/cards/meowth_lv14.2bpp"

CoolPorygonCardGfx::
	INCLUDE "gfx/cards/cool_porygon.pal.asm"
	INCLUDE "gfx/cards/cool_porygon.desc.asm"
	INCBIN "gfx/cards/cool_porygon.2bpp"
CoolPorygonCardGfxExtra::
	INCBIN "gfx/cards/cool_porygon_extra.2bpp"

	ds $178

SECTION "Card Gfx 21", ROMX

HungrySnorlaxCardGfx::
	INCLUDE "gfx/cards/hungry_snorlax.pal.asm"
	INCLUDE "gfx/cards/hungry_snorlax.desc.asm"
	INCBIN "gfx/cards/hungry_snorlax.2bpp"

MewtwoLv30CardGfx::
	INCLUDE "gfx/cards/mewtwo_lv30.pal.asm"
	INCLUDE "gfx/cards/mewtwo_lv30.desc.asm"
	INCBIN "gfx/cards/mewtwo_lv30.2bpp"

PikachuLv13CardGfx::
	INCLUDE "gfx/cards/pikachu_lv13.pal.asm"
	INCLUDE "gfx/cards/pikachu_lv13.desc.asm"
	INCBIN "gfx/cards/pikachu_lv13.2bpp"
PikachuLv13CardGfxExtra::
	INCBIN "gfx/cards/pikachu_lv13_extra.2bpp"

FarfetchdAltLv20CardGfx::
	INCLUDE "gfx/cards/farfetchd_alt_lv20.pal.asm"
	INCLUDE "gfx/cards/farfetchd_alt_lv20.desc.asm"
	INCBIN "gfx/cards/farfetchd_alt_lv20.2bpp"
FarfetchdAltLv20CardGfxExtra::
	INCBIN "gfx/cards/farfetchd_alt_lv20_extra.2bpp"

KangaskhanLv38CardGfx::
	INCLUDE "gfx/cards/kangaskhan_lv38.pal.asm"
	INCLUDE "gfx/cards/kangaskhan_lv38.desc.asm"
	INCBIN "gfx/cards/kangaskhan_lv38.2bpp"
KangaskhanLv38CardGfxExtra::
	INCBIN "gfx/cards/kangaskhan_lv38_extra.2bpp"

DiglettLv16CardGfx::
	INCLUDE "gfx/cards/diglett_lv16.pal.asm"
	INCLUDE "gfx/cards/diglett_lv16.desc.asm"
	INCBIN "gfx/cards/diglett_lv16.2bpp"
DiglettLv16CardGfxExtra::
	INCBIN "gfx/cards/diglett_lv16_extra.2bpp"

DugtrioLv40CardGfx::
	INCLUDE "gfx/cards/dugtrio_lv40.pal.asm"
	INCLUDE "gfx/cards/dugtrio_lv40.desc.asm"
	INCBIN "gfx/cards/dugtrio_lv40.2bpp"
DugtrioLv40CardGfxExtra::
	INCBIN "gfx/cards/dugtrio_lv40_extra.2bpp"

DragoniteLv43CardGfx::
	INCLUDE "gfx/cards/dragonite_lv43.pal.asm"
	INCLUDE "gfx/cards/dragonite_lv43.desc.asm"
	INCBIN "gfx/cards/dragonite_lv43.2bpp"

MagikarpLv10CardGfx::
	INCLUDE "gfx/cards/magikarp_lv10.pal.asm"
	INCLUDE "gfx/cards/magikarp_lv10.desc.asm"
	INCBIN "gfx/cards/magikarp_lv10.2bpp"
MagikarpLv10CardGfxExtra::
	INCBIN "gfx/cards/magikarp_lv10_extra.2bpp"

VenusaurAltLv67CardGfx::
	INCLUDE "gfx/cards/venusaur_alt_lv67.pal.asm"
	INCLUDE "gfx/cards/venusaur_alt_lv67.desc.asm"
	INCBIN "gfx/cards/venusaur_alt_lv67.2bpp"
VenusaurAltLv67CardGfxExtra::
	INCBIN "gfx/cards/venusaur_alt_lv67_extra.2bpp"

CharizardAltLv76CardGfx::
	INCLUDE "gfx/cards/charizard_alt_lv76.pal.asm"
	INCLUDE "gfx/cards/charizard_alt_lv76.desc.asm"
	INCBIN "gfx/cards/charizard_alt_lv76.2bpp"

BlastoiseAltLv52CardGfx::
	INCLUDE "gfx/cards/blastoise_alt_lv52.pal.asm"
	INCLUDE "gfx/cards/blastoise_alt_lv52.desc.asm"
	INCBIN "gfx/cards/blastoise_alt_lv52.2bpp"

FlyingPikachuAltLv12CardGfx::
	INCLUDE "gfx/cards/flying_pikachu_alt_lv12.pal.asm"
	INCLUDE "gfx/cards/flying_pikachu_alt_lv12.desc.asm"
	INCBIN "gfx/cards/flying_pikachu_alt_lv12.2bpp"
FlyingPikachuAltLv12CardGfxExtra::
	INCBIN "gfx/cards/flying_pikachu_alt_lv12_extra.2bpp"

TogepiCardGfx::
	INCLUDE "gfx/cards/togepi.pal.asm"
	INCLUDE "gfx/cards/togepi.desc.asm"
	INCBIN "gfx/cards/togepi.2bpp"

MarillCardGfx::
	INCLUDE "gfx/cards/marill.pal.asm"
	INCLUDE "gfx/cards/marill.desc.asm"
	INCBIN "gfx/cards/marill.2bpp"
MarillCardGfxExtra::
	INCBIN "gfx/cards/marill_extra.2bpp"

MankeyAltLv7CardGfx::
	INCLUDE "gfx/cards/mankey_alt_lv7.pal.asm"
	INCLUDE "gfx/cards/mankey_alt_lv7.desc.asm"
	INCBIN "gfx/cards/mankey_alt_lv7.2bpp"

ProfessorOakCardGfx::
	INCLUDE "gfx/cards/professor_oak.pal.asm"
	INCLUDE "gfx/cards/professor_oak.desc.asm"
	INCBIN "gfx/cards/professor_oak.2bpp"

ImposterProfessorOakCardGfx::
	INCLUDE "gfx/cards/imposter_professor_oak.pal.asm"
	INCLUDE "gfx/cards/imposter_professor_oak.desc.asm"
	INCBIN "gfx/cards/imposter_professor_oak.2bpp"
ImposterProfessorOakCardGfxExtra::
	INCBIN "gfx/cards/imposter_professor_oak_extra.2bpp"

	ds $1d0

SECTION "Card Gfx 22", ROMX

BillCardGfx::
	INCLUDE "gfx/cards/bill.pal.asm"
	INCLUDE "gfx/cards/bill.desc.asm"
	INCBIN "gfx/cards/bill.2bpp"

MrFujiCardGfx::
	INCLUDE "gfx/cards/mr_fuji.pal.asm"
	INCLUDE "gfx/cards/mr_fuji.desc.asm"
	INCBIN "gfx/cards/mr_fuji.2bpp"

LassCardGfx::
	INCLUDE "gfx/cards/lass.pal.asm"
	INCLUDE "gfx/cards/lass.desc.asm"
	INCBIN "gfx/cards/lass.2bpp"

ImakuniCardCardGfx::
	INCLUDE "gfx/cards/imakuni_card.pal.asm"
	INCLUDE "gfx/cards/imakuni_card.desc.asm"
	INCBIN "gfx/cards/imakuni_card.2bpp"
ImakuniCardCardGfxExtra::
	INCBIN "gfx/cards/imakuni_card_extra.2bpp"

PokemonTraderCardGfx::
	INCLUDE "gfx/cards/pokemon_trader.pal.asm"
	INCLUDE "gfx/cards/pokemon_trader.desc.asm"
	INCBIN "gfx/cards/pokemon_trader.2bpp"

PokemonBreederCardGfx::
	INCLUDE "gfx/cards/pokemon_breeder.pal.asm"
	INCLUDE "gfx/cards/pokemon_breeder.desc.asm"
	INCBIN "gfx/cards/pokemon_breeder.2bpp"

ClefairyDollCardGfx::
	INCLUDE "gfx/cards/clefairy_doll.pal.asm"
	INCLUDE "gfx/cards/clefairy_doll.desc.asm"
	INCBIN "gfx/cards/clefairy_doll.2bpp"
ClefairyDollCardGfxExtra::
	INCBIN "gfx/cards/clefairy_doll_extra.2bpp"

MysteriousFossilCardGfx::
	INCLUDE "gfx/cards/mysterious_fossil.pal.asm"
	INCLUDE "gfx/cards/mysterious_fossil.desc.asm"
	INCBIN "gfx/cards/mysterious_fossil.2bpp"

EnergyRetrievalCardGfx::
	INCLUDE "gfx/cards/energy_retrieval.pal.asm"
	INCLUDE "gfx/cards/energy_retrieval.desc.asm"
	INCBIN "gfx/cards/energy_retrieval.2bpp"
EnergyRetrievalCardGfxExtra::
	INCBIN "gfx/cards/energy_retrieval_extra.2bpp"

SuperEnergyRetrievalCardGfx::
	INCLUDE "gfx/cards/super_energy_retrieval.pal.asm"
	INCLUDE "gfx/cards/super_energy_retrieval.desc.asm"
	INCBIN "gfx/cards/super_energy_retrieval.2bpp"

EnergySearchCardGfx::
	INCLUDE "gfx/cards/energy_search.pal.asm"
	INCLUDE "gfx/cards/energy_search.desc.asm"
	INCBIN "gfx/cards/energy_search.2bpp"
EnergySearchCardGfxExtra::
	INCBIN "gfx/cards/energy_search_extra.2bpp"

EnergyRemovalCardGfx::
	INCLUDE "gfx/cards/energy_removal.pal.asm"
	INCLUDE "gfx/cards/energy_removal.desc.asm"
	INCBIN "gfx/cards/energy_removal.2bpp"
EnergyRemovalCardGfxExtra::
	INCBIN "gfx/cards/energy_removal_extra.2bpp"

SuperEnergyRemovalCardGfx::
	INCLUDE "gfx/cards/super_energy_removal.pal.asm"
	INCLUDE "gfx/cards/super_energy_removal.desc.asm"
	INCBIN "gfx/cards/super_energy_removal.2bpp"
SuperEnergyRemovalCardGfxExtra::
	INCBIN "gfx/cards/super_energy_removal_extra.2bpp"

SwitchCardGfx::
	INCLUDE "gfx/cards/switch.pal.asm"
	INCLUDE "gfx/cards/switch.desc.asm"
	INCBIN "gfx/cards/switch.2bpp"
SwitchCardGfxExtra::
	INCBIN "gfx/cards/switch_extra.2bpp"

PokemonCenterCardGfx::
	INCLUDE "gfx/cards/pokemon_center.pal.asm"
	INCLUDE "gfx/cards/pokemon_center.desc.asm"
	INCBIN "gfx/cards/pokemon_center.2bpp"
PokemonCenterCardGfxExtra::
	INCBIN "gfx/cards/pokemon_center_extra.2bpp"

PokeballCardGfx::
	INCLUDE "gfx/cards/pokeball.pal.asm"
	INCLUDE "gfx/cards/pokeball.desc.asm"
	INCBIN "gfx/cards/pokeball.2bpp"
PokeballCardGfxExtra::
	INCBIN "gfx/cards/pokeball_extra.2bpp"

ScoopUpCardGfx::
	INCLUDE "gfx/cards/scoop_up.pal.asm"
	INCLUDE "gfx/cards/scoop_up.desc.asm"
	INCBIN "gfx/cards/scoop_up.2bpp"
ScoopUpCardGfxExtra::
	INCBIN "gfx/cards/scoop_up_extra.2bpp"

ComputerSearchCardGfx::
	INCLUDE "gfx/cards/computer_search.pal.asm"
	INCLUDE "gfx/cards/computer_search.desc.asm"
	INCBIN "gfx/cards/computer_search.2bpp"

	ds $f0

SECTION "Card Gfx 23", ROMX

PokedexCardGfx::
	INCLUDE "gfx/cards/pokedex.pal.asm"
	INCLUDE "gfx/cards/pokedex.desc.asm"
	INCBIN "gfx/cards/pokedex.2bpp"

PlusPowerCardGfx::
	INCLUDE "gfx/cards/plus_power.pal.asm"
	INCLUDE "gfx/cards/plus_power.desc.asm"
	INCBIN "gfx/cards/plus_power.2bpp"
PlusPowerCardGfxExtra::
	INCBIN "gfx/cards/plus_power_extra.2bpp"

DefenderCardGfx::
	INCLUDE "gfx/cards/defender.pal.asm"
	INCLUDE "gfx/cards/defender.desc.asm"
	INCBIN "gfx/cards/defender.2bpp"
DefenderCardGfxExtra::
	INCBIN "gfx/cards/defender_extra.2bpp"

ItemFinderCardGfx::
	INCLUDE "gfx/cards/item_finder.pal.asm"
	INCLUDE "gfx/cards/item_finder.desc.asm"
	INCBIN "gfx/cards/item_finder.2bpp"

GustOfWindCardGfx::
	INCLUDE "gfx/cards/gust_of_wind.pal.asm"
	INCLUDE "gfx/cards/gust_of_wind.desc.asm"
	INCBIN "gfx/cards/gust_of_wind.2bpp"

DevolutionSprayCardGfx::
	INCLUDE "gfx/cards/devolution_spray.pal.asm"
	INCLUDE "gfx/cards/devolution_spray.desc.asm"
	INCBIN "gfx/cards/devolution_spray.2bpp"
DevolutionSprayCardGfxExtra::
	INCBIN "gfx/cards/devolution_spray_extra.2bpp"

PotionCardGfx::
	INCLUDE "gfx/cards/potion.pal.asm"
	INCLUDE "gfx/cards/potion.desc.asm"
	INCBIN "gfx/cards/potion.2bpp"
PotionCardGfxExtra::
	INCBIN "gfx/cards/potion_extra.2bpp"

SuperPotionCardGfx::
	INCLUDE "gfx/cards/super_potion.pal.asm"
	INCLUDE "gfx/cards/super_potion.desc.asm"
	INCBIN "gfx/cards/super_potion.2bpp"
SuperPotionCardGfxExtra::
	INCBIN "gfx/cards/super_potion_extra.2bpp"

FullHealCardGfx::
	INCLUDE "gfx/cards/full_heal.pal.asm"
	INCLUDE "gfx/cards/full_heal.desc.asm"
	INCBIN "gfx/cards/full_heal.2bpp"
FullHealCardGfxExtra::
	INCBIN "gfx/cards/full_heal_extra.2bpp"

ReviveCardGfx::
	INCLUDE "gfx/cards/revive.pal.asm"
	INCLUDE "gfx/cards/revive.desc.asm"
	INCBIN "gfx/cards/revive.2bpp"
ReviveCardGfxExtra::
	INCBIN "gfx/cards/revive_extra.2bpp"

MaintenanceCardGfx::
	INCLUDE "gfx/cards/maintenance.pal.asm"
	INCLUDE "gfx/cards/maintenance.desc.asm"
	INCBIN "gfx/cards/maintenance.2bpp"

PokemonFluteCardGfx::
	INCLUDE "gfx/cards/pokemon_flute.pal.asm"
	INCLUDE "gfx/cards/pokemon_flute.desc.asm"
	INCBIN "gfx/cards/pokemon_flute.2bpp"
PokemonFluteCardGfxExtra::
	INCBIN "gfx/cards/pokemon_flute_extra.2bpp"

GamblerCardGfx::
	INCLUDE "gfx/cards/gambler.pal.asm"
	INCLUDE "gfx/cards/gambler.desc.asm"
	INCBIN "gfx/cards/gambler.2bpp"

RecycleCardGfx::
	INCLUDE "gfx/cards/recycle.pal.asm"
	INCLUDE "gfx/cards/recycle.desc.asm"
	INCBIN "gfx/cards/recycle.2bpp"
RecycleCardGfxExtra::
	INCBIN "gfx/cards/recycle_extra.2bpp"

ChallengeCardGfx::
	INCLUDE "gfx/cards/challenge.pal.asm"
	INCLUDE "gfx/cards/challenge.desc.asm"
	INCBIN "gfx/cards/challenge.2bpp"
ChallengeCardGfxExtra::
	INCBIN "gfx/cards/challenge_extra.2bpp"

ImposterOaksRevengeCardGfx::
	INCLUDE "gfx/cards/imposter_oaks_revenge.pal.asm"
	INCLUDE "gfx/cards/imposter_oaks_revenge.desc.asm"
	INCBIN "gfx/cards/imposter_oaks_revenge.2bpp"
ImposterOaksRevengeCardGfxExtra::
	INCBIN "gfx/cards/imposter_oaks_revenge_extra.2bpp"

SleepCardGfx::
	INCLUDE "gfx/cards/sleep.pal.asm"
	INCLUDE "gfx/cards/sleep.desc.asm"
	INCBIN "gfx/cards/sleep.2bpp"

	ds $b8

SECTION "Card Gfx 24", ROMX

DiggerCardGfx::
	INCLUDE "gfx/cards/digger.pal.asm"
	INCLUDE "gfx/cards/digger.desc.asm"
	INCBIN "gfx/cards/digger.2bpp"
DiggerCardGfxExtra::
	INCBIN "gfx/cards/digger_extra.2bpp"

TheBosssWayCardGfx::
	INCLUDE "gfx/cards/the_bosss_way.pal.asm"
	INCLUDE "gfx/cards/the_bosss_way.desc.asm"
	INCBIN "gfx/cards/the_bosss_way.2bpp"
TheBosssWayCardGfxExtra::
	INCBIN "gfx/cards/the_bosss_way_extra.2bpp"

GoopGasAttackCardGfx::
	INCLUDE "gfx/cards/goop_gas_attack.pal.asm"
	INCLUDE "gfx/cards/goop_gas_attack.desc.asm"
	INCBIN "gfx/cards/goop_gas_attack.2bpp"
GoopGasAttackCardGfxExtra::
	INCBIN "gfx/cards/goop_gas_attack_extra.2bpp"

RocketsSneakAttackCardGfx::
	INCLUDE "gfx/cards/rockets_sneak_attack.pal.asm"
	INCLUDE "gfx/cards/rockets_sneak_attack.desc.asm"
	INCBIN "gfx/cards/rockets_sneak_attack.2bpp"
RocketsSneakAttackCardGfxExtra::
	INCBIN "gfx/cards/rockets_sneak_attack_extra.2bpp"

HereComesTeamRocketCardGfx::
	INCLUDE "gfx/cards/here_comes_team_rocket.pal.asm"
	INCLUDE "gfx/cards/here_comes_team_rocket.desc.asm"
	INCBIN "gfx/cards/here_comes_team_rocket.2bpp"
HereComesTeamRocketCardGfxExtra::
	INCBIN "gfx/cards/here_comes_team_rocket_extra.2bpp"

NightlyGarbageRunCardGfx::
	INCLUDE "gfx/cards/nightly_garbage_run.pal.asm"
	INCLUDE "gfx/cards/nightly_garbage_run.desc.asm"
	INCBIN "gfx/cards/nightly_garbage_run.2bpp"
NightlyGarbageRunCardGfxExtra::
	INCBIN "gfx/cards/nightly_garbage_run_extra.2bpp"

TheRocketsTrapCardGfx::
	INCLUDE "gfx/cards/the_rockets_trap.pal.asm"
	INCLUDE "gfx/cards/the_rockets_trap.desc.asm"
	INCBIN "gfx/cards/the_rockets_trap.2bpp"
TheRocketsTrapCardGfxExtra::
	INCBIN "gfx/cards/the_rockets_trap_extra.2bpp"

FossilExcavationCardGfx::
	INCLUDE "gfx/cards/fossil_excavation.pal.asm"
	INCLUDE "gfx/cards/fossil_excavation.desc.asm"
	INCBIN "gfx/cards/fossil_excavation.2bpp"
FossilExcavationCardGfxExtra::
	INCBIN "gfx/cards/fossil_excavation_extra.2bpp"

MoonStoneCardGfx::
	INCLUDE "gfx/cards/moon_stone.pal.asm"
	INCLUDE "gfx/cards/moon_stone.desc.asm"
	INCBIN "gfx/cards/moon_stone.2bpp"
MoonStoneCardGfxExtra::
	INCBIN "gfx/cards/moon_stone_extra.2bpp"

MaxReviveCardGfx::
	INCLUDE "gfx/cards/max_revive.pal.asm"
	INCLUDE "gfx/cards/max_revive.desc.asm"
	INCBIN "gfx/cards/max_revive.2bpp"
MaxReviveCardGfxExtra::
	INCBIN "gfx/cards/max_revive_extra.2bpp"

MasterBallCardGfx::
	INCLUDE "gfx/cards/master_ball.pal.asm"
	INCLUDE "gfx/cards/master_ball.desc.asm"
	INCBIN "gfx/cards/master_ball.2bpp"
MasterBallCardGfxExtra::
	INCBIN "gfx/cards/master_ball_extra.2bpp"

PokemonRecallCardGfx::
	INCLUDE "gfx/cards/pokemon_recall.pal.asm"
	INCLUDE "gfx/cards/pokemon_recall.desc.asm"
	INCBIN "gfx/cards/pokemon_recall.2bpp"

BillsComputerCardGfx::
	INCLUDE "gfx/cards/bills_computer.pal.asm"
	INCLUDE "gfx/cards/bills_computer.desc.asm"
	INCBIN "gfx/cards/bills_computer.2bpp"
BillsComputerCardGfxExtra::
	INCBIN "gfx/cards/bills_computer_extra.2bpp"

ComputerErrorCardGfx::
	INCLUDE "gfx/cards/computer_error.pal.asm"
	INCLUDE "gfx/cards/computer_error.desc.asm"
	INCBIN "gfx/cards/computer_error.2bpp"

SquirtleLv14CardGfx::
	INCLUDE "gfx/cards/squirtle_lv14.pal.asm"
	INCLUDE "gfx/cards/squirtle_lv14.desc.asm"
	INCBIN "gfx/cards/squirtle_lv14.2bpp"
SquirtleLv14CardGfxExtra::
	INCBIN "gfx/cards/squirtle_lv14_extra.2bpp"

SuperScoopUpCardGfx::
	INCLUDE "gfx/cards/super_scoop_up.pal.asm"
	INCLUDE "gfx/cards/super_scoop_up.desc.asm"
	INCBIN "gfx/cards/super_scoop_up.2bpp"

RaichuLv33CardGfx::
	INCLUDE "gfx/cards/raichu_lv33.pal.asm"
	INCLUDE "gfx/cards/raichu_lv33.desc.asm"
	INCBIN "gfx/cards/raichu_lv33.2bpp"
RaichuLv33CardGfxExtra::
	INCBIN "gfx/cards/raichu_lv33_extra.2bpp"

	ds $118

SECTION "Card Gfx 25", ROMX

IvysaurLv26CardGfx::
	INCLUDE "gfx/cards/ivysaur_lv26.pal.asm"
	INCLUDE "gfx/cards/ivysaur_lv26.desc.asm"
	INCBIN "gfx/cards/ivysaur_lv26.2bpp"

KoffingLv14CardGfx::
	INCLUDE "gfx/cards/koffing_lv14.pal.asm"
	INCLUDE "gfx/cards/koffing_lv14.desc.asm"
	INCBIN "gfx/cards/koffing_lv14.2bpp"

GrowlitheLv12CardGfx::
	INCLUDE "gfx/cards/growlithe_lv12.pal.asm"
	INCLUDE "gfx/cards/growlithe_lv12.desc.asm"
	INCBIN "gfx/cards/growlithe_lv12.2bpp"

JynxLv27CardGfx::
	INCLUDE "gfx/cards/jynx_lv27.pal.asm"
	INCLUDE "gfx/cards/jynx_lv27.desc.asm"
	INCBIN "gfx/cards/jynx_lv27.2bpp"

ArcanineLv35CardGfx::
	INCLUDE "gfx/cards/arcanine_lv35.pal.asm"
	INCLUDE "gfx/cards/arcanine_lv35.desc.asm"
	INCBIN "gfx/cards/arcanine_lv35.2bpp"

ElectabuzzLv30CardGfx::
	INCLUDE "gfx/cards/electabuzz_lv30.pal.asm"
	INCLUDE "gfx/cards/electabuzz_lv30.desc.asm"
	INCBIN "gfx/cards/electabuzz_lv30.2bpp"

WartortleLv24CardGfx::
	INCLUDE "gfx/cards/wartortle_lv24.pal.asm"
	INCLUDE "gfx/cards/wartortle_lv24.desc.asm"
	INCBIN "gfx/cards/wartortle_lv24.2bpp"
WartortleLv24CardGfxExtra::
	INCBIN "gfx/cards/wartortle_lv24_extra.2bpp"

SpearowLv9CardGfx::
	INCLUDE "gfx/cards/spearow_lv9.pal.asm"
	INCLUDE "gfx/cards/spearow_lv9.desc.asm"
	INCBIN "gfx/cards/spearow_lv9.2bpp"
SpearowLv9CardGfxExtra::
	INCBIN "gfx/cards/spearow_lv9_extra.2bpp"

MeowthLv17CardGfx::
	INCLUDE "gfx/cards/meowth_lv17.pal.asm"
	INCLUDE "gfx/cards/meowth_lv17.desc.asm"
	INCBIN "gfx/cards/meowth_lv17.2bpp"

BillsTeleporterCardGfx::
	INCLUDE "gfx/cards/bills_teleporter.pal.asm"
	INCLUDE "gfx/cards/bills_teleporter.desc.asm"
	INCBIN "gfx/cards/bills_teleporter.2bpp"
BillsTeleporterCardGfxExtra::
	INCBIN "gfx/cards/bills_teleporter_extra.2bpp"

BulbasaurLv12CardGfx::
	INCLUDE "gfx/cards/bulbasaur_lv12.pal.asm"
	INCLUDE "gfx/cards/bulbasaur_lv12.desc.asm"
	INCBIN "gfx/cards/bulbasaur_lv12.2bpp"
BulbasaurLv12CardGfxExtra::
	INCBIN "gfx/cards/bulbasaur_lv12_extra.2bpp"

MagmarLv18CardGfx::
	INCLUDE "gfx/cards/magmar_lv18.pal.asm"
	INCLUDE "gfx/cards/magmar_lv18.desc.asm"
	INCBIN "gfx/cards/magmar_lv18.2bpp"
MagmarLv18CardGfxExtra::
	INCBIN "gfx/cards/magmar_lv18_extra.2bpp"

GRsMewtwoCardGfx::
	INCLUDE "gfx/cards/g_rs_mewtwo.pal.asm"
	INCLUDE "gfx/cards/g_rs_mewtwo.desc.asm"
	INCBIN "gfx/cards/g_rs_mewtwo.2bpp"

DarkIvysaurCardGfx::
	INCLUDE "gfx/cards/dark_ivysaur.pal.asm"
	INCLUDE "gfx/cards/dark_ivysaur.desc.asm"
	INCBIN "gfx/cards/dark_ivysaur.2bpp"

DarkHaunterCardGfx::
	INCLUDE "gfx/cards/dark_haunter.pal.asm"
	INCLUDE "gfx/cards/dark_haunter.desc.asm"
	INCBIN "gfx/cards/dark_haunter.2bpp"
DarkHaunterCardGfxExtra::
	INCBIN "gfx/cards/dark_haunter_extra.2bpp"

DarkVenusaurCardGfx::
	INCLUDE "gfx/cards/dark_venusaur.pal.asm"
	INCLUDE "gfx/cards/dark_venusaur.desc.asm"
	INCBIN "gfx/cards/dark_venusaur.2bpp"

DarkClefableCardGfx::
	INCLUDE "gfx/cards/dark_clefable.pal.asm"
	INCLUDE "gfx/cards/dark_clefable.desc.asm"
	INCBIN "gfx/cards/dark_clefable.2bpp"

DarkRaichuCardGfx::
	INCLUDE "gfx/cards/dark_raichu.pal.asm"
	INCLUDE "gfx/cards/dark_raichu.desc.asm"
	INCBIN "gfx/cards/dark_raichu.2bpp"

	ds $50

SECTION "Card Gfx 26", ROMX

DarkMarowakCardGfx::
	INCLUDE "gfx/cards/dark_marowak.pal.asm"
	INCLUDE "gfx/cards/dark_marowak.desc.asm"
	INCBIN "gfx/cards/dark_marowak.2bpp"

DarkStarmieCardGfx::
	INCLUDE "gfx/cards/dark_starmie.pal.asm"
	INCLUDE "gfx/cards/dark_starmie.desc.asm"
	INCBIN "gfx/cards/dark_starmie.2bpp"

DarkNinetalesCardGfx::
	INCLUDE "gfx/cards/dark_ninetales.pal.asm"
	INCLUDE "gfx/cards/dark_ninetales.desc.asm"
	INCBIN "gfx/cards/dark_ninetales.2bpp"

DarkFearowCardGfx::
	INCLUDE "gfx/cards/dark_fearow.pal.asm"
	INCLUDE "gfx/cards/dark_fearow.desc.asm"
	INCBIN "gfx/cards/dark_fearow.2bpp"
DarkFearowCardGfxExtra::
	INCBIN "gfx/cards/dark_fearow_extra.2bpp"

RecycleEnergyCardGfx::
	INCLUDE "gfx/cards/recycle_energy.pal.asm"
	INCLUDE "gfx/cards/recycle_energy.desc.asm"
	INCBIN "gfx/cards/recycle_energy.2bpp"

DarkGengarCardGfx::
	INCLUDE "gfx/cards/dark_gengar.pal.asm"
	INCLUDE "gfx/cards/dark_gengar.desc.asm"
	INCBIN "gfx/cards/dark_gengar.2bpp"

LugiaCardGfx::
	INCLUDE "gfx/cards/lugia.pal.asm"
	INCLUDE "gfx/cards/lugia.desc.asm"
	INCBIN "gfx/cards/lugia.2bpp"
