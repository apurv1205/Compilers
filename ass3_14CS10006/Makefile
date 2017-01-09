Test_Output.txt: a.out ass3_14CS10006_test.c
	./a.out < ass3_14CS10006_test.c > Test_Output.txt

a.out: lex.yy.c y.tab.c ass3_14CS10006.o
	gcc lex.yy.c y.tab.c ass3_14CS10006.o -lfl

lex.yy.c: ass3_14CS10006.l
	flex ass3_14CS10006.l

y.tab.c: ass3_14CS10006.y
	yacc -dtv ass3_14CS10006.y

ass3_14CS10006.o: ass3_14CS10006.c
	gcc -c ass3_14CS10006.c

clean:
	rm y.tab.c y.tab.h a.out lex.yy.c y.output ass3_14CS10006.o Test_Output.txt