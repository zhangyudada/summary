#include<stdio.h>
#define N 10
int main()
{
	int array[N];
	int i,j,t;
	printf("������%d��������\n",N);
	for(i=0;i<N;i++)
		scanf("%d",&array[i]);
	printf("\n");
	for(j=0;j<N-1;j++)                        //����N-1��ѭ����ʵ��N-1�˱Ƚ�
		for(i=0;i<N-1-j;i++)                  //��ÿ��ѭ���н���N-1-j�αȽ�
			if(array[i]>array[i+1])
			{
				t=array[i];
				array[i]=array[i+1];
				array[i+1]=t;
			}
	printf("��%d������С��������Ϊ��\n",N);
	for(i=0;i<N;i++)
		printf(" %d",array[i]);
	printf("\n");
	return 0;
}


