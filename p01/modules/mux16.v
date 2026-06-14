`include "modules/mux.v"

module Mux16 (
    input [15:0] a,
    input [15:0] b,
    input sel,
    output [15:0] out
);

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : mux_loop
            Mux mux_inst (
                .i0(a[i]),
                .i1(b[i]),
                .sel(sel),
                .out(out[i])
            );
        end
    endgenerate
endmodule