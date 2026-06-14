import sys
import json


class Parser:
    def __init__(self, filename):
        self.filename = filename
        self.file = None
        self.whitespace_dict = {
            ' ': None,
            '\t': None,
            '\n': None,
            '\r': None
        }
        self.remove_table = str.maketrans(self.whitespace_dict)

    def get_lines(self):
        with open(self.filename, 'r') as f:
            return f.readlines()
        
    def parse(self):
        raw_lines = self.get_lines()
        cleaned_lines = []
        
        for line in raw_lines:
            cleaned = self.clean_up(line)
            cleaned_lines.append(cleaned)
            
        return cleaned_lines
    
    def clean_up(self,line):
        # Remove comments and whitespace from the line
        line_parts = line.split("//")
        code_part = line_parts[0].strip()
        cleaned_code = code_part.translate(self.remove_table)
        return cleaned_code


class Assembler:
    def __init__(self, parsed_data):
        self.parsed_data = parsed_data
        with open('master_table.json', 'r') as f:
            self.master_table = json.load(f)
        self.symbol_table = self.master_table['symbols']
        self.dest_table = self.master_table['dest']
        self.jump_table = self.master_table['jump']
        self.comp_table = self.master_table['comp']
        self.variable_rom = 16

    def convert_a_instruction(self, instruction):
        number = int(instruction[1:])  # Remove '@' and convert to integer
        bit_width = 16  # A-instruction is 16 bits wide

        #Apply a mask to simulate unsigned overflow
        # (1 << 16) - 1 creates a mask of sixteen 1s: 0xFFFF
        unsigned_number = number & ((1 << bit_width) - 1)

        #Format as a 16-bit binary string
        binary_str = f"{unsigned_number:016b}"

        # Safety Check: If an A-instruction starts with '1', something is wrong!
        if binary_str.startswith("1"):
            raise ValueError(f"Overflow Error: Constant in '{instruction}' exceeds 15 bits!")

        return binary_str  # Placeholder for converted A-instruction
    
    def convert_d_instruction(self, instruction):
        if ('=' in instruction) :
            dest, remainder = instruction.split('=')
        else:
            dest = None
            remainder = instruction

        if (';' in remainder):
            comp, jump = remainder.split(';')
        else:
            comp = remainder
            jump = None
        
        c_bits = self.comp_table.get(comp)
        if c_bits is None:
            raise ValueError(f"Invalid computation mnemonic: '{comp}' in instruction '{instruction}'")
        
        dest_bits = self.dest_table.get(dest, '000')  # Default to '000' if dest is None
        jump_bits = self.jump_table.get(jump, '000')  # Default to '000' if jump is None
        return f"111{c_bits}{dest_bits}{jump_bits}"  # Placeholder for parsed D-instruction components

    def label_resolution(self, instruction, rom_address):
        label = instruction[1:-1]
        # Store as integer (removes unnecessary str conversions)
        self.symbol_table[label] = rom_address 

    def assemble(self, output_filename):
        instruction_list = []
        cleaned_lines = self.parsed_data

        print("First pass: Resolving Labels...")
        rom_address = 0
        for line in cleaned_lines:
            if line == "":
                continue

            if line.startswith('(') and line.endswith(')'):
                # Labels map to the address of the NEXT instruction
                self.label_resolution(line, rom_address)
            else:
                # incrementing  ROM address for real instructions (A or C)
                rom_address += 1
        
        print("Second pass: Resolving Variables and Translating...")
        for line in cleaned_lines:
            
            if (line.startswith('(') and line.endswith(')')) or line == "":
                continue

            if line.startswith('@'):
                symbol = line[1:]
                if not symbol.isdigit():
                    # If it's a symbol we haven't seen, it MUST be a variable 
                    # (since all valid labels were gathered in Pass 1)
                    if symbol not in self.symbol_table:
                        self.symbol_table[symbol] = self.variable_rom
                        self.variable_rom += 1 # Move to next RAM slot
                    
                    # Look up the resolved address (integer) from the table
                    address = self.symbol_table[symbol]
                    a_instruction = self.convert_a_instruction(f"@{address}")
                else:
                    a_instruction = self.convert_a_instruction(line)
                
                instruction_list.append(a_instruction)
            else:
                d_instruction = self.convert_d_instruction(line)
                instruction_list.append(d_instruction)
 
        self.save_file(output_filename, instruction_list)

    def save_file(self, output_filename, binary_instructions):

        file_content = '\n'.join(binary_instructions)

        with open(output_filename, 'w') as f:
            f.write(file_content)
                
        print(f"Successfully assembled! Saved to {output_filename}")


if __name__ == "__main__":
    try:
        # Attempt to unpack exactly the arguments you expect
        # sys.argv[0] is the script name, [1] is input, [2] is output
        input_file = sys.argv[1]
        output_file = sys.argv[2]
        
    except IndexError:
        # This triggers if sys.argv[1] or sys.argv[2] don't exist
        print("Error: Missing file arguments!")
        print("Usage: python assembler.py <input_file.asm> <output_file.hack>")
        sys.exit(1)

    print("Parsing file...")
    parser = Parser(input_file)
    parsed_lines = parser.parse()

    print("Converting to binary...")
    assembler = Assembler(parsed_lines)
    assembler.assemble(output_file)
    print("Converted successfully!")


    
    