	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"abc\n"
.LC1:
	.string	"abcd"
.LC2:
	.string	"Please enter a number: "
.LC3:
	.string	"You Entered "
.LC4:
	.string	"\n"
	.text	
	.globl	main
	.type	main, @function
main: 
.LFB0:
	.cfi_startproc
	pushq 	%rbp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movq 	%rsp, %rbp
	.cfi_def_cfa_register 5
	subq	$130, %rsp

	movl	$5, %eax
	movl 	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	movl 	%eax, -20(%rbp)
	movl	$2, %eax
	movl 	%eax, -32(%rbp)
	movl	-32(%rbp), %eax
	movl 	%eax, -28(%rbp)
	movb	$0, -41(%rbp)
	movl	-41(%rbp), %eax
	movl 	%eax, -40(%rbp)
	movq 	$.LC0, -46(%rbp)
	movl	-46(%rbp), %eax
	movl 	%eax, -42(%rbp)
	movq 	$.LC1, -58(%rbp)
	movl	-58(%rbp), %eax
	movl 	%eax, -54(%rbp)
	movl	$5, %eax
	movl 	%eax, -70(%rbp)
	movl	-70(%rbp), %eax
	movl 	%eax, -66(%rbp)
	movl	-20(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl .L2
	jmp .L3
	jmp .L4
.L2: 
	movl	-20(%rbp), %eax
	movl 	%eax, -82(%rbp)
	addl 	$1, -20(%rbp)
	jmp .L4
.L3: 
	movl 	-20(%rbp), %eax
	movl 	-28(%rbp), %edx
	addl 	%edx, %eax
	movl 	%eax, -86(%rbp)
	movl	-86(%rbp), %eax
	movl 	%eax, -36(%rbp)
.L4: 
	movq 	$.LC2, -98(%rbp)
	movl 	-98(%rbp), %eax
	movq 	-98(%rbp), %rdi
	movq 	-98(%rbp), %rdi
call	prints
	movl	%eax, -102(%rbp)
	leaq	-78(%rbp), %rax
	movq 	%rax, -110(%rbp)
	movl 	-110(%rbp), %eax
	movq 	-110(%rbp), %rdi
	movq 	-110(%rbp), %rdi
call	readi
	movl	%eax, -114(%rbp)
	movl	-114(%rbp), %eax
	movl 	%eax, -66(%rbp)
	movq 	$.LC3, -122(%rbp)
	movl 	-122(%rbp), %eax
	movq 	-122(%rbp), %rdi
	movq 	-122(%rbp), %rdi
call	prints
	movl	%eax, -126(%rbp)
	movl 	-66(%rbp), %eax
	movq 	-66(%rbp), %rdi
	movq 	-66(%rbp), %rdi
call	printi
	movl	%eax, -134(%rbp)
	movl	-134(%rbp), %eax
	movl 	%eax, -36(%rbp)
	movq 	$.LC4, -142(%rbp)
	movl 	-142(%rbp), %eax
	movq 	-142(%rbp), %rdi
	movq 	-142(%rbp), %rdi
call	prints
	movl	%eax, -146(%rbp)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident		"Compiled by 14CS10006"
	.section	.note.GNU-stack,"",@progbits
