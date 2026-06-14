module PC #(
    parameter WIDTH = 16
) (
   input wire clk,
   input wire rst,
   input wire inc,
   input wire load,
   input wire [WIDTH-1:0] in,
   output reg [WIDTH-1:0] out  
);
    always @(posedge clk) begin
        if (rst) begin
            out <= 0;
        end else if (load) begin
            out <= in; // Load the new value into the PC
        end else if (inc) begin
            out <= out + 1; // Increment by 1 for byte-aligned instructions
        end else begin
            out <= out; // Hold the current value
        end
    end
    
endmodule