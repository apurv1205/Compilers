	.file	"test.c"
	.comm	a,4,4
	.globl	b
	.data
	.align 4
	.type	b, @object
	.size	b, 4
b:
	.long	1
	.globl	t00
	.data
	.align 4
	.type	t00, @object
	.size	t00, 4
t00:
	.long	1
	.comm	c,1,1
	.globl	d
	.type	d, @object
	.size	d, 1
d:
	.byte	0
	.globl	t01
	.type	t01, @object
	.size	t01, 1
t01:
	.byte	0
	.section	.rodata
.LC0:
	.string	"got into function\n"
.LC1:
	.string	"returning from function\n"
.LC2:
	.string	"Enter two numbers :\n"
.LC3:
	.string	"Sum is equal to "
.LC4:
	.string	"\n"
	.text	
	movl	$1, %eax
	movl 	%eax, 0(%rbp)
	movl	0(%rbp), %eax
	movl 	%eax, 0(%rbp)
	movb	$0, 0(%rbp)
	movl	0(%rbp), %eax
	movl 	%eax, 0(%rbp)
	.globl	add
	.type	add, @function
add: 
.LFB0:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$144, %rsp
	movq	%rdi, -20(%rbp)
	movq	%rsi, -16(%rbp)
	movl	$2, %eax
	movl 	%eax, -32(%rbp)
	movl	-32(%rbp), %eax
	movl 	%eax, -28(%rbp)
	movl	$10, %eax
	movl 	%eax, -80(%rbp)
	movq 	$.LC0, -92(%rbp)
	movl 	-92(%rbp), %eax
	movq 	-92(%rbp), %rdi
	call	prints
	movl	%eax, -96(%rbp)
	movl 	-20(%rbp), %eax
	movl 	-16(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -100(%rbp)
	movl	-100(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movl	$2, %eax
	movl 	%eax, -108(%rbp)
	movl	-108(%rbp), %eax
	movl 	%eax, -36(%rbp)
	movl	-20(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jge .L2
	jmp .L3
	jmp .L4
.L2: 
	movl	-20(%rbp), %eax
	movl 	%eax, -116(%rbp)
	addl 	$1, -20(%rbp)
	jmp .L4
.L3: 
	movl 	-20(%rbp), %eax
	movl 	-16(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -120(%rbp)
	movl	-120(%rbp), %eax
	movl 	%eax, -28(%rbp)
.L4: 
	movq 	$.LC1, -128(%rbp)
	movl 	-128(%rbp), %eax
	movq 	-128(%rbp), %rdi
	call	prints
	movl	%eax, -132(%rbp)
	movl	-24(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	add, .-add
	.globl	main
	.type	main, @function
main: 
.LFB1:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$176, %rsp

	movl	$2, %eax
	movl 	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movl	$10, %eax
	movl 	%eax, -76(%rbp)
	movq 	$.LC2, -104(%rbp)
	movl 	-104(%rbp), %eax
	movq 	-104(%rbp), %rdi
	call	prints
	movl	%eax, -108(%rbp)
	leaq	-96(%rbp), %rax
	movq 	%rax, -116(%rbp)
	movl 	-116(%rbp), %eax
	movq 	-116(%rbp), %rdi
	call	readi
	movl	%eax, -120(%rbp)
	movl	-120(%rbp), %eax
	movl 	%eax, -84(%rbp)
	leaq	-96(%rbp), %rax
	movq 	%rax, -128(%rbp)
	movl 	-128(%rbp), %eax
	movq 	-128(%rbp), %rdi
	call	readi
	movl	%eax, -132(%rbp)
	movl	-132(%rbp), %eax
	movl 	%eax, -88(%rbp)
	movl 	-84(%rbp), %eax
	movq 	-84(%rbp), %rdi
movl 	-88(%rbp), %eax
	movq 	-88(%rbp), %rsi
	call	add
	movl	%eax, -144(%rbp)
	movl	-144(%rbp), %eax
	movl 	%eax, -92(%rbp)
	movq 	$.LC3, -152(%rbp)
	movl 	-152(%rbp), %eax
	movq 	-152(%rbp), %rdi
	call	prints
	movl	%eax, -156(%rbp)
	movl 	-92(%rbp), %eax
	movq 	-92(%rbp), %rdi
	call	printi
	movl	%eax, -164(%rbp)
	movq 	$.LC4, -168(%rbp)
	movl 	-168(%rbp), %eax
	movq 	-168(%rbp), %rdi
	call	prints
	movl	%eax, -172(%rbp)
	movl	-24(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident		"Compiled by 14CS10006"
	.section	.note.GNU-stack,"",@progbits
