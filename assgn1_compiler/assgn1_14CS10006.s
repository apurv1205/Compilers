	.file	"assgn1_14CS10006.c"									#Source filename
	.section	.rodata                  							#read-only data section
	.align 8														#align with 8 bit boundary
.LC0:																#label of f-string - 1st printf
	.string	"Enter how many elements you want:"
.LC1:																#label of f-string - 1st scanf
	.string	"%d"
.LC2:																#label of f-string - 2nd scanf
	.string	"Enter the %d elements:\n"
.LC3:																#label of f-string - 2nd printf
	.string	"\nEnter the item to search"
.LC4:																#label of f-string - 3rd printf
	.string	"\n%d found in position: %d\n"
.LC5:																#label of f-string - 4th printf									
	.string	"\n%d inserted in position: %d\n"
.LC6:																#label of f-string - 5th printf
	.string	"The list of %d elements:\n"
.LC7:																#label of f-string - 6th printf
	.string	"%6d"
	.text															#code starts
	.globl	main													#main is a global name
	.type	main, @function											#main is a function
main:																#main starts
.LFB0:
	.cfi_startproc													#Call Frame Information
	pushq	%rbp													#save old base pointer
	.cfi_def_cfa_offset 16											#cfi directives
	.cfi_offset 6, -16												#cfi directives
	movq	%rsp, %rbp												#rbp <-- rsp (set new stack base pointer)
	.cfi_def_cfa_register 6											#cfi directive
	subq	$416, %rsp												#create space for local arrays and variables (in rsp)
	movl	$.LC0, %edi												#edi <-- 1st parameter for 1st printf, fstring
	call	puts													#calls puts for printf
	leaq	-416(%rbp), %rax										#rax <-- (rbp-416) (&n)(rax points to &n)
	movq	%rax, %rsi												#rsi <-- rax (rsi <-- &n) (2nd parameter)
	movl	$.LC1, %edi												#edi <-- 1st parameter for 1st scanf, fstring
	movl	$0, %eax												#eax <-- 0 
	call	__isoc99_scanf											#calls scanf, return value is stored in M[rbp-416] (n)
	movl	-416(%rbp), %eax										#eax <-- M[rbp-416] (n)
	movl	%eax, %esi												#esi <-- eax (n) (2nd parameter)
	movl	$.LC2, %edi												#edi <-- 1st parameter of 2nd printf, fstring
	movl	$0, %eax												#eax <-- 0 
	call	printf													#calls printf
	movl	$0, -408(%rbp)											#M[rbp-408] <-- 0 (i=0)
	jmp	.L2															#go to the beginning of for loop
.L3:
	leaq	-400(%rbp), %rax										#rax <-- (rbp-400) (&a)
	movl	-408(%rbp), %edx										#edx <-- M[rbp-408] (i)
	movslq	%edx, %rdx												#rdx <-- edx (32 bits to sign ext. 64 bits) 
	salq	$2, %rdx												#rdx <-- shift arithmetic by 2 bits (i*4)
	addq	%rdx, %rax												#rax <-- rdx+rax (rax <-- &a+4*i=a[i])
	movq	%rax, %rsi												#rsi <-- rax (a[i]) (2nd parameter)
	movl	$.LC1, %edi												#edi <-- 1st parameter for 1st scanf, fstring
	movl	$0, %eax												#eax <-- 0 
	call	__isoc99_scanf											#calls scanf (return value stored in &a[i])
	addl	$1, -408(%rbp)											#M[rbp-408]=1+M[rbp-408] (i++)
