
./obj_res/main_gcc.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <rank>:
   0:	f3 0f 1e fa          	endbr64 
   4:	55                   	push   %rbp
   5:	48 89 e5             	mov    %rsp,%rbp
   8:	89 7d ec             	mov    %edi,-0x14(%rbp)
   b:	89 75 e8             	mov    %esi,-0x18(%rbp)
   e:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
  15:	8b 45 ec             	mov    -0x14(%rbp),%eax
  18:	89 45 fc             	mov    %eax,-0x4(%rbp)
  1b:	eb 0e                	jmp    2b <rank+0x2b>
  1d:	8b 45 f8             	mov    -0x8(%rbp),%eax
  20:	0f af 45 fc          	imul   -0x4(%rbp),%eax
  24:	89 45 f8             	mov    %eax,-0x8(%rbp)
  27:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2e:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  31:	7e ea                	jle    1d <rank+0x1d>
  33:	8b 45 f8             	mov    -0x8(%rbp),%eax
  36:	5d                   	pop    %rbp
  37:	c3                   	retq   

0000000000000038 <main>:
  38:	f3 0f 1e fa          	endbr64 
  3c:	55                   	push   %rbp
  3d:	48 89 e5             	mov    %rsp,%rbp
  40:	53                   	push   %rbx
  41:	48 83 ec 18          	sub    $0x18,%rsp
  45:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 4c <main+0x14>
  4c:	e8 00 00 00 00       	callq  51 <main+0x19>
  51:	ba 02 00 00 00       	mov    $0x2,%edx
  56:	b8 05 00 00 00       	mov    $0x5,%eax
  5b:	39 c2                	cmp    %eax,%edx
  5d:	7e 0e                	jle    6d <main+0x35>
  5f:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 66 <main+0x2e>
  66:	e8 00 00 00 00       	callq  6b <main+0x33>
  6b:	eb 52                	jmp    bf <main+0x87>
  6d:	ba 05 00 00 00       	mov    $0x5,%edx
  72:	b9 05 00 00 00       	mov    $0x5,%ecx
  77:	b8 02 00 00 00       	mov    $0x2,%eax
  7c:	29 c1                	sub    %eax,%ecx
  7e:	89 c8                	mov    %ecx,%eax
  80:	83 c0 01             	add    $0x1,%eax
  83:	89 d6                	mov    %edx,%esi
  85:	89 c7                	mov    %eax,%edi
  87:	e8 00 00 00 00       	callq  8c <main+0x54>
  8c:	89 c3                	mov    %eax,%ebx
  8e:	b8 02 00 00 00       	mov    $0x2,%eax
  93:	89 c6                	mov    %eax,%esi
  95:	bf 01 00 00 00       	mov    $0x1,%edi
  9a:	e8 00 00 00 00       	callq  9f <main+0x67>
  9f:	89 c6                	mov    %eax,%esi
  a1:	89 d8                	mov    %ebx,%eax
  a3:	99                   	cltd   
  a4:	f7 fe                	idiv   %esi
  a6:	89 45 e8             	mov    %eax,-0x18(%rbp)
  a9:	8b 45 e8             	mov    -0x18(%rbp),%eax
  ac:	89 c6                	mov    %eax,%esi
  ae:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # b5 <main+0x7d>
  b5:	b8 00 00 00 00       	mov    $0x0,%eax
  ba:	e8 00 00 00 00       	callq  bf <main+0x87>
  bf:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%rbp)
  c6:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  ca:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  ce:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  d2:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  d6:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  da:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  de:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  e2:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
  e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
  e9:	89 c6                	mov    %eax,%esi
  eb:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # f2 <main+0xba>
  f2:	b8 00 00 00 00       	mov    $0x0,%eax
  f7:	e8 00 00 00 00       	callq  fc <main+0xc4>
  fc:	b8 00 00 00 00       	mov    $0x0,%eax
 101:	48 83 c4 18          	add    $0x18,%rsp
 105:	5b                   	pop    %rbx
 106:	5d                   	pop    %rbp
 107:	c3                   	retq   
