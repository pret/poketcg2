#!/usr/bin/env python

from __future__ import print_function

import argparse
import sys

from constants import cards
from constants import decks
from constants import directions
from constants import events
from constants import maps
from constants import npcs
from constants import sfxs
from constants import songs

args = None
rom = None
symbols = None
texts = None

# script command names and parameter lists
script_commands = {
	0xcd: { "name": "start_script",      "params": [ "skip_word" ] },

	0x00: { "name": "end_script",        "params": [] },
	0x01: { "name": "script_command_01", "params": [] }, # ?
	0x02: { "name": "script_command_02", "params": [] }, # ?
	0x03: { "name": "script_command_03", "params": [ "text" ] }, # print text
	0x04: { "name": "script_command_04", "params": [ "text", "text" ] }, # print variable text
	0x05: { "name": "script_command_05", "params": [ "text" ] }, # print npc text
	0x06: { "name": "script_command_06", "params": [ "text", "text" ] }, # print variable npc text
	0x07: { "name": "script_command_07", "params": [ "text", "byte" ] }, # ask question
	0x08: { "name": "script_command_08", "params": [ "script" ] }, # script jump
	0x09: { "name": "script_command_09", "params": [ "script" ] }, # conditional script jump
	0x0a: { "name": "script_command_0a", "params": [ "script" ] }, # conditional script jump
	0x0b: { "name": "script_command_0b", "params": [ "script" ] }, # conditional script jump
	0x0c: { "name": "script_command_0c", "params": [ "script" ] }, # conditional script jump
	0x0d: { "name": "script_command_0d", "params": [ "byte" ] }, # compare loaded var
	0x0e: { "name": "script_command_0e", "params": [ "byte" ] }, # set event
	0x0f: { "name": "script_command_0f", "params": [ "byte" ] }, # reset event
	0x10: { "name": "script_command_10", "params": [ "byte" ] }, # check event
	0x11: { "name": "script_command_11", "params": [ "byte", "byte" ] }, # set var
	0x12: { "name": "script_command_12", "params": [ "byte" ] }, # get var
	0x13: { "name": "script_command_13", "params": [ "byte" ] }, # inc var
	0x14: { "name": "script_command_14", "params": [ "byte" ] }, # dec var
	0x15: { "name": "script_command_15", "params": [ "byte", "byte", "byte", "byte" ] }, # load npc (position and direction)
	0x16: { "name": "script_command_16", "params": [ "byte" ] }, # unload npc
	0x17: { "name": "script_command_17", "params": [ "byte" ] }, # set player direction
	0x18: { "name": "script_command_18", "params": [ "byte" ] }, # set active npc direction
	0x19: { "name": "script_command_19", "params": [ "byte_decimal" ] }, # do frames
	0x1a: { "name": "script_command_1a", "params": [ "word", "byte", "byte" ] }, # load tilemap
	0x1b: { "name": "script_command_1b", "params": [ "card" ] }, # show card received screen
	0x1c: { "name": "script_command_1c", "params": [ "byte", "byte" ] }, # set player position
	0x1d: { "name": "script_command_1d", "params": [ "byte", "byte" ] }, # set active npc position
	0x1e: { "name": "script_command_1e", "params": [ "byte" ] }, # set scroll state
	0x1f: { "name": "script_command_1f", "params": [ "byte", "byte" ] }, # scroll to position
	0x20: { "name": "script_command_20", "params": [ "byte", "text" ] }, # set active npc
	0x21: { "name": "script_command_21", "params": [ "byte", "byte", "byte" ] }, # set player position and direction
	0x22: { "name": "script_command_22", "params": [ "byte", "byte", "byte", "byte" ] }, # set npc position and direction
	0x23: { "name": "script_command_23", "params": [ "byte", "byte" ] }, # screen fade out
	0x24: { "name": "script_command_24", "params": [ "byte", "byte" ] }, # screen fade in
	0x25: { "name": "script_command_25", "params": [ "byte", "byte" ] }, # set npc direction
	0x26: { "name": "script_command_26", "params": [ "byte", "byte", "byte" ] }, # set npc position
	0x27: { "name": "script_command_27", "params": [ "byte", "byte", "byte" ] }, # set active npc position and direction
	0x28: { "name": "script_command_28", "params": [ "byte", "byte" ] }, # animate player movement
	0x29: { "name": "script_command_29", "params": [ "byte", "byte", "byte" ] }, # animate npc movement
	0x2a: { "name": "script_command_2a", "params": [ "byte", "byte" ] }, # animate active npc movement
	0x2b: { "name": "script_command_2b", "params": [ "word", "byte" ] }, # move player
	0x2c: { "name": "script_command_2c", "params": [ "byte", "word" ] }, # move npc
	0x2d: { "name": "script_command_2d", "params": [ "word" ] }, # move active npc
	0x2e: { "name": "script_command_2e", "params": [ "byte", "byte" ] }, # start duel
	0x2f: { "name": "script_command_2f", "params": [] }, # wait for player animation
	0x30: { "name": "script_command_30", "params": [] }, # wait for fade
	0x31: { "name": "script_command_31", "params": [ "card" ] }, # get card count in collection and decks
	0x32: { "name": "script_command_32", "params": [ "card" ] }, # get card count in collection
	0x33: { "name": "script_command_33", "params": [ "card" ] }, # give card
	0x34: { "name": "script_command_34", "params": [ "card" ] }, # take card
	0x35: { "name": "script_command_35", "params": [ "text", "byte" ] }, # npc ask question
	0x36: { "name": "script_command_36", "params": [] }, # get player direction
	0x37: { "name": "script_command_37", "params": [ "byte", "byte" ] }, # compare var
	0x38: { "name": "script_command_38", "params": [] }, # get active npc direction
	0x39: { "name": "script_command_39", "params": [] }, # scroll to active npc
	0x3a: { "name": "script_command_3a", "params": [] }, # scroll to player
	0x3b: { "name": "script_command_3b", "params": [ "byte" ] }, # scroll to npc
	0x3c: { "name": "script_command_3c", "params": [ "word" ] }, # spin active npc
	0x3d: { "name": "script_command_3d", "params": [] }, # restore active npc direction
	0x3e: { "name": "script_command_3e", "params": [ "word" ] }, # spin active npc reverse
	0x3f: { "name": "script_command_3f", "params": [ "byte" ] }, # reset npc flag6
	0x40: { "name": "script_command_40", "params": [ "byte" ] }, # set npc flag6
	0x41: { "name": "script_command_41", "params": [ "byte" ] }, # duel requirement check
	0x42: { "name": "script_command_42", "params": [] }, # get active npc opposite direction
	0x43: { "name": "script_command_43", "params": [] }, # get player opposite direction
	0x44: { "name": "script_command_44", "params": [ "byte" ] }, # play sfx
	0x45: { "name": "script_command_45", "params": [ "byte" ] }, # play sfx and wait
	0x46: { "name": "script_command_46", "params": [ "text" ] }, # load text ram2
	0x47: { "name": "script_command_47", "params": [ "text", "text" ] }, # load variable text ram2
	0x48: { "name": "script_command_48", "params": [ "byte" ] }, # wait for animation
	0x49: { "name": "script_command_49", "params": [] }, # get player x position
	0x4a: { "name": "script_command_4a", "params": [] }, # get player y position
	0x4b: { "name": "script_command_4b", "params": [ "byte" ] }, # restore npc direction
	0x4c: { "name": "script_command_4c", "params": [ "byte", "word" ] }, # spin npc
	0x4d: { "name": "script_command_4d", "params": [ "byte", "word" ] }, # spin npc reverse
	0x4e: { "name": "script_command_4e", "params": [] }, # push var
	0x4f: { "name": "script_command_4f", "params": [] }, # pop var
	0x50: { "name": "script_command_50", "params": [ "script", "byte" ] }, # conditional script call
	0x51: { "name": "script_command_51", "params": [] }, # script ret
	0x52: { "name": "script_command_52", "params": [ "byte" ] }, # give coin
	0x53: { "name": "script_command_53", "params": [] }, # backup active npc
	0x54: { "name": "script_command_54", "params": [ "byte", "byte", "byte" ] }, # load player (position and direction)
	0x55: { "name": "script_command_55", "params": [] }, # unload player
	0x56: { "name": "script_command_56", "params": [ "word" ] }, # ?
	0x57: { "name": "script_command_57", "params": [ "byte" ] }, # get random
	0x58: { "name": "script_command_58", "params": [] }, # ?
	0x59: { "name": "script_command_59", "params": [ "word" ] }, # load text ram3
	0x5a: { "name": "script_command_5a", "params": [] }, # alternate quit
	0x5b: { "name": "script_command_5b", "params": [ "byte" ] }, # play song
	0x5c: { "name": "script_command_5c", "params": [] }, # resume song
	0x5d: { "name": "script_command_5d", "params": [ "script_far" ] }, # script callfar
	0x5e: { "name": "script_command_5e", "params": [] }, # script retfar
	0x5f: { "name": "script_command_5f", "params": [ "byte" ] }, # cardpop
	0x60: { "name": "script_command_60", "params": [ "byte" ] }, # play song next
	0x61: { "name": "script_command_61", "params": [ "text" ] }, # load text ram2b
	0x62: { "name": "script_command_62", "params": [ "text", "text" ] }, # load variable text ram2b
	0x63: { "name": "script_command_63", "params": [ "byte", "byte" ] }, # replace npc
	0x64: { "name": "script_command_64", "params": [ "byte" ] }, # ?
	0x65: { "name": "script_command_65", "params": [ "byte" ] }, # check npc loaded
	0x66: { "name": "script_command_66", "params": [ "byte" ] }, # give deck
	0x67: { "name": "script_command_67", "params": [ "byte", "byte" ] }, # ?
	0x68: { "name": "script_command_68", "params": [] }, # wait for ?
	0x69: { "name": "script_command_69", "params": [ "text" ] }, # print npc text instant
	0x6a: { "name": "script_command_6a", "params": [ "byte", "byte" ] }, # var add
	0x6b: { "name": "script_command_6b", "params": [ "byte", "byte" ] }, # var sub
	0x6c: { "name": "script_command_6c", "params": [ "card" ] }, # receive card
	0x6d: { "name": "script_command_6d", "params": [] }, # fetch wda99
	0x6e: { "name": "script_command_6e", "params": [ "word" ] }, # compare word var
	0x6f: { "name": "script_command_6f", "params": [] }, # fetch wda9b
	0x70: { "name": "script_command_70", "params": [] }, # game center
	0x71: { "name": "script_command_71", "params": [] }, # ?
	0x72: { "name": "script_command_72", "params": [ "word" ] }, # ?
	0x73: { "name": "script_command_73", "params": [ "word" ] }, # ?
	0x74: { "name": "script_command_74", "params": [] }, # set text ram3
	0x75: { "name": "script_command_75", "params": [] }, # ?
	0x76: { "name": "script_command_76", "params": [] }, # ?
	0x77: { "name": "script_command_77", "params": [] }, # link duel
	0x78: { "name": "script_command_78", "params": [] }, # wait song
	0x79: { "name": "script_command_79", "params": [ "word" ] }, # load palette
	0x7a: { "name": "script_command_7a", "params": [ "byte", "word" ] }, # set sprite frameset
	0x7b: { "name": "script_command_7b", "params": [] }, # wait sfx
	0x7c: { "name": "script_command_7c", "params": [ "text" ] }, # print text wide textbox
	0x7d: { "name": "script_command_7d", "params": [] }, # wait input
}

