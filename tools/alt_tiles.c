#define PROGRAM_NAME "alt_tiles"
#define USAGE_OPTS "[-h|--help] [-o|--out outfile] regularpic grayscalepic cardattr"

#include "common.h"

#define CARD_WIDTH_TILES  8
#define CARD_HEIGHT_TILES 6
#define CARD_NUM_TILES    CARD_WIDTH_TILES * CARD_HEIGHT_TILES
#define TILE_SIZE         16
#define CARD_SIZE_BYTES   CARD_NUM_TILES * TILE_SIZE

struct Options {
	char *outfile;
};

struct Options options;

void parse_args(int argc, char *argv[]) {
	struct option long_options[] = {
		{"out", required_argument, 0, 'o'},
		{"help", no_argument, 0, 'h'},
		{0}
	};
	for (int opt; (opt = getopt_long(argc, argv, "o:h", long_options)) != -1;) {
		switch (opt) {
		case 'o':
			options.outfile = optarg;
			break;
		case 'h':
			usage_exit(0);
			break;
		default:
			usage_exit(1);
		}
	}
}

struct Graphic {
	uint8_t *data;
	long size;
};

void assert_file_size(const char *filename, long expected_size, long actual_size) {
	if (actual_size != expected_size) {
		error_exit("Invalid size in file %s: %ld\n", filename, actual_size);
	}
}

bool compare_tiles(uint8_t *tile_1, uint8_t *tile_2) {
	for (int i = 0 ; i < TILE_SIZE; i++) {
		if (tile_1[i] != tile_2[i]) {
			return false;
		}
	}
	return true;
}

void get_alt_tiles_indices(uint8_t *cardattr, struct Graphic *regular_graphic, struct Graphic *grayscale_graphic) {
	int num_alt_tiles = 0;

	for (int tile = 0; tile < CARD_NUM_TILES; tile++) {
		uint8_t *tile_regular = &regular_graphic->data[tile * TILE_SIZE];
		uint8_t *tile_grayscale = &grayscale_graphic->data[tile * TILE_SIZE];
		if (!compare_tiles(tile_regular, tile_grayscale)) {
			*(cardattr + tile) |= 0x30 - tile + num_alt_tiles;
			num_alt_tiles++;
		}
	}
}

struct Graphic extract_alt_tiles(struct Graphic *grayscale_graphic, uint8_t *cardattr) {
	struct Graphic alt_tiles_graphic;
	alt_tiles_graphic.data = xmalloc(CARD_SIZE_BYTES);

	int num_alt_tiles = 0;

	for (int tile = 0; tile < CARD_NUM_TILES; tile++) {
		if ((cardattr[tile] & 0x3f) != 0) {
			memcpy(alt_tiles_graphic.data + num_alt_tiles * TILE_SIZE, grayscale_graphic->data + tile * TILE_SIZE, TILE_SIZE);
			num_alt_tiles++;
		}
	}

	alt_tiles_graphic.size = num_alt_tiles * TILE_SIZE;
	return alt_tiles_graphic;
}

int main(int argc, char *argv[]) {
	parse_args(argc, argv);

	argc -= optind;
	argv += optind;
	if (argc != 3) {
		usage_exit(1);
	}

	struct Graphic regular_graphic;
	struct Graphic grayscale_graphic;

	regular_graphic.data = read_u8(argv[0], &regular_graphic.size);
	grayscale_graphic.data = read_u8(argv[1], &grayscale_graphic.size);

	long cardattr_size;
	uint8_t *cardattr = read_u8(argv[2], &cardattr_size);

	assert_file_size(argv[0], CARD_SIZE_BYTES, regular_graphic.size);
	assert_file_size(argv[1], CARD_SIZE_BYTES, grayscale_graphic.size);
	assert_file_size(argv[2], CARD_NUM_TILES, cardattr_size);

	// overwrite card attributes with alt tile indices
	get_alt_tiles_indices(cardattr, &regular_graphic, &grayscale_graphic);
	write_u8(argv[2], cardattr, cardattr_size);

	struct Graphic alt_tiles_graphic = extract_alt_tiles(&grayscale_graphic, cardattr);

	if (options.outfile) {
		write_u8(options.outfile, alt_tiles_graphic.data, alt_tiles_graphic.size);
	}

	free(regular_graphic.data);
	free(grayscale_graphic.data);
	free(alt_tiles_graphic.data);
	free(cardattr);
	return 0;
}
