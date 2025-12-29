#!/usr/bin/env python

from __future__ import print_function

import argparse
import sys

from constants import directions
from constants import maps
from constants import mapgfx
from constants import npcs
from constants import songs

import configuration
from tcg2disasm import Disassembler

script_types = [
	"OWMODE_00",
	"OWMODE_01",
	"OWMODE_02",
	"OWMODE_03",
	"OWMODE_04",
	"OWMODE_05",
	"OWMODE_06",
	"OWMODE_07",
	"OWMODE_INTERACT",
	"OWMODE_AFTER_DUEL",
	"OWMODE_0A",
	"OWMODE_0B",
	"OWMODE_0C",
	"OWMODE_0D",
	"OWMODE_0E",
	"OWMODE_0F",
	"OWMODE_10",
	"OWMODE_11",
	"OWMODE_PAUSE_MENU"
]

args = None
rom = None

def get_bank(address):
	return int(address / 0x4000)

def get_relative_address(address):
	if address < 0x4000:
		return address
	return (address % 0x4000) + 0x4000

# get absolute pointer stored at an address in the rom
# if bank is None, assumes the pointer refers to the same bank as the bank it is located in
def get_pointer(address, bank=None):
	raw_pointer = rom[address + 1] * 0x100 + rom[address]
	if raw_pointer < 0x4000:
		bank = 0
	if bank is None:
		bank = get_bank(address)
	return (raw_pointer % 0x4000) + bank * 0x4000

def make_address_comment(address):
	if args.address_comments:
		return ": ; {:x} ({:x}:{:x})\n".format(address, get_bank(address), get_relative_address(address))
	else:
		return ":\n"

def make_blob(start, output, end=None):
	return { "start": start, "output": output, "end": end if end else start }

# run the disassembler and return the output
def dump_function(ptr):
	if ptr in [0x37480]:
		print('WARN: skipping cursed function {:x}'.format(ptr))
		return []
	if ptr == 0:
		return []
	print("DEBUG: disasm {:x}".format(ptr))

	try:
		disasm_output = disasm.output_bank_opcodes(ptr, None, parse_scripts=True)
		return [make_blob(ptr, disasm_output[0] + "\n", disasm_output[1])]
	except Exception as e:
		print("ERR:", e, "in function {:x}".format(ptr))
		return []

def dump_npcs(function_address, map_name_camelcase):
	blobs = []

	# the functions should always start with <ld hl, xxx_NPCs>
	if rom[function_address] == 0x21:
		table_start_address = get_pointer(function_address + 1)
	else:
		print("WARN: {}_NPCs table not found in function {:x}".format(map_name_camelcase, function_address))
		return []

	address = table_start_address

	label = map_name_camelcase + "_NPCs"
	output = label + make_address_comment(address)

	current_byte = rom[address]
	while current_byte != 0xff:
		npc_id = npcs[rom[address]]
		x_coord = rom[address+1]
		y_coord = rom[address+2]
		direction = directions[rom[address+3]]
		ptr = get_pointer(address+4)
		raw_ptr = rom[address+4] + (rom[address+5])*0x100

		if args.function_labels and ptr != 0:
			output += "\tnpc {}, {}, {}, {}, Func_{:x}\n".format(
				npc_id,	x_coord, y_coord, direction, ptr
			)
			blobs += dump_function(ptr)
		else:
			output += "\tnpc {}, {}, {}, {}, ${:x}\n".format(
				npc_id,	x_coord, y_coord, direction, raw_ptr
			)

		address += 6
		current_byte = rom[address]

	output += "\tdb $ff\n"
	blobs.append(make_blob(table_start_address, output, address+1))
	return blobs

