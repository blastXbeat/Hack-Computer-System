`timescale 1ns / 1ns
`include "modules/and.v"

module And_tb;
    reg a, b;
    wire out;

    And_gate uut (
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin

        $dumpfile("outputs/and_tb.vcd");
        $dumpvars(0, And_tb);

        // Test case 1: a = 0, b = 0
        a = 0; b = 0; #10;
        $display("Test case 1: a=%b, b=%b, out=%b", a, b, out);

        // Test case 2: a = 0, b = 1
        a = 0; b = 1; #10;
        $display("Test case 2: a=%b, b=%b, out=%b", a, b, out);

        // Test case 3: a = 1, b = 0
        a = 1; b = 0; #10;
        $display("Test case 3: a=%b, b=%b, out=%b", a, b, out);

        // Test case 4: a = 1, b = 1
        a = 1; b = 1; #10;
        $display("Test case 4: a=%b, b=%b, out=%b", a, b, out);

        $display("All test cases completed.");

        $finish;
    end
endmodule