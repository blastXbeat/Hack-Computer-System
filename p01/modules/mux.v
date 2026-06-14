module Mux (
    input wire i0 , i1 , sel,
    output wire out
);
    assign out = sel ? i1 : i0;
    
endmodule