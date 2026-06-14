`timescale 1ns / 1ns
`include "modules/mux.v"

module Mux_tb ;

    reg sel , i0 , i1;
    wire out;
    
    Mux uut(
        .i0(i0),
        .i1(i1),
        .sel(sel),
        .out(out)
    );

    initial begin

        $dumpfile("outputs/mux_tb.vcd");
        $dumpvars(0, Mux_tb);

        // Test case 1: sel = 0, i0 = 0, i1 = 0
        sel = 0; i0 = 0; i1 = 0;
        #10;
        $display("Test case 1: sel = %b, i0 = %b, i1 = %b, out = %b", sel, i0, i1, out);

        sel = 0; i0 = 0; i1 = 1;
        #10;
        $display("Test case 2: sel = %b, i0 = %b, i1 = %b, out = %b",sel, i0 , i1, out);

        sel = 0; i0 = 1; i1 = 0;
        #10;
        $display("Test case 3: sel = %b, i0 = %b, i1 = %b, out = %b",sel, i0 , i1, out);

        sel = 0; i0 = 1; i1 = 1;
        #10;
        $display("Test case 4: sel = %b, i0 = %b, i1 = %b, out = %b",sel, i0 , i1, out);

        sel = 1; i0 = 0; i1 = 0;
        #10;
        $display("Test case 5: sel = %b, i0 = %b, i1 = %b, out = %b",sel, i0 , i1, out);

        sel = 1; i0 = 0; i1 = 1;
        #10;
        $display("Test case 6: sel = %b, i0 = %b, i1 = %b, out = %b",sel, i0 , i1, out);

        sel = 1; i0 = 1; i1 = 0;
        #10;
        $display("Test case 7: sel = %b, i0 = %b, i1 = %b, out = %b",sel, i0 , i1, out);

        sel = 1; i0 = 1; i1 = 1;
        #10;
        $display("Test case 8: sel = %b, i0 = %b, i1 = %b, out = %b",sel, i0 , i1, out);

        $display("All test cases completed.");

        $finish;
    end
    
endmodule