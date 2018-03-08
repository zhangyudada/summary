#include<stdlib.h>   //使用malloc,需要<stdlid.h>
#include<stdio.h> 
struct LNode         //定义一个单链表类型变量 
{int data;  
 struct LNode *next; 
};
struct LNode *L;     //创建一个单链表
struct LNode *H;
void Josephus(struct LNode *L,int s,int m,int n,int x,int a[]); 
                     //函数声明
void main()
{int i,S,M,N,x;
 int a[50];  
 printf("请输入Josephus环的人数（小于50）：");
 scanf("%d",&N);
 for(i=0;i<N;i++)
	 a[i]=i+1;
 printf("这些人的编号依次为：");
 for(i=0;i<N;i++)
	 printf(" %d",a[i]);
 printf("\n");       //输出组成Josephus环的人的编号      
 printf("请输入开始报数位置及循环上限数字："); 
 scanf("%d %d",&S,&M);
                     //输入开始报数位置及循环上限数字    
 L=(struct LNode*)malloc(sizeof(struct LNode));
                     //建立单循环连的头结点
 L->data=a[0];  
 L->next=NULL;  
 Josephus(L,S,M,N,x,a); 
} 
void Josephus(struct LNode *L,int s,int m,int n,int x,int a[])
{struct LNode *p,*q;  
 int i,j;             //将组成Josephus环的人的编号储存到单链中  
 for(i=n-1;i>0;i--)
 {p=(struct LNode*)malloc(sizeof(struct LNode));   
  p->data=a[i];   
  p->next=L->next;   
  L->next=p;
 }      
 H=L;   
 for(i=0;i<n-1;i++)          
   H=H->next;    
 H->next=L;            //尾部节点的指针指向头结点   
 p=L;   
 for(i=1;i<s;i++)  
   p=p->next;          //找到开始报数位置   
 i=1;                     
 while(p->next!=p->next->next)
	                   //利用循环将元素输出
 {for(j=1;j<m-1;j++)     
    p=p->next;    
  q=p->next;    
  p->next=q->next;    
  x=q->data;    
  free(q);             //释放被输出元素的节点    
  printf("第%d 个出列的人编号为为%d\n",i,x);    p=p->next;    
  i++;
 }       
 printf("最后剩下的人编号为%d\n",p->data);
}                      //输出最后一个人的编号