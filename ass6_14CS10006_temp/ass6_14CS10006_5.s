	.file	"test.c"
	.section	.rodata
.LC0:
	.string	"Enter number of elements\n"
.LC1:
	.string	"Enter "
.LC2:
	.string	" integers\n"
.LC3:
	.string	"Sorted list in ascending order:\n"
.LC4:
	.string	"\n"
.LC5:
	.string	"Done.\n"
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
	subq	$676, %rsp

	movl	$100, %eax
	movl 	%eax, -420(%rbp)
	movq 	$.LC0, -448(%rbp)
	movl 	-448(%rbp), %eax
	movq 	-448(%rbp), %rdi
	movq 	-448(%rbp), %rdi
call	prints
	movl	%eax, -452(%rbp)
	leaq	-440(%rbp), %rax
	movq 	%rax, -460(%rbp)
	movl 	-460(%rbp), %eax
	movq 	-460(%rbp), %rdi
	movq 	-460(%rbp), %rdi
call	readi
	movl	%eax, -464(%rbp)
	movl	-464(%rbp), %eax
	movl 	%eax, -424(%rbp)
	movq 	$.LC1, -472(%rbp)
	movl 	-472(%rbp), %eax
	movq 	-472(%rbp), %rdi
	movq 	-472(%rbp), %rdi
call	prints
	movl	%eax, -476(%rbp)
	movl 	-424(%rbp), %eax
	movq 	-424(%rbp), %rdi
	movq 	-424(%rbp), %rdi
call	printi
	movl	%eax, -484(%rbp)
	movq 	$.LC2, -488(%rbp)
	movl 	-488(%rbp), %eax
	movq 	-488(%rbp), %rdi
	movq 	-488(%rbp), %rdi
call	prints
	movl	%eax, -492(%rbp)
	movl	$1, %eax
	movl 	%eax, -496(%rbp)
	movl	-496(%rbp), %eax
	movl 	%eax, -428(%rbp)
.L2: 
	movl	-428(%rbp), %eax
	cmpl	-424(%rbp), %eax
	jle .L4
	jmp .L5
.L3: 
	movl	-428(%rbp), %eax
	movl 	%eax, -504(%rbp)
	addl 	$1, -428(%rbp)
	jmp .L2
