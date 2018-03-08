#include<iostream>
#include<fstream>
#include<string>
#include<iomanip>
using namespace std;
struct grade
{
	float cgrade;
	float egrade;
	float sgrade;
	float mgrade;
};

struct student                                                        
{                                          
    string banji;                                                    
    int num;
    string name; 
	grade gra;
	float sum;
	float average;
}stu[90];

int n=90; 
static int  d=0;

void error()                   //������ʾ
{
	cout<<"*****������������������*****"<<endl<<endl;
}

void data_input()              //ѧ����Ϣ��¼���Լ����                                         
{ 
	int i;
	cout<<"����������ѧ�������Ϣ,����end����"<<endl;
	cout<<"�༶   ѧ��  ����   C++  Ӣ��  �ź�  ģ��"<<endl;
	for(i=d;i<n;i++)
	{
		 cin>>stu[i].banji;
		 if(stu[i].banji=="end") break;
		 cin>>stu[i].num>>stu[i].name>>stu[i].gra.cgrade
			>>stu[i].gra.egrade>>stu[i].gra.sgrade
			>>stu[i].gra.mgrade;
		 d++;
		 stu[i].sum=stu[i].gra.cgrade+stu[i].gra.egrade
		           +stu[i].gra.sgrade+stu[i].gra.mgrade;
         stu[i].average=stu[i].sum/4;
	 }
}

void data_show()               //ѧ����Ϣ����ʾ                                                  
{
	int i;
	cout<<endl;
	cout<<setiosflags(ios::left)
	    <<setw(8)<<"�༶"
		<<setw(8)<<"ѧ��"
		<<setw(8)<<"����"
		<<setw(8)<<"C++"
		<<setw(8)<<"Ӣ��"
		<<setw(8)<<"�ź�"
		<<setw(8)<<"ģ��"
		<<setw(8)<<"�ܷ�"
		<<setw(8)<<"ƽ����"<<endl;	
	for(i=0;i<d;i++)
	{
        if(stu[i].banji=="end") break;
        cout<<setiosflags(ios::left)
            <<setw(8)<<stu[i].banji
			<<setw(8)<<stu[i].num
			<<setw(8)<<stu[i].name
			<<setw(8)<<stu[i].gra.cgrade
			<<setw(8)<<stu[i].gra.egrade
			<<setw(8)<<stu[i].gra.sgrade
			<<setw(8)<<stu[i].gra.mgrade
			<<setw(8)<<stu[i].sum
			<<setw(8)<<stu[i].average<<endl;
	}
}

void data_delete()            //ѧ����Ϣ��ɾ��                                    
{ 
     data_show();
     cout<<"��ѡ����Ҫɾ����ѧ��:"; 
     int i,a,s=0; 
     cin>>a;
	 for(i=0;i<d;i++)                      
         { 
	       if(a==stu[i].num)
			{
			    s=1;
				int j;
				for(j=i;j<d-1;j++)
				{
					stu[j].banji=stu[j+1].banji;
					stu[j].num=stu[j+1].num;
					stu[j].name=stu[j+1].name;
					stu[i].gra.cgrade=stu[i+1].gra.cgrade;
                    stu[i].gra.egrade=stu[i+1].gra.egrade;
                    stu[i].gra.sgrade=stu[i+1].gra.sgrade;
                    stu[i].gra.mgrade=stu[i+1].gra.mgrade;
                    stu[i].sum=stu[i+1].sum;
                    stu[i].average=stu[i+1].average;
				}
				 d=d-1;
                 data_show();
				 cout<<"*****ɾ���ɹ�*****"<<endl;	
			}
			if(a==stu[i].num) break;  //�ҵ�Ҫɾ����ѧ�ź󣬽�����ѭ������Сʱ�临�Ӷ�
         }
       if(s==0) error();
}
		      
