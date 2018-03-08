#define m 8
#define n 10
#include<stdio.h>

typedef struct
{  int x,y;
}item;
item move[8];

typedef struct         
{  int x,y;
   int pre;                                  //preΪǰ������sq�е�����
}SqType;                                     

void printpath(SqType sq[],int rear)         //��ӡ�Թ�·���ĺ���
{   int i;
	i=rear;
	do{  printf("(%d,%d)��",sq[i].x,sq[i].y);  
	     i=sq[i].pre;}                       //����
	while(i!=-1);
}

int path(int maze[m][n],item move[8])        //moveΪ�Թ����飬moveΪ������������
{  SqType sq[1024];                      
   int front,rear;
   int x,y,i,j,v;                         
   sq[0].x=1;sq[0].y=1;sq[0].pre=-1;         //��ڵ����
   front=rear=0;                             //��ͷָ��ָ����Ƕ�ͷԪ��λ��                
   maze[1][1]=-1;
   while(front<=rear)                        //���в���     
   {  x=sq[front].x;y=sq[front].y;
 	  for(v=0;v<8;v++)                       //���з������
	  {  i=x+move[v].x;
	     j=y+move[v].y;
         if(maze[i][j]==0)                   //�ж��Ƿ�ɵ���
		 {  rear++;
       	    sq[rear].x=i;sq[rear].y=j;sq[rear].pre=front;  
			                                 //��������꼰ǰ�����������
       	    maze[i][j]=-1;                   //�ѷ��ʣ���Ϊ-1
		 }
         if(i==m-2&&j==n-2)                
		 {  printpath(sq,rear);              //��ӡ·��
		    printf("\n");
       	    return 1;                       
		 }
	  }
 	  front++;                               //��ǰ�������꣬ȡ��һ������
   }                                         
   return 0;
}

void main()
{   int maze[m][n]=                          
{
	{1,1,1,1,1,1,1,1,1,1},                   
	{1,0,1,1,1,0,1,1,1,1},
	{1,1,0,1,0,1,0,1,0,1},
	{1,0,1,0,0,1,1,1,1,1},
	{1,0,1,1,1,0,0,1,1,1},
	{1,1,0,0,1,1,0,0,0,1},
	{1,0,1,1,0,0,1,1,0,1},
	{1,1,1,1,1,1,1,1,1,1}
};                                           //�Թ���ʼ��
   item move[8]={{0,1},{1,1},{1,0},{1,-1},{0,-1},{-1,-1},{-1,0},{-1,1}};
                                             //�����ʼ��
   printf("���·��Ϊ��\n");
   path(maze,move);
}