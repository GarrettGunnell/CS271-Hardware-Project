@256
D=A
@SP
M=D
//0 write call
@CALL0
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@0
D=D-A
@5
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.init
0;JMP
(CALL0)
//
//7 write function
(Class1.set)
//
//8 C_Push
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
//
//9 C_Pop
@SP
AM=M-1
D=M
@R13
M=D
@0
D=A
@16
A=A+D
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
//
//10 C_Push
@1
D=A
@ARG
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1
//
//11 C_Pop
@SP
AM=M-1
D=M
@R13
M=D
@1
D=A
@16
A=A+D
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
//
//12 C_Push
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//
//13 write return
@LCL
D=M
@R13
M=D
@5
A=D-A
D=M
@R14
M=D
@SP
A=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M
@SP
M=D+1
@R13
D=M
A=D-1
D=M
@THAT
M=D
@R13
D=M
@2
A=D-A
D=M
@THIS
M=D
@R13
D=M
@3
A=D-A
D=M
@ARG
M=D
@R13
D=M
@4
A=D-A
D=M
@LCL
M=D
@R14
A=M
0;JMP
//
//16 write function
(Class1.get)
//
//17 C_Push
@0
D=A
@16
A=A+D
D=M
@SP
A=M
M=D
@SP
M=M+1
//
//18 C_Push
@1
D=A
@16
A=A+D
D=M
@SP
A=M
M=D
@SP
M=M+1
//
//19 sub
@SP
AM=M-1
D=M
A=A-1
M=M-D
//
//20 write return
@LCL
D=M
@R13
M=D
@5
A=D-A
D=M
@R14
M=D
@SP
A=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M
@SP
M=D+1
@R13
D=M
A=D-1
D=M
@THAT
M=D
@R13
D=M
@2
A=D-A
D=M
@THIS
M=D
@R13
D=M
@3
A=D-A
D=M
@ARG
M=D
@R13
D=M
@4
A=D-A
D=M
@LCL
M=D
@R14
A=M
0;JMP
//
//7 write function
(Class2.set)
//
//8 C_Push
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
//
//9 C_Pop
@SP
AM=M-1
D=M
@R13
M=D
@0
D=A
@18
A=A+D
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
//
//10 C_Push
@1
D=A
@ARG
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1
//
//11 C_Pop
@SP
AM=M-1
D=M
@R13
M=D
@1
D=A
@18
A=A+D
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
//
//12 C_Push
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
//
//13 write return
@LCL
D=M
@R13
M=D
@5
A=D-A
D=M
@R14
M=D
@SP
A=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M
@SP
M=D+1
@R13
D=M
A=D-1
D=M
@THAT
M=D
@R13
D=M
@2
A=D-A
D=M
@THIS
M=D
@R13
D=M
@3
A=D-A
D=M
@ARG
M=D
@R13
D=M
@4
A=D-A
D=M
@LCL
M=D
@R14
A=M
0;JMP
//
//16 write function
(Class2.get)
//
//17 C_Push
@0
D=A
@18
A=A+D
D=M
@SP
A=M
M=D
@SP
M=M+1
//
//18 C_Push
@1
D=A
@18
A=A+D
D=M
@SP
A=M
M=D
@SP
M=M+1
//
//19 sub
@SP
AM=M-1
D=M
A=A-1
M=M-D
//
//20 write return
@LCL
D=M
@R13
M=D
@5
A=D-A
D=M
@R14
M=D
@SP
A=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M
@SP
M=D+1
@R13
D=M
A=D-1
D=M
@THAT
M=D
@R13
D=M
@2
A=D-A
D=M
@THIS
M=D
@R13
D=M
@3
A=D-A
D=M
@ARG
M=D
@R13
D=M
@4
A=D-A
D=M
@LCL
M=D
@R14
A=M
0;JMP
//
//8 write function
(Sys.init)
//
//9 C_Push
@6
D=A
@SP
A=M
M=D
@SP
M=M+1
//
//10 C_Push
@8
D=A
@SP
A=M
M=D
@SP
M=M+1
//
//11 write call
@CALL1
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@2
D=D-A
@5
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Class1.set
0;JMP
(CALL1)
//
//12 C_Pop
@SP
AM=M-1
D=M
@R13
M=D
@0
D=A
@R5
A=A+D
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
//
//13 C_Push
@23
D=A
@SP
A=M
M=D
@SP
M=M+1
//
//14 C_Push
@15
D=A
@SP
A=M
M=D
@SP
M=M+1
//
//15 write call
@CALL2
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@2
D=D-A
@5
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Class2.set
0;JMP
(CALL2)
//
//16 C_Pop
@SP
AM=M-1
D=M
@R13
M=D
@0
D=A
@R5
A=A+D
D=A
@R14
M=D
@R13
D=M
@R14
A=M
M=D
//
//17 write call
@CALL3
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@0
D=D-A
@5
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Class1.get
0;JMP
(CALL3)
//
//18 write call
@CALL4
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@0
D=D-A
@5
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Class2.get
0;JMP
(CALL4)
//
//19 label
(Sys.init$WHILE)
//
//20 goto
@Sys.init$WHILE
0;JMP
//
(END)
@END
0;JMP