def dump_stepevents(function_address, map_name_camelcase):
	blobs = []
	# the functions should always have:
	# <ld hl, xxx_StepEvents>
	# <call ExecutePlayerCoordScript>
	temp = function_address
	while rom[temp] != 0xc9: # ret
		if rom[temp] == 0x21 and rom[temp+3] == 0xcd and rom[temp+4] == 0x4d and rom[temp+5] == 0x32:
			table_start_address = get_pointer(temp + 1)
			break
		temp += 1
	if table_start_address is None:
		print("WARN: {}_StepEvents table not found in function {:x}".format(map_name_camelcase, function_address))
		return []

	address = table_start_address

	label = map_name_camelcase + "_StepEvents"
	output = label + make_address_comment(address)

	current_byte = rom[address]
	while current_byte != 0xff:

		dump_output = dump_ow_coordinate_function(address)
		output += dump_output['output']
		blobs += dump_output['blobs']

		address += 9
		current_byte = rom[address]

	output += "\tdb $ff\n"

	blobs.append(make_blob(table_start_address, output, address+1))
	return blobs

def dump_npcinteractions(function_address, map_name_camelcase):
	blobs = []
	# the functions should always have:
	# <ld hl, xxx_NPCInteractions>
	# <call Func_328c>
	# ONLY LightningFortCatherine calls <Func_32aa instead>
	temp = function_address
	table_start_address = None
	while rom[temp] != 0xc9: # ret
		if rom[temp] == 0x21 and rom[temp+3] == 0xcd and (rom[temp+4] in [0x8c,0xaa]) and rom[temp+5] == 0x32:
			table_start_address = get_pointer(temp + 1)
			break
		temp += 1
	if table_start_address is None:
		print("WARN: {}_NPCInteractions table not found in function {:x}".format(map_name_camelcase, function_address))
		return []


	address = table_start_address

	label = map_name_camelcase + "_NPCInteractions"
	output = label + make_address_comment(address)

	current_byte = rom[address]
	while current_byte != 0xff:
		npc_id = npcs[rom[address]]
		bank = rom[address+1]
		ptr = get_pointer(address+2, bank)
		raw_ptr = rom[address+2] + (rom[address+3])*0x100

		if args.function_labels:
			output += "\tnpc_script {}, Func_{:x}\n".format(npc_id,ptr)
			blobs += dump_function(ptr)
		else:
			output += "\tnpc_script {}, ${:02x}, ${:x}\n".format(npc_id, bank, raw_ptr)

		address += 4
		current_byte = rom[address]

	output += "\tdb $ff\n"

	blobs.append(make_blob(table_start_address, output, address+1))
	return blobs

def dump_afterduelscripts(function_address, map_name_camelcase):
	blobs = []
	# the functions should always have:
	# <ld hl, xxx_AfterDuelScripts>
	# <ld a, [$d60e]>
	temp = function_address
	table_start_address = None
	while rom[temp] != 0xc9: # ret
		if rom[temp] == 0x21:
			table_start_address = get_pointer(temp + 1)
			break
		temp += 1
	if table_start_address is None:
		print("WARN: {}_AfterDuelScripts table not found in function {:x}".format(map_name_camelcase, function_address))
		return []


	address = table_start_address

	label = map_name_camelcase +"_AfterDuelScripts"
	output = label + make_address_comment(address)

	current_byte = rom[address]
	while current_byte != 0xff:
		npc_id = npcs[rom[address]]
		bank = rom[address+1]
		ptr = get_pointer(address+2, bank)
		raw_ptr = rom[address+2] + (rom[address+3])*0x100

		if args.function_labels:
			output += "\tnpc_script {}, Func_{:x}\n".format(npc_id,ptr)
			blobs += dump_function(ptr)
		else:
			output += "\tnpc_script {}, ${:02x}, ${:x}\n".format(npc_id, bank, raw_ptr)

		address += 4
		current_byte = rom[address]

	output += "\tdb $ff\n"

	blobs.append(make_blob(table_start_address, output, address+1))
	return blobs

