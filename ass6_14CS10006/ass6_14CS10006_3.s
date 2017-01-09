	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"Entered the fib function\n"
.LC1:
	.string	"\nThe fibonacci number is : "
.LC2:
	.string	"enter the i for finding its fibonacci number : "
.LC3:
	.string	"\n\nYou Entered : "
.LC4:
	.string	"\nNow, entering the function to calculate fibonacci numbers for i entered\n"
.LC5:
	.string	"\n\nReturned from the fib function\n\n"
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
	subq	$112, %rsp
	movq	%rdi, -20(%rbp)
	movq 	$.LC0, -28(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	prints
	movl	%eax, -32(%rbp)
	movl	$1, %eax
	movl 	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	movl 	%eax, -36(%rbp)
	movl	$0, %eax
	movl 	%eax, -48(%rbp)
	movl	-48(%rbp), %eax
	movl 	%eax, -44(%rbp)
	movl	$1, %eax
	movl 	%eax, -56(%rbp)
	movl	-56(%rbp), %eax
	movl 	%eax, -52(%rbp)
.L2: 
	movl	-52(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl .L3
	jmp .L4
.L3: 
	movl	-36(%rbp), %eax
	movl 	%eax, -60(%rbp)
	movl 	-36(%rbp), %eax
	movl 	-44(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -68(%rbp)
	movl	-68(%rbp), %eax
	movl 	%eax, -36(%rbp)
	movl	-60(%rbp), %eax
	movl 	%eax, -44(%rbp)
	movl	$1, %eax
	movl 	%eax, -80(%rbp)
	movl 	-52(%rbp), %eax
	movl 	-80(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	movl 	%eax, -52(%rbp)
	jmp .L2
.L4: 
	movq 	$.LC1, -92(%rbp)
	movl 	-92(%rbp), %eax
	movq 	-92(%rbp), %rdi
	call	prints
	movl	%eax, -96(%rbp)
	movl 	-36(%rbp), %eax
	movq 	-36(%rbp), %rdi
	call	printi
	movl	%eax, -104(%rbp)
	movl	-36(%rbp), %eax
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
	subq	$108, %rsp

	movq 	$.LC2, -28(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	prints
	movl	%eax, -32(%rbp)
	leaq	-40(%rbp), %rax
	movq 	%rax, -48(%rbp)
	movl 	-48(%rbp), %eax
	movq 	-48(%rbp), %rdi
	call	readi
	movl	%eax, -52(%rbp)
	movl	-52(%rbp), %eax
	movl 	%eax, -36(%rbp)
	movq 	$.LC3, -60(%rbp)
	movl 	-60(%rbp), %eax
	movq 	-60(%rbp), %rdi
	call	prints
	movl	%eax, -64(%rbp)
	movl 	-36(%rbp), %eax
	movq 	-36(%rbp), %rdi
	call	printi
	movl	%eax, -72(%rbp)
	movq 	$.LC4, -76(%rbp)
	movl 	-76(%rbp), %eax
	movq 	-76(%rbp), %rdi
	call	prints
	movl	%eax, -80(%rbp)
	movl 	-36(%rbp), %eax
	movq 	-36(%rbp), %rdi
	call	fib
	movl	%eax, -92(%rbp)
	movl	-92(%rbp), %eax
	movl 	%eax, -84(%rbp)
	movq 	$.LC5, -100(%rbp)
	movl 	-100(%rbp), %eax
	movq 	-100(%rbp), %rdi
	call	prints
	movl	%eax, -104(%rbp)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident		"Compiled by 14CS10006"
	.section	.note.GNU-stack,"",@progbits