void compile()               //ѧ����Ϣ�ı༭                                                   
{ 
      data_show(); 
      cout<<"��ѡ����Ҫ�༭��ѧ��:"; 
      int i,a,s=0; 
      cin>>a; 
	  for(i=0;i<d;i++)
	  {
		  if(a==stu[i].num)
		  { 
			  s=1;
			  for(;;)                          
			  { 
				   cout<<"(1).�༶:"<<stu[i].banji<<endl; 
				   cout<<"(2).ѧ��:"<<stu[i].num<<endl; 
				   cout<<"(3).����:"<<stu[i].name<<endl;
				   cout<<"(4).C++�ɼ�:"<<stu[i].gra.cgrade<<endl; 
				   cout<<"(5).Ӣ��ɼ�:"<<stu[i].gra.egrade<<endl;
				   cout<<"(6).�źųɼ�:"<<stu[i].gra.sgrade<<endl;
				   cout<<"(7).ģ��ɼ�:"<<stu[i].gra.mgrade<<endl;
				   cout<<"(8).�ܳɼ�:"<<stu[i].sum<<endl;
				   cout<<"(9).ƽ���ɼ�:"<<stu[i].average<<endl;
				   cout<<endl;
				   cout<<"�༭�༶������1"<<endl;
				   cout<<"�༭ѧ��������2"<<endl;
				   cout<<"�༭����������3"<<endl;
				   cout<<"�༭C++�ɼ�������4"<<endl;	  
				   cout<<"�༭Ӣ��ɼ�������5"<<endl;
				   cout<<"�༭�źųɼ�������6"<<endl;
				   cout<<"�༭ģ��ɼ�������7"<<endl;
				   cout<<"�˳�������8"<<endl;
				   cout<<endl;
				   cout<<"������ѡ��:"; 
				   int r; 
				   cin>>r;
				   switch(r)                               
				   { 
					   case 1:cout<<"�༶:";
							  cin>>stu[i].banji;break;     
					   case 2:cout<<"ѧ��:";  
							  cin>>stu[i].num;break; 
					   case 3:cout<<"����:"; 
							  cin>>stu[i].name;break; 
					   case 4:cout<<"C++�ɼ�:"; 
							  cin>>stu[i].gra.cgrade;
							  stu[i].sum=stu[i].gra.cgrade+stu[i].gra.egrade
		                          +stu[i].gra.sgrade+stu[i].gra.mgrade;
                              stu[i].average=stu[i].sum/4;
							  break; 
					   case 5:cout<<"Ӣ��ɼ�:"; 
							  cin>>stu[i].gra.egrade;
							  stu[i].sum=stu[i].gra.cgrade+stu[i].gra.egrade
		                          +stu[i].gra.sgrade+stu[i].gra.mgrade;
                              stu[i].average=stu[i].sum/4;
							  break; 
					   case 6:cout<<"�źųɼ�:"; 
							  cin>>stu[i].gra.sgrade;
							  stu[i].sum=stu[i].gra.cgrade+stu[i].gra.egrade
		                          +stu[i].gra.sgrade+stu[i].gra.mgrade;
                              stu[i].average=stu[i].sum/4;
							  break;
					   case 7:cout<<"ģ��ɼ�:"; 
							  cin>>stu[i].gra.mgrade;
							  stu[i].sum=stu[i].gra.cgrade+stu[i].gra.egrade
		                          +stu[i].gra.sgrade+stu[i].gra.mgrade;
                              stu[i].average=stu[i].sum/4;
							  break; 
					   case 8:cout<<"*****�޸ĳɹ�*****"<<endl;return;break;           
					   default:error(); 
				  } 
			  } 
		  }
		  if(a==stu[i].num) break;  //�ҵ�Ҫ�༭��ѧ�ź󣬽�����ѭ������Сʱ�临�Ӷ�
      } 
     if(s==0) 
      {
          error();
          compile(); 
       } 
}

void sort1()             //���༶ASCII����������
{
	int  i,j;
	string t1,t3;
	int t2;
	float t4,t5,t6,t7,t8,t9;
	for(i=0;i<d-1;i++)
	{
        for(j=0;j<d-i-1;j++)
		{
			if(stu[j].banji>=stu[j+1].banji) 
			{
				t1=stu[j].banji;  
				t2=stu[j].num;
				t3=stu[j].name;
				t4=stu[j].gra.cgrade;
				t5=stu[j].gra.egrade;
				t6=stu[j].gra.sgrade;
				t7=stu[j].gra.mgrade;
				t8=stu[j].sum;
				t9=stu[j].average;
				stu[j].banji=stu[j+1].banji;
				stu[j].num=stu[j+1].num;
				stu[j].name=stu[j+1].name;
				stu[j].gra.cgrade=stu[j+1].gra.cgrade;
				stu[j].gra.egrade=stu[j+1].gra.egrade;
				stu[j].gra.sgrade=stu[j+1].gra.sgrade;
				stu[j].gra.mgrade=stu[j+1].gra.mgrade;
				stu[j].sum=stu[j+1].sum;
				stu[j].average=stu[j+1].average;
				stu[j+1].banji=t1;
				stu[j+1].num=t2;
				stu[j+1].name=t3;
				stu[j+1].gra.cgrade=t4;
				stu[j+1].gra.egrade=t5;
				stu[j+1].gra.sgrade=t6;
				stu[j+1].gra.mgrade=t7;
				stu[j+1].sum=t8;
				stu[j+1].average=t9;
			}
		}
	}
	data_show(); 
	cout<<"����ɹ���"<<endl;
	cout<<endl;
}

