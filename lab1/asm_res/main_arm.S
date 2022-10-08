	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.global	N
	.section	.rodata
	.align	2
	.type	N, %object
	.size	N, 4
N:
	.word	5
	.global	m
	.align	2
	.type	m, %object
	.size	m, 4
m:
	.word	2
	.text
	.align	1
	.global	rank
	.arch armv7-a
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	rank, %function
rank:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	movs	r3, #1
	str	r3, [r7, #8]
	ldr	r3, [r7, #4]
	str	r3, [r7, #12]
	b	.L2
.L3:
	ldr	r3, [r7, #8]
	ldr	r2, [r7, #12]
	mul	r3, r2, r3
	str	r3, [r7, #8]
	ldr	r3, [r7, #12]
	adds	r3, r3, #1
	str	r3, [r7, #12]
.L2:
	ldr	r2, [r7, #12]
	ldr	r3, [r7]
	cmp	r2, r3
	ble	.L3
	ldr	r3, [r7, #8]
	mov	r0, r3
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.size	rank, .-rank
	.section	.rodata
	.align	2
.LC0:
	.ascii	"DEF TEST!\000"
	.align	2
.LC1:
	.ascii	"Error!\000"
	.global	__aeabi_idiv
	.align	2
.LC2:
	.ascii	"%d\012\000"
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}
	sub	sp, sp, #12
	add	r7, sp, #0
	ldr	r3, .L9
.LPIC0:
	add	r3, pc
	mov	r0, r3
	bl	puts(PLT)
	movs	r2, #2
	movs	r3, #5
	cmp	r2, r3
	ble	.L6
	ldr	r3, .L9+4
.LPIC1:
	add	r3, pc
	mov	r0, r3
	bl	puts(PLT)
	b	.L7
.L6:
	movs	r2, #5
	movs	r3, #2
	subs	r3, r2, r3
	adds	r3, r3, #1
	movs	r2, #5
	mov	r1, r2
	mov	r0, r3
	bl	rank(PLT)
	mov	r4, r0
	movs	r3, #2
	mov	r1, r3
	movs	r0, #1
	bl	rank(PLT)
	mov	r3, r0
	mov	r1, r3
	mov	r0, r4
	bl	__aeabi_idiv(PLT)
	mov	r3, r0
	str	r3, [r7]
	ldr	r1, [r7]
	ldr	r3, .L9+8
.LPIC2:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
.L7:
	movs	r3, #1
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
	ldr	r1, [r7, #4]
	ldr	r3, .L9+12
.LPIC3:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r4, r7, pc}
.L10:
	.align	2
.L9:
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC2-(.LPIC2+4)
	.word	.LC2-(.LPIC3+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
