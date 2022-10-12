	.arch armv7-a
	.file	"test2.c"

	.text
	.comm	res,40,4
RES_ADDR:
	.word res

	.align	1
	.global	main
	.type	main, %function
main:
@ save return address
	push	{lr}
@ initialize stack
	sub	sp, sp, #24
@ call function getint()
@ int n = getint()
	bl	getint
@ return value is in r0
@ [sp + 4] = n
	str	r0, [sp, #4]
@ put parameter in r0
	ldr	r0, [sp, #4]
@ call func(n)
	bl	func
@ int a = 10
@ [sp + 8] = a
	mov r4, #10
	str	r4, [sp, #8]
@ float fb = 1.0;
@ [sp + 12] = fb
	mov	r4, #1065353216
	str	r4, [sp, #12]	@ float
@ int b = fb
@ [sp + 16] = b
	vldr.32	s15, [sp, #12]
	vcvt.s32.f32	s15, s15
	vmov	r4, s15	@ int
	str	r4, [sp, #16]
@ inline function
@ inline_a = [sp, #8] = a
	ldr	r0, [sp, #8]
@ inline_b = [sp, #16] = b
	ldr	r1, [sp, #16]
	cmp	r0, r1
@ inline_a > inline_b
	bge	.L2
@ return value = inline_a
	mov	r3, r0
	b	.L3
.L2:
@ return value = inline_b
	mov	r3, r1
.L3:
@ r0 = return value
	mov	r0, r3
@ funRes = inlineFunc
@ [sp + 20] = funRes
	str r0, [sp, #20]
@ put parameter in r0
	ldr r0, [sp, #20]
@ call function putint(funRes)
	bl	putint
@ put return value 0 for main function
	mov	r0, #0
	adds	sp, sp, #24
	pop	{pc}

@ global const value
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Error!\n\000"
	
	
	.text
	.align	1
	.global	func
	.type	func, %function
func:
	push	{lr}
	sub	sp, sp, #16
	str	r0, [sp, #4]
.LPIC1:
@ n < 10?
	cmp	r0, #9
	ble	.L6
.LPIC0:
@ r3 = .LC0 -> "ERROR!\n"
	ldr r0, =.LC0
@ printf("ERROR!\n");
	bl	printf
@ goto return
	b	.L5
@ n < 10
.L6:
@ r1 = the beginning address of res
	ldr r1, RES_ADDR
	mov	r2, #1
@ res[0] = 1
	str	r2, [r1]
@ res[1] = 1
	str	r2, [r1, #4]
@ int i = 0;
	mov	r2, #0
	str	r2, [sp, #12]
.L12:
	ldr	r2, [sp, #12]
@ i++
	add	r2, r2, #1
	str	r2, [sp, #12]
	ldr	r2, [sp, #12]
@ i < 2?
	cmp	r2, #1
	ble	.L14
	ldr	r1, [sp, #12]
	ldr	r2, [sp, #4]
@ i == n?
	cmp	r1, r2
	beq	.L15
	ldr	r2, [sp, #12]
@ r2 = i - 1
	sub	r2, r2, #1
	ldr	r1, RES_ADDR
@ r1 = res[i-1]
	ldr	r1, [r1, r2, lsl #2]
	ldr	r2, [sp, #12]
	sub	r2, r2, #2
	ldr	r0, RES_ADDR
@ r2 = res[i-2]
	ldr	r2, [r0, r2, lsl #2]
	add	r1, r1, r2
	ldr	r0, RES_ADDR
	ldr	r2, [sp, #12]
@ res[i] = res[i-1] + res[i-2]
	str	r1, [r0, r2, lsl #2]
	b	.L12
@ i < 2 --> continue
.L14:
	nop
	b	.L12
@ i == n --> break
.L15:
	nop
	ldr r1, RES_ADDR
	ldr	r0, [sp, #4]
	bl	putarray
.L5:
	adds	sp, sp, #16
	pop	{pc}
	.size	func, .-func


	.align	1
	.global	inlineFunc
	.type	inlineFunc, %function
inlineFunc:
	sub	sp, sp, #12
	str	r0, [sp, #4]
	str	r1, [sp]
	ldr	r2, [sp, #4]
	ldr	r3, [sp]
	cmp	r2, r3
	bge	.L19
	ldr	r3, [sp, #4]
	b	.L20
.L19:
	ldr	r3, [sp]
.L20:
	mov	r0, r3
	adds	sp, sp, #12
	bx	lr
	.size	inlineFunc, .-inlineFunc
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
