module CPU (
   input [15:0] inM , 
   input [15:0] instruction,
   input reset,clock,
   output [15:0] outM,
   output writeM,
   output [15:0] addressM ,
   output [15:0] pc
);
    
    wire [15:0] aregin;
    wire [15:0] aluy;
    wire [15:0] alux;
    wire dload , aload ;
    wire zero , neg , pos;
    wire [2:0] comp ;
    wire jump , pcload;

    //Multiplexers ; Continous Data Flow Assignment
    assign aregin = instruction[15] ? outM:instruction;
    assign aluy = instruction[12] ? inM:addressM;

    //Control Routing Unit (aload, dload, writeM)
    assign dload = instruction[15] & instruction[4];
    assign aload = (~instruction[15]) | instruction[5];
    assign writeM = instruction[15] & instruction[3];

    // Program Counter Jump Logic (pcload)
    assign pos = ~(zero | neg);
    assign comp[2] = neg & instruction[2];
    assign comp[1] = zero & instruction[1];
    assign comp[0] = pos & instruction[0];
    assign jump = | comp;
    assign pcload = instruction[15] & jump;


    //Submodule Instantiation
    
    Register Areg(
        .clk(clock),
        .rst(1'b0),
        .load(aload),
        .in(aregin),
        .q(addressM)
    );

    Register Dreg(
        .clk(clock),
        .rst(1'b0),
        .load(dload),
        .in(outM),
        .q(alux)
    );

    ALU alu_inst(
        .x(alux),
        .y(aluy),
        .zx(instruction[11]), .nx(instruction[10]), .zy(instruction[9]), .ny(instruction[8]), .f(instruction[7]), .no(instruction[6]),
        .out(outM),
        .zr(zero),
        .ng(neg)
    );

    PC pc_inst(
        .clk(clock),
        .rst(reset),
        .inc(1'b1),
        .load(pcload),
        .in(addressM),
        .out(pc)
    );
    
endmodule