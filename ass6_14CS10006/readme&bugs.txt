Name : Apurv Kumar
Roll : 14CS10006

*********************************************Tiny C compiler*************************************************************

-------------------------How to run
To compile the .y, .l and translators type "make" after reaching the correct directory in the command prompt

To run a particular test case :
	type "make test1" or "make test2" or "make test3" or "make test4" or "make test5"
	 depending upon the file to test

To run the executable of the particular test case: 
	type "./test1" or "./test2" or "./test3" or "./test4" or "./test5" 
	depending upon the file to test.



--------------------------Loopholes

Shortcomings:
1. The function arguement passing is done with the help of registers. For this 4 registers are used and not the stack. The 			registers used for passing the arguements are %rdi,%rsi,%rdx,%rcx. These registers store their value in the function stack 		of n entering the required nested function. Due to this only 4 arguements can be passed to a function.
2. Very limited functionalities of c can be compiled by our compiler. Only the functionalities required by the assignments are implemented, like type conversions are not supported.
3. Only the I/O assembly functions provided by the assembly can be implemented.
4. Some array referencing and deferencing is done but, doesn't give correct results everytime.