void sort2()             //��ѧ����������
{
	int  i,j;
	string t1,t3;
	int t2;
	float t4,t5,t6,t7,t8,t9;
	for(i=0;i<d-1;i++)
	{
        for(j=0;j<d-i-1;j++)
		{
			if(stu[j].num>=stu[j+1].num) 
			{
				t1=stu[j].banji;  
				t2=stu[j].num;
				t3=stu[j].name;
				t4=stu[j].gra.cgrade;
				t5=stu[j].gra.egrade;
				t6=stu[j].gra.sgrade;
				t7=stu[j].gra.mgrade;
				t8=stu[j].sum;
				t9=stu[j].average;
				stu[j].banji=stu[j+1].banji;
				stu[j].num=stu[j+1].num;
				stu[j].name=stu[j+1].name;
				stu[j].gra.cgrade=stu[j+1].gra.cgrade;
				stu[j].gra.egrade=stu[j+1].gra.egrade;
				stu[j].gra.sgrade=stu[j+1].gra.sgrade;
				stu[j].gra.mgrade=stu[j+1].gra.mgrade;
				stu[j].sum=stu[j+1].sum;
				stu[j].average=stu[j+1].average;
				stu[j+1].banji=t1;
				stu[j+1].num=t2;
				stu[j+1].name=t3;
				stu[j+1].gra.cgrade=t4;
				stu[j+1].gra.egrade=t5;
				stu[j+1].gra.sgrade=t6;
				stu[j+1].gra.mgrade=t7;
				stu[j+1].sum=t8;
				stu[j+1].average=t9;
			}
		}
	}
	data_show(); 
	cout<<"����ɹ���"<<endl;
	cout<<endl;
}

void sort3()             //�����ֵ�ASCII����������
{
	int  i,j;
	string t1,t3;
	int t2;
	float t4,t5,t6,t7,t8,t9;
	for(i=0;i<d-1;i++)
	{
        for(j=0;j<d-i-1;j++)
		{
			if(stu[j].name>=stu[j+1].name) 
			{
				t1=stu[j].banji;  
				t2=stu[j].num;
				t3=stu[j].name;
				t4=stu[j].gra.cgrade;
				t5=stu[j].gra.egrade;
				t6=stu[j].gra.sgrade;
				t7=stu[j].gra.mgrade;
				t8=stu[j].sum;
				t9=stu[j].average;
				stu[j].banji=stu[j+1].banji;
				stu[j].num=stu[j+1].num;
				stu[j].name=stu[j+1].name;
				stu[j].gra.cgrade=stu[j+1].gra.cgrade;
				stu[j].gra.egrade=stu[j+1].gra.egrade;
				stu[j].gra.sgrade=stu[j+1].gra.sgrade;
				stu[j].gra.mgrade=stu[j+1].gra.mgrade;
				stu[j].sum=stu[j+1].sum;
				stu[j].average=stu[j+1].average;
				stu[j+1].banji=t1;
				stu[j+1].num=t2;
				stu[j+1].name=t3;
				stu[j+1].gra.cgrade=t4;
				stu[j+1].gra.egrade=t5;
				stu[j+1].gra.sgrade=t6;
				stu[j+1].gra.mgrade=t7;
				stu[j+1].sum=t8;
				stu[j+1].average=t9;
			}
		}
	}
	data_show(); 
	cout<<"����ɹ���"<<endl;
	cout<<endl;
}

void sort4()             //��C++�ɼ���������
{
	int  i,j;
	string t1,t3;
	int t2;
	float t4,t5,t6,t7,t8,t9;
	for(i=0;i<d-1;i++)
	{
        for(j=0;j<d-i-1;j++)
		{
			if(stu[j].gra.cgrade>=stu[j+1].gra.cgrade) 
			{
				t1=stu[j].banji;  
				t2=stu[j].num;
				t3=stu[j].name;
				t4=stu[j].gra.cgrade;
				t5=stu[j].gra.egrade;
				t6=stu[j].gra.sgrade;
				t7=stu[j].gra.mgrade;
				t8=stu[j].sum;
				t9=stu[j].average;
				stu[j].banji=stu[j+1].banji;
				stu[j].num=stu[j+1].num;
				stu[j].name=stu[j+1].name;
				stu[j].gra.cgrade=stu[j+1].gra.cgrade;
				stu[j].gra.egrade=stu[j+1].gra.egrade;
				stu[j].gra.sgrade=stu[j+1].gra.sgrade;
				stu[j].gra.mgrade=stu[j+1].gra.mgrade;
				stu[j].sum=stu[j+1].sum;
				stu[j].average=stu[j+1].average;
				stu[j+1].banji=t1;
				stu[j+1].num=t2;
				stu[j+1].name=t3;
				stu[j+1].gra.cgrade=t4;
				stu[j+1].gra.egrade=t5;
				stu[j+1].gra.sgrade=t6;
				stu[j+1].gra.mgrade=t7;
				stu[j+1].sum=t8;
				stu[j+1].average=t9;
			}
		}
	}
	data_show(); 
	cout<<"����ɹ���"<<endl;
	cout<<endl;
}

