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
    float fb = 3.0;
    b = fb;
    int funRes = inlineFunc(a, b);
}

void func(int n)
{
    if(n>10){
        printf("Error!");
    }
    res[0] = 1;
    res[1] = 1;
    int i = 2;
    while(i<10){
        res[i] = res[i-1] + res[i-2];
        i++;
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