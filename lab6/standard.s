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
	.file	"standard.c"
	.text
	.align	1
	.global	main
	.arch armv7-a
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	ldr r3, 1095027917
	str	r3, [r7]	@ float
	mov	r3, #1065353216
	str	r3, [r7, #4]	@ float
	vldr.32	s14, [r7]
	vldr.32	s15, [r7, #4]
	vadd.f32	s15, s14, s15
	vstr.32	s15, [r7]
	vldr.32	s14, [r7]
	vldr.32	s15, [r7, #4]
	vsub.f32	s15, s14, s15
	vstr.32	s15, [r7]
	vldr.32	s14, [r7]
	vldr.32	s15, [r7, #4]
	vmul.f32	s15, s14, s15
	vstr.32	s15, [r7]
	vldr.32	s13, [r7]
	vldr.32	s14, [r7, #4]
	vdiv.f32	s15, s13, s14
	vstr.32	s15, [r7]
	vldr.32	s14, [r7]
	vldr.32	s15, [r7, #4]
	vcmpe.f32	s14, s15
	vmrs	APSR_nzcv, FPSCR
	bpl	.L19
	mov	r3, #1065353216
	b	.L4
.L19:
	mov	r3, #0
.L4:
	str	r3, [r7]	@ float
	vldr.32	s14, [r7]
	vldr.32	s15, [r7, #4]
	vcmpe.f32	s14, s15
	vmrs	APSR_nzcv, FPSCR
	ble	.L20
	mov	r3, #1065353216
	b	.L7
.L20:
	mov	r3, #0
.L7:
	str	r3, [r7]	@ float
	vldr.32	s14, [r7]
	vldr.32	s15, [r7, #4]
	vcmpe.f32	s14, s15
	vmrs	APSR_nzcv, FPSCR
	bhi	.L21
	mov	r3, #1065353216
	b	.L10
.L21:
	mov	r3, #0
.L10:
	str	r3, [r7]	@ float
	vldr.32	s14, [r7]
	vldr.32	s15, [r7, #4]
	vcmpe.f32	s14, s15
	vmrs	APSR_nzcv, FPSCR
	blt	.L22
	mov	r3, #1065353216
	b	.L13
.L22:
	mov	r3, #0
.L13:
	str	r3, [r7]	@ float
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
