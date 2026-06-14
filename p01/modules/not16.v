`include "modules/not.v"

module Not16(
   input [15:0] in,
    output [15:0] out
);
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : not_loop
            Not not_gate_inst (
                .a(in[i]),
                .out(out[i])
            );
        end
    endgenerate
endmodule