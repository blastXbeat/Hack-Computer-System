// Whenever Keyboard input => Blacken then screen

(LOOP) // setiing i = 0
    @i
    M=0 // set i = 0 

(SCREEN_SWEEP) // checking whether i = 8192 and key borad pressed or not
    @8192
    D=A
    @i
    D=D-M
    @LOOP
    D;JEQ // if i = 8192 jmp to loop to set it 0 

    @KBD // RAM[24576]
    D=M 
    @BLACK 
    D;JNE //If key is pressed Jmp to black
    
(WHITE) //Setting white
    @i
    D=M
    @SCREEN
    D=D+A
    A=D
    M=0
    @INCREMENT
    0;JMP

(BLACK) // Setting Black
    @i
    D=M
    @SCREEN
    D=D+A
    A=D
    M=-1

(INCREMENT)
    @i
    M=M+1

    @SCREEN_SWEEP
    0;JMP



    
        

