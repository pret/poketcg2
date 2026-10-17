#define PROGRAM_NAME "card_attributes"
#define USAGE_OPTS "[-h|--help] [-o|--out outfile] attrmap"

#include "common.h"

#define CARD_WIDTH_TILES  8
#define CARD_HEIGHT_TILES 6
#define CARD_NUM_TILES    CARD_WIDTH_TILES * CARD_HEIGHT_TILES

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

void assert_file_size(const char *filename, long expected_size, long actual_size) {
	if (actual_size != expected_size) {
		error_exit("Invalid size in file %s: %ld\n", filename, actual_size);
	}
}

uint8_t *create_card_attributes(uint8_t *attrmap) {
	uint8_t *data = xmalloc(CARD_NUM_TILES);

	for (int tile = 0; tile < CARD_NUM_TILES; tile++) {
		data[tile] = (attrmap[tile] << 6);
	}

	return data;
}

int main(int argc, char *argv[]) {
	parse_args(argc, argv);

	argc -= optind;
	argv += optind;
	if (argc != 1) {
		usage_exit(1);
	}

	long attrmap_size;
	uint8_t *attrmap = read_u8(argv[0], &attrmap_size);
	assert_file_size(argv[0], CARD_NUM_TILES, attrmap_size);

	uint8_t *data = create_card_attributes(attrmap);

	if (options.outfile) {
		write_u8(options.outfile, data, CARD_NUM_TILES);
	}

	free(attrmap);
	free(data);
	return 0;
}