def dump_ow_coordinate_function(address):
	blobs = []
	x_coord = rom[address]
	y_coord = rom[address+1]
	a_register = rom[address+2]
	d_register = rom[address+3]
	e_register = rom[address+4]
	b_register = rom[address+5]
	bank = rom[address+6]
	function_addr = get_pointer(address+7, bank)
	raw_ptr = rom[address+7] + (rom[address+8])*0x100

	# see map_exit macro
	if function_addr == 0xd3c4:
		output = "\tmap_exit {}, {}, {}, {}, {}, {}\n".format(
			x_coord, y_coord, maps[a_register], d_register, e_register, directions[b_register]
		)
	# see ow_script macro
	elif a_register == 0 and d_register == 0 and e_register == 0 and b_register == 0:
		if args.function_labels:
			output = "\tow_script {}, {}, Func_{:x}\n".format(
				x_coord, y_coord, function_addr
			)
			blobs += dump_function(function_addr)
		else:
			output = "\tow_script {}, {}, ${:02x}, ${:x}\n".format(
				x_coord, y_coord, bank, raw_ptr
			)
	# generic case
	else:
		if args.function_labels:
			output = "\t_ow_coordinate_function {}, {}, {}, {}, {}, {}, Func_{:x}\n".format(
				x_coord, y_coord, a_register, d_register, e_register, b_register, function_addr
			)
			blobs += dump_function(function_addr)
		else:
			output = "\t_ow_coordinate_function {}, {}, {}, {}, {}, {}, ${:02x}, ${:x}\n".format(
				x_coord, y_coord, a_register, d_register, e_register, b_register, bank, raw_ptr
			)

	# this is gross. I'm sorry.
	return {'output':output, 'blobs':blobs}

def dump_owinteractions(function_address, map_name_camelcase):
	blobs = []
	# the functions should always have:
	# <ld hl, xxx_OWInteractions>
	# <call Func_32bf>
	# Only the two SealedFort maps instead have: <call ExecuteCoordScript>
	table_start_address = None
	temp = function_address
	while rom[temp] != 0xc9: # ret
		if rom[temp] == 0x21 and rom[temp+3] == 0xcd and (rom[temp+4] in [0xbf,0x54]) and rom[temp+5] == 0x32:
			table_start_address = get_pointer(temp + 1)
			break
		temp += 1
	if table_start_address is None:
		print("WARN: {}_OWInteractions table not found in function {:x}".format(map_name_camelcase,function_address))
		return []

	address = table_start_address

	label = map_name_camelcase + "_OWInteractions"
	output = label + make_address_comment(address)

	current_byte = rom[address]
	while current_byte != 0xff:
		dump_output = dump_ow_coordinate_function(address)
		output += dump_output['output']
		blobs += dump_output['blobs']

		address += 9
		current_byte = rom[address]

	output += "\tdb $ff\n"

	blobs.append(make_blob(table_start_address, output, address+1))
	return blobs

def dump_mapscripts_table(address, map_name_camelcase):
	blobs = []

	start_address = address
	output = ""
	label = map_name_camelcase + "_MapScripts"
	output += label + make_address_comment(start_address)

	current_byte = rom[address]
	while current_byte != 0xff:
		script_type = rom[address]
		function_ptr = get_pointer(address+1)
		raw_ptr = rom[address+1] + (rom[address+2])*0x100

		if args.function_labels:
			output += "\tdbw " + script_types[script_type] + ", Func_{:x}\n".format(function_ptr)
			blobs += dump_function(function_ptr)
		else:
			output += "\tdbw " + script_types[script_type] + ", ${:04x}\n".format(raw_ptr)

		if script_type == 6:
			blobs += dump_stepevents(function_ptr, map_name_camelcase)
		elif script_type == 7:
			blobs += dump_npcs(function_ptr, map_name_camelcase)
		elif script_type == 8:
			blobs += dump_npcinteractions(function_ptr, map_name_camelcase)
			blobs += dump_owinteractions(function_ptr, map_name_camelcase)
		elif script_type == 9:
			blobs += dump_afterduelscripts(function_ptr, map_name_camelcase)

		address += 3
		current_byte = rom[address]

	output += "\tdb $ff\n"

	blobs.append(make_blob(start_address, output, address+1))
	return blobs

