#include <stdio.h>

const int N = 2;

int main()
{
    int array[N][N];
    int i = 0, j = 0;
    while(i<N){
        while(j<N){
            if(j==0){
                array[i][j] = i+1;
            } else {
                array[i][j] = array[i][j-1] * array[i][j-1];
            }
            j++;
        }
        i++;
    }
    int res[N][N] = {{1,1},{2,4}};
    int flag = 0;
    while(i>0){
        while(j>0){
            flag += !(res[i][j]==res[i][j]);
            j--;
        }
        i--;
    }
    printf("%d\n", flag);
}