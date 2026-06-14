module SCREEN (
    input [15:0] in_,
    input [13:0] address,
    input load, clock,
    output reg [15:0] out
);
 reg [15:0] screen [0:8191];
 integer i;
 integer log_file;

 initial begin
    for(i=0;i<8192;i=i+1)
        screen[i] = 16'b0;

    $readmemb("screen.txt", screen , 0 , 8191);
    // Open a log file in append mode ("a") so it keeps adding lines
    log_file = $fopen("screen_live_log.txt", "a");
 end

 always @(posedge clock) begin
     if (load) begin
         screen[address] <= in_;
         $fdisplayb(log_file, "Addr: %d | Data written: %b", address, in_);
     end
     out <= screen[address];
 end
    
endmodule