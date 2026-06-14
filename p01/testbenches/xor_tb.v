`timescale 1ns / 1ns
`include "modules/xor.v"

module Xor_gate_tb;
    reg a, b;
    wire out;

    Xor_gate uut (
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin
        
        $dumpfile("outputs/xor_tb.vcd");
        $dumpvars(0, Xor_gate_tb);

        // Test case 1: a = 0, b = 0
        a = 0; b = 0; #10;
        $display("Test case 1: a=0, b=0, out=%b", out);

        // Test case 2: a = 0, b = 1
        a = 0; b = 1; #10;
        $display("Test case 2: a=0, b=1, out=%b", out);

        // Test case 3: a = 1, b = 0
        a = 1; b = 0; #10;
        $display("Test case 3: a=1, b=0, out=%b", out);

        // Test case 4: a = 1, b = 1
        a = 1; b = 1; #10;
        $display("Test case 4: a=1, b=1, out=%b", out);

        $display("All test cases completed.");

        $finish;

    end

endmodule