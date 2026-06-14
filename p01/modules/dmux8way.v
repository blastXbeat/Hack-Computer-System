module DMux8Way (
    input wire in,
    input wire [2:0] sel,
    output reg a, b, c, d, e, f, g, h
);
    always @(*) begin
        a = 1'b0;
        b = 1'b0;
        c = 1'b0;
        d = 1'b0;
        e = 1'b0;
        f = 1'b0;
        g = 1'b0;
        h = 1'b0;


        case (sel)
            3'b000: a = in;
            3'b001: b = in;
            3'b010: c = in;
            3'b011: d = in;
            3'b100: e = in;
            3'b101: f = in;
            3'b110: g = in;
            3'b111: h = in;
            default: begin
                a = 1'b0;
                b = 1'b0;
                c = 1'b0;
                d = 1'b0;
                e = 1'b0;
                f = 1'b0;
                g = 1'b0;
                h = 1'b0;
            end 
        endcase

    end

endmodule