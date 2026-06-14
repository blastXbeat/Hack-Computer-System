`include "./submodules/RAM.v"
`include "./submodules/Register.v"

module Memory (
    input [15:0] in_,
    input [14:0] address,
    input load, clock,
    output reg [15:0] out
);
    wire ramload, scrload , regload;
    assign ramload = ~address[14] & load;
    wire [15:0] ramout , scrout , regout;
    
    RAM #(
        .ADDR_WIDTH(14)
    ) ram32k_inst(
        .clk(clock),
        .load(ramload),
        .addr(address[13:0]),
        .din(in_),
        .dout(ramout)
    );

    assign scrload =  load & address[14] & ~address[13]; 

    RAM #(
        .ADDR_WIDTH(13)
    ) scratchpad_inst(
        .clk(clock),
        .load(scrload),
        .addr(address[12:0]),
        .din(in_),
        .dout(scrout)
    );

    assign regload = load & address[14] & address[13];

    Register reg_inst(
        .clk(clock),
        .rst(1'b0), // No reset functionality needed for this register in the current design
        .load(regload),
        .in(in_),
        .q(regout)
    );

    always @(*) begin
        case (address[14:13])
            2'b00,
            2'b01: out <= ramout; // RAM output is directly assigned to out
            2'b10: out <= scrout; // scratchpad output is directly assigned to out
            2'b11: out <= regout; // register output is directly assigned to out
            default: out <= 16'b0; // default case
        endcase
    end 

endmodule