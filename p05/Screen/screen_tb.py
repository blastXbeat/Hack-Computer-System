import os
import pygame
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

# 1. FORCE PYGAME TO RUN HEADLESS (No X-Server / GUI needed!)
os.environ["SDL_VIDEODRIVER"] = "dummy"

WIDTH, HEIGHT = 512, 256
WORDS_PER_ROW = WIDTH // 16 
TOTAL_WORDS = 8192         

pygame.init()
# This creates an in-memory rendering surface instead of a desktop window
screen_surface = pygame.Surface((WIDTH, HEIGHT))

def export_screen_snapshot(dut):
    """Reads the DUT memory array and writes it directly to a PNG file."""
    screen_surface.fill((0, 0, 0)) 
    v_mem = dut.screen

    for addr in range(TOTAL_WORDS):
        try:
            word_value = v_mem[addr].value.to_unsigned()
        except ValueError:
            word_value = 0
                
        row = addr // WORDS_PER_ROW
        word_col = addr % WORDS_PER_ROW
        start_x = word_col * 16

        for bit in range(16):
            pixel_x = start_x + (15 - bit)
            if (word_value >> bit) & 1:
                screen_surface.set_at((pixel_x, row), (255, 255, 255)) 

    # Save the frame snapshot directly to your shared project workspace folder
    pygame.image.save(screen_surface, "simulation_output.png")
    print("--> Success! Captured memory state and saved to 'simulation_output.png'")

@cocotb.test()
async def test_screen(dut):
    """Read-only image verification test."""
    cocotb.start_soon(Clock(dut.clock, 10, unit="ns").start())

    # Set inputs to safe defaults
    dut.load.value = 0
    dut.in_.value = 0 
    dut.address.value = 0
    
    # Let memory load settle for a couple cycles
    for _ in range(5):
        await RisingEdge(dut.clock)
        
    dut._log.info("Processing Verilog memory array...")
    export_screen_snapshot(dut)
    dut._log.info("Simulation complete.")