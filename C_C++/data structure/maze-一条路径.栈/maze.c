#define m 8
#define n 10
#define MAXSIZE 1024
#include<stdio.h>
#include<stdlib.h>                            //ʹ��malloc,��Ҫ<stdlid.h>                    
                                        
typedef struct
{int x,y;
}item;
item move[8];

typedef struct
{int x,y,d;                                   //�����꼰����
}datatype;
typedef struct
{datatype data[MAXSIZE];
 int top;
}SeqStack;

SeqStack *Init_SeqStack()                     //�ÿ�ջ
{ SeqStack *s;
  s=(SeqStack*)malloc(sizeof(SeqStack));
  s->top=-1;
  return s;
}

int Empty_SeqStack(SeqStack *s)               //�ж�ջ��
{ if(s->top==-1) return 1;
  else return 0;
}

int Push_SeqStack(SeqStack *s,datatype x)     //��ջ
{ if(s->top==MAXSIZE-1) return 0;
  else{ s->top++;
        s->data[s->top]=x;
		return 1;}
}

int Pop_SeqStack(SeqStack *s,datatype *x)     //��ջ
{ if(Empty_SeqStack(s)) return 0;
  else{ *x=s->data[s->top];
        s->top--;
		return 1;}
}

int path(int maze[m][n],item move[8])
{ SeqStack *s;
  datatype temp;
  int x,y,d,i,j;
  s=Init_SeqStack();                          //����һ����ջ
  temp.x=1;temp.y=1;temp.d=-1;
  maze[1][1]=-1;
  Push_SeqStack(s,temp);                      //��ڽ�ջ
  while(!Empty_SeqStack(s))
  { Pop_SeqStack(s,&temp);
    x=temp.x;y=temp.y;d=temp.d+1;             //�ص���һ��λ�ý�����һ���������̽
	while(d<8)                                //�����з������
	{ i=x+move[d].x;
	  j=y+move[d].y;                          //�µ�����
	  if(maze[i][j]==0)                       //�ж��Ƿ�ɵ���
	  { temp.x=x;temp.y=y;temp.d=d;           //��¼��ǰ�����꼰����
	    Push_SeqStack(s,temp);                //���꼰������ջ    
		x=i;y=j;maze[x][y]=-1;                //�����µ�
		if(x==m-2&&y==n-2)                    //�ǳ������Թ���·
		{  while(s->top!=-1){
             printf("(%d,%d)��",s->data[s->top].x,s->data[s->top].y);
             s->top--;}
            printf("\n");                     //��·�����
			return 1;
		}
		else
			d=0;                              //���ǳ����������̽
	  }
	  else d++;                               //���ɵ�������һ��������̽
	}
  }
  return 0;                                   //�Թ���·
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
};                                           //�Թ���ʼ��
   item move[8]={{0,1},{1,1},{1,0},{1,-1},{0,-1},{-1,-1},{-1,0},{-1,1}};
                                             //�����ʼ��
   printf("һ��·��Ϊ��\n");
   path(maze,move);
}