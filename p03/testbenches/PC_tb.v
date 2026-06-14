`timescale 1ns/1ns
`include "p03/modules/PC.v"

module PC_tb;

    localparam WIDTH = 16; // Define the width of the PC
    reg clk;
    reg rst;
    reg inc;
    reg load;
    reg [WIDTH-1:0] in;
    wire [WIDTH-1:0] out;

    localparam CLK_PERIOD = 10; // Clock period in nanoseconds
    always #(CLK_PERIOD/2) clk = ~clk; // Toggle clock every CLK_PERIOD/2 ns

    PC #(
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .inc(inc),
        .load(load),
        .in(in),
        .out(out)
    );

    task drive(input [WIDTH-1:0] input_value, input inc_signal, input load_signal, input rst_signal);
    begin
        in = input_value;
        inc = inc_signal;
        load = load_signal;
        rst = rst_signal;
        @(posedge clk);
        #1; // Small delay to observe the output after the clock edge
        $display("At time %t, rst = %h, inc = %h, load = %h, in = %h, out = %h ", $time, rst , inc , load , in , out);
    end
    endtask

    initial begin
        $dumpfile("p03/outputs/PC_tb.vcd");
        $dumpvars(0, PC_tb);

        // Initialize signals
        clk = 0;
        rst = 0;
        inc = 0;
        load = 0;
        in = 0;
        
        #1;
        // Apply reset
        $display("Applying reset...");
        drive(0, 0, 0, 1); // Reset the PC
        

        // Release reset and increment PC
        $display("Releasing reset and incrementing PC...");
        drive(0, 1, 0, 0); // Increment the PC
        

        // Load a specific value into the PC
        $display("Loading value into PC...");
        drive(16'h1234, 0, 1, 0); // Load the value 0x1234 into the PC
        

        // Increment the PC again
        $display("Incrementing PC again...");
        drive(0, 1, 0, 0); // Increment the PC

        //Testing reset and load prirority
        $display("Testing reset and load priority...");
        drive(16'h5678, 0, 1, 1); // Apply reset and load simultaneously

        //Testing load and increment priority
        $display("Testing load and increment priority...");
        drive(16'h9ABC, 1, 1, 0); // Apply load and increment simultaneously

        //Testing reset and increment priority
        $display("Testing reset and increment priority...");
        drive(0, 1, 0, 1); // Apply reset and increment simultaneously
        
        #10;
        $finish; // End simulation  
    end
endmodule