#define PROGRAM_NAME "card_gfx"
#define USAGE_OPTS "[-h|--help] [--printer printer.2bpp] [--extra-out extra_outfile.2bpp] infile.png infile.pal.bin infile.cardattr.bin outfile.2bpp"

#include "common.h"
#include "lodepng/lodepng.h"

enum
{
	ARG_INFILE_PNG = 0,
	ARG_INFILE_PAL = 1,
	ARG_INFILE_ATTR = 2,
	ARG_OUTFILE = 3,
	REQ_POS_ARGS = 4,

	NUM_CARD_PALS = 3,
	NUM_PAL_COLORS = 4,
	CARD_PAL_SIZE = 2 * NUM_PAL_COLORS * NUM_CARD_PALS,

	CARD_WIDTH_PX = 64,
	CARD_HEIGHT_PX = 48,
	NUM_CARD_TILES = 8 * 6,
	CARD_ATTR_SIZE = NUM_CARD_TILES,
	TILE_SIZE = 16,
	CARD_GFX_SIZE = TILE_SIZE * NUM_CARD_TILES,
};

struct Options
{
	char *printer_infile;
	char *extra_outfile;
};

struct Options options = {0};

void parse_args(int argc, char *argv[])
{
	static const struct option long_options[] = {
			{"help", no_argument, NULL, 'h'},
			{"printer", required_argument, NULL, 'p'},
			{"extra-out", required_argument, NULL, 'e'},
			{0},
	};
	for (int opt; (opt = getopt_long(argc, argv, "p:e:h", long_options)) != -1;)
	{
		switch (opt)
		{
		case 'p':
			options.printer_infile = optarg;
			break;
		case 'e':
			options.extra_outfile = optarg;
			break;
		case 'h':
			usage_exit(EXIT_SUCCESS);
		default:
			usage_exit(EXIT_FAILURE);
		}
	}
	if (argc - optind != REQ_POS_ARGS)
	{
		usage_exit(EXIT_FAILURE);
	}
	if ((options.printer_infile == NULL) != (options.extra_outfile == NULL))
	{
		error_exit("--printer and --extra-out must be specified together\n");
	}
}

struct Color
{
	uint8_t r, g, b;
};

uint16_t pack_color(struct Color color)
{
	return (color.b << 10) | (color.g << 5) | color.r;
}

struct Color unpack_color(uint16_t gbc_color)
{
	return (struct Color){
			.r = gbc_color & 0x1f,
			.g = (gbc_color >> 5) & 0x1f,
			.b = (gbc_color >> 10) & 0x1f,
	};
}

typedef struct Color Palette[NUM_PAL_COLORS];

struct Cardattr
{
	uint8_t pal, alt;
};

struct Cardattr unpack_cardattr(uint8_t attr)
{
	return (struct Cardattr){
			.pal = (attr >> 6) & 0x03,
			.alt = attr & 0x3f,
	};
}

void read_card_pal(const char *filename, Palette **palettes)
{
	long filesize;
	uint8_t *bytes = read_u8(filename, &filesize);
	if (filesize != CARD_PAL_SIZE)
	{
		error_exit("%s: Expected %d bytes, got %ld\n", filename, CARD_PAL_SIZE, filesize);
	}

	*palettes = xmalloc(NUM_CARD_PALS * sizeof(**palettes));
	for (size_t pal_index = 0; pal_index < NUM_CARD_PALS; ++pal_index)
	{
		for (size_t color_index = 0; color_index < NUM_PAL_COLORS; ++color_index)
		{
			size_t color_offset = pal_index * NUM_PAL_COLORS + color_index;
			uint16_t gbc_color = (bytes[color_offset * 2 + 1] << 8) | bytes[color_offset * 2];
			(*palettes)[pal_index][color_index] = unpack_color(gbc_color);
		}
	}

	free(bytes);
}

void read_card_attr(const char *filename, struct Cardattr **attrs)
{
	long filesize;
	uint8_t *bytes = read_u8(filename, &filesize);
	if (filesize != CARD_ATTR_SIZE)
	{
		error_exit("%s: Expected %d bytes, got %ld\n", filename, CARD_ATTR_SIZE, filesize);
	}

	*attrs = xmalloc(CARD_ATTR_SIZE * sizeof(**attrs));
	for (size_t i = 0; i < CARD_ATTR_SIZE; ++i)
	{
		(*attrs)[i] = unpack_cardattr(bytes[i]);
	}

	free(bytes);
}

uint16_t rgb8_to_rgb5(struct Color color)
{
	return (uint16_t)((color.r >> 3) | ((color.g >> 3) << 5) | ((color.b >> 3) << 10));
}

