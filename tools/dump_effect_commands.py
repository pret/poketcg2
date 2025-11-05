#!/usr/bin/env python

from __future__ import print_function

import argparse
import re

import configuration
from tcg2disasm import Disassembler
from tcg2disasm import sort_and_add_sections

args = None
rom = None

def get_raw_addr(addr):
	if addr:
		if ":" in addr:
			addr = addr.split(":")
			addr = int(addr[0], 16)*0x4000+(int(addr[1], 16)%0x4000)
		else:
			label_addr = disasm.find_address_from_label(addr)
			if label_addr:
				addr = label_addr
			else:
				addr = int(addr, 16)

	return addr

def replace_bank16(effect_commands_bank_filepath):
	bank16_output_file = ""

	with open(effect_commands_bank_filepath) as f:
		effect_bank = None

		for line in f:
			effect_commands_header_match = re.search("^EffectCommands_", line)
			effect_bank_match = re.search("db \\$(..) ; effect bank", line)
			effect_match = re.search("dbw .*, \\$(....)", line)

			if effect_commands_header_match:
				effect_bank = None
			elif effect_bank_match:
				effect_bank = effect_bank_match.group(1)
			elif effect_match:
				function_address = effect_match.group(1)
				function_name = "Func_%x" % get_raw_addr(effect_bank + ":" + function_address)
				line = re.sub("\\$(....)", function_name, line)

			bank16_output_file += line

	return bank16_output_file

def dump_functions(effect_commands_bank_filepath):
	function_addresses = []
	with open(effect_commands_bank_filepath) as f:
		effect_bank = None

		for line in f:
			effect_commands_header_match = re.search("^EffectCommands_", line)
			effect_bank_match = re.search("db \\$(..) ; effect bank", line)
			effect_match = re.search("dbw .*, \\$(....)", line)

			if effect_commands_header_match:
				effect_bank = None
			elif effect_bank_match:
				effect_bank = effect_bank_match.group(1)
			elif effect_match:
				function_local_address = effect_match.group(1)
				function_addresses.append(get_raw_addr(effect_bank + ":" + function_local_address))

	function_outputs = disasm.recursively_output_functions(function_addresses,None,parse_scripts=True)
	sort_and_add_sections(function_outputs, True)

	return function_outputs

if __name__ == "__main__":
	ap = argparse.ArgumentParser(description="")
	ap.add_argument("-r", "--rom", default="baserom.gbc", help="rom file to extract from")
	ap.add_argument("-s", "--symfile", default="poketcg2.sym", help="symfile to extract symbols from")

	args = ap.parse_args()
	rom = bytearray(open(args.rom, "rb").read())

	# initialize disassembler
	conf = configuration.Config()
	disasm = Disassembler(conf)
	disasm.initialize(args.rom, args.symfile)

	output_file = replace_bank16("src/engine/bank16.asm")
	function_outputs = dump_functions("src/engine/bank16.asm")

	# prepare and print output
	formatted_output = ''

	for f in function_outputs:
		formatted_output += f["output"]
		formatted_output += "\n\n"

	formatted_output = formatted_output.rstrip('\n')

	print(output_file)
	print(formatted_output)
