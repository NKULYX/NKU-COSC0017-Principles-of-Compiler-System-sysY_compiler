
./obj_res/main_llvm.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <rank>:
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	89 7d f0             	mov    %edi,-0x10(%rbp)
   7:	89 75 f4             	mov    %esi,-0xc(%rbp)
   a:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
  11:	89 7d fc             	mov    %edi,-0x4(%rbp)
  14:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  1b:	00 00 00 00 
  1f:	90                   	nop
  20:	8b 45 fc             	mov    -0x4(%rbp),%eax
  23:	3b 45 f4             	cmp    -0xc(%rbp),%eax
  26:	7f 10                	jg     38 <rank+0x38>
  28:	8b 45 f8             	mov    -0x8(%rbp),%eax
  2b:	0f af 45 fc          	imul   -0x4(%rbp),%eax
  2f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  32:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  36:	eb e8                	jmp    20 <rank+0x20>
  38:	8b 45 f8             	mov    -0x8(%rbp),%eax
  3b:	5d                   	pop    %rbp
  3c:	c3                   	retq   
  3d:	0f 1f 00             	nopl   (%rax)

0000000000000040 <main>:
  40:	55                   	push   %rbp
  41:	48 89 e5             	mov    %rsp,%rbp
  44:	53                   	push   %rbx
  45:	48 83 ec 18          	sub    $0x18,%rsp
  49:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  50:	bf 00 00 00 00       	mov    $0x0,%edi
  55:	be 00 00 00 00       	mov    $0x0,%esi
  5a:	31 c0                	xor    %eax,%eax
  5c:	e8 00 00 00 00       	callq  61 <main+0x21>
  61:	bf 04 00 00 00       	mov    $0x4,%edi
  66:	be 05 00 00 00       	mov    $0x5,%esi
  6b:	e8 00 00 00 00       	callq  70 <main+0x30>
  70:	89 c3                	mov    %eax,%ebx
  72:	bf 01 00 00 00       	mov    $0x1,%edi
  77:	be 02 00 00 00       	mov    $0x2,%esi
  7c:	e8 00 00 00 00       	callq  81 <main+0x41>
  81:	89 c1                	mov    %eax,%ecx
  83:	89 d8                	mov    %ebx,%eax
  85:	99                   	cltd   
  86:	f7 f9                	idiv   %ecx
  88:	89 45 f0             	mov    %eax,-0x10(%rbp)
  8b:	bf 00 00 00 00       	mov    $0x0,%edi
  90:	89 c6                	mov    %eax,%esi
  92:	31 c0                	xor    %eax,%eax
  94:	e8 00 00 00 00       	callq  99 <main+0x59>
  99:	c7 45 f4 09 00 00 00 	movl   $0x9,-0xc(%rbp)
  a0:	bf 00 00 00 00       	mov    $0x0,%edi
  a5:	be 09 00 00 00       	mov    $0x9,%esi
  aa:	31 c0                	xor    %eax,%eax
  ac:	e8 00 00 00 00       	callq  b1 <main+0x71>
  b1:	31 c0                	xor    %eax,%eax
  b3:	48 83 c4 18          	add    $0x18,%rsp
  b7:	5b                   	pop    %rbx
  b8:	5d                   	pop    %rbp
  b9:	c3                   	retq   
