#include<stdio.h>
#define N 10
int main()
{
	int array[N];
	int i,j,t;
	printf("请输入%d个整数：\n",N);
	for(i=0;i<N;i++)
		scanf("%d",&array[i]);
	printf("\n");
	for(j=0;j<N-1;j++)                        //进行N-1次循环，实现N-1趟比较
		for(i=0;i<N-1-j;i++)                  //在每趟循环中进行N-1-j次比较
			if(array[i]>array[i+1])
			{
				t=array[i];
				array[i]=array[i+1];
				array[i+1]=t;
			}
	printf("这%d个数从小到大排序为：\n",N);
	for(i=0;i<N;i++)
		printf(" %d",array[i]);
	printf("\n");
	return 0;
}