def dump_mapheader(start_address, map_name_camelcase):
	blobs = []

	output = ""
	address = start_address

	map_gfx = mapgfx[rom[address]]
	mapscripts_ptr = get_pointer(address+2, rom[address+1])
	music = songs[rom[address+4]]

	output = map_name_camelcase + "_MapHeader" + make_address_comment(start_address)
	output += "\tdb " + map_gfx + "\n"
	output += "\tdba " + map_name_camelcase + "_MapScripts\n"
	output += "\tdb " + music + "\n"

	blobs.append(make_blob(start_address, output, start_address+5))
	blobs += (dump_mapscripts_table(mapscripts_ptr, map_name_camelcase))

	return blobs

def macro_case_to_pascalcase(name: str):
	return name.replace("MAP", "").replace("_", " ").title().replace(" ", "")

def dump_mapheadersptrs_table(start_address):
	blobs = []
	output = "MapHeaderPtrs::\n"

	address = start_address

	# there are 0x73 maps in the game
	for i in range(0x73+1):
		current_map = maps[i]
		map_name_camelcase = macro_case_to_pascalcase(current_map)
		map_header_address = get_pointer(address+1, rom[address])

		output += "\tdba " + map_name_camelcase + "_MapHeader\n"

		blobs += dump_mapheader(map_header_address, map_name_camelcase)
		address += 3

	blobs.append(make_blob(start_address, output, address))
	return blobs

def fill_gap(start, end):
	output = ""
	for address in range(start, end):
		output += "\tdb ${:x}\n".format(rom[address])
	output += "\n"
	return output

def sort_and_filter(blobs):
	blobs.sort(key=lambda b: (b["start"], b["end"], not b["output"].startswith(";")))
	filtered = []
	for blob, next in zip(blobs, blobs[1:]+[None]):
		if next and blob["start"] == next["start"] and blob["output"] == next["output"]:
			continue
		if next and blob["end"] < next["start"] and get_bank(blob["end"]) == get_bank(next["start"]):
			if args.fill_gaps:
				blob["output"] += fill_gap(blob["end"], next["start"])
			else:
				blob["output"] += "; gap from 0x{:x} to 0x{:x}\n\n".format(blob["end"], next["start"])

				# bit of a sketchy place to add SECTIONs to the output, but it works well
				bank = get_bank(next["start"])
				raw_addr = next["start"] - ((bank-1)*0x4000)
				blob["output"] += 'SECTION "Bank {:x}@{:04x}", ROMX[${:04x}], BANK[${:x}]\n'.format(bank, raw_addr, raw_addr, bank)
		blob["output"] += '\n'
		filtered.append(blob)
	if len(filtered) > 0:
		filtered[-1]["output"] = filtered[-1]["output"].rstrip("\n")
	return filtered

if __name__ == "__main__":
	ap = argparse.ArgumentParser(description="Pokemon TCG 2 Map Header Extractor")
	ap.add_argument("-a", "--address-comments", action="store_true", help="add address comments after labels")
	ap.add_argument("-f", "--function-labels", action="store_true", help="use function labels (Func_xxx) instead of raw bank/addr bytes")
	ap.add_argument("-g", "--fill-gaps", action="store_true", help="use 'db's to fill the gaps between visited locations")
	ap.add_argument("-r", "--rom", default="baserom.gbc", help="rom file to extract script from")
	ap.add_argument("-s", "--symfile", default="poketcg2.sym", help="symfile to extract symbols from")

	args = ap.parse_args()
	rom = bytearray(open(args.rom, "rb").read())
	blobs = []

	# initialize disassembler
	conf = configuration.Config()
	disasm = Disassembler(conf)
	disasm.initialize(args.rom, args.symfile)

	map_header_table_addr = 0xc651
	blobs += dump_mapheadersptrs_table(map_header_table_addr)

	blobs = sort_and_filter(blobs)
	output = ""
	for blob in blobs:
		output += blob["output"]
	print(output)
