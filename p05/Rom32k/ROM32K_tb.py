import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_rom32k(dut):
    """Test bench for ROM32K"""

    expected_values = [
        0x0002,
        0xEC10,
        0x0003,
        0xE090,
        0x0000,
        0xE308
    ]

    for addr in range(6):
        dut.address.value = addr

        # Allow combinational logic to settle
        await Timer(1, unit="ns")

        actual = dut.out.value.to_unsigned()

        assert actual == expected_values[addr], (
            f"Test Failed at address {addr}: "
            f"Expected {expected_values[addr]:04X}, got {actual:04X}"
        )

        dut._log.info(
            f"Test Passed at address {addr}: "
            f"Correctly read value {actual:04X}"
        )

    dut._log.info("All tests completed successfully.")