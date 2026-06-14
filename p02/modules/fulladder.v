`include "p02/modules/halfadder.v"
`include "p01/modules/or.v"

module FullAdder(
    input wire a,b,c,
    output wire sum,carry
);
    wire sum_cnct , carry_cnct1 , carry_cnct2 ; 

    HalfAdder inst1(
        .a(a),
        .b(b),
        .sum(sum_cnct),
        .carry(carry_cnct1)
    );

    HalfAdder inst2(
        .a(sum_cnct),
        .b(c),
        .sum(sum),
        .carry(carry_cnct2)
    );

    Or_gate instor(
        .a(carry_cnct1),
        .b(carry_cnct2),
        .out(carry)
    );
    
endmodule