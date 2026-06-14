module RAM #(
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 4
)(
    input clk, load ,
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] din,
    output [DATA_WIDTH-1:0] dout
);
    reg [DATA_WIDTH-1:0] ram [0:(2**ADDR_WIDTH)-1] ;

    always @(posedge clk ) begin
        if (load) begin
            ram[addr] <= din;
        end
    end

    assign dout = ram[addr] ;
   
endmodule