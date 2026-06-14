`timescale 1ns / 1ns
`include "p02/modules/alu.v"

module ALU_tb ;

    reg zx , zy , nx , ny , f , no ;
    reg [15:0] x ,y ;
    wire [15:0] out ;
    wire zr, ng ;


    ALU inst(
        .x(x),
        .y(y),
        .zx(zx) , .zy(zy) , .ny(ny) , .nx(nx) , .f(f) , .no(no),
        .out(out),
        .zr(zr),
        .ng(ng)
    ) ;

    initial begin
        $dumpfile("p02/outputs/alu_tb.vcd");
        $dumpvars(0 , ALU_tb);
        
        // Setting x and y
        x = 16'b0000000000000000;  // x = 0
        y = 16'b1111111111111111;  // y = -1
        
        $display("Starting ALU Verification with x=%d (%b), y=%d (%b)\n", $signed(x), x, $signed(y), y);

        // Test 1 : compute 0
        zx = 1; nx = 0; zy = 1; ny = 0; f = 1; no = 0;
        #10;
        $display("Compute  0  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 2 : compute -1
        zx = 1; nx = 1; zy = 1; ny = 0; f = 1; no = 0;
        #10;
        $display("Compute -1  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 3 : compute x
        zx = 0; nx = 0; zy = 1; ny = 1; f = 0; no = 0;
        #10;
        $display("Compute x  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 4 : compute y
        zx = 1; nx = 1; zy = 0; ny = 0; f = 0; no = 0;
        #10;
        $display("Compute y  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 5 : compute 1
        zx = 1; nx = 1; zy = 1; ny = 1; f = 1; no = 1;
        #10;
        $display("Compute 1  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 6 : compute !x
        zx = 0; nx = 1; zy = 1; ny = 1; f = 0; no = 1;
        #10;
        $display("Compute !x  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 7 : compute !y
        zx = 1; nx = 1; zy = 0; ny = 1; f = 0; no = 1;
        #10;
        $display("Compute !y  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 8 : compute -x
        zx = 0; nx = 1; zy = 1; ny = 1; f = 1; no = 1;
        #10;
        $display("Compute -x  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 9 : compute -y
        zx = 1; nx = 1; zy = 0; ny = 1; f = 1; no = 1;
        #10;
        $display("Compute -y  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 10 : compute x+1
        zx = 0; nx = 0; zy = 1; ny = 1; f = 1; no = 1;
        #10;
        $display("Compute x+1 => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 11 : compute y+1
        zx = 1; nx = 1; zy = 0; ny = 0; f = 1; no = 1;
        #10;
        $display("Compute y+1 => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 12 : compute x-1
        zx = 0; nx = 0; zy = 1; ny = 1; f = 1; no = 0;
        #10;
        $display("Compute x-1 => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 13 : compute y-1
        zx = 1; nx = 1; zy = 0; ny = 0; f = 1; no = 0;
        #10;
        $display("Compute y-1 => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 14 : compute x+y
        zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0;
        #10;
        $display("Compute x+y => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 15 : compute x-y
        zx = 0; nx = 0; zy = 0; ny = 1; f = 1; no = 0;
        #10;
        $display("Compute x-y => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 16 : compute y-x
        zx = 0; nx = 1; zy = 0; ny = 0; f = 1; no = 0;
        #10;
        $display("Compute y-x => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 17 : compute x&y
        zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0;
        #10;
        $display("Compute x&y => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Test 18 : compute x|y
        zx = 0; nx = 1; zy = 0; ny = 1; f = 0; no = 1;
        #10;
        $display("Compute x|y => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);
        
        // Set initial values: x = 17, y = 3
        x = 16'b0000000000010001;  // Decimal 17
        y = 16'b0000000000000011;  // Decimal 3
        
        $display("Starting ALU Verification with x=%d (%b), y=%d (%b)\n", $signed(x), x, $signed(y), y);

        // Compute 0
        zx = 1; nx = 0; zy = 1; ny = 0; f = 1; no = 0;
        #10;
        $display("Compute  0  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute 1
        zx = 1; nx = 1; zy = 1; ny = 1; f = 1; no = 1;
        #10;
        $display("Compute  1  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute -1
        zx = 1; nx = 1; zy = 1; ny = 0; f = 1; no = 0;
        #10;
        $display("Compute -1  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute x
        zx = 0; nx = 0; zy = 1; ny = 1; f = 0; no = 0;
        #10;
        $display("Compute  x  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute y
        zx = 1; nx = 1; zy = 0; ny = 0; f = 0; no = 0;
        #10;
        $display("Compute  y  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute !x
        zx = 0; nx = 0; zy = 1; ny = 1; f = 0; no = 1;
        #10;
        $display("Compute !x  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute !y
        zx = 1; nx = 1; zy = 0; ny = 0; f = 0; no = 1;
        #10;
        $display("Compute !y  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute -x
        zx = 0; nx = 0; zy = 1; ny = 1; f = 1; no = 1;
        #10;
        $display("Compute -x  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute -y
        zx = 1; nx = 1; zy = 0; ny = 0; f = 1; no = 1;
        #10;
        $display("Compute -y  => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute x + 1
        zx = 0; nx = 1; zy = 1; ny = 1; f = 1; no = 1;
        #10;
        $display("Compute x+1 => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute y + 1
        zx = 1; nx = 1; zy = 0; ny = 1; f = 1; no = 1;
        #10;
        $display("Compute y+1 => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute x - 1
        zx = 0; nx = 0; zy = 1; ny = 1; f = 1; no = 0;
        #10;
        $display("Compute x-1 => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute y - 1
        zx = 1; nx = 1; zy = 0; ny = 0; f = 1; no = 0;
        #10;
        $display("Compute y-1 => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute x + y
        zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0;
        #10;
        $display("Compute x+y => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute x - y
        zx = 0; nx = 1; zy = 0; ny = 0; f = 1; no = 1;
        #10;
        $display("Compute x-y => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute y - x
        zx = 0; nx = 0; zy = 0; ny = 1; f = 1; no = 1;
        #10;
        $display("Compute y-x => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute x & y
        zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0;
        #10;
        $display("Compute x&y => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        // Compute x | y
        zx = 0; nx = 1; zy = 0; ny = 1; f = 0; no = 1;
        #10;
        $display("Compute x|y => out=%d (%b), zr=%b, ng=%b", $signed(out), out, zr, ng);

        $display("All tests completed");
        $finish;
    end
endmodule