void read_card_gfx(const char *filename, uint16_t rgb555[CARD_HEIGHT_PX][CARD_WIDTH_PX])
{
	unsigned char *image = NULL;
	unsigned width, height;
	unsigned error = lodepng_decode24_file(&image, &width, &height, filename);
	if (error)
	{
		error_exit("PNG decoder error %u: %s\n", error, lodepng_error_text(error));
	}
	if (width != CARD_WIDTH_PX || height != CARD_HEIGHT_PX)
	{
		error_exit("%s: Expected a 64x48 PNG, got %ux%u\n", filename, width, height);
	}

	for (unsigned h = 0; h < CARD_HEIGHT_PX; ++h)
	{
		for (unsigned w = 0; w < CARD_WIDTH_PX; ++w)
		{
			size_t i = (h * CARD_WIDTH_PX + w) * 3;
			struct Color color = {
					.r = image[i + 0],
					.g = image[i + 1],
					.b = image[i + 2],
			};
			rgb555[h][w] = rgb8_to_rgb5(color);
		}
	}

	free(image);
}

void output_bpp(uint16_t rgb555[CARD_HEIGHT_PX][CARD_WIDTH_PX],
								Palette palettes[NUM_CARD_PALS],
								struct Cardattr attrs[CARD_ATTR_SIZE],
								uint8_t bpp[CARD_GFX_SIZE],
								const char *outfile)
{
	for (unsigned w = 0; w < 8; ++w)
		for (unsigned h = 0; h < 6; ++h)
		{
			unsigned tile = w * 6 + h;
			unsigned attr = h * 8 + w;
			if (attrs[attr].pal >= NUM_CARD_PALS)
				error_exit("Tile %u uses invalid palette %u\n", tile, attrs[attr].pal);
			Palette *palette = &palettes[attrs[attr].pal];

			for (unsigned y = 0; y < 8; ++y)
			{
				uint8_t low = 0;
				uint8_t high = 0;

				for (unsigned x = 0; x < 8; ++x)
				{
					uint16_t color = rgb555[h * 8 + y][w * 8 + x];
					unsigned color_index;

					for (color_index = 0; color_index < NUM_PAL_COLORS; ++color_index)
					{
						struct Color palette_color = (*palette)[color_index];
						uint16_t packed = pack_color(palette_color);
						if (packed == color)
							break;
					}
					if (color_index == NUM_PAL_COLORS)
					{
						struct Color unpacked = unpack_color(color);
						error_exit("Pixel at (%u,%u) is not in palette %u: (%u, %u, %u)\n",
											 w * 8 + x, h * 8 + y, attrs[attr].pal,
											 unpacked.r, unpacked.g, unpacked.b);
					}

					low |= (color_index & 1) << (7 - x);
					high |= ((color_index >> 1) & 1) << (7 - x);
				}

				bpp[tile * TILE_SIZE + y * 2] = low;
				bpp[tile * TILE_SIZE + y * 2 + 1] = high;
			}
		}

	write_u8(outfile, bpp, CARD_GFX_SIZE);
}

void output_printer_extra_bpp(const char *infile,
															struct Cardattr attrs[CARD_ATTR_SIZE],
															const char *outfile)
{
	long infile_size;
	uint8_t *input = read_u8(infile, &infile_size);
	if (infile_size != CARD_GFX_SIZE)
		error_exit("%s: Expected %d bytes, got %ld\n", infile, CARD_GFX_SIZE, infile_size);

	uint8_t *output = xmalloc(infile_size);
	size_t output_size = 0;
	for (size_t index = 0; index < CARD_ATTR_SIZE; ++index)
	{
		if (attrs[index].alt)
		{
			memcpy(output + output_size, input + index * TILE_SIZE, TILE_SIZE);
			output_size += TILE_SIZE;
		}
	}

	write_u8(outfile, output, output_size);

	free(input);
	free(output);
}

int main(int argc, char *argv[])
{
	parse_args(argc, argv);

	argc -= optind;
	argv += optind;
	if (argc != REQ_POS_ARGS)
	{
		usage_exit(EXIT_FAILURE);
	}

	uint16_t card_rgb555[CARD_HEIGHT_PX][CARD_WIDTH_PX];
	read_card_gfx(argv[ARG_INFILE_PNG], card_rgb555);
	Palette *card_pals;
	read_card_pal(argv[ARG_INFILE_PAL], &card_pals);
	struct Cardattr *card_attrs;
	read_card_attr(argv[ARG_INFILE_ATTR], &card_attrs);
	uint8_t card_regular_2bpp[CARD_GFX_SIZE];
	output_bpp(card_rgb555, card_pals, card_attrs, card_regular_2bpp, argv[ARG_OUTFILE]);

	if (options.printer_infile && options.extra_outfile)
		output_printer_extra_bpp(options.printer_infile, card_attrs, options.extra_outfile);

	free(card_pals);
	free(card_attrs);
	return EXIT_SUCCESS;
}
