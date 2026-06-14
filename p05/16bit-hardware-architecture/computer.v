module Computer(
    input wire clk,
    input wire rst
);
    wire [15:0] pc;
    wire [15:0] instruction;
    wire [15:0] outM;
    wire [15:0] addressM;
    wire [15:0] inM;
    wire writeM;

    ROM32K rom (
        .address(pc),
        .out(instruction)
    );

    Memory memory (
        .clock(clk),
        .address(addressM),
        .in_(outM),
        .load(writeM),
        .out(inM)
    );

    CPU cpu (
        .clock(clk),
        .reset(rst),
        .instruction(instruction),
        .outM(outM),
        .addressM(addressM),
        .inM(inM),
        .writeM(writeM),
        .pc(pc)
    );
endmodule