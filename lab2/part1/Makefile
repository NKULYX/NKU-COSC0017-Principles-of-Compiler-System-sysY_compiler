.PHONY : asm, obj, exe, clean

asm:
	arm-linux-gnueabihf-g++ test1.cpp -S -o test1.s
	arm-linux-gnueabihf-gcc test2.c -S -o test2.s

obj:
	arm-linux-gnueabihf-gcc test1.s -c -o test1.o
	arm-linux-gnueabihf-gcc test2.s -c -o test2.o

exe:
	arm-linux-gnueabihf-gcc test1.o -o test1 -static
	arm-linux-gnueabihf-gcc test2.o ./lib/sylib.c -o test2 -static

clean:
	rm test2.s test1.s *.o test1 test2