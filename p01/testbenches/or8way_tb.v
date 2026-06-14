`timescale 1ns / 1ns
`include "modules/or8way.v"

module Or8Way_tb;

    reg [7:0] a;
    wire out;

    Or8Way or8way_inst (
        .in(a),
        .out(out)
    );

    initial begin

        $dumpfile("outputs/or8way_tb.vcd");
        $dumpvars(0, Or8Way_tb);

        // Test case 1: All inputs are 0
        a = 8'b00000000;
        #10;
        $display("Test case 1: a = %b, out = %b", a, out);

        // Test case 2: One input is 1
        a = 8'b00000001;
        #10;
        $display("Test case 2: a = %b, out = %b", a, out);

        // Test case 3: Multiple inputs are 1
        a = 8'b00001100;
        #10;
        $display("Test case 3: a = %b, out = %b", a, out);

        // Test case 4: All inputs are 1
        a = 8'b11111111;
        #10;
        $display("Test case 4: a = %b, out = %b", a, out);
        
        $display("All test cases completed.");
        $finish;
    end
endmodule