asmGenerate: comp
	./comp 1 > ass6_14CS10006_quads1.out
	./comp 2 > ass6_14CS10006_quads2.out
	./comp 3 > ass6_14CS10006_quads3.out
	./comp 4 > ass6_14CS10006_quads4.out
	./comp 5 > ass6_14CS10006_quads5.out

comp: lex.yy.o y.tab.o ass6_14CS10006_translator.o ass6_14CS10006_target_translator.o
	g++ lex.yy.o y.tab.o ass6_14CS10006_translator.o \
	ass6_14CS10006_target_translator.o -lfl -o comp

ass6_14CS10006_target_translator.o: ass6_14CS10006_target_translator.cxx
	g++ -c ass6_14CS10006_target_translator.cxx

ass6_14CS10006_translator.o: ass6_14CS10006_translator.cxx ass6_14CS10006_translator.h
	g++ -c ass6_14CS10006_translator.h
	g++ -c ass6_14CS10006_translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

y.tab.o: y.tab.c
	g++ -c y.tab.c

lex.yy.c: ass6_14CS10006.l y.tab.h ass6_14CS10006_translator.h
	flex ass6_14CS10006.l

y.tab.c: ass6_14CS10006.y
	yacc -dtv ass6_14CS10006.y -W

y.tab.h: ass6_14CS10006.y
	yacc -dtv ass6_14CS10006.y -W
	
clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o ass6_14CS10006_translator.o test1 test2 test3 test4 test5 y.output comp ass6_14CS10006_target_translator.o libass2_14CS10006.a ass6_14CS10006_1.o ass2_14CS10006.o ass6_14CS10006_2.o ass6_14CS10006_3.o ass6_14CS10006_4.o ass6_14CS10006_5.o

clean1:
	rm test1 ass6_14CS10006_1.o libass2_14CS10006.a ass2_14CS10006.o

#Test files
test1: ass6_14CS10006_1.o libass2_14CS10006.a
	gcc ass6_14CS10006_1.o -o test1 -L. -lass2_14CS10006
ass6_14CS10006_1.o: myl.h
	gcc -c ass6_14CS10006_1.s

test2: ass6_14CS10006_2.o libass2_14CS10006.a
	gcc ass6_14CS10006_2.o -o test2 -L. -lass2_14CS10006
ass6_14CS10006_2.o: myl.h
	gcc -Wall -c ass6_14CS10006_2.s

test3: ass6_14CS10006_3.o libass2_14CS10006.a
	gcc ass6_14CS10006_3.o -o test3 -L. -lass2_14CS10006
ass6_14CS10006_3.o: myl.h
	gcc -Wall -c ass6_14CS10006_3.s

test4: ass6_14CS10006_4.o libass2_14CS10006.a
	gcc ass6_14CS10006_4.o -o test4 -L. -lass2_14CS10006
ass6_14CS10006_4.o: myl.h
	gcc -Wall -c ass6_14CS10006_4.s

test5: ass6_14CS10006_5.o libass2_14CS10006.a
	gcc ass6_14CS10006_5.o -o test5 -L. -lass2_14CS10006
ass6_14CS10006_5.o: myl.h
	gcc -Wall -c ass6_14CS10006_5.s


libass2_14CS10006.a: ass2_14CS10006.o
	ar -rcs libass2_14CS10006.a ass2_14CS10006.o

ass2_14CS10006.o: ass2_14CS10006.c myl.h
	gcc -Wall -c ass2_14CS10006.c