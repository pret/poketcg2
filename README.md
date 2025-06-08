# Pokémon TCG 2

This is a disassembly of Pokémon TCG 2.

It uses the following ROM as a base:

- Pokémon Card GB2 - GR Dan Sanjou! (J) [C][!].gbc `sha1: a7e12bcc5f514e3aad8de570fd511aab0a308822`

To assemble, first download RGBDS (https://github.com/gbdev/rgbds/releases) and extract it to /usr/local/bin.
Copy the above ROM to this directory as "baserom.gbc".
Run `make` in your shell.

This will output a file named "poketcg2.gbc".


## See also

- [**Tools**][tools]

You can find us on [Discord (pret, #poketcg)](https://discord.gg/d5dubZ3).

For other pret projects, see [pret.github.io](https://pret.github.io/).

[tools]: https://github.com/pret/gb-asm-tools
