#include<stdio.h>
#include<stdlib.h> 
#include <conio.h>
#define MAXVALUE 10000                     //为找到最小，定义一个较大的数

typedef struct
{  
    int weight;
    int parent;
    int lchild;
    int rchild;
}HNodeType;
HNodeType HFMTree[2*26-1];

typedef struct
{
	int bit[26];
	int start;
}HCodeType;
HCodeType HuffCode[26];

void Weight_Input(FILE *fp)                //统计文件中各英文字符出现频度的函数
{                                          
	char ch;
	while((ch=fgetc(fp))!='@')
	{
		switch(ch)
		{
			case 'a':HFMTree[0].weight++;break;
			case 'b':HFMTree[1].weight++;break;
			case 'c':HFMTree[2].weight++;break;
			case 'd':HFMTree[3].weight++;break;
			case 'e':HFMTree[4].weight++;break;
			case 'f':HFMTree[5].weight++;break;
			case 'g':HFMTree[6].weight++;break;
			case 'h':HFMTree[7].weight++;break;
			case 'i':HFMTree[8].weight++;break;
			case 'j':HFMTree[9].weight++;break;
			case 'k':HFMTree[10].weight++;break;
			case 'l':HFMTree[11].weight++;break;
			case 'm':HFMTree[12].weight++;break;
			case 'n':HFMTree[13].weight++;break;
			case 'o':HFMTree[14].weight++;break;
			case 'p':HFMTree[15].weight++;break;
			case 'q':HFMTree[16].weight++;break;
			case 'r':HFMTree[17].weight++;break;
			case 's':HFMTree[18].weight++;break;
			case 't':HFMTree[19].weight++;break;
			case 'u':HFMTree[20].weight++;break;
			case 'v':HFMTree[21].weight++;break;
			case 'w':HFMTree[22].weight++;break;
			case 'x':HFMTree[23].weight++;break;
			case 'y':HFMTree[24].weight++;break;
			case 'z':HFMTree[25].weight++;break;
		}
	}                                      
}


void Create_HuffMTree(HNodeType HFMTree[],FILE *fp)
{                                          //构造的哈夫曼树存储于HFMTree[],文件指针指向需要读入的文件
	int m1,x1,m2,x2;                       //x1和x2存储最小和次小权值，m1和m2存储其位置
	int i,j;
	for(i=0;i<2*26-1;i++)                  //HFMTree初始化
	{
		HFMTree[i].weight=0;
		HFMTree[i].parent=-1;
		HFMTree[i].lchild=-1;
		HFMTree[i].rchild=-1;
	}
    Weight_Input(fp);                      //输入26个叶子结点的权值  
	for(i=0;i<26-1;i++)
	{
		x1=x2=MAXVALUE;
		m1=m2=0;
		for(j=0;j<26+i;j++)                //构造哈夫曼树
		{
			if(HFMTree[j].parent==-1&&HFMTree[j].weight<x1)
			{                              //找出根结点具有最小和次小权值的两棵树
				x2=x1;m2=m1;
				x1=HFMTree[j].weight;m1=j;
			}
			else if(HFMTree[j].parent==-1&&HFMTree[j].weight<x2)
			{
				x2=HFMTree[j].weight;
				m2=j;
			}
			
		}                                  //将找出的两棵子树合并为一棵子树
		HFMTree[m1].parent=26+i;
		HFMTree[m2].parent=26+i;
		HFMTree[26+i].weight=HFMTree[m1].weight;
		HFMTree[26+i].lchild=m1;
		HFMTree[26+i].rchild=m2;
	}
}

void HaffmanCode(HNodeType HFMTree[],HCodeType HuffCode[])
{
	HCodeType cd;                          //字符编码的缓冲变量
	int i,j,c,p;
	for(i=0;i<26;i++)                       //求每个叶子结点的哈夫曼编码
	{
		cd.start=26-1;
		c=i;
		p=HFMTree[c].parent;
		while(p!=-1)                       //由叶子结点向上直到树根
		{
			if(HFMTree[p].lchild==c)
		        cd.bit[cd.start]=0;
			else
				cd.bit[cd.start]=1;
			cd.start--;
			c=p;
			p=HFMTree[c].parent;
		}
		for(j=cd.start+1;j<26;j++)          //保存求出的每个叶结点的哈夫曼编码和编码起始位
			HuffCode[i].bit[j]=cd.bit[j];
		HuffCode[i].start=cd.start+1;
	}
}

int main()
{
	int i,j;
    FILE *fp;
    fp=fopen("E:\\file.txt","r");           //这是取文件操作，调试时请将file.txt文件放到E盘
    Create_HuffMTree(HFMTree,fp);
    HaffmanCode(HFMTree,HuffCode);
	printf("小写字母a到z的哈夫曼编码依次为：\n");
    for(i=0;i<26;i++)                       //输出各英文字符的哈夫曼编码
	{
		printf("%c:",i+97);
		for(j=HuffCode[i].start;j<26;j++)
			printf("%d",HuffCode[i].bit[j]); 
		printf("\n");
	}
	return 0;
}

	
