`include "p02/modules/add16.v"

module Inc16 (
    input wire [15:0] in ,
    output wire [15:0] out
);

    wire [15:0] b ;
    assign b = 16'b0000000000000001;

    Add16 uut (
        .a(in),
        .b(b),
        .out(out)
    );

endmodule