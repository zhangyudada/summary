#define m 8
#define n 10
#define MAXSIZE 1024
#include<stdio.h>
#include<stdlib.h>                            //使用malloc,需要<stdlid.h>                    
                                        
typedef struct
{int x,y;
}item;
item move[8];

typedef struct
{int x,y,d;                                   //横坐标及方向
}datatype;
typedef struct
{datatype data[MAXSIZE];
 int top;
}SeqStack;

SeqStack *Init_SeqStack()                     //置空栈
{ SeqStack *s;
  s=(SeqStack*)malloc(sizeof(SeqStack));
  s->top=-1;
  return s;
}

int Empty_SeqStack(SeqStack *s)               //判断栈空
{ if(s->top==-1) return 1;
  else return 0;
}

int Push_SeqStack(SeqStack *s,datatype x)     //入栈
{ if(s->top==MAXSIZE-1) return 0;
  else{ s->top++;
        s->data[s->top]=x;
		return 1;}
}

int Pop_SeqStack(SeqStack *s,datatype *x)     //出栈
{ if(Empty_SeqStack(s)) return 0;
  else{ *x=s->data[s->top];
        s->top--;
		return 1;}
}

int path(int maze[m][n],item move[8])
{ SeqStack *s;
  datatype temp;
  int x,y,d,i,j;
  s=Init_SeqStack();                          //建立一个空栈
  temp.x=1;temp.y=1;temp.d=-1;
  maze[1][1]=-1;
  Push_SeqStack(s,temp);                      //入口进栈
  while(!Empty_SeqStack(s))
  { Pop_SeqStack(s,&temp);
    x=temp.x;y=temp.y;d=temp.d+1;             //回到上一个位置进行下一个方向的试探
	while(d<8)                                //当还有方向可试
	{ i=x+move[d].x;
	  j=y+move[d].y;                          //新点坐标
	  if(maze[i][j]==0)                       //判断是否可到达
	  { temp.x=x;temp.y=y;temp.d=d;           //记录当前的坐标及方向
	    Push_SeqStack(s,temp);                //坐标及方向入栈    
		x=i;y=j;maze[x][y]=-1;                //到达新点
		if(x==m-2&&y==n-2)                    //是出口则迷宫有路
		{  while(s->top!=-1){
             printf("(%d,%d)←",s->data[s->top].x,s->data[s->top].y);
             s->top--;}
            printf("\n");                     //将路径输出
			return 1;
		}
		else
			d=0;                              //不是出口则继续试探
	  }
	  else d++;                               //不可到达则换下一个方向试探
	}
  }
  return 0;                                   //迷宫无路
}

void main()
{      int maze[m][n]=
{
	{1,1,1,1,1,1,1,1,1,1},
	{1,0,1,1,1,0,1,1,1,1},
	{1,1,0,1,0,1,1,1,1,1},
	{1,0,1,0,0,0,0,0,1,1},
	{1,0,1,1,1,0,1,1,1,1},
	{1,1,0,0,1,1,0,0,0,1},
	{1,0,1,1,0,0,1,1,0,1},
	{1,1,1,1,1,1,1,1,1,1}
};                                           //迷宫初始化
   item move[8]={{0,1},{1,1},{1,0},{1,-1},{0,-1},{-1,-1},{-1,0},{-1,1}};
                                             //方向初始化
   printf("一条路径为：\n");
   path(maze,move);
}