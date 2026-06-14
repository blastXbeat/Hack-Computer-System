module DFF #(
    parameter WIDTH = 16 
) (
    input wire clk , 
    input wire rst ,
    input wire [WIDTH-1:0] d ,
    output reg [WIDTH-1:0] q
);
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= {WIDTH{1'b0}}; // Reset q to 0
        end else begin
            q <= d;
        end
    end

    
endmodule