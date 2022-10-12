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
	.file	"test2.c"
	.text
	.comm	_sysy_start,8,4
	.comm	_sysy_end,8,4
	.comm	_sysy_l1,4096,4
	.comm	_sysy_l2,4096,4
	.comm	_sysy_h,4096,4
	.comm	_sysy_m,4096,4
	.comm	_sysy_s,4096,4
	.comm	_sysy_us,4096,4
	.comm	_sysy_idx,4,4
	.comm	res,40,4
	.align	1
	.global	main
	.arch armv7-a
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #32
	add	r7, sp, #0
	bl	getint(PLT)
	str	r0, [r7, #4]
	ldr	r0, [r7, #4]
	bl	func(PLT)
	movs	r3, #10
	str	r3, [r7, #8]
	mov	r3, #1065353216
	str	r3, [r7, #12]	@ float
	vldr.32	s15, [r7, #12]
	vcvt.s32.f32	s15, s15
	vmov	r3, s15	@ int
	str	r3, [r7, #16]
	ldr	r3, [r7, #8]
	str	r3, [r7, #24]
	ldr	r3, [r7, #16]
	str	r3, [r7, #28]
	ldr	r2, [r7, #24]
	ldr	r3, [r7, #28]
	cmp	r2, r3
	bge	.L2
	ldr	r3, [r7, #24]
	b	.L3
.L2:
	ldr	r3, [r7, #28]
.L3:
	str	r3, [r7, #20]
	ldr	r0, [r7, #20]
	bl	putint(PLT)
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #32
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.size	main, .-main
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Error!\000"
	.text
	.align	1
	.global	func
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	func, %function
func:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	str	r0, [r7, #4]
	ldr	r3, .L16
.LPIC1:
	add	r3, pc
	ldr	r2, [r7, #4]
	cmp	r2, #9
	ble	.L6
	ldr	r3, .L16+4
.LPIC0:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	b	.L5
.L6:
	ldr	r2, .L16+8
	ldr	r2, [r3, r2]
	mov	r1, r2
	movs	r2, #1
	str	r2, [r1]
	ldr	r2, .L16+8
	ldr	r2, [r3, r2]
	mov	r1, r2
	movs	r2, #1
	str	r2, [r1, #4]
	movs	r2, #0
	str	r2, [r7, #12]
.L12:
	ldr	r2, [r7, #12]
	adds	r2, r2, #1
	str	r2, [r7, #12]
	ldr	r2, [r7, #12]
	cmp	r2, #1
	ble	.L14
	ldr	r1, [r7, #12]
	ldr	r2, [r7, #4]
	cmp	r1, r2
	beq	.L15
	ldr	r2, [r7, #12]
	subs	r2, r2, #1
	ldr	r1, .L16+8
	ldr	r1, [r3, r1]
	ldr	r1, [r1, r2, lsl #2]
	ldr	r2, [r7, #12]
	subs	r2, r2, #2
	ldr	r0, .L16+8
	ldr	r0, [r3, r0]
	ldr	r2, [r0, r2, lsl #2]
	add	r1, r1, r2
	ldr	r2, .L16+8
	ldr	r2, [r3, r2]
	mov	r0, r2
	ldr	r2, [r7, #12]
	str	r1, [r0, r2, lsl #2]
	b	.L12
.L14:
	nop
	b	.L12
.L15:
	nop
	ldr	r2, .L16+8
	ldr	r3, [r3, r2]
	mov	r1, r3
	ldr	r0, [r7, #4]
	bl	putarray(PLT)
.L5:
	adds	r7, r7, #16
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L17:
	.align	2
.L16:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC1+4)
	.word	.LC0-(.LPIC0+4)
	.word	res(GOT)
	.size	func, .-func
	.align	1
	.global	inlineFunc
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	inlineFunc, %function
inlineFunc:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	ldr	r2, [r7, #4]
	ldr	r3, [r7]
	cmp	r2, r3
	bge	.L19
	ldr	r3, [r7, #4]
	b	.L20
.L19:
	ldr	r3, [r7]
.L20:
	mov	r0, r3
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.size	inlineFunc, .-inlineFunc
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
