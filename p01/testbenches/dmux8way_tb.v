`timescale 1ns / 1ns
`include "modules/dmux8way.v"

module DMux8Way_tb ;

    reg in;
    reg [2:0] sel;
    wire a, b, c, d, e, f, g, h;

    DMux8Way uut (
        .in(in),
        .sel(sel),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .h(h)  
    ); 

    initial begin
        $dumpfile("outputs/dmux8way_tb.vcd");
        $dumpvars(0, DMux8Way_tb);

        in = 1'b1;

        // Test case 1: sel = 000
        sel = 3'b000;
        #10; // Wait for 10 time units
        $display("Test case 1: sel = %b: a=%b, b=%b, c=%b, d=%b, e=%b, f=%b, g=%b, h=%b", sel, a, b, c, d, e, f, g, h);

        // Test case 2: sel = 001
        sel = 3'b001;
        #10; // Wait for 10 time units
        $display("Test case 2: sel = %b: a=%b, b=%b, c=%b, d=%b, e=%b, f=%b, g=%b, h=%b", sel, a, b, c, d, e, f, g, h);

        // Test case 3: sel = 010
        sel = 3'b010;
        #10; // Wait for 10 time units
        $display("Test case 3: sel = %b: a=%b, b=%b, c=%b, d=%b, e=%b, f=%b, g=%b, h=%b", sel, a, b, c, d, e, f, g, h);

        // Test case 4: sel = 011
        sel = 3'b011;
        #10; // Wait for 10 time units
        $display("Test case 4: sel = %b: a=%b, b=%b, c=%b, d=%b, e=%b, f=%b, g=%b, h=%b", sel, a, b, c, d, e, f, g, h);

        // Test case 5: sel = 100
        sel = 3'b100;
        #10; // Wait for 10 time units
        $display("Test case 5: sel = %b: a=%b, b=%b, c=%b, d=%b, e=%b, f=%b, g=%b, h=%b", sel, a, b, c, d, e, f, g, h);

        // Test case 6: sel = 101
        sel = 3'b101;
        #10; // Wait for 10 time units
        $display("Test case 6: sel = %b: a=%b, b=%b, c=%b, d=%b, e=%b, f=%b, g=%b, h=%b", sel, a, b, c, d, e, f, g, h);

        // Test case 7: sel = 110
        sel = 3'b110;   
        #10; // Wait for 10 time units
        $display("Test case 7: sel = %b: a=%b, b=%b, c=%b, d=%b, e=%b, f=%b, g=%b, h=%b", sel, a, b, c, d, e, f, g, h);
        
        // Test case 8: sel = 111
        sel = 3'b111;
        #10; // Wait for 10 time units
        $display("Test case 8: sel = %b: a=%b, b=%b, c=%b, d=%b, e=%b, f=%b, g=%b, h=%b", sel, a, b, c, d, e, f, g, h);

        $display("All test cases completed.");
        $finish;
    end

endmodule