@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//9
@SP
AM=M-1
D=M
@R13
M=D
@0
D=A
@LCL
A=M+D
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
//10
(LOOP_START)
@0
D=A
@ARG
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1
//12
@0
D=A
@LCL
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1
//13
@SP
AM=M-1
D=M
A=A-1
M=M+D
//14
@SP
AM=M-1
D=M
@R13
M=D
@0
D=A
@LCL
A=M+D
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
//15
@0
D=A
@ARG
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1
//16
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
//17
@SP
AM=M-1
D=M
A=A-1
M=M-D
//18
@SP
AM=M-1
D=M
@R13
M=D
@0
D=A
@ARG
A=M+D
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
//19
@0
D=A
@ARG
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1
//20
@SP
AM=M-1
D=M
@LOOP_START
D;JNE
@0
D=A
@LCL
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1
//22
(END)
@END
0;JMP