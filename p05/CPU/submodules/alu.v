module ALU (
    input wire [15:0] x , y ,
    input wire zx , nx , zy , ny , f , no , 
    output reg [15:0] out ,
    output reg zr , ng
);
    
    reg [15:0] x_f , y_f , fout ;
    wire [15:0] add_out , and_out ;


    always @(*) begin
        x_f = x ;
        y_f = y ; 

        x_f = zx ? 16'b0 : x_f ;
        y_f = zy ? 16'b0 : y_f ;

        if (nx) x_f = ~x_f ;
        if (ny) y_f = ~y_f ;

        fout = f ? (x_f + y_f) : (x_f & y_f) ;
 
        out = no ? ~fout :  fout;
        ng = out[15];
        zr = ~(|out) ; 
    end

endmodule