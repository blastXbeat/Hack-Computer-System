module Keyboard (
    input             clock,
    input      [15:0] kbd_in,   // 16-bit raw bus input from physical keyboard/testbench
    output reg [15:0] kbd_out   // Captured ASCII value read by the CPU memory bus
);

    // Synchronously latch the keyboard input data on every clock cycle
    always @(posedge clock) begin
        kbd_out <= kbd_in;
    ends

endmodule