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
	.file	"test1.cpp"
	.text
	.section	.rodata
	.align	2
	.type	_ZL1N, %object
	.size	_ZL1N, 4
_ZL1N:
	.word	2
	.align	2
.LC1:
	.ascii	"%d\012\000"
	.align	2
.LC0:
	.word	1
	.word	1
	.word	2
	.word	4
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
	.fnstart
.LFB0:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}
	.save {r4, r7, lr}
	.pad #52
	sub	sp, sp, #52
	.setfp r7, sp, #0
	add	r7, sp, #0
	ldr	r2, .L14
.LPIC2:
	add	r2, pc
	ldr	r3, .L14+4
	ldr	r3, [r2, r3]
	ldr	r3, [r3]
	str	r3, [r7, #44]
	mov	r3,#0
	movs	r3, #0
	str	r3, [r7]
	movs	r3, #0
	str	r3, [r7, #4]
.L7:
	ldr	r3, [r7]
	cmp	r3, #1
	bgt	.L2
.L6:
	ldr	r3, [r7, #4]
	cmp	r3, #1
	bgt	.L3
	ldr	r3, [r7, #4]
	cmp	r3, #0
	bne	.L4
	ldr	r3, [r7]
	adds	r2, r3, #1
	ldr	r3, [r7]
	lsls	r1, r3, #1
	ldr	r3, [r7, #4]
	add	r3, r3, r1
	lsls	r3, r3, #2
	add	r1, r7, #48
	add	r3, r3, r1
	str	r2, [r3, #-36]
	b	.L5
.L4:
	ldr	r3, [r7, #4]
	subs	r3, r3, #1
	ldr	r2, [r7]
	lsls	r2, r2, #1
	add	r3, r3, r2
	lsls	r3, r3, #2
	add	r2, r7, #48
	add	r3, r3, r2
	ldr	r2, [r3, #-36]
	ldr	r3, [r7, #4]
	subs	r3, r3, #1
	ldr	r1, [r7]
	lsls	r1, r1, #1
	add	r3, r3, r1
	lsls	r3, r3, #2
	add	r1, r7, #48
	add	r3, r3, r1
	ldr	r3, [r3, #-36]
	mul	r2, r3, r2
	ldr	r3, [r7]
	lsls	r1, r3, #1
	ldr	r3, [r7, #4]
	add	r3, r3, r1
	lsls	r3, r3, #2
	add	r1, r7, #48
	add	r3, r3, r1
	str	r2, [r3, #-36]
.L5:
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
	b	.L6
.L3:
	ldr	r3, [r7]
	adds	r3, r3, #1
	str	r3, [r7]
	b	.L7
.L2:
	ldr	r3, .L14+8
.LPIC0:
	add	r3, pc
	add	r4, r7, #28
	ldm	r3, {r0, r1, r2, r3}
	stm	r4, {r0, r1, r2, r3}
	movs	r3, #0
	str	r3, [r7, #8]
.L11:
	ldr	r3, [r7]
	cmp	r3, #0
	ble	.L8
.L10:
	ldr	r3, [r7, #4]
	cmp	r3, #0
	ble	.L9
	ldr	r3, [r7, #4]
	subs	r3, r3, #1
	str	r3, [r7, #4]
	b	.L10
.L9:
	ldr	r3, [r7]
	subs	r3, r3, #1
	str	r3, [r7]
	b	.L11
.L8:
	ldr	r1, [r7, #8]
	ldr	r3, .L14+12
.LPIC1:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	movs	r3, #0
	ldr	r1, .L14+16
.LPIC3:
	add	r1, pc
	ldr	r2, .L14+4
	ldr	r2, [r1, r2]
	ldr	r1, [r2]
	ldr	r2, [r7, #44]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L13
	bl	__stack_chk_fail(PLT)
.L13:
	mov	r0, r3
	adds	r7, r7, #52
	mov	sp, r7
	@ sp needed
	pop	{r4, r7, pc}
.L15:
	.align	2
.L14:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC2+4)
	.word	__stack_chk_guard(GOT)
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC3+4)
	.fnend
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",%progbits
