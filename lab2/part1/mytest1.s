    .arch armv7-a
    .arm
@ 数据段
@ 全局变量及常量的声明
    .data
    str: .asciz "%d\n"
    .text
    .section .rodata
    .global N
    .align 4
    .size N, 4
N:
    .word 2
@ 代码段
@ 主函数
    .global main
    .type main , %function
main:
.L1:
    push {r4, r5, r6, r7, r8, r9, r10, lr}
    sub	sp, sp, #32                 //sp为array
    mov	r4, #0                      //i=r4
    mov r5, #0                      //j=r5
    ldr r6, addr_N                  //N=r6
    ldr r6, [r6]
    add r7, sp, #16                 //res
    mov r8, #1
    str r8, [r7]
    str r8, [r7, #4]
    mov r8, #2
    str r8, [r7, #8]
    mov r8, #4
    str r8, [r7, #12]               //int res[N][N] = {{1,1},{2,4}};

.L2:
    cmp r4, r6                      //while(i<N)
    bge .L8
    mov	r5, #0

.L3:
    cmp r5, r6                      //while(j<N)
    bge .L7

.L4:
    add r7, r5, r4, lsl #1
    add r7, sp, r7, lsl #2          //r7=&(array[i][j])

    cmp r5, #0                      //if(j==0)
    beq .L5
    ldr r8, [r7, #-4]
    mul r8, r8, r8                  //array[i][j] = array[i][j-1] * array[i][j-1];
    str r8, [r7]
    b .L6

.L5:
    add r8, r4, #1                  //array[i][j] = i+1;
    str r8, [r7]

.L6:
    add r5, r5, #1                  //j++
    b .L3

.L7:
    add r4, r4, #1                  //i++
    b .L2

.L8:
    mov r8, #0                      //flag=r8
    mov r4, #0                      //i=0

.L9:
    cmp r4, r6
    bge .L13
    mov r5, #0                      //j=0

.L10:
    cmp r5, r6
    bge .L12
    add r7, r5, r4, lsl #1
    add r7, sp, r7, lsl #2          //r7=&(array[i][j])
    ldr r9, [r7]                    //r9 = array[i][j]
    ldr r10, [r7, #16]              //r10 = res[i][j]
    cmp r9, r10                     //flag += !(res[i][j]==res[i][j]);
    beq .L11
    add r8, r8, #1                  //j++

.L11:
    add r5, r5, #1                  //i++
    b .L10

.L12:
    add r4, r4, #1
    b .L9

.L13:
    ldr r0 ,=str
    mov r1, r8
    bl printf
    add	sp, sp, #32
    pop {r4, r5, r6, r7, r8, r9, r10, pc}
@ 桥接全局变量的地址
addr_N:
    .word N