void sort5()             //��Ӣ��ɼ���������
{
	int  i,j;
	string t1,t3;
	int t2;
	float t4,t5,t6,t7,t8,t9;
	for(i=0;i<d-1;i++)
	{
        for(j=0;j<d-i-1;j++)
		{
			if(stu[j].gra.egrade>=stu[j+1].gra.egrade) 
			{
				t1=stu[j].banji;  
				t2=stu[j].num;
				t3=stu[j].name;
				t4=stu[j].gra.cgrade;
				t5=stu[j].gra.egrade;
				t6=stu[j].gra.sgrade;
				t7=stu[j].gra.mgrade;
				t8=stu[j].sum;
				t9=stu[j].average;
				stu[j].banji=stu[j+1].banji;
				stu[j].num=stu[j+1].num;
				stu[j].name=stu[j+1].name;
				stu[j].gra.cgrade=stu[j+1].gra.cgrade;
				stu[j].gra.egrade=stu[j+1].gra.egrade;
				stu[j].gra.sgrade=stu[j+1].gra.sgrade;
				stu[j].gra.mgrade=stu[j+1].gra.mgrade;
				stu[j].sum=stu[j+1].sum;
				stu[j].average=stu[j+1].average;
				stu[j+1].banji=t1;
				stu[j+1].num=t2;
				stu[j+1].name=t3;
				stu[j+1].gra.cgrade=t4;
				stu[j+1].gra.egrade=t5;
				stu[j+1].gra.sgrade=t6;
				stu[j+1].gra.mgrade=t7;
				stu[j+1].sum=t8;
				stu[j+1].average=t9;
			}
		}
	}
	data_show(); 
	cout<<"����ɹ���"<<endl;
	cout<<endl;
}

void sort6()             //���źųɼ���������
{
	int  i,j;
	string t1,t3;
	int t2;
	float t4,t5,t6,t7,t8,t9;
	for(i=0;i<d-1;i++)
	{
        for(j=0;j<d-i-1;j++)
		{
			if(stu[j].gra.sgrade>=stu[j+1].gra.sgrade) 
			{
				t1=stu[j].banji;  
				t2=stu[j].num;
				t3=stu[j].name;
				t4=stu[j].gra.cgrade;
				t5=stu[j].gra.egrade;
				t6=stu[j].gra.sgrade;
				t7=stu[j].gra.mgrade;
				t8=stu[j].sum;
				t9=stu[j].average;
				stu[j].banji=stu[j+1].banji;
				stu[j].num=stu[j+1].num;
				stu[j].name=stu[j+1].name;
				stu[j].gra.cgrade=stu[j+1].gra.cgrade;
				stu[j].gra.egrade=stu[j+1].gra.egrade;
				stu[j].gra.sgrade=stu[j+1].gra.sgrade;
				stu[j].gra.mgrade=stu[j+1].gra.mgrade;
				stu[j].sum=stu[j+1].sum;
				stu[j].average=stu[j+1].average;
				stu[j+1].banji=t1;
				stu[j+1].num=t2;
				stu[j+1].name=t3;
				stu[j+1].gra.cgrade=t4;
				stu[j+1].gra.egrade=t5;
				stu[j+1].gra.sgrade=t6;
				stu[j+1].gra.mgrade=t7;
				stu[j+1].sum=t8;
				stu[j+1].average=t9;
			}
		}
	}
	data_show(); 
	cout<<"����ɹ���"<<endl;
	cout<<endl;
}

void sort7()             //��ģ��ɼ���������
{
	int  i,j;
	string t1,t3;
	int t2;
	float t4,t5,t6,t7,t8,t9;
	for(i=0;i<d-1;i++)
	{
        for(j=0;j<d-i-1;j++)
		{
			if(stu[j].gra.mgrade>=stu[j+1].gra.mgrade) 
			{
				t1=stu[j].banji;  
				t2=stu[j].num;
				t3=stu[j].name;
				t4=stu[j].gra.cgrade;
				t5=stu[j].gra.egrade;
				t6=stu[j].gra.sgrade;
				t7=stu[j].gra.mgrade;
				t8=stu[j].sum;
				t9=stu[j].average;
				stu[j].banji=stu[j+1].banji;
				stu[j].num=stu[j+1].num;
				stu[j].name=stu[j+1].name;
				stu[j].gra.cgrade=stu[j+1].gra.cgrade;
				stu[j].gra.egrade=stu[j+1].gra.egrade;
				stu[j].gra.sgrade=stu[j+1].gra.sgrade;
				stu[j].gra.mgrade=stu[j+1].gra.mgrade;
				stu[j].sum=stu[j+1].sum;
				stu[j].average=stu[j+1].average;
				stu[j+1].banji=t1;
				stu[j+1].num=t2;
				stu[j+1].name=t3;
				stu[j+1].gra.cgrade=t4;
				stu[j+1].gra.egrade=t5;
				stu[j+1].gra.sgrade=t6;
				stu[j+1].gra.mgrade=t7;
				stu[j+1].sum=t8;
				stu[j+1].average=t9;
			}
		}
	}
	data_show(); 
	cout<<"����ɹ���"<<endl;
	cout<<endl;
}

