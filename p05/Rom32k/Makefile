SIM ?= icarus

TOPLEVEL_LANG = verilog

VERILOG_SOURCES += $(PWD)/ROM32K.v

# Specify the TOPLEVEL module name inside your Verilog code
TOPLEVEL = ROM32K

# Specify the name of your Python testbench file (without the .py extension)
COCOTB_TEST_MODULES = ROM32K_tb

# --- Include cocotb build rules ---
include $(shell cocotb-config --makefiles)/Makefile.sim