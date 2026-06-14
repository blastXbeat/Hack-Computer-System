# Hack Computer System

A complete implementation of the **16-bit Hack computer architecture** from the **Nand2Tetris** course, built from the ground up in **Verilog**. The project includes a custom CPU, memory hierarchy, a Python-based assembler, and simulation infrastructure for functional verification and waveform analysis.

## Features

* 16-bit Hack computer architecture
* Verilog implementation of core hardware components
* CPU and memory subsystem
* ROM and RAM modules
* Python-based Hack assembler
* Assembly programs for testing and validation
* Verilog testbenches
* VCD waveform generation and GTKWave-based debugging
* Modular and hierarchical design

## Project Structure

```text
.
|-- p01/
|   |-- modules/         # HDL Logic Gates (And, Mux, Not, etc.)
|   `-- testbenches/     # Verilog testbenches
|-- p02/
|   |-- modules/         # Combinational Logic (ALU, Adders, Inc)
|   `-- testbenches/
|-- p03/
|   |-- modules/         # Sequential Logic (DFF, RAM, Registers, PC)
|   `-- testbenches/
|-- p04/                 # Assembly Programming
|   |-- fill.asm
|   `-- mult.asm
|-- p05/                 # Full Hardware Architecture & Subsystems
|   |-- 16bit-hardware-architecture/
|   |   |-- Makefile
|   |   |-- computer.v
|   |   `-- computer_tb.py
|   |-- CPU/
|   |   |-- Makefile
|   |   |-- cpu.v
|   |   `-- cpu_tb.py
|   |-- Keyboard/
|   |   |-- Makefile
|   |   |-- kbd.v
|   |   `-- kbd_tb.py
|   |-- Memory/
|   |   |-- Makefile
|   |   |-- Memory.v
|   |   `-- Memory_tb.py
|   |-- Rom32k/
|   |   |-- Makefile
|   |   |-- ROM32K.v
|   |   `-- ROM32K_tb.py
|   `-- Screen/
|       |-- Makefile
|       |-- image-binary.py
|       |-- luffy.png
|       |-- screen.v
|       `-- screen_tb.py
`-- p06/                 # Hack Assembler
    |-- assembler.py
    |-- master_table.json
    `-- test_asm/        # Test assembly source files (.asm)
```

## Verification

The design is verified using custom Verilog testbenches. Simulation waveforms are generated as VCD files and analyzed using GTKWave for functional debugging and validation.

## Tools Used

* Verilog
* Python
* Icarus Verilog
* GTKWave
* Git
* Docker

## Architecture

This project follows the Hack computer architecture described in the Nand2Tetris course and demonstrates hardware-software co-design principles by combining digital hardware implementation with supporting software tools.

## References

* *The Elements of Computing Systems* by Noam Nisan and Shimon Schocken
* Nand2Tetris Project
