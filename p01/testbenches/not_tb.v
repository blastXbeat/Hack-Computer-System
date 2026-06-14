`timescale 1ns / 1ns
`include "modules/not.v"

module Not_tb;
    reg a;
    wire out;

    Not uut (
        .a(a),
        .out(out)
    );

    initial begin

        $dumpfile("outputs/not_tb.vcd");
        $dumpvars(0, Not_tb);

        // Test case 1: a = 0
        a = 0;
        #10; // Wait for 10 time units
        $display("Test case 1: a = %b, out = %b", a, out);

        // Test case 2: a = 1
        a = 1;
        #10; // Wait for 10 time units
        $display("Test case 2: a = %b, out = %b", a, out);

        $display("Test completed.");

        $finish; // End the simulation
    end
endmodule