	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"\n\nEntered the function \n"
.LC1:
	.string	"Value to be returned is : "
.LC2:
	.string	"Entering the function inc... \n"
.LC3:
	.string	"\n\nThe value returned from the function is \n"
.LC4:
	.string	"\n"
	.text	
	.globl	inc
	.type	inc, @function
inc: 
.LFB0:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$76, %rsp
	movq	%rdi, -20(%rbp)
	movq	%rsi, -16(%rbp)
	movq 	$.LC0, -28(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	prints
	movl	%eax, -32(%rbp)
	movl	$5, %eax
	movl 	%eax, -36(%rbp)
	movl 	-16(%rbp), %eax
	movl 	-36(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -40(%rbp)
	movl 	-40(%rbp), %eax
	movl 	-20(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -44(%rbp)
	movl	-44(%rbp), %eax
	movl 	%eax, -16(%rbp)
	movq 	$.LC1, -52(%rbp)
	movl 	-52(%rbp), %eax
	movq 	-52(%rbp), %rdi
	call	prints
	movl	%eax, -56(%rbp)
	movl 	-16(%rbp), %eax
	movq 	-16(%rbp), %rdi
	call	printi
	movl	%eax, -64(%rbp)
	movl	-16(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	inc, .-inc
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
	subq	$96, %rsp

	movl	$10, %eax
	movl 	%eax, -32(%rbp)
	movl	-32(%rbp), %eax
	movl 	%eax, -28(%rbp)
	movl	$1, %eax
	movl 	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movq 	$.LC2, -48(%rbp)
	movl 	-48(%rbp), %eax
	movq 	-48(%rbp), %rdi
	call	prints
	movl	%eax, -52(%rbp)
	movl 	-24(%rbp), %eax
	movq 	-24(%rbp), %rdi
movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rsi
	call	inc
	movl	%eax, -60(%rbp)
	movl	-60(%rbp), %eax
	movl 	%eax, -28(%rbp)
	movq 	$.LC3, -68(%rbp)
	movl 	-68(%rbp), %eax
	movq 	-68(%rbp), %rdi
	call	prints
	movl	%eax, -72(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	printi
	movl	%eax, -80(%rbp)
	movq 	$.LC4, -84(%rbp)
	movl 	-84(%rbp), %eax
	movq 	-84(%rbp), %rdi
	call	prints
	movl	%eax, -88(%rbp)
	movl	$0, %eax
	movl 	%eax, -92(%rbp)
	movl	-92(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident		"Compiled by 14CS10006"
	.section	.note.GNU-stack,"",@progbits
