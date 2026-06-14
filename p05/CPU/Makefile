SIM ?= icarus                    # Tells Cocotb which simulator engine to boot
VERILOG_SOURCES += $(PWD)/cpu.v  # Tells the simulator where your hardware files are
TOPLEVEL = CPU                   # Specifies the exact root Verilog module to test
COCOTB_TEST_MODULES = cpu_tb     # Specifies the Python test script filename

include $(shell cocotb-config --makefiles)/Makefile.sim