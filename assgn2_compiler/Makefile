a.out: main.o libass2_14CS10006.a
	gcc main.o -L. -lass2_14CS10006

main.o: main.c myl.h
	gcc -Wall -c main.c

libass2_14CS10006.a: ass2_14CS10006.o
	ar -rcs libass2_14CS10006.a ass2_14CS10006.o

ass2_14CS10006.o: ass2_14CS10006.c myl.h
	gcc -Wall -c ass2_14CS10006.c

clean:
	rm a.out main.o libass2_14CS10006.a ass2_14CS10006.o