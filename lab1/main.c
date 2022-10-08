#include <stdio.h>

#define _DEF_TEST "DEF TEST!"

const int N = 5;
const int m = 2;

int rank(int start, int end)
{
    int ans = 1;
    for (int i = start; i <= end; i++)
    {
        ans *= i;
    }
    return ans;
}

int main()
{
#ifdef _DEF_TEST
    printf("%s\n", _DEF_TEST);
#endif
    // int m = 2;
    // scanf("%d", &m);
    if (1==0)
    {
        printf("Error1!\n");
    }
    if (m > N)
    {
        printf("Error!\n");
    }
    else
    {
        int cnm = rank(N - m + 1, N) / rank(1, m);
        printf("%d\n", cnm);
    }
    int a = 1;
    a += 1;
    a += 1;
    a += 1;
    a += 1;
    a += 1;
    a += 1;
    a += 1;
    a += 1;
    printf("%d\n",a);
    return 0;
}