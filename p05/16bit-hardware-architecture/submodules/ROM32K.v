module ROM32K (
    input  wire [14:0] address, // 15-bit address for 32K words
    output reg  [15:0] out
);

    // Declare a memory array: 32768 words, each 16 bits wide
    reg [15:0] rom_array [0:32767];

    // Initialize the ROM with your Hack binary file
    initial begin
        // Assumes your program is compiled into a text file named "prog.hack"
        // where each line is a 16-bit binary string (e.g., 0000000000000101)
        $readmemb("/workspace/p05/16bit-hardware-architecture/prog.hack", rom_array);
    end

    // Asynchronous read (just like Hack ROM)
    always @(*) begin
        out = rom_array[address];
    end

endmodule