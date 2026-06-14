`timescale 1ns / 1ns
`include "modules/not16.v"

module Not16_tb;

    reg [15:0] in;
    wire [15:0] out;

    Not16 uut (
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("outputs/not16_tb.vcd");
        $dumpvars(0, Not16_tb);

        //Test case 1: in = 00000000000000000000000000000000
        in = 16'b0000000000000000;
        #10
        $display("Test case 1: in = %b, out = %b",in ,out);

        //Test case 2: in = 1111111111111111
        in = 16'b1111111111111111;
        #10
        $display("Test case 2: in = %b, out = %b",in ,out);

        //Test case 3: in = 1010101010101010
        in = 16'b1010101010101010;
        #10
        $display("Test case 3: in = %b, out = %b",in ,out);

        //Test case 4: in = 0101010101010101
        in = 16'b0101010101010101;
        #10
        $display("Test case 4: in = %b, out = %b",in ,out);

        $display("Test completed");
        $finish;
    end
endmodule