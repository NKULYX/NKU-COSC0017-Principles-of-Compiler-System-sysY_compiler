.PHONY : pre, lexer, ast-gcc, ast-llvm, cfg, rtl, it-llvm, pass-opt, asm, obj, exe, abtiobj, antiexe, manual

pre:
	gcc main.c -E -o main.i

lexer:
	clang -E -Xclang -dump-tokens main.c > LLVM_tokens.log 2>&1

ast-gcc:
	gcc -fdump-tree-original-raw main.c
	mv main.c.004t.original ast-gcc.log

ast-llvm:
	clang -E -Xclang -ast-dump main.c > LLVM_AST.log 2>&1

cfg:
	rm -rf cfg_res
	mkdir cfg_res
	cd cfg_res && gcc -O0 -fdump-tree-all-graph ../main.c

rtl:
	rm -rf rtl_res
	mkdir rtl_res
	cd rtl_res && gcc -fdump-rtl-all-graph ../main.c

ir-llvm:
	clang -S -emit-llvm -Xclang -disable-O0-optnone main.c

pass-opt:
	rm -rf opt_res
	mkdir opt_res
	@if [ ! -e ./main.ll ]; then clang -S -emit-llvm -Xclang -disable-O0-optnone main.c; fi
	llc -print-before-all -print-after-all main.ll > opt_res/opt_all.log 2>&1
	llvm-as main.ll -o opt_res/main.bc 
	opt -instcombine opt_res/main.bc -f > opt_res/opt_instcomb.bc 2>&1 
	llvm-dis opt_res/opt_instcomb.bc -o opt_res/opt_instcomb.ll
	opt -mem2reg opt_res/main.bc -f > opt_res/opt_m2r.bc 2>&1 
	llvm-dis opt_res/opt_m2r.bc -o opt_res/opt_m2r.ll

asm:
	rm -rf asm_res
	mkdir asm_res
	@if [ ! -e ./main.ll ]; then clang -S -emit-llvm -Xclang -disable-O0-optnone main.c; fi
	llc main.ll -o ./asm_res/main_llvm.S
	@if [ ! -e ./main.i ]; then gcc main.c -E -o main.i; fi
	gcc main.i -S -o ./asm_res/main_gcc.S
	arm-linux-gnueabihf-gcc main.i -S -o ./asm_res/main_arm.S

obj:
	rm -rf obj_res
	mkdir obj_res
	@if [ ! -e ./asm_res ]; then make asm; fi
	gcc ./asm_res/main_gcc.S -c -o ./obj_res/main_gcc.o
	gcc ./asm_res/main_llvm.S -c -o ./obj_res/main_llvm.o
	arm-linux-gnueabihf-gcc ./asm_res/main_arm.S -o ./obj_res/main_arm.o
	@if [ ! -e ./main.ll ]; then clang -S -emit-llvm -Xclang -disable-O0-optnone main.c; fi
	llvm-as main.ll -o ./obj_res/main.bc
	llc ./obj_res/main.bc -filetype=obj -o ./obj_res/llvm.o

antiobj:
	rm -rf antiobj_res
	mkdir antiobj_res
	@if [ ! -e ./obj_res ]; then make obj; fi
	objdump -d ./obj_res/main_gcc.o > ./antiobj_res/main_gcc-anti-obj.S
	objdump -d ./obj_res/main_llvm.o > ./antiobj_res/main_llvm-anti-obj.S
	nm ./obj_res/main_gcc.o > ./antiobj_res/main_gcc-nm-obj.txt
	nm ./obj_res/main_llvm.o > ./antiobj_res/main_llvm-nm-obj.txt
	nm ./obj_res/main_arm.o > ./antiobj_res/main_arm-nm-obj.txt

exe:
	gcc -O0 -o main main.o

antiexe:
	objdump -d main > main-anti-exe.S
	nm main > main-nm-exe.txt

manual-llvm:
	clang ./manual/manual.ll ./lib/sylib.c -o ./manual/manual

clean:
	rm -rf *res *.ll *.s *.S *.i *.log