quit_commands = [
	0x00,
	0x08,
	0x51,
	0x5a,
	0x5e,
]

# length in bytes of each type of parameter
param_lengths = {
	"byte":           1,
	"byte_decimal":   1,
	"deck":           1,
	"direction":      1,
	"event":          1,
	"map":            1,
	"npc":            1,
	"prizes":         1,
	"sfx":            1,
	"song":           1,
	"word":           2,
	"word_decimal":   2,
	"card":           2,
	"movement":       2,
	"movement_table": 2,
	"text":           2,
	"script":         2,
	"skip_word":      2,
	"script_far":     3,
}

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
	return ": ; {:x} ({:x}:{:x})\n".format(address, get_bank(address), get_relative_address(address))

def make_blob(start, output, end=None):
	return { "start": start, "output": output, "end": end if end else start }

def dump_movement(address):
	blobs = []
	label = "NPCMovement_{:x}".format(address)
	if address in symbols[get_bank(address)]:
		label = symbols[get_bank(address)][address]
	blobs.append(make_blob(address, label + make_address_comment(address)))
	while 1:
		movement = rom[address]
		if movement == 0xff:
			blobs.append(make_blob(address, "\tdb ${:02x}\n\n".format(movement), address + 1))
			break
		if movement == 0xfe:
			jump = rom[address + 1]
			if jump > 127:
				jump -= 256
			blobs.append(make_blob(address, "\tdb ${:02x}, {}\n\n".format(movement, jump), address + 2))
			break
		blobs.append(make_blob(address, "\tdb {}".format(directions[movement & 0b01111111]) + (" | NO_MOVE\n" if movement & 0b10000000 else "\n"), address + 1))
		address += 1
	return blobs

