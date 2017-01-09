	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"\nEntered the function for i : "
.LC1:
	.string	"Hello World\n"
.LC2:
	.string	"abcd"
.LC3:
	.string	"Please enter a number for recursive fibonacci: "
.LC4:
	.string	"You Entered "
.LC5:
	.string	"\n"
.LC6:
	.string	"Now testting for recursive fibonacci number ....Entering the function\n"
.LC7:
	.string	"\n\nReturned from recursive fibonacci function"
	.text	
	.globl	fib
	.type	fib, @function
fib: 
.LFB0:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$120, %rsp
	movq	%rdi, -20(%rbp)
	movq 	$.LC0, -28(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	prints
	movl	%eax, -32(%rbp)
	movl 	-20(%rbp), %eax
	movq 	-20(%rbp), %rdi
	call	printi
	movl	%eax, -40(%rbp)
	movl	$1, %eax
	movl 	%eax, -48(%rbp)
	movl 	-20(%rbp), %eax
	movl 	-48(%rbp), %edx
	subl 	%edx, %eax
	movl 	%eax, -52(%rbp)
	movl	-52(%rbp), %eax
	movl 	%eax, -44(%rbp)
	movl	$0, %eax
	movl 	%eax, -64(%rbp)
	movl	-44(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jle .L2
	jmp .L3
	jmp .L4
.L2: 
	movl	$1, %eax
	movl 	%eax, -68(%rbp)
	movl	-68(%rbp), %eax
	jmp .L4
.L3: 
	movl 	-44(%rbp), %eax
	movq 	-44(%rbp), %rdi
	call	fib
	movl	%eax, -76(%rbp)
	movl	-76(%rbp), %eax
	movl 	%eax, -56(%rbp)
	movl	$1, %eax
	movl 	%eax, -84(%rbp)
	movl 	-44(%rbp), %eax
	movl 	-84(%rbp), %edx
	subl 	%edx, %eax
	movl 	%eax, -88(%rbp)
	movl	-88(%rbp), %eax
	movl 	%eax, -44(%rbp)
	movl 	-44(%rbp), %eax
	movq 	-44(%rbp), %rdi
	call	fib
	movl	%eax, -96(%rbp)
	movl	-96(%rbp), %eax
	movl 	%eax, -60(%rbp)
	movl 	-56(%rbp), %eax
	movl 	-60(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -104(%rbp)
	movl	-104(%rbp), %eax
	movl 	%eax, -56(%rbp)
	movl	-56(%rbp), %eax
.L4: 
	movl	$1, %eax
	movl 	%eax, -112(%rbp)
	movl	-112(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	fib, .-fib
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
	subq	$190, %rsp

	movl	$5, %eax
	movl 	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movl	$2, %eax
	movl 	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	movl 	%eax, -32(%rbp)
	movb	$0, -45(%rbp)
	movl	-45(%rbp), %eax
	movl 	%eax, -44(%rbp)
	movq 	$.LC1, -50(%rbp)
	movl	-50(%rbp), %eax
	movl 	%eax, -46(%rbp)
	movq 	$.LC2, -62(%rbp)
	movl	-62(%rbp), %eax
	movl 	%eax, -58(%rbp)
	movl	$5, %eax
	movl 	%eax, -74(%rbp)
	movl	-74(%rbp), %eax
	movl 	%eax, -70(%rbp)
	movl	-24(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jl .L7
	jmp .L8
	jmp .L9
.L7: 
	movl	-24(%rbp), %eax
	movl 	%eax, -86(%rbp)
	addl 	$1, -24(%rbp)
	jmp .L9
.L8: 
	movl 	-24(%rbp), %eax
	movl 	-32(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -90(%rbp)
	movl	-90(%rbp), %eax
	movl 	%eax, -40(%rbp)
.L9: 
	movq 	$.LC3, -102(%rbp)
	movl 	-102(%rbp), %eax
	movq 	-102(%rbp), %rdi
	call	prints
	movl	%eax, -106(%rbp)
	leaq	-82(%rbp), %rax
	movq 	%rax, -114(%rbp)
	movl 	-114(%rbp), %eax
	movq 	-114(%rbp), %rdi
	call	readi
	movl	%eax, -118(%rbp)
	movl	-118(%rbp), %eax
	movl 	%eax, -70(%rbp)
	movq 	$.LC4, -126(%rbp)
	movl 	-126(%rbp), %eax
	movq 	-126(%rbp), %rdi
	call	prints
	movl	%eax, -130(%rbp)
	movl 	-70(%rbp), %eax
	movq 	-70(%rbp), %rdi
	call	printi
	movl	%eax, -138(%rbp)
	movl	-138(%rbp), %eax
	movl 	%eax, -40(%rbp)
	movq 	$.LC5, -146(%rbp)
	movl 	-146(%rbp), %eax
	movq 	-146(%rbp), %rdi
	call	prints
	movl	%eax, -150(%rbp)
	movq 	$.LC6, -154(%rbp)
	movl 	-154(%rbp), %eax
	movq 	-154(%rbp), %rdi
	call	prints
	movl	%eax, -158(%rbp)
	movl	$0, %eax
	movl 	%eax, -166(%rbp)
	movl	-166(%rbp), %eax
	movl 	%eax, -162(%rbp)
	movl 	-70(%rbp), %eax
	movq 	-70(%rbp), %rdi
	call	fib
	movl	%eax, -174(%rbp)
	movl	-174(%rbp), %eax
	movl 	%eax, -162(%rbp)
	movq 	$.LC7, -182(%rbp)
	movl 	-182(%rbp), %eax
	movq 	-182(%rbp), %rdi
	call	prints
	movl	%eax, -186(%rbp)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident		"Compiled by 14CS10006"
	.section	.note.GNU-stack,"",@progbits
