`timescale 1ns/1ns
`include "p02/modules/add16.v"

module Add16_tb ; 
    reg [15:0] a , b ;
    wire [15:0] out ;

    Add16 uut(
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin 

        $dumpfile("p02/outputs/add16_tb.vcd");
        $dumpvars(0 , Add16_tb);

        // Test case 1
        a = 16'b0000000000000000 ;
        b = 16'b0000000000000000 ;
        #10 ;
        $display("Test case 1: a=%b, b=%b => out=%b", a, b, out);

        // Test case 2
        a = 16'b0000000000000001 ;
        b = 16'b0000000000000001 ;
        #10 ;
        $display("Test case 2: a=%b, b=%b => out=%b", a, b, out);

        // Test case 3
        a = 16'b0000000000000010 ;
        b = 16'b0000000000000010 ;
        #10 ;
        $display("Test case 3: a=%b, b=%b => out=%b", a, b, out);

        // Test case 4
        a = 16'b1111111111111111 ;
        b = 16'b0000000000000001 ;
        #10 ;
        $display("Test case 4: a=%b, b=%b => out=%b", a, b, out);
        
        // Test case 5
        a = 16'b1010101010101010 ;
        b = 16'b0101010101010101 ;
        #10 ;
        $display("Test case 5: a=%b, b=%b => out=%b", a, b, out);
        
        $display("All test cases completed.");
        $finish ;
    end
endmodule