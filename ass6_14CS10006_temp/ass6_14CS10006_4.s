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
	.string	"Got into function\n"
.LC1:
	.string	"Returning from function\n"
.LC2:
	.string	"Enter two numbers to find their sum using a function call\n"
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
	subq	$180, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -12(%rbp)
	movq	%rdx, -12(%rbp)
	movl	$2, %eax
	movl 	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movl	$10, %eax
	movl 	%eax, -76(%rbp)
	movq 	$.LC0, -88(%rbp)
	movl 	-88(%rbp), %eax
	movq 	-88(%rbp), %rdi
	movq 	-88(%rbp), %rdi
call	prints
	movl	%eax, -92(%rbp)
	movl 	-16(%rbp), %eax
	movl 	-12(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -96(%rbp)
	movl	-96(%rbp), %eax
	movl 	%eax, -20(%rbp)
	movl	$2, %eax
	movl 	%eax, -104(%rbp)
	movl	-104(%rbp), %eax
	movl 	%eax, -32(%rbp)
	movl	-16(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jge .L2
	jmp .L3
	jmp .L4
.L2: 
	movl	-16(%rbp), %eax
	movl 	%eax, -112(%rbp)
	addl 	$1, -16(%rbp)
	jmp .L4
.L3: 
	movl 	-16(%rbp), %eax
	movl 	-12(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -116(%rbp)
	movl	-116(%rbp), %eax
	movl 	%eax, -24(%rbp)
.L4: 
	leaq	-24(%rbp), %rax
	movq 	%rax, -124(%rbp)
	movl	-124(%rbp), %eax
	movl 	%eax, -80(%rbp)
	movl	-80(%rbp), %eax
	movl	(%eax),%eax
	movl 	%eax, -132(%rbp)
	movl	-132(%rbp), %eax
	movl 	%eax, -12(%rbp)
	movl	-16(%rbp), %eax
	movl 	%eax, -140(%rbp)
	addl 	$1, -16(%rbp)
	movl	-80(%rbp), %eax
	movl	(%eax),%eax
	movl 	%eax, -144(%rbp)
	movl	-80(%rbp), %eax
	movl	-16(%rbp), %edx
	movl	%edx, (%eax)
	negl	-16(%rbp)
	movl	-148(%rbp), %eax
	movl 	%eax, -16(%rbp)
	movl	$2, %eax
	movl 	%eax, -156(%rbp)
	movl 	-156(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -160(%rbp)
	movq	-160(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, -36(%rbp,%rax,1)
	movl	$8, %eax
	movl 	%eax, -168(%rbp)
	movl 	-168(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -172(%rbp)
	movq	-172(%rbp), %rax
	movq	-36(%rbp,%rax,1), %rax
	movq 	%rax, -176(%rbp)
	movl	-176(%rbp), %eax
	movl 	%eax, -16(%rbp)
	movq 	$.LC1, -184(%rbp)
	movl 	-184(%rbp), %eax
	movq 	-184(%rbp), %rdi
	movq 	-184(%rbp), %rdi
call	prints
	movl	%eax, -188(%rbp)
	movl	-20(%rbp), %eax
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
	subq	$188, %rsp

	movl	$2, %eax
	movl 	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	movl 	%eax, -20(%rbp)
	movl	$10, %eax
	movl 	%eax, -72(%rbp)
	movq 	$.LC2, -100(%rbp)
	movl 	-100(%rbp), %eax
	movq 	-100(%rbp), %rdi
	movq 	-100(%rbp), %rdi
call	prints
	movl	%eax, -104(%rbp)
	leaq	-92(%rbp), %rax
	movq 	%rax, -112(%rbp)
	movl 	-112(%rbp), %eax
	movq 	-112(%rbp), %rdi
	movq 	-112(%rbp), %rdi
call	readi
	movl	%eax, -116(%rbp)
	movl	-116(%rbp), %eax
	movl 	%eax, -80(%rbp)
	leaq	-92(%rbp), %rax
	movq 	%rax, -124(%rbp)
	movl 	-124(%rbp), %eax
	movq 	-124(%rbp), %rdi
	movq 	-124(%rbp), %rdi
call	readi
	movl	%eax, -128(%rbp)
	movl	-128(%rbp), %eax
	movl 	%eax, -84(%rbp)
	movl 	-80(%rbp), %eax
	movq 	-80(%rbp), %rdi
	movq 	-80(%rbp), %rdi
movl 	-84(%rbp), %eax
	movq 	-84(%rbp), %rsi
movl 	-84(%rbp), %eax
	movq 	-84(%rbp), %rdx
call	add
	movl	%eax, -140(%rbp)
	movl	-140(%rbp), %eax
	movl 	%eax, -88(%rbp)
	movq 	$.LC3, -148(%rbp)
	movl 	-148(%rbp), %eax
	movq 	-148(%rbp), %rdi
	movq 	-148(%rbp), %rdi
call	prints
	movl	%eax, -152(%rbp)
	movl 	-88(%rbp), %eax
	movq 	-88(%rbp), %rdi
	movq 	-88(%rbp), %rdi
call	printi
	movl	%eax, -160(%rbp)
	movq 	$.LC4, -164(%rbp)
	movl 	-164(%rbp), %eax
	movq 	-164(%rbp), %rdi
	movq 	-164(%rbp), %rdi
call	prints
	movl	%eax, -168(%rbp)
	movl 	-28(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -172(%rbp)
	movq	-172(%rbp), %rax
	movq	-176(%rbp), %rdx
	movq	%rdx, -32(%rbp,%rax,1)
	movl	$2, %eax
	movl 	%eax, -184(%rbp)
	movl 	-184(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -188(%rbp)
	movq	-188(%rbp), %rax
	movq	-176(%rbp), %rdx
	movq	%rdx, -32(%rbp,%rax,1)
	movl 	-20(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -196(%rbp)
	movq	-196(%rbp), %rax
	movq	-32(%rbp,%rax,1), %rax
	movq 	%rax, -200(%rbp)
	movl	-200(%rbp), %eax
	movl 	%eax, -176(%rbp)
	movl	-20(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident		"Compiled by 14CS10006"
	.section	.note.GNU-stack,"",@progbits