def dump_movement_table(address):
	blobs = []
	label = "NPCMovementTable_{:x}".format(address)
	if address in symbols[get_bank(address)]:
		label = symbols[get_bank(address)][address]
	blobs.append(make_blob(address, label + make_address_comment(address)))
	for i in range(4):
		pointer = get_pointer(address)
		blobs.append(make_blob(address, "\tdw NPCMovement_{:x}\n".format(pointer) + ("\n" if i == 3 else ""), address + 2))
		blobs += dump_movement(pointer)
		address += 2
	return blobs

# parse a script starting at the given address
# returns a list of all commands
def dump_script(start_address, address=None, visited=set()):
	global symbols
	blobs = []
	branches = set()
	calls = set()
	if address is None:
		label = "Script_{:x}".format(start_address)
		if start_address in symbols[get_bank(start_address)]:
			label = symbols[get_bank(start_address)][start_address]
		blobs.append(make_blob(start_address, label + make_address_comment(start_address)))
		address = start_address
	else:
		label = ".ows_{:x}\n".format(address)
		if address in symbols[get_bank(address)]:
			label = symbols[get_bank(address)][address]
			if label.startswith("."):
				label += "\n"
			else:
				label += make_address_comment(address)
		blobs.append(make_blob(address, label))
	if address in visited:
		return blobs
	visited.add(address)
	while 1:
		command_address = address
		command_id = rom[command_address]
		command = script_commands[command_id]
		address += 1
		output = "\t{}".format(command["name"])
		# print all params for current command
		for i in range(len(command["params"])):
			param = rom[address]
			param_type = command["params"][i]
			param_length = param_lengths[param_type]
			if param_type == "byte":
				output += " ${:02x}".format(param)
			elif param_type == "byte_decimal":
				output += " {}".format(param)
			elif param_type == "deck":
				output += " {}".format(decks[param])
			elif param_type == "direction":
				output += " {}".format(directions[param])
			elif param_type == "event":
				output += " {}".format(events[param])
			elif param_type == "map":
				output += " {}".format(maps[param])
			elif param_type == "npc":
				output += " {}".format(npcs[param])
			elif param_type == "prizes":
				output += " PRIZES_{}".format(param)
			elif param_type == "sfx":
				output += " {}".format(sfxs[param])
			elif param_type == "song":
				output += " {}".format(songs[param])
			elif param_type == "word":
				output += " ${:04x}".format(param + rom[address + 1] * 0x100)
			elif param_type == "word_decimal":
				output += " {}".format(param + rom[address + 1] * 0x100)
			elif param_type == "card":
				output += " {}".format(cards[param + rom[address + 1] * 0x100])
			elif param_type == "movement":
				param = get_pointer(address)
				label = "NPCMovement_{:x}".format(param)
				if param in symbols[get_bank(param)]:
					label = symbols[get_bank(param)][param]
				output += " {}".format(label)
				blobs += dump_movement(param)
			elif param_type == "movement_table":
				param = get_pointer(address)
				label = "NPCMovementTable_{:x}".format(param)
				if param in symbols[get_bank(param)]:
					label = symbols[get_bank(param)][param]
				output += " {}".format(label)
				blobs += dump_movement_table(param)
			elif param_type == "text":
				text_id = param + rom[address + 1] * 0x100
				if text_id == 0x0000:
					output += " NULL"
				else:
					output += " {}".format(texts[text_id])
			elif param_type == "script" or param_type == "script_far":
				if param_type == "script":
					param = get_pointer(address)
				else:
					bank = rom[address + 2]
					if bank not in symbols:
						symbols[bank] = load_symbols(args.symfile, bank)
					param = get_pointer(address, bank)
				if param == 0x0000:
					label = "NULL"
				elif param == start_address:
					label = "Script_{:x}".format(param)
					if param in symbols[get_bank(param)]:
						label = symbols[get_bank(param)][param]
				elif param_type == "script_far":
					label = "Script_{:x}".format(param)
					if param in symbols[get_bank(param)]:
						label = symbols[get_bank(param)][param]
					if args.follow_far_calls:
						calls.add(param)
				else:
					label = ".ows_{:x}".format(param)
					if param in symbols[get_bank(param)]:
						label = symbols[get_bank(param)][param]
					if param > start_address or args.allow_backward_jumps:
						branches.add(param)
				output += " {}".format(label)
			address += param_length
			if i < len(command["params"]) - 1:
				output += ","
		output += "\n"
		blobs.append(make_blob(command_address, output, address))
		if command_id in quit_commands:
			if rom[address] == 0xc9:
				blobs.append(make_blob(address, "\tret\n", address + 1))
				address += 1
			blobs.append(make_blob(address, "; 0x{:x}\n\n".format(address)))
			break
	for branch in branches:
		blobs += dump_script(start_address, branch, visited)
	for call in calls:
		blobs += dump_script(call, call, visited)
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
		filtered.append(blob)
	if len(filtered) > 0:
		filtered[-1]["output"] = filtered[-1]["output"].rstrip("\n")
	return filtered

