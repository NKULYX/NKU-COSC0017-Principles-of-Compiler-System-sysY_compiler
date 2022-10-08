	.file	"main.c"
	.text
	.globl	N
	.section	.rodata
	.align 4
	.type	N, @object
	.size	N, 4
N:
	.long	5
	.globl	m
	.align 4
	.type	m, @object
	.size	m, 4
m:
	.long	2
	.text
	.globl	rank
	.type	rank, @function
rank:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	$1, -8(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L2
.L3:
	movl	-8(%rbp), %eax
	imull	-4(%rbp), %eax
	movl	%eax, -8(%rbp)
	addl	$1, -4(%rbp)
.L2:
	movl	-4(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jle	.L3
	movl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	rank, .-rank
	.section	.rodata
.LC0:
	.string	"DEF TEST!"
.LC1:
	.string	"Error!"
.LC2:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$2, %edx
	movl	$5, %eax
	cmpl	%eax, %edx
	jle	.L6
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	jmp	.L7
.L6:
	movl	$5, %edx
	movl	$5, %ecx
	movl	$2, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	addl	$1, %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	rank
	movl	%eax, %ebx
	movl	$2, %eax
	movl	%eax, %esi
	movl	$1, %edi
	call	rank
	movl	%eax, %esi
	movl	%ebx, %eax
	cltd
	idivl	%esi
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L7:
	movl	$1, -20(%rbp)
	addl	$1, -20(%rbp)
	addl	$1, -20(%rbp)
	addl	$1, -20(%rbp)
	addl	$1, -20(%rbp)
	addl	$1, -20(%rbp)
	addl	$1, -20(%rbp)
	addl	$1, -20(%rbp)
	addl	$1, -20(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
