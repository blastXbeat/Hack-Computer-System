SIM ?= icarus

TOPLEVEL_LANG = verilog

VERILOG_SOURCES += $(PWD)/kbd.v

# Specify the TOPLEVEL module name inside your Verilog code
TOPLEVEL = Keyboard

# Specify the name of your Python testbench file (without the .py extension)
COCOTB_TEST_MODULES = kbd_tb

# --- Include cocotb build rules ---
include $(shell cocotb-config --makefiles)/Makefile.sim