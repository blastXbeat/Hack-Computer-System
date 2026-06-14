`timescale 1ns/1ns
`include "modules/dmux.v"

module DMux_tb;

    reg in ,sel;
    wire o0 , o1;

    DMux uut(
        .in(in),
        .sel(sel),
        .o0(o0),
        .o1(o1)
    );

    initial begin

        $dumpfile("outputs/dmux_tb.vcd");
        $dumpvars(0, DMux_tb);

        //Test case 1: sel = 0 , in = 0
        sel = 0; in = 0;
        #10
        $display("Test case 1: sel = %b, in = %b, o0 = %b, o1 = %b",sel ,in ,o0 , o1);

        //Test case 2: sel = 0 , in = 1
        sel = 0; in = 1;
        #10
        $display("Test case 2: sel = %b, in = %b, o0 = %b, o1 = %b",sel ,in ,o0 , o1);

        //Test case 3: sel = 1 , in = 0
        sel = 1; in = 0;
        #10
        $display("Test case 3: sel = %b, in = %b, o0 = %b, o1 = %b",sel ,in ,o0 , o1);

        //Test case 4: sel = 1 , in = 1
        sel = 1; in = 1;
        #10
        $display("Test case 4: sel = %b, in = %b, o0 = %b, o1 = %b",sel ,in ,o0 , o1);

        $display("Test completed");
        $finish;
        
    end


endmodule