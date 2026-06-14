import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge , ClockCycles, Timer

@cocotb.test()
async def test_computer(dut):
    """Test bench for Hack CPU"""

    clock = Clock(dut.clock, 20, unit="ns")  # Create a clock with a period of 20 ns => 50 MHz
    cocotb.start_soon(clock.start())  # Start the clock

   # Initialise
    dut.reset.value = 1
    dut.inM.value = 0
    dut.instruction.value = 0

    await ClockCycles(dut.clock, 2)  # 2 clock cycles
    dut.reset.value = 0  # Deassert reset
    await ClockCycles(dut.clock, 1)  # 1 clock cycle

    dut._log.info(f"Reset cleared . Initial PC value is : {dut.pc.value.to_unsigned()}")

    # Test 1: Load a value into A register
    dut.instruction.value = 0b0000000000001010  # @10
    await RisingEdge(dut.clock)  # Wait for the next clock edge 
    await Timer(1, unit="ns") # Let the delta-cycles and register outputs settle! 
    assert dut.addressM.value.to_unsigned() == 10, f"Test 1 Failed: Expected A=10, got {dut.addressM.value.to_unsigned()}"
    dut._log.info("Test 1 Passed: A register loaded with 10")


    # Test 2: Load a value into D register
    dut.instruction.value = 0b1110110000010000  # D=A
    await RisingEdge(dut.clock)  # Wait for the next clock edge
    await Timer(1, unit="ns") # Let the delta-cycles and register outputs settle!
    assert dut.alux.value.to_unsigned() == 10, f"Test 2 Failed: Expected D=10, got {dut.alux.value.to_unsigned()}"
    dut._log.info("Test 2 Passed: D register loaded with value from A register")

    # Test 3: Add A and D and store in D
    dut.instruction.value = 0b1110000010010000  # D=D+A
    await RisingEdge(dut.clock)  # Wait for the next clock edge
    await Timer(1, unit="ns") # Let the delta-cycles and register outputs settle!
    assert dut.alux.value.to_unsigned() == 20, f"Test 3 Failed: Expected D=20, got {dut.alux.value.to_unsigned()}"
    dut._log.info("Test 3 Passed: D register updated with D+A")

    # Test 4: Store D into memory at address in A
    dut.instruction.value = 0b1110001100001000  # M=D
    await RisingEdge(dut.clock)  # Wait for the next clock edge
    await Timer(1, unit="ns") # Let the delta-cycles and register outputs settle!
    assert dut.outM.value.to_unsigned() == 20, f"Test 4 Failed: Expected outM=20, got {dut.outM.value.to_unsigned()}\n Expected address in A=10 got: {dut.addressM.value.to_unsigned()}\n Expected writeM=1 got: {dut.writeM.value.to_unsigned()}"
    dut._log.info("Test 4 Passed: Memory at address A updated with value from D register")

    # Test 5: Jump to address 0 if D is not zero
    dut.instruction.value = 0b1110001100000111  # D;JNE
    await RisingEdge(dut.clock)  # Wait for the next clock edge
    await Timer(1, unit="ns") # Let the delta-cycles and register outputs settle!
    assert dut.pc.value.to_unsigned() != 0, f"Test 5 Failed: Expected PC!=0, got {dut.pc.value.to_unsigned()}"
    dut._log.info("Test 5 Passed: Jumped to address 0 because D is not zero")

    await ClockCycles(dut.clock, 5)  # Wait for a few more clock cycles to observe behavior
    dut._log.info("All tests completed successfully.")
   