void sort8()             //��ƽ���ɼ���������
{
	int  i,j;
	string t1,t3;
	int t2;
	float t4,t5,t6,t7,t8,t9;
	for(i=0;i<d-1;i++)
	{
        for(j=0;j<d-i-1;j++)
		{
			if(stu[j].average>=stu[j+1].average) 
			{
				t1=stu[j].banji;  
				t2=stu[j].num;
				t3=stu[j].name;
				t4=stu[j].gra.cgrade;
				t5=stu[j].gra.egrade;
				t6=stu[j].gra.sgrade;
				t7=stu[j].gra.mgrade;
				t8=stu[j].sum;
				t9=stu[j].average;
				stu[j].banji=stu[j+1].banji;
				stu[j].num=stu[j+1].num;
				stu[j].name=stu[j+1].name;
				stu[j].gra.cgrade=stu[j+1].gra.cgrade;
				stu[j].gra.egrade=stu[j+1].gra.egrade;
				stu[j].gra.sgrade=stu[j+1].gra.sgrade;
				stu[j].gra.mgrade=stu[j+1].gra.mgrade;
				stu[j].sum=stu[j+1].sum;
				stu[j].average=stu[j+1].average;
				stu[j+1].banji=t1;
				stu[j+1].num=t2;
				stu[j+1].name=t3;
				stu[j+1].gra.cgrade=t4;
				stu[j+1].gra.egrade=t5;
				stu[j+1].gra.sgrade=t6;
				stu[j+1].gra.mgrade=t7;
				stu[j+1].sum=t8;
				stu[j+1].average=t9;
			}
		}
	}
	data_show(); 
	cout<<"����ɹ���"<<endl;
	cout<<endl;
}

void sort()            //��������
{
	for(;;)
	{
		cout<<"���༶����������1"<<endl;
	    cout<<"��ѧ������������2"<<endl;
	    cout<<"����������������3"<<endl;
	    cout<<"��C++�ɼ�����������4"<<endl;
	    cout<<"��Ӣ��ɼ�����������5"<<endl;
	    cout<<"���źųɼ�����������6"<<endl;
	    cout<<"��ģ��ɼ�����������7"<<endl;
	    cout<<"��ƽ���ɼ�����������8"<<endl;
	    cout<<"�˳�����������9"<<endl;
	    cout<<endl;
	    cout<<"������ѡ��:"; 
	    int r; 
	    cin>>r;
	    switch(r)                                    
	    {
	    	case 1:sort1();break;     
            case 2:sort2();break;    
			case 3:sort3();break;    
			case 4:sort4();break;   
			case 5:sort5();break; 
			case 6:sort6();break;
			case 7:sort7();break;
			case 8:sort8();break;
    		case 9:cout<<"*****�������*****"<<endl;return;break;           
			default:error(); 
		} 
	}
}

