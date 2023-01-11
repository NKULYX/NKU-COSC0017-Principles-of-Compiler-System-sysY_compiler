	.arch armv8-a
	.arch_extension crc
	.arm
	.data
	.global get_next
	.type get_next , %function
get_next:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #16
.L29:
	str r0, [fp, #-16]
	str r1, [fp, #-12]
	ldr r10, [fp, #-12]
	ldr r9, =0
	ldr r8, =4
	mul r7, r9, r8
	add r9, r7, r10
	ldr r10, =-1
	str r10, [r9]
	ldr r10, =0
	str r10, [fp, #-8]
	ldr r10, =-1
	str r10, [fp, #-4]
	b .L38
.L38:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L37
	b .L46
.L37:
	ldr r10, [fp, #-4]
	ldr r9, =-1
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L48
	b .L54
.L46:
	b .L39
.L48:
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	ldr r8, [fp, #-12]
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r8
	str r10, [r9]
	b .L50
.L54:
	b .L51
.L39:
	b .Lget_next_END
.L50:
	b .L38
.L51:
	ldr r10, [fp, #-8]
	ldr r9, [fp, #-16]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	ldr r10, [fp, #-4]
	ldr r8, [fp, #-16]
	ldr r7, =4
	mul r6, r10, r7
	add r10, r6, r8
	ldr r8, [r10]
	cmp r9, r8
	moveq r10, #1
	movne r10, #0
	beq .L48
	b .L67
.L67:
	b .L49
.L49:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-12]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	str r9, [fp, #-4]
	b .L50
.Lget_next_END:
	add sp, sp, #16
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global KMP
	.type KMP , %function
KMP:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	ldr r4,=16400
	sub sp, sp, r4
.L81:
	ldr r10, =-16400
	str r0, [fp, r10]
	ldr r10, =-16396
	str r1, [fp, r10]
	ldr r10, =-16400
	ldr r9, [fp, r10]
	ldr r10, =0
	add r8, r10, r9
	ldr r10, =0
	add r9, r10, #-16392
	add r10, fp, r9
	mov r1, r10
	mov r0, r8
	bl get_next
	ldr r10, =0
	str r10, [fp, #-8]
	ldr r10, =0
	str r10, [fp, #-4]
	b .L93
.L93:
	ldr r10, [fp, #-4]
	ldr r9, =-16396
	ldr r8, [fp, r9]
	ldr r9, =4
	mul r7, r10, r9
	add r10, r7, r8
	ldr r9, [r10]
	ldr r10, =0
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L92
	b .L101
.L92:
	ldr r10, [fp, #-8]
	ldr r9, =-16400
	ldr r8, [fp, r9]
	ldr r9, =4
	mul r7, r10, r9
	add r10, r7, r8
	ldr r9, [r10]
	ldr r10, [fp, #-4]
	ldr r8, =-16396
	ldr r7, [fp, r8]
	ldr r8, =4
	mul r6, r10, r8
	add r10, r6, r7
	ldr r8, [r10]
	cmp r9, r8
	moveq r10, #1
	movne r10, #0
	beq .L103
	b .L117
.L101:
	b .L94
.L103:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	ldr r10, [fp, #-8]
	ldr r9, =-16400
	ldr r8, [fp, r9]
	ldr r9, =4
	mul r7, r10, r9
	add r10, r7, r8
	ldr r9, [r10]
	ldr r10, =0
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L121
	b .L129
.L117:
	b .L104
.L94:
	ldr r10, =-1
	mov r0, r10
	b .LKMP_END
.L121:
	ldr r10, [fp, #-4]
	mov r0, r10
	b .LKMP_END
.L129:
	b .L122
.L104:
	ldr r10, [fp, #-8]
	ldr r9, =4
	mul r8, r10, r9
	add r10, r8, #-16392
	add r10, fp, r10
	ldr r9, [r10]
	str r9, [fp, #-8]
	ldr r10, [fp, #-8]
	ldr r9, =-1
	cmp r10, r9
	moveq r10, #1
	movne r10, #0
	beq .L136
	b .L140
.L122:
	b .L105
.L136:
	ldr r10, [fp, #-8]
	add r9, r10, #1
	str r9, [fp, #-8]
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L137
.L140:
	b .L137
.L105:
	b .L93
.L137:
	b .L105
.LKMP_END:
	ldr r4,=16400
	add sp, sp, r4
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global read_str
	.type read_str , %function
read_str:
	push {r6, r7, r8, r9, r10, fp, lr}
	mov fp, sp
	sub sp, sp, #8
.L144:
	str r0, [fp, #-8]
	ldr r10, =0
	str r10, [fp, #-4]
	b .L148
.L148:
	ldr r10, =0
	ldr r9, =1
	cmp r10, r9
	movne r10, #1
	moveq r10, #0
	bne .L147
	b .L151
.L147:
	bl getch
	mov r10, r0
	ldr r9, [fp, #-4]
	ldr r8, [fp, #-8]
	ldr r7, =4
	mul r6, r9, r7
	add r9, r6, r8
	str r10, [r9]
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, [r10]
	ldr r10, =10
	cmp r9, r10
	moveq r10, #1
	movne r10, #0
	beq .L157
	b .L165
.L151:
	b .L149
.L157:
	b .L149
.L165:
	b .L158
.L149:
	ldr r10, [fp, #-4]
	ldr r9, [fp, #-8]
	ldr r8, =4
	mul r7, r10, r8
	add r10, r7, r9
	ldr r9, =0
	str r9, [r10]
	ldr r10, [fp, #-4]
	mov r0, r10
	b .Lread_str_END
.L158:
	ldr r10, [fp, #-4]
	add r9, r10, #1
	str r9, [fp, #-4]
	b .L148
.Lread_str_END:
	add sp, sp, #8
	pop {r6, r7, r8, r9, r10, fp, lr}
	bx lr

	.global main
	.type main , %function
main:
	push {r8, r9, r10, fp, lr}
	mov fp, sp
	ldr r4,=32768
	sub sp, sp, r4
.L174:
	ldr r10, =0
	add r9, r10, #-32768
	add r10, fp, r9
	mov r0, r10
	bl read_str
	mov r10, r0
	ldr r10, =0
	add r9, r10, #-16384
	add r10, fp, r9
	mov r0, r10
	bl read_str
	mov r10, r0
	ldr r10, =0
	add r9, r10, #-32768
	ldr r10, =0
	add r8, r10, #-16384
	mov r1, r8
	mov r0, r9
	bl KMP
	mov r10, r0
	mov r0, r10
	bl putint
	mov r0, #10
	bl putch
	ldr r10, =0
	mov r0, r10
	b .Lmain_END
.Lmain_END:
	ldr r4,=32768
	add sp, sp, r4
	pop {r8, r9, r10, fp, lr}
	bx lr

