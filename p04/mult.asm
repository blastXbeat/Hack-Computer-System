// Task : RAM[2] = RAM[0] * RAM[1]
// variable i =0 , sum = 0 , n = RAM[1] 
// LOOP :
//     if i=n 
//         stop
//     else 
//     sum = sum + Ram[0]
// 

//Initialise
    D=0 // D =0
    @i
    M=D // i =0
    @sum
    M=D  // sum =0


(LOOP) // Loop till i = n
    @i
    D=M
    @R1
    D=D-M
    @END
    D;JEQ

    // Process
    @R0
    D=M
    @sum
    M=D+M
    @i
    M=M+1

    @LOOP
    0;JMP

(END)
    @sum
    D=M
    @R2
    M=D

(FINISH)
    @FINISH
    0;JMP




