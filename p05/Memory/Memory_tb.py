import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_memory_mapping(dut):
    """Verifies write and read operations across RAM, Scratchpad, and Register zones."""

    # 1. Start the simulation clock (10ns period)
    cocotb.start_soon(Clock(dut.clock, 10, unit="ns").start())

    # Initialize all input pins to a safe default state
    dut.in_.value = 0
    dut.address.value = 0
    dut.load.value = 0
    await RisingEdge(dut.clock)

    # Define test vectors for each memory segment
    # [Target Zone, Address, Data to Write]
    test_cases = [
        ("Main RAM Block",   0x1ABC, 0xDEAF), # Address[14] = 0 (Matches 2'b00 / 2'b01)
        ("Scratchpad RAM",   0x4567, 0x1234), # Address[14:13] = 2'b10
        ("Keyboard Register",0x6000, 0xABCD)  # Address[14:13] = 2'b11
    ]

    dut._log.info("--- Phase 1: Sequential Write Operations ---")
    for zone, addr, data in test_cases:
        await RisingEdge(dut.clock)
        dut.address.value = addr
        dut.in_.value = data
        dut.load.value = 1  # Enable writing
        
        dut._log.info(f"[WRITE] Storing {hex(data)} into {zone} at Address {hex(addr)}")
        
        # Hold for 1 cycle so the submodule registers latch the data on posedge clock
        await RisingEdge(dut.clock)



    await Timer(1, unit="ns")  # Ensure all writes have fully propagated through the memory hierarchy

    # Turn off load globally so we don't accidentally overwrite data during the read phase
    dut.load.value = 0
    dut.in_.value = 0
    await RisingEdge(dut.clock)
    await Timer(10, unit="ns")  # Let the delta-cycles and register outputs settle!

    dut._log.info("--- Phase 2: Sequential Read Verification Phase ---")
    for zone, addr, expected_data in test_cases:
        await RisingEdge(dut.clock)
        dut.address.value = addr
        
        # Give combinational multiplexer case logic a tiny fractional timeline step to settle
        await Timer(1, unit="ns")
        
        # Read back the data from the output bus
        captured_data = dut.out.value.to_unsigned()
        dut._log.info(f"[READ]  Address {hex(addr)} ({zone}) ---> Output Bus holds: {hex(captured_data)}")
        
        # Assertion validation check
        assert captured_data == expected_data, \
            f"Memory Map Mismatch in {zone}! Expected {hex(expected_data)}, but read back {hex(captured_data)}"

    dut._log.info("SUCCESS: All memory-mapped zones read and verified flawlessly!")