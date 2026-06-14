`timescale 1ns/1ns
`include "modules/dmux4way.v"

module DMux4Way_tb ;

    reg in ;
    reg [1:0] sel ;
    wire a,b,c,d ;

    DMux4Way uut (
        .in(in),
        .sel(sel),
        .a(a),
        .b(b),
        .c(c),
        .d(d)
    );

    initial begin

        $dumpfile("outputs/dmux4way_tb.vcd");
        $dumpvars(0, DMux4Way_tb);
        
        in = 1'b1;

        // Test case 1: sel = 00
        sel = 2'b00;
        #10; // Wait for 10 time units
        $display("Test case 1: sel = 00, a=%b, b=%b, c=%b, d=%b", a, b, c, d);

        // Test case 2: sel = 01
        sel = 2'b01;
        #10; // Wait for 10 time units
        $display("Test case 2: sel = 01, a=%b, b=%b, c=%b, d=%b", a, b, c, d);

        // Test case 3: sel = 10
        sel = 2'b10;
        #10; // Wait for 10 time units
        $display("Test case 3: sel = 10, a=%b, b=%b, c=%b, d=%b", a, b, c, d);

        // Test case 4: sel = 11
        sel = 2'b11;
        #10; // Wait for 10 time units
        $display("Test case 4: sel = 11, a=%b, b=%b, c=%b, d=%b", a, b, c, d);

        $display("All test cases completed.");
        $finish; // End the simulation
    end 
        

endmodule