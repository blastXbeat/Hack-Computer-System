`timescale 1ns/1ns
`include "p02/modules/fulladder.v"

module FullAdder_tb ;
    
    reg a,b,c;
    wire sum,carry;

    FullAdder uut(
        .a(a),
        .b(b),
        .c(c),
        .sum(sum),
        .carry(carry)
    );

    initial begin 
        $dumpfile("p02/outputs/fulladder.vcd");
        $dumpvars(0,FullAdder_tb);

        //Test case 1 : a=0, b=0, c=0
        a=0; b=0; c=0;
        #10; // Wait for 10 time units
        $display("Test case 1: a=%b, b=%b, c=%b => sum=%b, carry=%b", a, b, c, sum, carry);

        //Test case 2 : a=0, b=0, c=1
        a=0; b=0; c=1;
        #10; // Wait for 10 time units
        $display("Test case 2: a=%b, b=%b, c=%b => sum=%b, carry=%b", a, b, c, sum, carry);

        //Test case 3 : a=0, b=1, c=0
        a=0; b=1; c=0;
        #10; // Wait for 10 time units
        $display("Test case 3: a=%b, b=%b, c=%b => sum=%b, carry=%b", a, b, c, sum, carry);
        
        //Test case 4 : a=0, b=1, c=1
        a=0; b=1; c=1;
        #10; // Wait for 10 time units
        $display("Test case 4: a=%b, b=%b, c=%b => sum=%b, carry=%b", a, b, c, sum, carry);
        
        //Test case 5 : a=1, b=0, c=0
        a=1; b=0; c=0;
        #10; // Wait for 10 time units
        $display("Test case 5: a=%b, b=%b, c=%b => sum=%b, carry=%b", a, b, c, sum, carry);

        //Test case 6 : a=1, b=0, c=1
        a=1; b=0; c=1;
        #10; // Wait for 10 time units
        $display("Test case 6: a=%b, b=%b, c=%b => sum=%b, carry=%b", a, b, c, sum, carry);

        //Test case 7 : a=1, b=1, c=0
        a=1; b=1; c=0;
        #10; // Wait for 10 time units
        $display("Test case 7: a=%b, b=%b, c=%b => sum=%b, carry=%b", a, b, c, sum, carry);

        //Test case 8 : a=1, b=1, c=1
        a=1; b=1; c=1;
        #10; // Wait for 10 time units
        $display("Test case 8: a=%b, b=%b, c=%b => sum=%b, carry=%b", a, b, c, sum, carry);

        $display("Test completed.");
        $finish; // End the simulation

    end
endmodule