.L4: 
	movl	$1, %eax
	movl 	%eax, -508(%rbp)
	movl 	-428(%rbp), %eax
	movl 	-508(%rbp), %edx
	subl 	%edx, %eax
	movl 	%eax, -512(%rbp)
	movl 	-512(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -516(%rbp)
	leaq	-440(%rbp), %rax
	movq 	%rax, -520(%rbp)
	movl 	-520(%rbp), %eax
	movq 	-520(%rbp), %rdi
	movq 	-520(%rbp), %rdi
call	readi
	movl	%eax, -524(%rbp)
	movq	-516(%rbp), %rax
	movq	-524(%rbp), %rdx
	movq	%rdx, -20(%rbp,%rax,1)
	jmp .L3
.L5: 
	movl	$1, %eax
	movl 	%eax, -532(%rbp)
	movl	-532(%rbp), %eax
	movl 	%eax, -428(%rbp)
.L6: 
	movl	-428(%rbp), %eax
	cmpl	-424(%rbp), %eax
	jl .L8
	jmp .L14
.L7: 
	movl	-428(%rbp), %eax
	movl 	%eax, -540(%rbp)
	addl 	$1, -428(%rbp)
	jmp .L6
.L8: 
	movl	$1, %eax
	movl 	%eax, -544(%rbp)
	movl	-544(%rbp), %eax
	movl 	%eax, -432(%rbp)
.L9: 
	movl 	-424(%rbp), %eax
	movl 	-428(%rbp), %edx
	subl 	%edx, %eax
	movl 	%eax, -552(%rbp)
	movl	-432(%rbp), %eax
	cmpl	-552(%rbp), %eax
	jle .L11
	jmp .L7
.L10: 
	movl	-432(%rbp), %eax
	movl 	%eax, -556(%rbp)
	addl 	$1, -432(%rbp)
	jmp .L9
.L11: 
	movl	$1, %eax
	movl 	%eax, -560(%rbp)
	movl 	-432(%rbp), %eax
	movl 	-560(%rbp), %edx
	subl 	%edx, %eax
	movl 	%eax, -564(%rbp)
	movl 	-564(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -568(%rbp)
	movq	-568(%rbp), %rax
	movq	-20(%rbp,%rax,1), %rax
	movq 	%rax, -572(%rbp)
	movl 	-432(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -576(%rbp)
	movq	-576(%rbp), %rax
	movq	-20(%rbp,%rax,1), %rax
	movq 	%rax, -580(%rbp)
	movl	-572(%rbp), %eax
	cmpl	-580(%rbp), %eax
	jg .L12
	jmp .L10
	jmp .L13
.L12: 
	movl	$1, %eax
	movl 	%eax, -584(%rbp)
	movl 	-432(%rbp), %eax
	movl 	-584(%rbp), %edx
	subl 	%edx, %eax
	movl 	%eax, -588(%rbp)
	movl 	-588(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -592(%rbp)
	movq	-592(%rbp), %rax
	movq	-20(%rbp,%rax,1), %rax
	movq 	%rax, -596(%rbp)
	movl	-596(%rbp), %eax
	movl 	%eax, -436(%rbp)
	movl	$1, %eax
	movl 	%eax, -604(%rbp)
	movl 	-432(%rbp), %eax
	movl 	-604(%rbp), %edx
	subl 	%edx, %eax
	movl 	%eax, -608(%rbp)
	movl 	-608(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -612(%rbp)
	movl 	-432(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -616(%rbp)
	movq	-616(%rbp), %rax
	movq	-20(%rbp,%rax,1), %rax
	movq 	%rax, -620(%rbp)
	movq	-612(%rbp), %rax
	movq	-620(%rbp), %rdx
	movq	%rdx, -20(%rbp,%rax,1)
	movl 	-432(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -628(%rbp)
	movq	-628(%rbp), %rax
	movq	-436(%rbp), %rdx
	movq	%rdx, -20(%rbp,%rax,1)
	jmp .L10
.L13: 
	jmp .L10
	jmp .L7
.L14: 
	movq 	$.LC3, -636(%rbp)
	movl 	-636(%rbp), %eax
	movq 	-636(%rbp), %rdi
	movq 	-636(%rbp), %rdi
call	prints
	movl	%eax, -640(%rbp)
	movl	$1, %eax
	movl 	%eax, -644(%rbp)
	movl	-644(%rbp), %eax
	movl 	%eax, -428(%rbp)
.L15: 
	movl	-428(%rbp), %eax
	cmpl	-424(%rbp), %eax
	jle .L17
	jmp .L18
.L16: 
	movl	-428(%rbp), %eax
	movl 	%eax, -652(%rbp)
	addl 	$1, -428(%rbp)
	jmp .L15
.L17: 
	movl	$1, %eax
	movl 	%eax, -656(%rbp)
	movl 	-428(%rbp), %eax
	movl 	-656(%rbp), %edx
	subl 	%edx, %eax
	movl 	%eax, -660(%rbp)
	movl 	-660(%rbp), %eax
	imull 	$4, %eax
	movl 	%eax, -664(%rbp)
	movq	-664(%rbp), %rax
	movq	-20(%rbp,%rax,1), %rax
	movq 	%rax, -668(%rbp)
	movl 	-668(%rbp), %eax
	movq 	-668(%rbp), %rdi
	movq 	-668(%rbp), %rdi
call	printi
	movl	%eax, -672(%rbp)
	movq 	$.LC4, -676(%rbp)
	movl 	-676(%rbp), %eax
	movq 	-676(%rbp), %rdi
	movq 	-676(%rbp), %rdi
call	prints
	movl	%eax, -680(%rbp)
	jmp .L16
.L18: 
	movq 	$.LC5, -684(%rbp)
	movl 	-684(%rbp), %eax
	movq 	-684(%rbp), %rdi
	movq 	-684(%rbp), %rdi
call	prints
	movl	%eax, -688(%rbp)
	movl	$0, %eax
	movl 	%eax, -692(%rbp)
	movl	-692(%rbp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident		"Compiled by 14CS10006"
	.section	.note.GNU-stack,"",@progbits