.L2:
	movl	-416(%rbp), %eax										#eax <-- M[rbp-416] (n)
	cmpl	%eax, -408(%rbp)										#if M[rbp-408] < eax, (i<n)
	jl	.L3															#jump less than, to .L3 part				
	movl	-416(%rbp), %edx										#edx <-- M[rbp-416] (n)
	leaq	-400(%rbp), %rax										#rax <-- (rbp-400) (&a)
	movl	%edx, %esi												#esi <-- edx (n) (2nd parameter)
	movq	%rax, %rdi												#rdi <-- rax (&a) (1st parameter)
	call	inst_sort												#calls inst_sort
	movl	$.LC3, %edi												#edi <-- 1st parameter for 2nd printf, fstring
	call	puts													#calls puts for printf
	leaq	-412(%rbp), %rax										#rax <-- (rbp-412) (&item)
	movq	%rax, %rsi												#rsi <-- rax (2nd parameter)
	movl	$.LC1, %edi												#edi <-- 1st parameter for 1st scanf, fstring
	movl	$0, %eax												#eax <-- 0 
	call	__isoc99_scanf											#calls scanf (return value stored in &item)
	movl	-412(%rbp), %edx										#edx <-- M[rbp-412] (item) (3rd parameter)
	movl	-416(%rbp), %ecx										#ecx <-- M[rbp-416] (n)
	leaq	-400(%rbp), %rax										#rax <-- (rbp-400) (&a)
	movl	%ecx, %esi												#esi <-- ecx (n) (2nd parameter)
	movq	%rax, %rdi												#rdi <-- rax (&a) (1st parameter)
	call	bsearch													#calls bsearch
	movl	%eax, -404(%rbp)										#M[rbp-404] <-- eax (bsearch returns eax which is entered in loc)
	movl	-404(%rbp), %eax										#eax <-- M[rbp-404] (loc)
	cltq															#32 bits to sign ext. 64 bits 
	movl	-400(%rbp,%rax,4), %edx									#edx <-- M[rbp-400+4*rax] (a[loc])
	movl	-412(%rbp), %eax										#eax <-- M[rbp-412] (item)
	cmpl	%eax, %edx												#compare eax and edx (item and a[loc])
	jne	.L4															#if not equal, jump to .L4
	movl	-404(%rbp), %eax										#eax <-- M[rbp-404] (loc)
	leal	1(%rax), %edx											#edx <-- (rax+1) (loc+1)(3rd arguement)
	movl	-412(%rbp), %eax										#eax <-- M[rbp-412]
	movl	%eax, %esi												#esi <-- eax (2nd parameter)
	movl	$.LC4, %edi												#edi <-- 1st parameter for 3rd printf, fstring
	movl	$0, %eax												#eax <-- 0
	call	printf													#printf is called
	jmp	.L5															#jump to part .L5
.L4:
	movl	-412(%rbp), %edx										#edx <-- M[rbp-412] (item) (3rd parameter)
	movl	-416(%rbp), %ecx										#ecx <-- M[rbp-416] (n)
	leaq	-400(%rbp), %rax										#rax <-- (rbp-400) (&a)
	movl	%ecx, %esi												#esi <-- ecx (2nd paraeter) (n)
	movq	%rax, %rdi												#rdi <-- rax (1st parameter) (&a)
	call	insert													#calls insert
	movl	%eax, -404(%rbp)										#M[rbp-404] <-- eax, returned value is stored in loc
	movl	-416(%rbp), %eax										#eax <-- M[rbp-416] (n)
	addl	$1, %eax												#eax <-- eax+1 (n+1)
	movl	%eax, -416(%rbp)										#M[rbp-416] <-- eax (n=n+1)
	movl	-404(%rbp), %eax										#eax <-- M[rbp-404] (loc)
	leal	1(%rax), %edx											#edx <-- (rax+1) (loc+1)(3rd arguement)
	movl	-412(%rbp), %eax										#eax <-- M[rbp-412] (item)
	movl	%eax, %esi												#esi <-- eax (2nd parameter)
	movl	$.LC5, %edi												#edi <-- 1st parameter for 4th printf, fstring
	movl	$0, %eax												#eax <-- 0
	call	printf													#printf is called
