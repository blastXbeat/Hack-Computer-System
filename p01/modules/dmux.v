module DMux (
    input wire in ,sel , 
    output wire o0 , o1
);
    assign o0 = in & ~sel;
    assign o1 = in & sel;
    
endmodule