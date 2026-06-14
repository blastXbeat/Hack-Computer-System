`timescale 1ns/1ns
`include "p02/modules/halfadder.v"

module Halfadder_tb;

    reg a , b;
    wire sum , carry;

    HalfAdder uut(
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin

        $dumpfile("p02/outputs/halfadder_tb.vcd");
        $dumpvars(0,Halfadder_tb);

        // Test case 1: a=0 , b=0
        a = 1'b0; b = 1'b0;
        #10
        $display("Test case 1 :a = %b , b = %b, sum = %b , carry = %b",a,b,sum ,carry);

        // Test case 2: a=0 , b=1
        a = 1'b0; b = 1'b1;
        #10
        $display("Test case 2 :a = %b , b = %b, sum = %b , carry = %b",a,b,sum ,carry);

        // Test case 3: a=1 , b=0
        a = 1'b1; b = 1'b0;
        #10
        $display("Test case 3 :a = %b , b = %b, sum = %b , carry = %b",a,b,sum ,carry);

        // Test case 4: a=1 , b=1
        a = 1'b1; b = 1'b1;
        #10
        $display("Test case 4 :a = %b , b = %b, sum = %b , carry = %b",a,b,sum ,carry);

        $display("Test completed");
        $finish;

    end
endmodule
