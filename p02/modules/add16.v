`include "p02/modules/fulladder.v"

module Add16 (
    input wire [15:0] a , b ,
    output wire [15:0] out
);
    wire [16:0]  carry ; 
    assign carry[0] = 1'b0 ; 
    genvar i ;
    generate
        for (i = 0 ; i< 16 ; i = i +1) begin : and_loop
        
            FullAdder fulladder_inst (
                .a(a[i]),
                .b(b[i]),
                .c(carry[i]),
                .sum(out[i]),
                .carry(carry[i+1])
            );

        end
    endgenerate

endmodule