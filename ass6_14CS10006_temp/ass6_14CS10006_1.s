	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"HELLO\n"
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
	subq	$24, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -12(%rbp)
	movq	%rdx, -12(%rbp)
	movl	$5, %eax
	movl 	%eax, -20(%rbp)
	movl 	-12(%rbp), %eax
	movl 	-20(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -24(%rbp)
	movl 	-24(%rbp), %eax
	movl 	-16(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl 	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
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
	subq	$56, %rsp

	movl	$10, %eax
	movl 	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movl	$1, %eax
	movl 	%eax, -32(%rbp)
	movl	-32(%rbp), %eax
	movl 	%eax, -20(%rbp)
	movq 	$.LC0, -44(%rbp)
	movl 	-44(%rbp), %eax
	movq 	-44(%rbp), %rdi
	movq 	-44(%rbp), %rdi
call	prints
	movl	%eax, -48(%rbp)
	movl 	-20(%rbp), %eax
	movq 	-20(%rbp), %rdi
	movq 	-20(%rbp), %rdi
movl 	-24(%rbp), %eax
	movq 	-24(%rbp), %rsi
movl 	-24(%rbp), %eax
	movq 	-24(%rbp), %rdx
call	inc
	movl	%eax, -56(%rbp)
	movl	-56(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movl 	-24(%rbp), %eax
	movq 	-24(%rbp), %rdi
	movq 	-24(%rbp), %rdi
call	printi
	movl	%eax, -68(%rbp)
	movl	$0, %eax
	movl 	%eax, -72(%rbp)
	movl	-72(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident		"Compiled by 14CS10006"
	.section	.note.GNU-stack,"",@progbits
