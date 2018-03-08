#define m 8
#define n 10
#include<stdio.h>

typedef struct
{  int x,y;
}item;
item move[8];

typedef struct         
{  int x,y;
   int pre;                                  //pre为前驱点在sq中的坐标
}SqType;                                     

void printpath(SqType sq[],int rear)         //打印迷宫路径的函数
{   int i;
	i=rear;
	do{  printf("(%d,%d)←",sq[i].x,sq[i].y);  
	     i=sq[i].pre;}                       //回溯
	while(i!=-1);
}

int path(int maze[m][n],item move[8])        //move为迷宫数组，move为坐标增量数组
{  SqType sq[1024];                      
   int front,rear;
   int x,y,i,j,v;                         
   sq[0].x=1;sq[0].y=1;sq[0].pre=-1;         //入口点入队
   front=rear=0;                             //对头指针指向的是对头元素位置                
   maze[1][1]=-1;
   while(front<=rear)                        //队列不空     
   {  x=sq[front].x;y=sq[front].y;
 	  for(v=0;v<8;v++)                       //还有方向可试
	  {  i=x+move[v].x;
	     j=y+move[v].y;
         if(maze[i][j]==0)                   //判断是否可到达
		 {  rear++;
       	    sq[rear].x=i;sq[rear].y=j;sq[rear].pre=front;  
			                                 //到达点坐标及前驱点坐标入队
       	    maze[i][j]=-1;                   //已访问，置为-1
		 }
         if(i==m-2&&j==n-2)                
		 {  printpath(sq,rear);              //打印路径
		    printf("\n");
       	    return 1;                       
		 }
	  }
 	  front++;                               //当前点搜索完，取下一点搜索
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
};                                           //迷宫初始化
   item move[8]={{0,1},{1,1},{1,0},{1,-1},{0,-1},{-1,-1},{-1,0},{-1,1}};
                                             //方向初始化
   printf("最短路径为：\n");
   path(maze,move);
}