def find_unreachable_labels(input):
	scope = ""
	label_scopes = {}
	local_labels = set()
	local_references = set()
	unreachable_labels = set()
	for line in input.split("\n"):
		line = line.split(";")[0].rstrip()
		if line.startswith("\t"):
			for word in [x.rstrip(",") for x in line.split()]:
				if word.startswith("."):
					local_references.add(word)
		elif line.startswith("."):
			label = line.split()[0]
			local_labels.add(label)
			label_scopes[label] = scope
		elif line.endswith(":"):
			for label in local_references:
				if label not in local_labels:
					unreachable_labels.add(label)
			scope = line[:-1]
			local_labels = set()
			local_references = set()
	for label in local_references:
		if label not in local_labels:
			unreachable_labels.add(label)
	unreachable_labels = list(unreachable_labels)
	for i in range(len(unreachable_labels)):
		label = unreachable_labels[i]
		unreachable_labels[i] = { "scope": label_scopes.get(label, ""), "label": label }
	return unreachable_labels

def fix_unreachable_labels(input, unreachable_labels):
	scope = ""
	output = ""
	for line in input.split("\n"):
		stripped_line = line.split(";")[0].rstrip()
		if line.startswith("\t"):
			for label in unreachable_labels:
				if label["label"] in line and label["scope"] != scope:
					line = line.replace(label["label"], label["scope"] + label["label"])
		elif stripped_line.endswith(":"):
			scope = stripped_line[:-1]
		output += line + "\n"
	output = output.rstrip("\n")
	return output

