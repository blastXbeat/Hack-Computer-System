`include "p01/modules/xor.v"
`include "p01/modules/and.v"

module HalfAdder (
    input wire a , b ,
    output wire sum , carry
);
    
    Xor_gate xor1 (
        .a(a),
        .b(b),
        .out(sum)
    );

    And_gate and1 (
        .a(a),
        .b(b),
        .out(carry)
    );


endmodule