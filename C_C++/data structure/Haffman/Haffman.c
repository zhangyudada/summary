#include<stdio.h>
#include<stdlib.h> 
#include <conio.h>
#define MAXVALUE 10000                     //Ϊ�ҵ���С������һ���ϴ����

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

void Weight_Input(FILE *fp)                //ͳ���ļ��и�Ӣ���ַ�����Ƶ�ȵĺ���
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
{                                          //����Ĺ��������洢��HFMTree[],�ļ�ָ��ָ����Ҫ������ļ�
	int m1,x1,m2,x2;                       //x1��x2�洢��С�ʹ�СȨֵ��m1��m2�洢��λ��
	int i,j;
	for(i=0;i<2*26-1;i++)                  //HFMTree��ʼ��
	{
		HFMTree[i].weight=0;
		HFMTree[i].parent=-1;
		HFMTree[i].lchild=-1;
		HFMTree[i].rchild=-1;
	}
    Weight_Input(fp);                      //����26��Ҷ�ӽ���Ȩֵ  
	for(i=0;i<26-1;i++)
	{
		x1=x2=MAXVALUE;
		m1=m2=0;
		for(j=0;j<26+i;j++)                //�����������
		{
			if(HFMTree[j].parent==-1&&HFMTree[j].weight<x1)
			{                              //�ҳ�����������С�ʹ�СȨֵ��������
				x2=x1;m2=m1;
				x1=HFMTree[j].weight;m1=j;
			}
			else if(HFMTree[j].parent==-1&&HFMTree[j].weight<x2)
			{
				x2=HFMTree[j].weight;
				m2=j;
			}
			
		}                                  //���ҳ������������ϲ�Ϊһ������
		HFMTree[m1].parent=26+i;
		HFMTree[m2].parent=26+i;
		HFMTree[26+i].weight=HFMTree[m1].weight;
		HFMTree[26+i].lchild=m1;
		HFMTree[26+i].rchild=m2;
	}
}

void HaffmanCode(HNodeType HFMTree[],HCodeType HuffCode[])
{
	HCodeType cd;                          //�ַ�����Ļ������
	int i,j,c,p;
	for(i=0;i<26;i++)                       //��ÿ��Ҷ�ӽ��Ĺ���������
	{
		cd.start=26-1;
		c=i;
		p=HFMTree[c].parent;
		while(p!=-1)                       //��Ҷ�ӽ������ֱ������
		{
			if(HFMTree[p].lchild==c)
		        cd.bit[cd.start]=0;
			else
				cd.bit[cd.start]=1;
			cd.start--;
			c=p;
			p=HFMTree[c].parent;
		}
		for(j=cd.start+1;j<26;j++)          //���������ÿ��Ҷ���Ĺ���������ͱ�����ʼλ
			HuffCode[i].bit[j]=cd.bit[j];
		HuffCode[i].start=cd.start+1;
	}
}

int main()
{
	int i,j;
    FILE *fp;
    fp=fopen("E:\\file.txt","r");           //����ȡ�ļ�����������ʱ�뽫file.txt�ļ��ŵ�E��
    Create_HuffMTree(HFMTree,fp);
    HaffmanCode(HFMTree,HuffCode);
	printf("Сд��ĸa��z�Ĺ�������������Ϊ��\n");
    for(i=0;i<26;i++)                       //�����Ӣ���ַ��Ĺ���������
	{
		printf("%c:",i+97);
		for(j=HuffCode[i].start;j<26;j++)
			printf("%d",HuffCode[i].bit[j]); 
		printf("\n");
	}
	return 0;
}

	
