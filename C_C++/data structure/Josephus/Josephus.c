#include<stdlib.h>   //ʹ��malloc,��Ҫ<stdlid.h>
#include<stdio.h> 
struct LNode         //����һ�����������ͱ��� 
{int data;  
 struct LNode *next; 
};
struct LNode *L;     //����һ��������
struct LNode *H;
void Josephus(struct LNode *L,int s,int m,int n,int x,int a[]); 
                     //��������
void main()
{int i,S,M,N,x;
 int a[50];  
 printf("������Josephus����������С��50����");
 scanf("%d",&N);
 for(i=0;i<N;i++)
	 a[i]=i+1;
 printf("��Щ�˵ı������Ϊ��");
 for(i=0;i<N;i++)
	 printf(" %d",a[i]);
 printf("\n");       //������Josephus�����˵ı��      
 printf("�����뿪ʼ����λ�ü�ѭ���������֣�"); 
 scanf("%d %d",&S,&M);
                     //���뿪ʼ����λ�ü�ѭ����������    
 L=(struct LNode*)malloc(sizeof(struct LNode));
                     //������ѭ������ͷ���
 L->data=a[0];  
 L->next=NULL;  
 Josephus(L,S,M,N,x,a); 
} 
void Josephus(struct LNode *L,int s,int m,int n,int x,int a[])
{struct LNode *p,*q;  
 int i,j;             //�����Josephus�����˵ı�Ŵ��浽������  
 for(i=n-1;i>0;i--)
 {p=(struct LNode*)malloc(sizeof(struct LNode));   
  p->data=a[i];   
  p->next=L->next;   
  L->next=p;
 }      
 H=L;   
 for(i=0;i<n-1;i++)          
   H=H->next;    
 H->next=L;            //β���ڵ��ָ��ָ��ͷ���   
 p=L;   
 for(i=1;i<s;i++)  
   p=p->next;          //�ҵ���ʼ����λ��   
 i=1;                     
 while(p->next!=p->next->next)
	                   //����ѭ����Ԫ�����
 {for(j=1;j<m-1;j++)     
    p=p->next;    
  q=p->next;    
  p->next=q->next;    
  x=q->data;    
  free(q);             //�ͷű����Ԫ�صĽڵ�    
  printf("��%d �����е��˱��ΪΪ%d\n",i,x);    p=p->next;    
  i++;
 }       
 printf("���ʣ�µ��˱��Ϊ%d\n",p->data);
}                      //������һ���˵ı��