.L5:
	movl	-416(%rbp), %eax										#eax <-- M[rbp-416] (n)
	movl	%eax, %esi												#esi <-- eax (2nd parameter)
	movl	$.LC6, %edi												#edi <-- 1st parameter for 5th printf, fstring
	movl	$0, %eax												#eax <-- 0
	call	printf													#printf is called
	movl	$0, -408(%rbp)											#M[rbp-408] <-- 0 (i=0)
	jmp	.L6															#jump to part .L6
.L7:	
	movl	-408(%rbp), %eax										#eax <-- M[rbp-408] (i)		
	cltq															#32 bits to sign ext. 64 bits 
	movl	-400(%rbp,%rax,4), %eax									#eax <-- M[rbp-400+4*rax] (a[i])
	movl	%eax, %esi												#esi <--eax (2nd parameter)
	movl	$.LC7, %edi												#edi <-- 1st parameter for 6th printf, fstring
	movl	$0, %eax												#eax <-- 0
	call	printf													#printf is called
	addl	$1, -408(%rbp)											#M[rbp-408] <-- 1+M[rbp-408] (i=i+1)
.L6:
	movl	-416(%rbp), %eax										#eax <-- M[rbp-416] (n)
	cmpl	%eax, -408(%rbp)										#compare eax and M[rbp-408] (n and i)
	jl	.L7															#if less than, then jump to L7 (i<n)
	movl	$10, %edi												#edi <-- 10 (1st parameter)
	call	putchar													#ptchar is called
	movl	$0, %eax												#eax <-- 0
	leave															#remove stack frame
	.cfi_def_cfa 7, 8												#cfi directive
	ret 															#return
	.cfi_endproc													#cfi directive
.LFE0:
	.size	main, .-main
	.globl	inst_sort												#inst_sort is a global name
	.type	inst_sort, @function									#inst_sort is a function
inst_sort:
.LFB1:
	.cfi_startproc													#cfi directives
	pushq	%rbp                           							#save old base pointer
	.cfi_def_cfa_offset 16 											#cfi directives
	.cfi_offset 6, -16 												#cfi directives
	movq	%rsp, %rbp 												#rsp <-- rbp set new stack base pointer
	.cfi_def_cfa_register 6 										#cfi directives
	movq	%rdi, -24(%rbp) 										#M[rbp-24] <-- rdi (&num)
	movl	%esi, -28(%rbp)											#M[rbp-28] <-- esi (n)
	movl	$1, -8(%rbp) 											#M[rbp-8] <-- 1 (j=1)
	jmp	.L10														#jump to part .L10
.L14:
	movl	-8(%rbp), %eax											#eax <-- M[rbp-8] (j)
	cltq															#32 bits to sign ext. 64 bits 
	leaq	0(,%rax,4), %rdx										#rdx <-- M[4*rax]
	movq	-24(%rbp), %rax											#rax <-- M[rbp-24] (&num)
	addq	%rdx, %rax												#rax <-- rdx + rax (&num + 4*j=num[j])
	movl	(%rax), %eax											#eax <-- (rax) (&j)
	movl	%eax, -4(%rbp)											#M[rbp-4] <-- eax (k=num[j])
	movl	-8(%rbp), %eax											#eax <-- M[rbp-8] (j)
	subl	$1, %eax												#make space of 1 byte for eax 
	movl	%eax, -12(%rbp)											#eax is allocated memory
	jmp	.L11														#jump to part .L11
