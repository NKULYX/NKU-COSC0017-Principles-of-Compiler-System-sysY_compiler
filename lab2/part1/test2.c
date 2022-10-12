#include <stdio.h>
#include <math.h>
#include "./lib/sylib.h"

void func(int n);
int inlineFunc(int a, int b);

int res[10];

int main()
{
    int n = getint();
    func(n);
    int a = 10, b;
    float fb = 1.0;
    b = fb;
    int funRes = inlineFunc(a, b);
    putint(funRes);
}

void func(int n)
{
    if(n>=10){
        printf("Error!");
        return;
    }
    res[0] = 1;
    res[1] = 1;
    int i = 0;
    while(1){
        i++;
        if(i < 2){
            continue;
        }
        if(i == n){
            break;
        }
        res[i] = res[i-1] + res[i-2];
    }
    putarray(n,res);
}

__attribute__((always_inline)) int inlineFunc(int a, int b)
{
    if(a < b){
        return a;
    }
    else{
        return b;
    }
}