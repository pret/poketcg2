#!/usr/bin/env python

from __future__ import print_function

import argparse
import sys

from constants import cards
from constants import cardpops
from constants import coins
from constants import conditions
from constants import decks
from constants import directions
from constants import duel_requirements
from constants import events
from constants import framesets
from constants import maps
from constants import npcs
from constants import palettes
from constants import sfxs
from constants import songs
from constants import tilemaps
from constants import vars

args = None
rom = None
symbols = None
texts = None

# script command names and parameter lists
script_commands = {
	0xcd: { "name": "start_script",                           "params": [ "skip_word" ] },

	0x00: { "name": "end_script",                             "params": [] },
	0x01: { "name": "script_command_01",                      "params": [] }, # reset npc's flag6 if in area (on screen?)
	0x02: { "name": "script_command_02",                      "params": [] }, # set npc's flag6 if in area (on screen?)
	0x03: { "name": "print_text",                             "params": [ "text" ] },
	0x04: { "name": "print_variable_text",                    "params": [ "text", "text" ] },
	0x05: { "name": "print_npc_text",                         "params": [ "text" ] },
	0x06: { "name": "print_variable_npc_text",                "params": [ "text", "text" ] },
	0x07: { "name": "ask_question",                           "params": [ "text", "bool" ] },
	0x08: { "name": "script_jump",                            "params": [ "script" ] },
	0x09: { "name": "script_jump_if_b0nz",                    "params": [ "script" ] },
	0x0a: { "name": "script_jump_if_b0z",                     "params": [ "script" ] },
	0x0b: { "name": "script_jump_if_b1nz",                    "params": [ "script" ] },
	0x0c: { "name": "script_jump_if_b1z",                     "params": [ "script" ] },
	0x0d: { "name": "compare_loaded_var",                     "params": [ "byte" ] },
	0x0e: { "name": "set_event",                              "params": [ "event" ] },
	0x0f: { "name": "reset_event",                            "params": [ "event" ] },
	0x10: { "name": "check_event",                            "params": [ "event" ] },
	0x11: { "name": "set_var",                                "params": [ "var", "byte" ] },
	0x12: { "name": "get_var",                                "params": [ "var" ] },
	0x13: { "name": "inc_var",                                "params": [ "var" ] },
	0x14: { "name": "dec_var",                                "params": [ "var" ] },
	0x15: { "name": "load_npc",                               "params": [ "npc", "byte_decimal", "byte_decimal", "direction" ] },
	0x16: { "name": "unload_npc",                             "params": [ "npc" ] },
	0x17: { "name": "set_player_direction",                   "params": [ "direction" ] },
	0x18: { "name": "set_active_npc_direction",               "params": [ "direction" ] },
	0x19: { "name": "do_frames",                              "params": [ "byte_decimal" ] },
	0x1a: { "name": "load_tilemap",                           "params": [ "tilemap", "byte", "byte" ] },
	0x1b: { "name": "show_card_received_screen",              "params": [ "card" ] },
	0x1c: { "name": "set_player_position",                    "params": [ "byte_decimal", "byte_decimal" ] },
	0x1d: { "name": "set_active_npc_position",                "params": [ "byte_decimal", "byte_decimal" ] },
	0x1e: { "name": "set_scroll_state",                       "params": [ "byte" ] }, # todo: enumerate scroll states
	0x1f: { "name": "scroll_to_position",                     "params": [ "byte", "byte" ] },
	0x20: { "name": "set_active_npc",                         "params": [ "npc", "text" ] },
	0x21: { "name": "set_player_position_and_direction",      "params": [ "byte_decimal", "byte_decimal", "direction" ] },
	0x22: { "name": "set_npc_position_and_direction",         "params": [ "npc", "byte_decimal", "byte_decimal", "direction" ] },
	0x23: { "name": "fade_in",                                "params": [ "byte", "bool" ] },
	0x24: { "name": "fade_out",                               "params": [ "byte", "bool" ] },
	0x25: { "name": "set_npc_direction",                      "params": [ "npc", "direction" ] },
	0x26: { "name": "set_npc_position",                       "params": [ "npc", "byte_decimal", "byte_decimal" ] },
	0x27: { "name": "set_active_npc_position_and_direction",  "params": [ "byte_decimal", "byte_decimal", "direction" ] },
	0x28: { "name": "animate_player_movement",                "params": [ "byte", "byte" ] },
	0x29: { "name": "animate_npc_movement",                   "params": [ "npc", "byte", "byte" ] },
	0x2a: { "name": "animate_active_npc_movement",            "params": [ "byte", "byte" ] },
	0x2b: { "name": "move_player",                            "params": [ "word", "bool" ] }, # todo: parse movement data
	0x2c: { "name": "move_npc",                               "params": [ "npc", "word" ] }, # todo: parse movement data
	0x2d: { "name": "move_active_npc",                        "params": [ "word" ] }, # todo: parse movement data
	0x2e: { "name": "start_duel",                             "params": [ "deck", "song" ] },
	0x2f: { "name": "wait_for_player_animation",              "params": [] },
	0x30: { "name": "wait_for_fade",                          "params": [] },
	0x31: { "name": "get_card_count_in_collection_and_decks", "params": [ "card" ] },
	0x32: { "name": "get_card_count_in_collection",           "params": [ "card" ] },
	0x33: { "name": "give_card",                              "params": [ "card" ] },
	0x34: { "name": "take_card",                              "params": [ "card" ] },
	0x35: { "name": "npc_ask_question",                       "params": [ "text", "bool" ] },
	0x36: { "name": "get_player_direction",                   "params": [] },
	0x37: { "name": "compare_var",                            "params": [ "var", "byte" ] },
	0x38: { "name": "get_active_npc_direction",               "params": [] },
	0x39: { "name": "scroll_to_active_npc",                   "params": [] },
	0x3a: { "name": "scroll_to_player",                       "params": [] },
	0x3b: { "name": "scroll_to_npc",                          "params": [ "npc" ] },
	0x3c: { "name": "spin_active_npc",                        "params": [ "word_decimal" ] },
	0x3d: { "name": "restore_active_npc_direction",           "params": [] },
	0x3e: { "name": "spin_active_npc_reverse",                "params": [ "word_decimal" ] },
	0x3f: { "name": "reset_npc_flag6",                        "params": [ "npc" ] },
	0x40: { "name": "set_npc_flag6",                          "params": [ "npc" ] },
	0x41: { "name": "duel_requirement_check",                 "params": [ "duel_requirement" ] },
	0x42: { "name": "get_active_npc_opposite_direction",      "params": [] },
	0x43: { "name": "get_player_opposite_direction",          "params": [] },
	0x44: { "name": "play_sfx",                               "params": [ "sfx" ] },
	0x45: { "name": "play_sfx_and_wait",                      "params": [ "sfx" ] },
	0x46: { "name": "set_text_ram2",                          "params": [ "text" ] },
	0x47: { "name": "set_variable_text_ram2",                 "params": [ "text", "text" ] },
	0x48: { "name": "wait_for_npc_animation",                 "params": [ "npc" ] },
	0x49: { "name": "get_player_x_position",                  "params": [] },
	0x4a: { "name": "get_player_y_position",                  "params": [] },
	0x4b: { "name": "restore_npc_direction",                  "params": [ "npc" ] },
	0x4c: { "name": "spin_npc",                               "params": [ "npc", "word_decimal" ] },
	0x4d: { "name": "spin_npc_reverse",                       "params": [ "npc", "word_decimal" ] },
	0x4e: { "name": "push_var",                               "params": [] },
	0x4f: { "name": "pop_var",                                "params": [] },
	0x50: { "name": "script_call",                            "params": [ "script", "condition" ] },
	0x51: { "name": "script_ret",                             "params": [] },
	0x52: { "name": "give_coin",                              "params": [ "coin" ] },
	0x53: { "name": "backup_active_npc",                      "params": [] },
	0x54: { "name": "load_player",                            "params": [ "byte_decimal", "byte_decimal", "direction" ] },
	0x55: { "name": "unload_player",                          "params": [] },
	0x56: { "name": "give_booster_packs",                     "params": [ "booster" ] },
	0x57: { "name": "get_random",                             "params": [ "byte" ] },
	0x58: { "name": "script_command_58",                      "params": [] }, # ?
	0x59: { "name": "set_text_ram3",                          "params": [ "word" ] },
	0x5a: { "name": "quit_script",                            "params": [] },
	0x5b: { "name": "play_song",                              "params": [ "song" ] },
	0x5c: { "name": "resume_song",                            "params": [] },
	0x5d: { "name": "script_callfar",                         "params": [ "script_far" ] },
	0x5e: { "name": "script_retfar",                          "params": [] },
	0x5f: { "name": "card_pop",                               "params": [ "cardpop" ] },
	0x60: { "name": "play_song_next",                         "params": [ "song" ] },
	0x61: { "name": "set_text_ram2b",                         "params": [ "text" ] },
	0x62: { "name": "set_variable_text_ram2b",                "params": [ "text", "text" ] },
	0x63: { "name": "replace_npc",                            "params": [ "npc", "npc" ] },
	0x64: { "name": "script_command_64",                      "params": [ "byte" ] }, # ?
	0x65: { "name": "check_npc_loaded",                       "params": [ "npc" ] },
	0x66: { "name": "give_deck",                              "params": [ "deck" ] },
	0x67: { "name": "script_command_67",                      "params": [ "byte", "byte" ] }, # ?
	0x68: { "name": "script_command_68",                      "params": [] }, # wait for ?
	0x69: { "name": "print_npc_text_instant",                 "params": [ "text" ] },
	0x6a: { "name": "var_add",                                "params": [ "var", "byte" ] },
	0x6b: { "name": "var_sub",                                "params": [ "var", "byte" ] },
	0x6c: { "name": "receive_card",                           "params": [ "card" ] },
	0x6d: { "name": "get_game_center_chips",                  "params": [] },
	0x6e: { "name": "compare_loaded_var_word",                "params": [ "word" ] },
	0x6f: { "name": "get_game_center_banked_chips",           "params": [] },
	0x70: { "name": "game_center",                            "params": [] },
	0x71: { "name": "script_command_71",                      "params": [] }, # conditionally set npc's flag6 if in area (on screen?)
	0x72: { "name": "give_chips",                             "params": [ "word_decimal" ] },
	0x73: { "name": "take_chips",                             "params": [ "word_decimal" ] },
	0x74: { "name": "load_text_ram3",                         "params": [] },
	0x75: { "name": "deposit_chips",                          "params": [] },
	0x76: { "name": "withdraw_chips",                         "params": [] },
	0x77: { "name": "link_duel",                              "params": [] },
	0x78: { "name": "wait_song",                              "params": [] },
	0x79: { "name": "load_palette",                           "params": [ "palette" ] },
	0x7a: { "name": "set_sprite_frameset",                    "params": [ "npc", "frameset" ] },
	0x7b: { "name": "wait_sfx",                               "params": [] },
	0x7c: { "name": "print_text_wide_textbox",                "params": [ "text" ] },
	0x7d: { "name": "wait_input",                             "params": [] },
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
	"byte":             1,
	"byte_decimal":     1,
	"bool":             1,
	"cardpop":          1,
	"coin":             1,
	"condition":        1,
	"deck":             1,
	"direction":        1,
	"duel_requirement": 1,
	"event":            1,
	"map":              1,
	"npc":              1,
	"prizes":           1,
	"sfx":              1,
	"song":             1,
	"var":              1,
	"word":             2,
	"word_decimal":     2,
	"booster":          2,
	"card":             2,
	"frameset":         2,
	"palette":          2,
	"tilemap":          2,
	"movement":         2,
	"movement_table":   2,
	"text":             2,
	"script":           2,
	"skip_word":        2,
	"script_far":       3,
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
	if args.address_comments:
		return ": ; {:x} ({:x}:{:x})\n".format(address, get_bank(address), get_relative_address(address))
	else:
		return ":\n"

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
			elif param_type == "bool":
				if param == 0:
					output += " FALSE"
				elif param == 1:
					output += " TRUE"
				else:
					raise ValueError
			elif param_type == "cardpop":
				output += " {}".format(cardpops[param])
			elif param_type == "coin":
				output += " {}".format(coins[param])
			elif param_type == "deck":
				output += " {}".format(decks[param])
			elif param_type == "direction":
				output += " {}".format(directions[param])
			elif param_type == "duel_requirement":
				output += " {}".format(duel_requirements[param])
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
			elif param_type == "var":
				output += " {}".format(vars[param])
			elif param_type == "word":
				output += " ${:04x}".format(param + rom[address + 1] * 0x100)
			elif param_type == "word_decimal":
				output += " {}".format(param + rom[address + 1] * 0x100)
			elif param_type == "booster":
				bank = 3
				if bank not in symbols:
					symbols[bank] = load_symbols(args.symfile, bank)
				param = get_pointer(address, bank)
				label = "BoosterList_{:x}".format(param)
				if param in symbols[bank]:
					label = symbols[bank][param]
				output += " {}".format(label)
			elif param_type == "card":
				output += " {}".format(cards[param + rom[address + 1] * 0x100])
			elif param_type == "frameset":
				output += " {}".format(framesets[param + rom[address + 1] * 0x100])
			elif param_type == "palette":
				output += " {}".format(palettes[param + rom[address + 1] * 0x100])
			elif param_type == "tilemap":
				output += " {}".format(tilemaps[param + rom[address + 1] * 0x100])
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
				if command_id == 0x50:
					condition = rom[address + 2]
					if condition != 0:
						output += " {},".format(conditions[condition])
				output += " {}".format(label)
			address += param_length
			if i < len(command["params"]) - 1:
				output += ","
		if output.endswith(","):
			output = output[:-1]
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
		blobs += dump_script(call, None, visited)
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
	ap.add_argument("-a", "--address-comments", action="store_true", help="add address comments after labels")
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
