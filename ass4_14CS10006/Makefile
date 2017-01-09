Test_Output.txt: a.out ass4_14CS10006_test.c
	./a.out < ass4_14CS10006_test.c > Test_Output.txt

a.out: lex.yy.c y.tab.c ass4_14CS10006_main.o
	gcc lex.yy.c y.tab.c ass4_14CS10006_main.o -lfl

lex.yy.c: ass4_14CS10006.l
	flex ass4_14CS10006.l

y.tab.c: ass4_14CS10006.y
	yacc -dtv ass4_14CS10006.y

ass4_14CS10006_main.o: ass4_14CS10006_main.c
	gcc -c ass4_14CS10006_main.c

clean:
	rm y.tab.c y.tab.h a.out lex.yy.c y.output ass4_14CS10006_main.o Test_Output.txt