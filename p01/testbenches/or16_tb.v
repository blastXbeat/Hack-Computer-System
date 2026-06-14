`timescale 1ns / 1ns
`include "modules/or16.v"

module Or16_tb;

    reg [15:0] a, b;
    wire [15:0] out;

    Or16 uut (
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin
        $dumpfile("outputs/or16_tb.vcd");
        $dumpvars(0, Or16_tb);

        //Test case 1: a = 0000000000000000 , b = 1111111111111111
        a = 16'b0000000000000000; b = 16'b1111111111111111;
        #10
        $display("Test case 1: a = %b, b = %b, out = %b",a ,b ,out);

        //Test case 2: a = 1010101010101010 , b = 0101010101010101
        a = 16'b1010101010101010; b = 16'b0101010101010101;
        #10 
        $display("Test case 2: a = %b, b = %b, out = %b",a ,b ,out);

        //Test case 3: a = 1111111111111111 , b = 0000000000000000
        a = 16'b1111111111111111; b = 16'b0000000000000000;
        #10
        $display("Test case 3: a = %b, b = %b, out = %b",a ,b ,out);

        //Test case 4: a = 1111111111111111 , b = 1111111111111111
        a = 16'b1111111111111111; b = 16'b1111111111111111;
        #10
        $display("Test case 4: a = %b, b = %b, out = %b",a ,b ,out);

        //Test case 5: a = 0000000000000000 , b = 0000000000000000
        a = 16'b0000000000000000; b = 16'b0000000000000000;
        #10
        $display("Test case 5: a = %b, b = %b, out = %b",a ,b ,out);

        $display("Test completed");
        $finish;

    end
endmodule