void calculate()             //ʵ�ֶԳɼ���ͳ�ƹ���
{
	data_show();
	int i,j;
    float sumc=0,sume=0,sums=0,summ=0;
    float countc=0,counte=0,counts=0,countm=0;
	float maxc=stu[0].gra.cgrade,minc=stu[0].gra.cgrade,
		  maxe=stu[0].gra.egrade,mine=stu[0].gra.egrade,
		  maxs=stu[0].gra.sgrade,mins=stu[0].gra.sgrade,
		  maxm=stu[0].gra.mgrade,minm=stu[0].gra.mgrade,
		  max_score=maxc+maxe+maxs+maxm,min_score=minc+mine+mins+minm;
	for(i=1;i<d;i++)                        //�󵥿Ƴɼ����ܳɼ�����߷ּ���ͷ�
	{
		if(maxc<stu[i].gra.cgrade)
			maxc=stu[i].gra.cgrade;
		if(minc>stu[i].gra.cgrade)
			minc=stu[i].gra.cgrade;
		if(maxe<stu[i].gra.egrade)
			maxe=stu[i].gra.egrade;
		if(mine>stu[i].gra.egrade)
			mine=stu[i].gra.egrade;
		if(maxs<stu[i].gra.sgrade)
			maxs=stu[i].gra.sgrade;
		if(mins>stu[i].gra.sgrade)
			mins=stu[i].gra.sgrade;
		if(maxm<stu[i].gra.mgrade)
			maxm=stu[i].gra.mgrade;
		if(minm>stu[i].gra.mgrade)
			minm=stu[i].gra.mgrade;		
		if(max_score<(stu[i].gra.cgrade+stu[i].gra.egrade
		              +stu[i].gra.sgrade+stu[i].gra.mgrade))	
			max_score=stu[i].gra.cgrade+stu[i].gra.egrade
		              +stu[i].gra.sgrade+stu[i].gra.mgrade;
		if(min_score>(stu[i].gra.cgrade+stu[i].gra.egrade
		              +stu[i].gra.sgrade+stu[i].gra.mgrade))	
			min_score=stu[i].gra.cgrade+stu[i].gra.egrade
		              +stu[i].gra.sgrade+stu[i].gra.mgrade;
	}
		 
	for(j=0;j<d;j++)              //�󵥿Ƴɼ���ƽ���ּ�������
	{
		sumc=sumc+stu[j].gra.cgrade;
		if(stu[j].gra.cgrade>=60) ++countc;
        sume=sume+stu[j].gra.egrade;
		if(stu[j].gra.egrade>=60) ++counte;
		sums=sums+stu[j].gra.sgrade;
		if(stu[j].gra.sgrade>=60) ++counts;
		summ=summ+stu[j].gra.mgrade;
		if(stu[j].gra.mgrade>=60) ++countm;
	}
    for(;;)
    {
    	cout<<"��������Ӧ�����ѡ������Ҫͳ�Ƶĳɼ�"<<endl;
	    cout<<"1 C++�ɼ���2 Ӣ��ɼ���3 �źųɼ���4 ģ��ɼ���5 �ܳɼ���6 �˳�"<<endl;  
		cout<<"��������ţ�";
		int r; 
		cin>>r; 
		switch(r)                               
		{ 
			case 1:cout<<"C++��߷�:"<<maxc<<"  C++��ͷ�:"<<minc
				   	   <<"  C++ƽ����:"<<sumc/d<<"  C++������:"<<countc/d<<endl<<endl;break; 
			case 2:cout<<"Ӣ����߷�:"<<maxe<<"  Ӣ����ͷ�:"<<mine
				   	   <<"  Ӣ��ƽ����:"<<sume/d<<"  Ӣ�Ｐ����:"<<counte/d<<endl<<endl;break;
			case 3:cout<<"�ź���߷�:"<<maxs<<"  �ź���ͷ�:"<<mins
				       <<"  �ź�ƽ����:"<<sums/d<<"  �źż�����:"<<counts/d<<endl<<endl;break;
			case 4:cout<<"ģ����߷�:"<<maxm<<"  ģ����ͷ�:"<<minm
				       <<"  ģ��ƽ����:"<<summ/d<<"  ģ�缰����:"<<countm/d<<endl<<endl;break;
			case 5:cout<<"�ܷ���߷�:"<<max_score<<"  �ܷ���ͷ�:"<<min_score<<endl<<endl;break;
			case 6:cout<<"*****ͳ�����******";return;break;
			default:error();
		}
    }
}

void search1()                        //��ѧ�Ų�ѯѧ���ɼ�
{     
      data_show();
      cout<<"��������Ҫ��ѯ��ѧ��:"; 
      int a,i=0,s=0;
	  cin>>a;                                                        
      for(i=0;i<d;i++) 
      { 
		  if(a==stu[i].num)
		  {
			  cout<<"(1).�༶:"<<stu[i].banji<<endl; 
			  cout<<"(2).ѧ��:"<<stu[i].num<<endl; 
			  cout<<"(3).����:"<<stu[i].name<<endl;
	   	      cout<<"(4).C++�ɼ�:"<<stu[i].gra.cgrade<<endl; 
			  cout<<"(5).Ӣ��ɼ�:"<<stu[i].gra.egrade<<endl;
			  cout<<"(6).�źųɼ�:"<<stu[i].gra.sgrade<<endl;
			  cout<<"(7).ģ��ɼ�:"<<stu[i].gra.mgrade<<endl;
			  cout<<"(8).�ܳɼ�:"<<stu[i].sum<<endl;
			  cout<<"(9).ƽ���ɼ�:"<<stu[i].average<<endl;
		      cout<<endl;
		      s=1;
		  }
		  if(a==stu[i].num) break;  //�ҵ�Ҫ���ҵ�ѧ�ź󣬽�����ѭ������Сʱ�临�Ӷ�
		 
	  }
	  if(s==0) 
		  cout<<"*****��Ǹû����Ҫ��ѯ����Ϣ*****"<<endl<<endl;
} 