.L13:
	movl	-12(%rbp), %eax											#eax <-- M[rbp-12] (i)
	cltq															#32 bits to sign ext. 64 bits 
	addq	$1, %rax												#rax <-- 1+rax (i=i+1)
	leaq	0(,%rax,4), %rdx										#rdx <-- M[4*rax] 
	movq	-24(%rbp), %rax											#rax <-- M[rbp-24] (&num)
	addq	%rax, %rdx												#rdx <-- rax + rdx (&num + 4*i=num[i])
	movl	-12(%rbp), %eax											#eax <-- M[rbp-12] (i)
	cltq															#32 bits to sign ext. 64 bits
	leaq	0(,%rax,4), %rcx										#rcx <-- M[4*rax]
	movq	-24(%rbp), %rax											#rax <-- M[rbp-24] (&num)
	addq	%rcx, %rax												#rax <-- rax + rcx (&num + 4*i=num[i])
	movl	(%rax), %eax											#eax <-- (rax) (num[i])
	movl	%eax, (%rdx)											#(rdx) <-- eax
	subl	$1, -12(%rbp)											#make space of 1 byte for M[rbp-12] 
.L11:
	cmpl	$0, -12(%rbp)											#compare 0 and M[rbp-12] (i>=0)
	js	.L12														# jump sign to part .L12
	movl	-12(%rbp), %eax											#eax <-- M[rbp-12] (i)
	cltq															#32 bits to sign ext. 64 bits
	leaq	0(,%rax,4), %rdx										#rdx <-- M[rax*4]
	movq	-24(%rbp), %rax											#rax <-- M[rbp-24] (&num)
	addq	%rdx, %rax												#rax <-- rax + rdx (&num + 4*i=num[i])
	movl	(%rax), %eax											#eax <-- (rax) num[i]
	cmpl	-4(%rbp), %eax											#compare eax and M[rbp-4] (k and num[i])
	jg	.L13														#if greater than then jump to part .L13
.L12:
	movl	-12(%rbp), %eax											#eax <-- M[rbp-12] (i)
	cltq															#32 bits to sign ext. 64 bits
	addq	$1, %rax												#rax <-- rax+1 (i=i+1)
	leaq	0(,%rax,4), %rdx										#rdx <-- M[rax*4] 
	movq	-24(%rbp), %rax											#rax <-- M[rbp-24] (&num + 4*j=num[i])
	addq	%rax, %rdx												#rdx <-- rax		
	movl	-4(%rbp), %eax											#eax <-- M[rbp-4] (num[i+1]=k)
	movl	%eax, (%rdx)											#(rdx) <-- eax (num[i]=num[i+1])
	addl	$1, -8(%rbp)											#M[rbp-8] <-- M[rbp-8] + 1 (j=j+1)
.L10:
	movl	-8(%rbp), %eax											#eax <-- M[rbp-8] (j)
	cmpl	-28(%rbp), %eax											#compare eax and M[rbp-28] (j < n)
	jl	.L14														#if less than then jump to part .L14
	popq	%rbp 													#removing the stack base pointer (memory register) at the end of a function
	.cfi_def_cfa 7, 8												#cfi directive	
	ret 															#return
	.cfi_endproc 													#cfi directive
.LFE1:
	.size	inst_sort, .-inst_sort
	.globl	bsearch 												#bsearch is a global name
	.type	bsearch, @function										#bsearch is a function
bsearch:
.LFB2:
	.cfi_startproc													#cfi directive
	pushq	%rbp 													#save old base pointer
	.cfi_def_cfa_offset 16											#cfi directive
	.cfi_offset 6, -16												#cfi directive
	movq	%rsp, %rbp 												#rbp <-- rsp
	.cfi_def_cfa_register 6											#cfi directive
	movq	%rdi, -24(%rbp)											#M[rbp-24] <-- rdi (a)
	movl	%esi, -28(%rbp)											#M[rbp-28] <-- esi (n)
	movl	%edx, -32(%rbp) 										#M[rbp-32] <-- edx (item)
	movl	$1, -8(%rbp)											#M[rbp-8] <-- 1 (bottom = 1)
	movl	-28(%rbp), %eax											#eax <-- <[rbp-28] (n)
	movl	%eax, -12(%rbp)											#M[rbp-12] <-- eax (top = n)
