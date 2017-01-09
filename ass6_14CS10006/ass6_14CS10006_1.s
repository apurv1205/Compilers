	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"***********************Some random outputs!!*************************\n"
.LC1:
	.string	"Passing pointers to function f!\n"
.LC2:
	.string	"Value passed to function: "
.LC3:
	.string	"\n"
.LC4:
	.string	"Value returned from function s is: "
.LC5:
	.string	"\n"
.LC6:
	.string	"Read an integer!!"
.LC7:
	.string	"\n"
.LC8:
	.string	"The integer that was read is:"
.LC9:
	.string	"\n"
	.text	
	.globl	f
	.type	f, @function
f: 
.LFB0:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$52, %rsp
	movq	%rdi, -20(%rbp)
	movl	-20(%rbp), %eax
	movl	(%eax),%eax
	movl 	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movl	$2, %eax
	movl 	%eax, -36(%rbp)
	movl 	-24(%rbp), %eax
	movl 	-36(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	movl 	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	f, .-f
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
	subq	$168, %rsp

	movq 	$.LC0, -40(%rbp)
	movl 	-40(%rbp), %eax
	movq 	-40(%rbp), %rdi
	call	prints
	movl	%eax, -44(%rbp)
	movl	$3, %eax
	movl 	%eax, -48(%rbp)
	movl	-48(%rbp), %eax
	movl 	%eax, -28(%rbp)
	leaq	-28(%rbp), %rax
	movq 	%rax, -56(%rbp)
	movl	-56(%rbp), %eax
	movl 	%eax, -32(%rbp)
	movq 	$.LC1, -64(%rbp)
	movl 	-64(%rbp), %eax
	movq 	-64(%rbp), %rdi
	call	prints
	movl	%eax, -68(%rbp)
	movq 	$.LC2, -72(%rbp)
	movl 	-72(%rbp), %eax
	movq 	-72(%rbp), %rdi
	call	prints
	movl	%eax, -76(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	printi
	movl	%eax, -84(%rbp)
	movq 	$.LC3, -88(%rbp)
	movl 	-88(%rbp), %eax
	movq 	-88(%rbp), %rdi
	call	prints
	movl	%eax, -92(%rbp)
	movq 	$.LC4, -96(%rbp)
	movl 	-96(%rbp), %eax
	movq 	-96(%rbp), %rdi
	call	prints
	movl	%eax, -100(%rbp)
	movl 	-24(%rbp), %eax
	movq 	-24(%rbp), %rdi
	call	printi
	movl	%eax, -104(%rbp)
	movq 	$.LC5, -108(%rbp)
	movl 	-108(%rbp), %eax
	movq 	-108(%rbp), %rdi
	call	prints
	movl	%eax, -112(%rbp)
	movq 	$.LC6, -116(%rbp)
	movl 	-116(%rbp), %eax
	movq 	-116(%rbp), %rdi
	call	prints
	movl	%eax, -120(%rbp)
	movq 	$.LC7, -124(%rbp)
	movl 	-124(%rbp), %eax
	movq 	-124(%rbp), %rdi
	call	prints
	movl	%eax, -128(%rbp)
	movl 	-32(%rbp), %eax
	movq 	-32(%rbp), %rdi
	call	readi
	movl	%eax, -136(%rbp)
	movl	-136(%rbp), %eax
	movl 	%eax, -28(%rbp)
	movq 	$.LC8, -144(%rbp)
	movl 	-144(%rbp), %eax
	movq 	-144(%rbp), %rdi
	call	prints
	movl	%eax, -148(%rbp)
	movl 	-28(%rbp), %eax
	movq 	-28(%rbp), %rdi
	call	printi
	movl	%eax, -152(%rbp)
	movq 	$.LC9, -156(%rbp)
	movl 	-156(%rbp), %eax
	movq 	-156(%rbp), %rdi
	call	prints
	movl	%eax, -160(%rbp)
	movl	$0, %eax
	movl 	%eax, -164(%rbp)
	movl	-164(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident		"Compiled by 14CS10006"
	.section	.note.GNU-stack,"",@progbits
