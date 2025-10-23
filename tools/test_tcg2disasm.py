import unittest

import configuration
from tcg2disasm import Disassembler


class TestDisasm(unittest.TestCase):
    def setUp(self):
        rom = "baserom.gbc"
        symfile = "poketcg2.sym"

        # initialize disassembler
        conf = configuration.Config()
        disasm = Disassembler(conf)
        disasm.initialize(rom, symfile)

        self.disasm = disasm

    def test_Func_41233(self):
        ptr = 0x41233

        with open("tools/test/test_data/Func_41233.asm") as f:
            test_data = f.read()

            disasm_output = self.disasm.output_bank_opcodes(ptr, None, parse_scripts=True)[0]
            self.assertEqual(test_data, disasm_output)

    def test_Func_2c0b4(self):
        ptr = 0x2c0b4

        with open("tools/test/test_data/Func_2c0b4.asm") as f:
            test_data = f.read()

            disasm_output = self.disasm.output_bank_opcodes(ptr, None, parse_scripts=True)[0]
            self.assertEqual(test_data, disasm_output)

    def test_Func_35e5e(self):
        ptr = 0x35e5e

        with open("tools/test/test_data/Func_35e5e.asm") as f:
            test_data = f.read()

            disasm_output = self.disasm.output_bank_opcodes(ptr, None, parse_scripts=True)[0]
            self.assertEqual(test_data, disasm_output)

    def test_Func_334b3(self):
        ptr = 0x334b3

        with open("tools/test/test_data/Func_334b3.asm") as f:
            test_data = f.read()

            disasm_output = self.disasm.output_bank_opcodes(ptr, None, parse_scripts=True)[0]
            self.assertEqual(test_data, disasm_output)

    def test_Func_2c6ec(self):
        ptr = 0x2c6ec

        with open("tools/test/test_data/Func_2c6ec.asm") as f:
            test_data = f.read()

            disasm_output = self.disasm.output_bank_opcodes(ptr, None, parse_scripts=True)[0]
            self.assertEqual(test_data, disasm_output)

    def test_Func_3639f(self):
        ptr = 0x3639f

        with open("tools/test/test_data/Func_3639f.asm") as f:
            test_data = f.read()

            disasm_output = self.disasm.output_bank_opcodes(ptr, None, parse_scripts=True)[0]
            self.assertEqual(test_data, disasm_output)

    def test_Func_3678e(self):
        ptr = 0x3678e

        with open("tools/test/test_data/Func_3678e.asm") as f:
            test_data = f.read()

            disasm_output = self.disasm.output_bank_opcodes(ptr, None, parse_scripts=True)[0]
            self.assertEqual(test_data, disasm_output)

    def test_Func_3468f(self):
        ptr = 0x3468f

        with open("tools/test/test_data/Func_3468f.asm") as f:
            test_data = f.read()

            disasm_output = self.disasm.output_bank_opcodes(ptr, None, parse_scripts=True)[0]
            self.assertEqual(test_data, disasm_output)

    def test_Func_41662(self):
        ptr = 0x41662

        with open("tools/test/test_data/Func_41662.asm") as f:
            test_data = f.read()

            disasm_output = self.disasm.output_bank_opcodes(ptr, None, parse_scripts=True)[0]
            self.assertEqual(test_data, disasm_output)

if __name__ == '__main__':
    unittest.main()