`timescale 1ns/1ns
`include "modules/mux8way16.v"

module Mux8way16_tb;

    reg [15:0] a, b, c, d, e, f, g, h;
    reg [2:0] sel;
    wire [15:0] out;

    Mux8Way16 uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .h(h),
        .sel(sel),
        .out(out)
    );

    initial begin
        $dumpfile("outputs/mux8way16_tb.vcd");
        $dumpvars(0, Mux8way16_tb);

        // Test case 1: sel = 000, out should be a
        a = 16'hAAAA; b = 16'hBBBB; c = 16'hCCCC; d = 16'hDDDD;
        e = 16'hEEEE; f = 16'hFFFF; g = 16'h1111; h = 16'h2222;
        sel = 3'b000; #10;
        $display("Test case 1: sel = %b, out = %h (expected %h)", sel, out, a);

        // Test case 2: sel = 001, out should be b
        sel = 3'b001; #10;
        $display("Test case 2: sel = %b, out = %h (expected %h)", sel, out, b);

        // Test case 3: sel = 010, out should be c
        sel = 3'b010; #10;
        $display("Test case 3: sel = %b, out = %h (expected %h)", sel, out, c);

        // Test case 4: sel = 011, out should be d
        sel = 3'b011; #10;
        $display("Test case 4: sel = %b, out = %h (expected %h)", sel, out, d);

        // Test case 5: sel = 100, out should be e
        sel = 3'b100; #10;
        $display("Test case 5: sel = %b, out = %h (expected %h)", sel, out, e);

        // Test case 6: sel = 101, out should be f
        sel = 3'b101; #10;
        $display("Test case 6: sel = %b, out = %h (expected %h)", sel, out, f);

        // Test case 7: sel = 110, out should be g
        sel = 3'b110; #10;
        $display("Test case 7: sel = %b, out = %h (expected %h)", sel, out, g);

        // Test case 8: sel = 111, out should be h
        sel = 3'b111; #10;
        $display("Test case 8: sel = %b, out = %h (expected %h)", sel, out, h);
        
        $display("All test cases completed.");
        $finish;

        end
endmodule