def load_symbols(symfile, load_bank):
	sym = {}
	for line in open(symfile, encoding="utf8"):
		line = line.split(";")[0].strip()
		if line.startswith("{:02x}:".format(load_bank)):
			bank_address, label = line.split(" ")[:2]
			bank, address = bank_address.split(":")
			address = (int(address, 16) % 0x4000) + int(bank, 16) * 0x4000
			if "." in label:
				label = "." + label.split(".")[1]
			sym[address] = label
	return sym

def load_texts(txfile):
	tx = [None]
	for line in open(txfile, encoding="utf8"):
		if line.startswith("\ttextpointer"):
			tx.append(line.split()[1])
	return tx

if __name__ == "__main__":
	ap = argparse.ArgumentParser(description="Pokemon TCG 2 Script Extractor")
	ap.add_argument("-b", "--allow-backward-jumps", action="store_true", help="extract scripts that are found before the starting address")
	ap.add_argument("-c", "--follow-far-calls", action="store_true", help="extract scripts that are in another bank")
	ap.add_argument("-f", "--fix-unreachable", action="store_true", help="fix unreachable labels that are referenced from the wrong scope")
	ap.add_argument("-g", "--fill-gaps", action="store_true", help="use 'db's to fill the gaps between visited locations")
	ap.add_argument("-i", "--ignore-errors", action="store_true", help="silently proceed to the next address if an error occurs")
	ap.add_argument("-r", "--rom", default="baserom.gbc", help="rom file to extract script from")
	ap.add_argument("-s", "--symfile", default="poketcg2.sym", help="symfile to extract symbols from")
	ap.add_argument("addresses", nargs="+", help="addresses to extract from")
	args = ap.parse_args()
	rom = bytearray(open(args.rom, "rb").read())
	symbols = {}
	texts = load_texts("src/text/text_offsets.asm")
	blobs = []
	for address in args.addresses:
		try:
			addr = int(address, 16)
			bank = get_bank(addr)
			if bank not in symbols:
				symbols[bank] = load_symbols(args.symfile, bank)
			blobs += dump_script(addr)
		except:
			print("Parsing script failed: {}".format(address), file=sys.stderr)
			if not args.ignore_errors:
				raise
	blobs = sort_and_filter(blobs)
	output = ""
	for blob in blobs:
		output += blob["output"]
	if args.fix_unreachable:
		unreachable_labels = find_unreachable_labels(output)
		output = fix_unreachable_labels(output, unreachable_labels)
	print(output)