void search2()                         //��������ѯѧ���ɼ�
{     
      data_show();
      cout<<"��������Ҫ��ѯ������:"; 
      int i=0,s=0;
      string a;
	  cin>>a;                                                        
      for(i=0;i<d;i++) 
      { 
		  if(a==stu[i].name)
		  {
			  cout<<"(1).�༶:"<<stu[i].banji<<endl; 
			  cout<<"(2).ѧ��:"<<stu[i].num<<endl; 
			  cout<<"(3).����:"<<stu[i].name<<endl;
	   	      cout<<"(4).C++�ɼ�:"<<stu[i].gra.cgrade<<endl; 
			  cout<<"(5).Ӣ��ɼ�:"<<stu[i].gra.egrade<<endl;
			  cout<<"(6).�źųɼ�:"<<stu[i].gra.sgrade<<endl;
			  cout<<"(7).ģ��ɼ�:"<<stu[i].gra.mgrade<<endl;
			  cout<<"(8).�ܳɼ�:"<<stu[i].sum<<endl;
			  cout<<"(9).ƽ���ɼ�:"<<stu[i].average<<endl;
		      cout<<endl;
		      s=1;
		  }
		  if(a==stu[i].name) break;  //�ҵ�Ҫ���ҵ������󣬽�����ѭ������Сʱ�临�Ӷ�
		 
	  }
	  if(s==0) 
		  cout<<"*****��Ǹû����Ҫ��ѯ����Ϣ*****"<<endl<<endl;
}

void search3()                         //���γ�����ѯ�γ̳ɼ�
{     
      data_show();
      cout<<"��������Ӧ�����ѡ������Ҫ��ѯ�ĳɼ�"<<endl;
	  cout<<"1 C++�ɼ���2 Ӣ��ɼ���3 �źųɼ���4 ģ��ɼ���5 ƽ���ɼ�"<<endl;
      cout<<"��������ţ�";
      int r,i;
	  cin>>r;
	  switch(r)
	  {
	  	case 1:cout<<setiosflags(ios::left)
	               <<setw(8)<<"�༶"
				   <<setw(8)<<"ѧ��"
			       <<setw(8)<<"����"
			       <<setw(8)<<"C++"<<endl;
	           for(i=0;i<d;i++)
	           {
	           	cout<<setiosflags(ios::left)
			        <<setw(8)<<stu[i].banji
			        <<setw(8)<<stu[i].num
			        <<setw(8)<<stu[i].name
			        <<setw(8)<<stu[i].gra.cgrade<<endl;
			    }
                cout<<endl;break;
         case 2:cout<<setiosflags(ios::left)
	                <<setw(8)<<"�༶"
				    <<setw(8)<<"ѧ��"
			        <<setw(8)<<"����"
			        <<setw(8)<<"Ӣ��"<<endl;
	            for(i=0;i<d;i++)
	            {
	           	cout<<setiosflags(ios::left)
			        <<setw(8)<<stu[i].banji
			        <<setw(8)<<stu[i].num
			        <<setw(8)<<stu[i].name
			        <<setw(8)<<stu[i].gra.egrade<<endl;
			    }
                cout<<endl;break; 
         case 3:cout<<setiosflags(ios::left)
	                <<setw(8)<<"�༶"
				    <<setw(8)<<"ѧ��"
			        <<setw(8)<<"����"
			        <<setw(8)<<"�ź�"<<endl;
	            for(i=0;i<d;i++)
	            {
	           	cout<<setiosflags(ios::left)
			        <<setw(8)<<stu[i].banji
			        <<setw(8)<<stu[i].num
			        <<setw(8)<<stu[i].name
			        <<setw(8)<<stu[i].gra.sgrade<<endl;
			    }
                cout<<endl;break;            
         case 4:cout<<setiosflags(ios::left)
	                <<setw(8)<<"�༶"
				    <<setw(8)<<"ѧ��"
			        <<setw(8)<<"����"
			        <<setw(8)<<"ģ��"<<endl;
	            for(i=0;i<d;i++)
	            {
	             cout<<setiosflags(ios::left)
			         <<setw(8)<<stu[i].banji
			         <<setw(8)<<stu[i].num
			         <<setw(8)<<stu[i].name
			         <<setw(8)<<stu[i].gra.mgrade<<endl;
			     }
                 cout<<endl;break; 
          case 5:cout<<setiosflags(ios::left)
	                 <<setw(8)<<"�༶"
				     <<setw(8)<<"ѧ��"
			         <<setw(8)<<"����"
			         <<setw(8)<<"ƽ���ɼ�"<<endl;
	             for(i=0;i<d;i++)
	             {
	           	  cout<<setiosflags(ios::left)
			          <<setw(8)<<stu[i].banji
			          <<setw(8)<<stu[i].num
			          <<setw(8)<<stu[i].name
			          <<setw(8)<<stu[i].average<<endl;
			      }
                  cout<<endl;break;     
           default: cout<<"*****��Ǹû����Ҫ��ѯ����Ϣ*****"<<endl<<endl;     
	  }
}

