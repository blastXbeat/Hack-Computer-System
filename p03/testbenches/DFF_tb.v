`timescale 1ns / 1ns
`include "p03/modules/DFF.v"

module DFF_tb ;

    reg clk , rst;
    reg [15:0] d ;
    wire [15:0] q ;

    DFF uut(
        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)
    );

    // Designing the clock
    localparam CLK_PERIOD = 10;
    always #(CLK_PERIOD/2) clk = ~clk ;

    always @(posedge clk) begin
        if (!rst) begin
            $strobe("At time %t,d = %h, q = %h ", $time, d , q);
        end
    end
    
    task reset_dut ;
    begin
        rst = 1; d = 16'h0000;
        @(posedge clk);
        #1;
    end
    endtask

    task apply_input(input [15:0] data); 
    begin
        @(posedge clk);
        #1;
        d=data;
    end
    endtask




    initial begin
        $dumpfile("p03/outputs/DFF_tb.vcd");
        $dumpvars(0, DFF_tb);

        clk = 0;

        $display("Applying reset...");
        reset_dut();

        $display("Releasing reset and applying inputs...");
        rst = 0;

        apply_input(16'h0001); // Apply 0x0001
        apply_input(16'h00FF); // Apply 0x00FF
        apply_input(16'h1234); // Apply 0x1234

        @( posedge clk);
        #1;

        $display("Test trigerring mid-run reset ...");
        rst = 1; // Trigger reset in the middle of the test
        @( posedge clk);
        $display("At time %t,d = %h, q = %h ", $time, d , q);

        $display("Test completed.");
        $finish;


    end
endmodule