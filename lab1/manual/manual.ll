declare i32 @printf(i8*, ...)                               ;#include<stdio.h>  (printf声明)
declare i32 @__isoc99_scanf(i8*, ...)                       ;#include<stdio.h>  (scanf声明)
declare i32 @getint()
@cnm = global i32 0                                         ;int cnm = 0
@input = private constant [3 x i8] c"%d\00", align 1        ;输入提示
@error = private constant [8 x i8] c"Error!\0A\00", align 1 ;"ERROR!\n"用来输出错误信息
@format = private constant [4 x i8] c"%d\0A\00", align 1    ;"%d"被定义为私有常量
define i32 @rank (i32 %start, i32 %end) {                   ;int rank(int start, int end)
    %ans = alloca i32                                       ;int ans
    %i = alloca i32                                         ;int i
    store i32 1, i32* %ans                                  ;ans = 1
    store i32 %start, i32* %i                               ;i = start
    br label %for_judge

for_judge:
    %i_comp = load i32, i32* %i
    %comp = icmp sle i32 %i_comp, %end                      ;i<=end
    br i1 %comp, label %for_block, label %for_exit

for_block:
    %i_mul = load i32, i32* %i
    %ans_mul = load i32, i32* %ans
    %ans_next = mul i32 %ans_mul, %i_mul                    ;ans *= i (notice: SSA)
    store i32 %ans_next, i32* %ans
    %i_next = add i32 %i_mul, 1                             ;i++
    store i32 %i_next, i32* %i
    br label %for_judge

for_exit:
    %ans_ret = load i32, i32* %ans
    ret i32 %ans_ret                                        ;return ans
}

define i32 @main () {
    %m_main = call i32 @getint()
    %valid = icmp sle i32 %m_main, 21                       ;m<=N
    br i1 %valid, label %pass, label %unpass                ;if m<=N goto pass else goto unpass

pass:
    %arg_up_1_1 = sub i32 21, %m_main                       ;N-m
    %arg_up_1 = add i32 %arg_up_1_1, 1                      ;N-m+1
    %up = call i32 @rank(i32 %arg_up_1, i32 21)             ;rank(N-m+1, N)
    %low = call i32 @rank(i32 1, i32 %m_main)               ;rank(1, m)
    %result = sdiv i32 %up, %low                            ;cnm = rank(N-m+1, N)/rank(1, m)
    %print_res = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @format, i64 0, i64 0), i32 %result)
    br label %main_exit

unpass:
    %print_error = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @error, i64 0, i64 0))
    br label %main_exit

main_exit:
    ret i32 0
}