void search()                    //����ѯ����
{
	for(;;)
	{
		cout<<endl;
		cout<<"��ѧ�Ų���������1"<<endl;
		cout<<"����������������2"<<endl;
		cout<<"���γ̲���������3"<<endl;
		cout<<"�˳�������4"<<endl;
		cout<<endl;
		cout<<"������ѡ��:"; 
		int r; 
		cin>>r;
		switch(r)                                    
		{
			case 1:search1();break;     
    		case 2:search2();break;    
			case 3:search3();break;    
    		case 4:cout<<"*****��ѯ���*****"<<endl;return;break;           
			default:error(); 
		} 
	}
}

void savefile()            //��ѧ���ɼ���Ϣ�浽������                                    
{
        int i;
        ofstream outfile("E://����//ѧ���ɼ�.txt",ios::out);
                           //��Cѧϰ��������·����Ҫ�á�//���������á�/��
		if(!outfile)
		{
			cerr<<"open ѧ���ɼ�.txt error!"<<endl;
			exit(1);
		}
		outfile<<d<<endl;
		for(i=0;i<d;i++)
		{
			outfile<<stu[i].banji<<' ';
			outfile<<stu[i].num<<' ';
			outfile<<stu[i].name<<' ';
	        outfile<<stu[i].gra.cgrade<<' ';
			outfile<<stu[i].gra.egrade<<' ';
			outfile<<stu[i].gra.sgrade<<' ';
			outfile<<stu[i].gra.mgrade<<' ';
            outfile<<stu[i].sum<<' ';
			outfile<<stu[i].average<<' ';
			outfile<<endl;
		}
	    outfile.close();
       	cout<<endl;	
		cout<<"ѧ����Ϣ�ѱ���"<<endl;
}

void loadfile()            //��ѧ���ɼ��Ӵ�������ĳ�����
{
	ifstream infile("E://����//ѧ���ɼ�.txt",ios::in);
	                       //��Cѧϰ��������·����Ҫ�á�//���������á�/��
    if(!infile)
	{
		cerr<<"open ѧ���ɼ�.txt error!"<<endl;
		exit(1);
	}
	infile>>d;
	for(int i=0;i<d;i++)
	{
	infile>>stu[i].banji;
	infile>>stu[i].num;	
	infile>>stu[i].name;
	infile>>stu[i].gra.cgrade;
	infile>>stu[i].gra.egrade;
	infile>>stu[i].gra.sgrade;
	infile>>stu[i].gra.mgrade;
    infile>>stu[i].sum;	
	infile>>stu[i].average;
	}
}




void main()                                                      
{ 
   loadfile();
   for(;;) 
   {   cout<<endl;
	   cout<<"*****��ӭʹ��ѧ���ɼ���������ϵͳ*****\n"; 
	   cout<<"*             ���ܲ˵�:              *\n";
	   cout<<"*         1 ���ѧ���ɼ���Ϣ         *\n"; 
	   cout<<"*         2 ���ѧ���ɼ���Ϣ         *\n";                                  
	   cout<<"*         3 ɾ��ѧ���ɼ���Ϣ         *\n";
	   cout<<"*         4 �༭ѧ���ɼ���Ϣ         *\n"; 
	   cout<<"*         5 ѧ���ɼ���Ϣ����         *\n"; 
	   cout<<"*         6 ѧ���ɼ���Ϣͳ��         *\n"; 
	   cout<<"*         7 ѧ���ɼ���Ϣ��ѯ         *\n";
	   cout<<"*         8 ����ѧ���ɼ���Ϣ         *\n";
	   cout<<"*         9 ��            ��         *\n"; 
	   cout<<"**************************************\n";
	   cout<<"������ѡ�";
	   int r;
	   cin>>r; 
       cout<<endl; 
	   switch(r)
	   {
	   	case 1:data_show();break;                              
        case 2:data_input();break;                                
		case 3:data_delete();break;                                   
		case 4:compile();break;                                   
		case 5:sort();break; 
		case 6:calculate();break;
		case 7:search();break; 
		case 8:savefile();break;
		case 9:cout<<"*****ллʹ��*****\n";return;break;                                                      
		default:error();
	   } 
		cout<<endl;
   }
}