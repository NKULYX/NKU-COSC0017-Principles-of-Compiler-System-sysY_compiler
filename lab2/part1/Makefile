.PHONY : asm, obj, exe, clean

asm:
	gcc test1.cpp -S -o test1.s
	gcc test2.c -S -o test2.s

obj:
	gcc test1.s -c -o test1.o
	gcc test2.s -c -o test2.o

exe:
	gcc test1.o -o test1
	gcc test2.o ./lib/sylib.c -o test2

clean:
	rm *.s *.o test1 test2