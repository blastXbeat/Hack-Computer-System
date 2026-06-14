`timescale 1ns/1ns
`include "p02/modules/inc16.v"

module Inc16_tb ;
    reg [15:0] in ;
    wire [15:0] out;


    Inc16 uut (
        .in(in),
        .out(out)
    );


    initial begin

        $dumpfile("p02/outputs/inc16_tb.vcd");
        $dumpvars(0,Inc16_tb);

        //Test case 1: in = 0000000000000000
        in = 16'b0000000000000000 ;
        #10 ;
        $display("Test case 1: in=%b => out=%b", in, out);

        //Test case 2: in = 0000000000000001
        in = 16'b0000000000000001 ;
        #10 ;
        $display("Test case 2: in=%b => out=%b", in, out);

        //Test case 3: in = 1111111111111111
        in = 16'b1111111111111111 ;
        #10 ;
        $display("Test case 3: in=%b => out=%b", in, out);

        //Test case 4: in = 1010101010101010
        in = 16'b1010101010101010 ;
        #10 ;
        $display("Test case 4: in=%b => out=%b", in, out);

        $display("All test cases completed.");
        $finish ;

    end
endmodule
