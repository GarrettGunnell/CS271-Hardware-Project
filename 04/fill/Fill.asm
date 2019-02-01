// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.
(WHILE_LOOP)
@16384
D=A
@currentPosition
M=D // currentPos is a pointer to the upper left corner of the screen
@i
M=0
@KBD
D=M
@IF_TRUE
D;JEQ // if no Keyboard Input, Goto IF_TRUE
(LOOP) // for (int i = 0; i <= 8192; ++i)
@i
D=M
@8192
D=D-A
@END
D;JEQ
@currentPosition
A=M
M=-1
@currentPosition
D = M
D = D + 1
M=D
@i
M = M + 1
@LOOP
0;JMP
(IF_TRUE) // for (int i = 0; i <= 8192; ++i)
@i
D=M
@8192
D=D-A
@END
D;JEQ
@currentPosition
A=M
M=0
@currentPosition
D = M
D = D + 1
M=D
@i
M = M + 1
@IF_TRUE
0;JMP
(END)
@WHILE_LOOP
0;JMP
