`timescale 1ns/1ns
`include "p03/modules/RAM.v"

module RAM_tb ; 
    
    localparam TB_DATAWIDTH = 16 ;
    localparam TB_ADDRWIDTH = 3 ;
    localparam TB_RAMDEPTH = 2 ** TB_ADDRWIDTH;

    
    reg [TB_DATAWIDTH-1:0] din ;
    reg [TB_ADDRWIDTH-1:0] addr ; // taking sample of 8 registers
    reg load , clk ;
    wire [TB_DATAWIDTH-1:0] dout;

    localparam CLK_PERIOD = 10 ;
    always #(CLK_PERIOD/2) clk = ~clk ;

    integer i;

    RAM  #(
        .DATA_WIDTH(TB_DATAWIDTH),
        .ADDR_WIDTH(TB_ADDRWIDTH)
    ) uut (
        .clk(clk),
        .din(din),
        .dout(dout),
        .addr(addr),
        .load(load)
    );

    task data_flow(input [TB_DATAWIDTH-1:0] in , input [TB_ADDRWIDTH-1:0] address , input ld);
    begin
        @(posedge clk);
        #1;
        load = ld;
        addr = address;
        din = in ;
        @(posedge clk);
        #1;
        $strobe("At time %t, load = %h, address = %h, in = %h, out = %h ", $time, load , addr, din , dout);    
    end
    endtask
    
    
    initial begin
        $dumpfile("p03/outputs/RAM_tb.vcd");
        $dumpvars(0, RAM_tb);

        clk = 0 ;
        load = 0 ;
        din = 0 ;
    
        // Write to addresses 0 to 7
        $display("Writing to RAM...");
        for (i = 0; i<TB_RAMDEPTH ; i++ ) begin : assign_loop
            data_flow(i ,i , 1);
        end
        #10;

        //Read 0 , 3 , 7 
        $display("Reading from RAM...");
        data_flow(16'h0000, 0, 0); // Read from address 0
        data_flow(16'h0000, 3, 0); // Read from address 3
        data_flow(16'h0000, 7, 0); // Read from address 7
        #10;

        $display("Test completed.");
        $finish;

    end
endmodule