.L19:
	movl	-12(%rbp), %eax 										#eax <-- M[rbp-12] (top)
	movl	-8(%rbp), %edx											#edx <-- M[rbp-8] (bottom)
	addl	%edx, %eax												#eax <-- edx + eax (top=top+bottom)
	movl	%eax, %edx												#edx <-- eax (bottom = top+bottom)
	shrl	$31, %edx												#edx right shifted by 31 bits (divided by 2^31)
	addl	%edx, %eax												#eax <-- eax + edx
	sarl	%eax													#(eax = top/2 + bottom/2)
	movl	%eax, -4(%rbp)											#M[rbp-4] < -- eax (mid = (top+bottom)/2)
	movl	-4(%rbp), %eax											#eax <-- M[rbp-4] (mid)
	cltq															#32 bits to sign ext. 64 bits
	leaq	0(,%rax,4), %rdx										#rdx <-- (4*rax) 
	movq	-24(%rbp), %rax											#rax <-- M[rbp-24] (&a)
	addq	%rdx, %rax												#rax <-- rdx + rax (&a + 4*mid=a[mid])
	movl	(%rax), %eax											#eax <-- (rax) (mid])
	cmpl	-32(%rbp), %eax											#compare eax and M[rbp-32] (item and a[mid])
	jle	.L16														#if larger than or equal to jump to part .L16
	movl	-4(%rbp), %eax											#eax <-- M[rbp-4] (mid )
	subl	$1, %eax												#allocate memory of size 1 bit for eax
	movl	%eax, -12(%rbp)											#M[rbp-12] --> eax (top)
	jmp	.L17														#jump to part .L17
.L16:
	movl	-4(%rbp), %eax											#eax <-- M[rbp-4] (mid)
	cltq															#32 bits to sign ext. 64 bits	
	leaq	0(,%rax,4), %rdx										#rdx <-- (4*rax) 
	movq	-24(%rbp), %rax											#rax <-- M[rbp-24] (&a)
	addq	%rdx, %rax												#rax <-- rdx + rax (&a+4*mid=a[mid])
	movl	(%rax), %eax											#eax <-- (rax) (a[mid])
	cmpl	-32(%rbp), %eax											#compare M[rbp-32] and eax (a[mid] and item)
	jge	.L17														#if greater than or equal to, jump to part .L17
	movl	-4(%rbp), %eax											#eax <-- M[rbp-4] (mid)
	addl	$1, %eax												#eax <-- eax + 1 (mid=mid+1)
	movl	%eax, -8(%rbp)											#M[rbp-8] <-- eax (bottom=mid)
.L17:
	movl	-4(%rbp), %eax											#eax <-- M[rbp-4] (mid)
	cltq															#32 bits to sign ext. 64 bits
	leaq	0(,%rax,4), %rdx										#rdx <-- (4*rax) 
	movq	-24(%rbp), %rax											#rax <-- M[rbp-24] (&a)
	addq	%rdx, %rax												#rax <-- rax + rdx (&a+4*mid=a[mid])
	movl	(%rax), %eax											#eax <-- (rax) (a[mid])
	cmpl	-32(%rbp), %eax											#compare eax and M[rbp-32] (a[mid] and item)
	je	.L18														#if equal, jump to part .L18
	movl	-8(%rbp), %eax											#eax <-- M[rbp-8] (bottom)
	cmpl	-12(%rbp), %eax											#compare eax and M[rbp-12] (bottom and top)
	jle	.L19														#if less than or equal to, jump to part .L19
.L18:
	movl	-4(%rbp), %eax											#eax <-- M[rbp-4] (mid)
	popq	%rbp 													#remove base stack pointer, free the register
	.cfi_def_cfa 7, 8												#cfi directive
	ret 															#return
	.cfi_endproc 													#cfi directive
.LFE2:
	.size	bsearch, .-bsearch
	.globl	insert 													#insert is a global name
	.type	insert, @function 										#insert is a function
