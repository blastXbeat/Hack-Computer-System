import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_simple_keyboard(dut):
    """Feeds characters into the keyboard module and verifies the output."""
    
    # 1. Start a simple clock runner in the background
    cocotb.start_soon(Clock(dut.clock, 10, unit="ns").start())
    
    # Initialize the input to 0 (No key pressed)
    dut.kbd_in.value = 0
    await RisingEdge(dut.clock)
    
    # 2. Define the string sequence you want to simulate typing
    test_string = "LUFFY"
    dut._log.info(f"Simulating physical typing sequence: '{test_string}'")
    
    for char in test_string:
        # Convert the string letter to its integer ASCII representation (e.g., 'L' -> 76)
        ascii_code = ord(char)
        
        # Drive the ASCII code onto the input lines
        dut.kbd_in.value = ascii_code
        await RisingEdge(dut.clock) # Wait for the clock edge to latch data

        await Timer(10, unit="ns") # Brief delay to allow the hardware to process the input
        
        # 3. Read back and check the hardware output register value instantly
        captured_value = dut.kbd_out.value.to_unsigned()
        dut._log.info(f"Input Key: '{char}' ({ascii_code}) ---> Hardware Output: {captured_value}")
        
        # Instant verification check
        assert captured_value == ascii_code, f"Mismatch! Expected {ascii_code}, got {captured_value}"
        
        # Simulate releasing the key (input drops back to 0)
        dut.kbd_in.value = 0
        await RisingEdge(dut.clock)
        await Timer(10, unit="ns") # Brief delay between keystrokes

    dut._log.info("Success! All characters were cleanly mapped and verified.")