`timescale 1ns / 1ns
`include "modules/mux16.v"

module Mux16_tb ;

    reg [15:0] a, b ;
    reg sel ;
    wire [15:0] out ;

    Mux16 mux16 (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin

        $dumpfile("outputs/mux16_tb.vcd") ;
        $dumpvars(0, Mux16_tb) ;

        // Test case 1: sel = 0, out should be equal to a
        a = 16'h1234 ;
        b = 16'h5678 ;
        sel = 0 ;
        #10 ;
        $display("Test case 1: sel=0, out=%h (expected %h)", out, a) ;

        // Test case 2: sel = 1, out should be equal to b
        sel = 1 ;
        #10 ;
        $display("Test case 2: sel=1, out=%h (expected %h)", out, b) ;

        // Test case 3: Change inputs and test again
        a = 16'hABCD ;
        b = 16'hEF01 ;
        sel = 0 ;
        #10 ;
        $display("Test case 3: sel=0, out=%h (expected %h)", out, a) ;

        sel = 1 ;
        #10 ;
        $display("Test case 4: sel=1, out=%h (expected %h)", out, b) ;
        
        $display("Test completed") ;
        $finish ;
    end
endmodule