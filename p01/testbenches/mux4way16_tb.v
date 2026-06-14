`timescale 1ns/1ns
`include "modules/mux4way16.v"

module Mux4Way16_tb ;

    reg [15:0] a, b, c, d;
    reg [1:0] sel;
    wire [15:0] out;

    Mux4Way16 uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .out(out)
    );


    initial begin 

        $dumpfile("outputs/mux4way16_tb.vcd");
        $dumpvars(0, Mux4Way16_tb);

        a = 16'hAAAA; // 1010101010101010
        b = 16'h5555; // 0101010101010101
        c = 16'hFFFF; // 1111111111111111
        d = 16'h0000; // 0000000000000000

        // Test case 1: sel = 00, out should be a
        sel = 2'b00;
        #10; // Wait for 10 time units
        $display("Test case 1: sel = %b, out = %h (expected %h)", sel, out, a);

        // Test case 2: sel = 01, out should be b
        sel = 2'b01;
        #10; // Wait for 10 time units
        $display("Test case 2: sel = %b, out = %h (expected %h)", sel, out, b);

        // Test case 3: sel = 10, out should be c
        sel = 2'b10;
        #10; // Wait for 10 time units
        $display("Test case 3: sel = %b, out = %h (expected %h)", sel, out, c);

        // Test case 4: sel = 11, out should be d
        sel = 2'b11;
        #10; // Wait for 10 time units
        $display("Test case 4: sel = %b, out = %h (expected %h)", sel, out, d);

        $display("All test cases completed.");
        $finish; // End the simulation

    end


endmodule