insert:
.LFB3:
	.cfi_startproc 													#cfi directive
	pushq	%rbp 													#save old base pointer
	.cfi_def_cfa_offset 16 											#cfi directive
	.cfi_offset 6, -16 												#cfi directive
	movq	%rsp, %rbp 												#rbp <-- rsp
	.cfi_def_cfa_register 6 										#cfi directive
	movq	%rdi, -24(%rbp) 										#M[rbp-24] <-- rdi (&num)
	movl	%esi, -28(%rbp) 										#M[rbp-28] <-- esi (n)
	movl	%edx, -32(%rbp) 										#M[rbp-32] <-- edx (k)
	movl	-28(%rbp), %eax 										#eax <-- M[rbp-28] (n)
	subl	$1, %eax 												#eax is allocated a memory of size 1
	movl	%eax, -4(%rbp)											#M[rbp-4] <-- eax (i)							
	jmp	.L22														#jump to .L22
.L24:
	movl	-4(%rbp), %eax											#eax <-- M[rbp-4] (i)
	cltq 															#32 bits to sign ext. 64 bits
	addq	$1, %rax 												#rax <-- rax + 1 (i=i+1)
	leaq	0(,%rax,4), %rdx 										#rdx <-- (rax*4)
	movq	-24(%rbp), %rax 										#rax <-- M[rbp-24] (&num)
	addq	%rax, %rdx 												#rdx <-- rax
	movl	-4(%rbp), %eax 											#eax <-- M[rbp-4] (i)
	cltq 															#32 bits to sign ext. 64 bits
	leaq	0(,%rax,4), %rcx 										#rcx <-- (rax*4)
	movq	-24(%rbp), %rax 										#rax <-- M[rbp-24]
	addq	%rcx, %rax 												#rax <-- rax + rcx (&num + 4*i=num[i])
	movl	(%rax), %eax 											#eax <-- (rax)
	movl	%eax, (%rdx) 											#(rdx) <-- eax (num[i+1]=num[i])
	subl	$1, -4(%rbp) 											#M[rbp-4] is allocated a memory of size 1 bit
.L22:
	cmpl	$0, -4(%rbp) 											#compare 0 and M[rbp-4] (i<=0)
	js	.L23 														#jump sign, if smaller, jump to part .L23
	movl	-4(%rbp), %eax											#eax <-- M[rbp-4] (i)
	cltq                       										#32 bits to sign ext. 64 bits
	leaq	0(,%rax,4), %rdx 										#rdx <-- (4*rax)
	movq	-24(%rbp), %rax											#rax <-- M[rbp-24] (&num)
	addq	%rdx, %rax 												#rax <-- rax + rdx (&num + 4*i=num[i])
	movl	(%rax), %eax											#eax <-- (rax) (num[i])
	cmpl	-32(%rbp), %eax											#compare eax and M[rbp-32] (k and num[i])
	jg	.L24 														#if greater, jump to part .L24
.L23:
	movl	-4(%rbp), %eax											#eax <-- M[rbp-4] (i)
	cltq                                   							#32 bits to sign ext. 64 bits
	addq	$1, %rax 												#rax <-- 1 + rax (i=i+1)
	leaq	0(,%rax,4), %rdx 										#rdx <-- (4*rax)
	movq	-24(%rbp), %rax 										#rax <-- M[rbp-24] (&num)
	addq	%rax, %rdx 												#rdx <-- rax + rdx (&num + 4*(i+1)=num[i+1])
	movl	-32(%rbp), %eax 										#eax <-- M[rbp-32] (k)
	movl	%eax, (%rdx) 											#(rdx) <-- eax (num[i+1]=k)
	movl	-4(%rbp), %eax 											#eax <-- M[rbp-4] (i)
	addl	$1, %eax 												#eax <-- eax + 1 (i=i+1)
	popq	%rbp 													#remove base pointer and free the register
	.cfi_def_cfa 7, 8 												#cfi directive
	ret 															#return
	.cfi_endproc 													#cfi directive
.LFE3:
	.size	insert, .-insert
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
