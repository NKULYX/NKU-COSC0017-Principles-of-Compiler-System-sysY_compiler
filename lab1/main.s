	.text
	.file	"main.c"
	.globl	rank                    # -- Begin function rank
	.p2align	4, 0x90
	.type	rank,@function
rank:                                   # @rank
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -16(%rbp)
	movl	%esi, -12(%rbp)
	movl	$1, -8(%rbp)
	movl	%edi, -4(%rbp)
	.p2align	4, 0x90
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jg	.LBB0_3
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
	movl	-8(%rbp), %eax
	imull	-4(%rbp), %eax
	movl	%eax, -8(%rbp)
	addl	$1, -4(%rbp)
	jmp	.LBB0_1
.LBB0_3:
	movl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	rank, .Lfunc_end0-rank
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset %rbx, -24
	movl	$0, -20(%rbp)
	movl	$.L.str, %edi
	movl	$.L.str.1, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$4, %edi
	movl	$5, %esi
	callq	rank
	movl	%eax, %ebx
	movl	$1, %edi
	movl	$2, %esi
	callq	rank
	movl	%eax, %ecx
	movl	%ebx, %eax
	cltd
	idivl	%ecx
	movl	%eax, -16(%rbp)
	movl	$.L.str.2, %edi
	movl	%eax, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$9, -12(%rbp)
	movl	$.L.str.2, %edi
	movl	$9, %esi
	xorl	%eax, %eax
	callq	printf
	xorl	%eax, %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	N,@object               # @N
	.section	.rodata,"a",@progbits
	.globl	N
	.p2align	2
N:
	.long	5                       # 0x5
	.size	N, 4

	.type	m,@object               # @m
	.globl	m
	.p2align	2
m:
	.long	2                       # 0x2
	.size	m, 4

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%s\n"
	.size	.L.str, 4

	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"DEF TEST!"
	.size	.L.str.1, 10

	.type	.L.str.2,@object        # @.str.2
.L.str.2:
	.asciz	"%d\n"
	.size	.L.str.2, 4

	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
