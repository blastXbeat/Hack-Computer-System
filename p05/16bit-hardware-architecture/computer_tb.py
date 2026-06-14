import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_computer(dut):
    """Execute Add.hack and verify RAM[0] = 5."""

    dut._log.info("=" * 60)
    dut._log.info("TEST START : Add Program")
    dut._log.info("=" * 60)

    # ------------------------------------------------------------------
    # Clock Generation
    # ------------------------------------------------------------------
    dut._log.info("[SETUP] Starting 50 MHz system clock")
    clock = Clock(dut.clk, 20, unit="ns")
    cocotb.start_soon(clock.start())

    # ------------------------------------------------------------------
    # Reset Sequence
    # ------------------------------------------------------------------
    dut._log.info("[RESET] Applying reset")
    dut.rst.value = 1
    await ClockCycles(dut.clk, 2)

    dut.rst.value = 0
    dut._log.info("[RESET] Released reset")

    # ------------------------------------------------------------------
    # Program Execution
    # ------------------------------------------------------------------
    dut._log.info("[EXECUTE] Running program")
    await ClockCycles(dut.clk, 10)

    # ------------------------------------------------------------------
    # Verification
    # ------------------------------------------------------------------
    expected = 5
    actual = dut.memory.ram32k_inst.ram[0].value.to_unsigned()

    dut._log.info(
        f"[VERIFY] RAM[0] = 0x{actual:04X} ({actual}), "
        f"expected = 0x{expected:04X} ({expected})"
    )

    assert actual == expected, (
        f"RAM[0] mismatch: expected {expected}, got {actual}"
    )

    dut._log.info("[PASS] Add program executed successfully")
    dut._log.info("=" * 60)