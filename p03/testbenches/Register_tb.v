`timescale 1ns / 1ns 
`include "p03/modules/Register.v"

module Register_tb ;
    
    reg [15:0] in ;
    reg load ; 
    reg clk ;
    reg rst ; 
    wire [15:0] out;

    localparam CLK_PERIOD =10 ;
    always #(CLK_PERIOD/2) clk = ~clk ;

    Register uut(
        .in(in),
        .load(load),
        .clk(clk),
        .rst(rst),
        .q(out)
    );
    
    //Watch the output on every clock edge
    always @(posedge clk) begin
        if (!rst) begin
            $strobe("At time %t, load = %h, in = %h, out = %h ", $time, load , in , out);
        end
    end

    task reset_dut ; //reset the design under test
    begin
        rst = 1; in = 16'h0000 ; load = 0;
        @(posedge clk);
        #1 ;
    end
    endtask

    task drive_input(input  [15:0] data , input  load_sig) ; //drive input to the design under test
    begin
        @(posedge clk);
        #1;
        in = data ;
        load = load_sig; // Enable loading of new data
    end
    endtask

    initial begin
        $dumpfile("p03/outputs/Register_tb.vcd");
        $dumpvars(0, Register_tb);

        clk = 0; // Initialize clock
        load = 0; // Initially, loading is disabled
        rst = 0; // Initially, reset is deasserted

        $display("Applying reset...");
        reset_dut(); // Apply reset to initialize the register

        $display("Releasing reset and applying inputs...");
        rst = 0;

        //  Run  Intended Stimulus Sequence
        $display("--- Starting Intended Test Sequence ---");

        // 1. Load 0x0001 (Should succeed)
        drive_input(16'h0001, 1); 

        // 2. Attempt to load 0x00FF with load=0 (Should be ignored!)
        drive_input(16'h00FF, 0); 

        // 3. Load 0x1234 (Should succeed)
        drive_input(16'h1234, 1);

        repeat(2) @( posedge clk);
        #1;

        $display("Test trigerring mid-run reset ...");
        rst = 1; // Trigger reset in the middle of the test
        #1;
        $display("At time %t, in = %h, out = %h ", $time, in , out);

        $display("Test completed.");
        $finish;
    end

endmodule