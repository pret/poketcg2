MACRO card_data_struct
\1Type::          ds 1
\1Gfx::           ds 2
\1Name::          ds 2
\1Rarity::        ds 1
\1Set::           ds 1
	ds 1 ; ???
\1ID::            ds 2
\1EffectCommands:: ; ds 2
\1HP::            ds 1
\1Stage::         ds 1
\1NonPokemonDescription:: ; ds 2
\1PreEvoName::    ds 2
\1Atk1::         atk_data_struct \1Atk1
\1Atk2::         atk_data_struct \1Atk2
\1RetreatCost::   ds 1
\1Weakness::      ds 1
\1Resistance::    ds 1
\1Category::      ds 2
\1PokedexNumber:: ds 1
\1Unknown1::      ds 1
\1Level::         ds 1
\1Length::        ds 2
\1Weight::        ds 2
\1Description::   ds 2
;\1Unknown2::      ds 1
ENDM

MACRO atk_data_struct
\1EnergyCost::     ds NUM_TYPES / 2
\1Name::           ds 2
\1Description::    ds 4
\1Damage::         ds 1
\1Category::       ds 1
\1EffectCommands:: ds 2
\1Flag1::          ds 1
\1Flag2::          ds 1
\1Flag3::          ds 1
\1EffectParam::    ds 1
\1Animation::      ds 1
ENDM

MACRO text_header
\1DefaultFont:: ds 1
\1FontWidth::   ds 1
\1Address::     ds 2
\1RomBank::     ds 1
ENDM

MACRO loaded_npc_struct
\1ID::         ds 1
\1Sprite::     ds 1
\1CoordX::     ds 1
\1CoordY::     ds 1
\1Direction::  ds 1
\1Field0x05::  ds 1
\1Field0x06::  ds 1
\1Field0x07::  ds 1
\1Field0x08::  ds 1
\1Field0x09::  ds 1
\1Field0x0a::  ds 1
\1Field0x0b::  ds 1
ENDM

MACRO sprite_vram_struct
\1Valid::      ds 1
\1ID::         ds 1
\1TileOffset:: ds 1
\1TileSize::   ds 1
ENDM

MACRO duel_anim_struct
\1ID::             ds 1
\1Screen::         ds 1
\1DuelistSide::    ds 1
\1LocationParam::  ds 1
\1Damage::         ds 2
\1Unknown2::       ds 1
\1Bank::           ds 1
ENDM

MACRO deck_struct
\1Name::  ds DECK_NAME_SIZE
\1Cards:: ds DECK_COMPRESSED_SIZE
ENDM

MACRO sprite_anim_struct
\1Unk0:: ds 1
\1Unk1:: ds 1
\1Unk2:: ds 1
\1XPos:: ds 1
\1YPos:: ds 1
\1FrameIndex:: ds 1
\1FramesetID:: ds 2
\1FrameDuration:: ds 1
\1TileOffset:: ds 1
\1AnimID:: ds 2
\1MoveDuration:: ds 1
\1StartDelay:: ds 1
\1UnkE:: ds 2
ENDM

MACRO obj_tile_struct
\1ID::         ds 2 ; TILESET_* constant
\1TileOffset:: ds 1 ; tile offset
	ds 1 ; padding
ENDM

MACRO ow_obj_struct
\1Flags::   ds 1
\1ID::      ds 1
\1AnimPtr:: ds 2
\1Unk4::    ds 1
\1Unk5::    ds 1
\1Unk6::    ds 2
ENDM
