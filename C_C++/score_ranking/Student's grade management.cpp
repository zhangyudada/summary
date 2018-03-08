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

void error()                   //出错提示
{
	cout<<"*****输入有误请重新输入*****"<<endl<<endl;
}

void data_input()              //学生信息的录入以及添加                                         
{ 
	int i;
	cout<<"请依次输入学生相关信息,输入end结束"<<endl;
	cout<<"班级   学号  姓名   C++  英语  信号  模电"<<endl;
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

void data_show()               //学生信息的显示                                                  
{
	int i;
	cout<<endl;
	cout<<setiosflags(ios::left)
	    <<setw(8)<<"班级"
		<<setw(8)<<"学号"
		<<setw(8)<<"姓名"
		<<setw(8)<<"C++"
		<<setw(8)<<"英语"
		<<setw(8)<<"信号"
		<<setw(8)<<"模电"
		<<setw(8)<<"总分"
		<<setw(8)<<"平均分"<<endl;	
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

void data_delete()            //学生信息的删除                                    
{ 
     data_show();
     cout<<"请选择您要删除的学号:"; 
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
				 cout<<"*****删除成功*****"<<endl;	
			}
			if(a==stu[i].num) break;  //找到要删除的学号后，结束外循环，减小时间复杂度
         }
       if(s==0) error();
}
		      
void compile()               //学生信息的编辑                                                   
{ 
      data_show(); 
      cout<<"请选择您要编辑的学号:"; 
      int i,a,s=0; 
      cin>>a; 
	  for(i=0;i<d;i++)
	  {
		  if(a==stu[i].num)
		  { 
			  s=1;
			  for(;;)                          
			  { 
				   cout<<"(1).班级:"<<stu[i].banji<<endl; 
				   cout<<"(2).学号:"<<stu[i].num<<endl; 
				   cout<<"(3).姓名:"<<stu[i].name<<endl;
				   cout<<"(4).C++成绩:"<<stu[i].gra.cgrade<<endl; 
				   cout<<"(5).英语成绩:"<<stu[i].gra.egrade<<endl;
				   cout<<"(6).信号成绩:"<<stu[i].gra.sgrade<<endl;
				   cout<<"(7).模电成绩:"<<stu[i].gra.mgrade<<endl;
				   cout<<"(8).总成绩:"<<stu[i].sum<<endl;
				   cout<<"(9).平均成绩:"<<stu[i].average<<endl;
				   cout<<endl;
				   cout<<"编辑班级请输入1"<<endl;
				   cout<<"编辑学号请输入2"<<endl;
				   cout<<"编辑姓名请输入3"<<endl;
				   cout<<"编辑C++成绩请输入4"<<endl;	  
				   cout<<"编辑英语成绩请输入5"<<endl;
				   cout<<"编辑信号成绩请输入6"<<endl;
				   cout<<"编辑模电成绩请输入7"<<endl;
				   cout<<"退出请输入8"<<endl;
				   cout<<endl;
				   cout<<"请输入选项:"; 
				   int r; 
				   cin>>r;
				   switch(r)                               
				   { 
					   case 1:cout<<"班级:";
							  cin>>stu[i].banji;break;     
					   case 2:cout<<"学号:";  
							  cin>>stu[i].num;break; 
					   case 3:cout<<"姓名:"; 
							  cin>>stu[i].name;break; 
					   case 4:cout<<"C++成绩:"; 
							  cin>>stu[i].gra.cgrade;
							  stu[i].sum=stu[i].gra.cgrade+stu[i].gra.egrade
		                          +stu[i].gra.sgrade+stu[i].gra.mgrade;
                              stu[i].average=stu[i].sum/4;
							  break; 
					   case 5:cout<<"英语成绩:"; 
							  cin>>stu[i].gra.egrade;
							  stu[i].sum=stu[i].gra.cgrade+stu[i].gra.egrade
		                          +stu[i].gra.sgrade+stu[i].gra.mgrade;
                              stu[i].average=stu[i].sum/4;
							  break; 
					   case 6:cout<<"信号成绩:"; 
							  cin>>stu[i].gra.sgrade;
							  stu[i].sum=stu[i].gra.cgrade+stu[i].gra.egrade
		                          +stu[i].gra.sgrade+stu[i].gra.mgrade;
                              stu[i].average=stu[i].sum/4;
							  break;
					   case 7:cout<<"模电成绩:"; 
							  cin>>stu[i].gra.mgrade;
							  stu[i].sum=stu[i].gra.cgrade+stu[i].gra.egrade
		                          +stu[i].gra.sgrade+stu[i].gra.mgrade;
                              stu[i].average=stu[i].sum/4;
							  break; 
					   case 8:cout<<"*****修改成功*****"<<endl;return;break;           
					   default:error(); 
				  } 
			  } 
		  }
		  if(a==stu[i].num) break;  //找到要编辑的学号后，结束外循环，减小时间复杂度
      } 
     if(s==0) 
      {
          error();
          compile(); 
       } 
}

void sort1()             //按班级ASCII码升序排序
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
	cout<<"排序成功！"<<endl;
	cout<<endl;
}

void sort2()             //按学号升序排序
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
	cout<<"排序成功！"<<endl;
	cout<<endl;
}

void sort3()             //按名字的ASCII码升序排序
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
	cout<<"排序成功！"<<endl;
	cout<<endl;
}

void sort4()             //按C++成绩升序排序
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
	cout<<"排序成功！"<<endl;
	cout<<endl;
}

void sort5()             //按英语成绩升序排序
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
	cout<<"排序成功！"<<endl;
	cout<<endl;
}

void sort6()             //按信号成绩升序排序
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
	cout<<"排序成功！"<<endl;
	cout<<endl;
}

void sort7()             //按模电成绩升序排序
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
	cout<<"排序成功！"<<endl;
	cout<<endl;
}

void sort8()             //按平均成绩升序排序
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
	cout<<"排序成功！"<<endl;
	cout<<endl;
}

void sort()            //主排序函数
{
	for(;;)
	{
		cout<<"按班级排序请输入1"<<endl;
	    cout<<"按学号排序请输入2"<<endl;
	    cout<<"按姓名排序请输入3"<<endl;
	    cout<<"按C++成绩排序请输入4"<<endl;
	    cout<<"按英语成绩排序请输入5"<<endl;
	    cout<<"按信号成绩排序请输入6"<<endl;
	    cout<<"按模电成绩排序请输入7"<<endl;
	    cout<<"按平均成绩排序请输入8"<<endl;
	    cout<<"退出程序请输入9"<<endl;
	    cout<<endl;
	    cout<<"请输入选项:"; 
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
    		case 9:cout<<"*****排序完成*****"<<endl;return;break;           
			default:error(); 
		} 
	}
}

void calculate()             //实现对成绩的统计功能
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
	for(i=1;i<d;i++)                        //求单科成绩与总成绩的最高分及最低分
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
		 
	for(j=0;j<d;j++)              //求单科成绩的平均分及及格率
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
    	cout<<"请输入相应序号以选择你需要统计的成绩"<<endl;
	    cout<<"1 C++成绩，2 英语成绩，3 信号成绩，4 模电成绩，5 总成绩，6 退出"<<endl;  
		cout<<"请输入序号：";
		int r; 
		cin>>r; 
		switch(r)                               
		{ 
			case 1:cout<<"C++最高分:"<<maxc<<"  C++最低分:"<<minc
				   	   <<"  C++平均分:"<<sumc/d<<"  C++及格率:"<<countc/d<<endl<<endl;break; 
			case 2:cout<<"英语最高分:"<<maxe<<"  英语最低分:"<<mine
				   	   <<"  英语平均分:"<<sume/d<<"  英语及格率:"<<counte/d<<endl<<endl;break;
			case 3:cout<<"信号最高分:"<<maxs<<"  信号最低分:"<<mins
				       <<"  信号平均分:"<<sums/d<<"  信号及格率:"<<counts/d<<endl<<endl;break;
			case 4:cout<<"模电最高分:"<<maxm<<"  模电最低分:"<<minm
				       <<"  模电平均分:"<<summ/d<<"  模电及格率:"<<countm/d<<endl<<endl;break;
			case 5:cout<<"总分最高分:"<<max_score<<"  总分最低分:"<<min_score<<endl<<endl;break;
			case 6:cout<<"*****统计完成******";return;break;
			default:error();
		}
    }
}

void search1()                        //按学号查询学生成绩
{     
      data_show();
      cout<<"请输入您要查询的学号:"; 
      int a,i=0,s=0;
	  cin>>a;                                                        
      for(i=0;i<d;i++) 
      { 
		  if(a==stu[i].num)
		  {
			  cout<<"(1).班级:"<<stu[i].banji<<endl; 
			  cout<<"(2).学号:"<<stu[i].num<<endl; 
			  cout<<"(3).姓名:"<<stu[i].name<<endl;
	   	      cout<<"(4).C++成绩:"<<stu[i].gra.cgrade<<endl; 
			  cout<<"(5).英语成绩:"<<stu[i].gra.egrade<<endl;
			  cout<<"(6).信号成绩:"<<stu[i].gra.sgrade<<endl;
			  cout<<"(7).模电成绩:"<<stu[i].gra.mgrade<<endl;
			  cout<<"(8).总成绩:"<<stu[i].sum<<endl;
			  cout<<"(9).平均成绩:"<<stu[i].average<<endl;
		      cout<<endl;
		      s=1;
		  }
		  if(a==stu[i].num) break;  //找到要查找的学号后，结束外循环，减小时间复杂度
		 
	  }
	  if(s==0) 
		  cout<<"*****抱歉没有您要查询的信息*****"<<endl<<endl;
} 

void search2()                         //按姓名查询学生成绩
{     
      data_show();
      cout<<"请输入您要查询的姓名:"; 
      int i=0,s=0;
      string a;
	  cin>>a;                                                        
      for(i=0;i<d;i++) 
      { 
		  if(a==stu[i].name)
		  {
			  cout<<"(1).班级:"<<stu[i].banji<<endl; 
			  cout<<"(2).学号:"<<stu[i].num<<endl; 
			  cout<<"(3).姓名:"<<stu[i].name<<endl;
	   	      cout<<"(4).C++成绩:"<<stu[i].gra.cgrade<<endl; 
			  cout<<"(5).英语成绩:"<<stu[i].gra.egrade<<endl;
			  cout<<"(6).信号成绩:"<<stu[i].gra.sgrade<<endl;
			  cout<<"(7).模电成绩:"<<stu[i].gra.mgrade<<endl;
			  cout<<"(8).总成绩:"<<stu[i].sum<<endl;
			  cout<<"(9).平均成绩:"<<stu[i].average<<endl;
		      cout<<endl;
		      s=1;
		  }
		  if(a==stu[i].name) break;  //找到要查找的姓名后，结束外循环，减小时间复杂度
		 
	  }
	  if(s==0) 
		  cout<<"*****抱歉没有您要查询的信息*****"<<endl<<endl;
}

void search3()                         //按课程名查询课程成绩
{     
      data_show();
      cout<<"请输入相应序号以选择你需要查询的成绩"<<endl;
	  cout<<"1 C++成绩，2 英语成绩，3 信号成绩，4 模电成绩，5 平均成绩"<<endl;
      cout<<"请输入序号：";
      int r,i;
	  cin>>r;
	  switch(r)
	  {
	  	case 1:cout<<setiosflags(ios::left)
	               <<setw(8)<<"班级"
				   <<setw(8)<<"学号"
			       <<setw(8)<<"姓名"
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
	                <<setw(8)<<"班级"
				    <<setw(8)<<"学号"
			        <<setw(8)<<"姓名"
			        <<setw(8)<<"英语"<<endl;
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
	                <<setw(8)<<"班级"
				    <<setw(8)<<"学号"
			        <<setw(8)<<"姓名"
			        <<setw(8)<<"信号"<<endl;
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
	                <<setw(8)<<"班级"
				    <<setw(8)<<"学号"
			        <<setw(8)<<"姓名"
			        <<setw(8)<<"模电"<<endl;
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
	                 <<setw(8)<<"班级"
				     <<setw(8)<<"学号"
			         <<setw(8)<<"姓名"
			         <<setw(8)<<"平均成绩"<<endl;
	             for(i=0;i<d;i++)
	             {
	           	  cout<<setiosflags(ios::left)
			          <<setw(8)<<stu[i].banji
			          <<setw(8)<<stu[i].num
			          <<setw(8)<<stu[i].name
			          <<setw(8)<<stu[i].average<<endl;
			      }
                  cout<<endl;break;     
           default: cout<<"*****抱歉没有您要查询的信息*****"<<endl<<endl;     
	  }
}

void search()                    //主查询函数
{
	for(;;)
	{
		cout<<endl;
		cout<<"按学号查找请输入1"<<endl;
		cout<<"按姓名查找请输入2"<<endl;
		cout<<"按课程查找请输入3"<<endl;
		cout<<"退出请输入4"<<endl;
		cout<<endl;
		cout<<"请输入选项:"; 
		int r; 
		cin>>r;
		switch(r)                                    
		{
			case 1:search1();break;     
    		case 2:search2();break;    
			case 3:search3();break;    
    		case 4:cout<<"*****查询完成*****"<<endl;return;break;           
			default:error(); 
		} 
	}
}

void savefile()            //将学生成绩信息存到磁盘中                                    
{
        int i;
        ofstream outfile("E://张宇//学生成绩.txt",ios::out);
                           //在C学习编译器中路径需要用“//”，不能用“/”
		if(!outfile)
		{
			cerr<<"open 学生成绩.txt error!"<<endl;
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
		cout<<"学生信息已保存"<<endl;
}

void loadfile()            //将学生成绩从磁盘载入的程序中
{
	ifstream infile("E://张宇//学生成绩.txt",ios::in);
	                       //在C学习编译器中路径需要用“//”，不能用“/”
    if(!infile)
	{
		cerr<<"open 学生成绩.txt error!"<<endl;
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
	   cout<<"*****欢迎使用学生成绩排名管理系统*****\n"; 
	   cout<<"*             功能菜单:              *\n";
	   cout<<"*         1 浏览学生成绩信息         *\n"; 
	   cout<<"*         2 添加学生成绩信息         *\n";                                  
	   cout<<"*         3 删除学生成绩信息         *\n";
	   cout<<"*         4 编辑学生成绩信息         *\n"; 
	   cout<<"*         5 学生成绩信息排序         *\n"; 
	   cout<<"*         6 学生成绩信息统计         *\n"; 
	   cout<<"*         7 学生成绩信息查询         *\n";
	   cout<<"*         8 保存学生成绩信息         *\n";
	   cout<<"*         9 退            出         *\n"; 
	   cout<<"**************************************\n";
	   cout<<"请输入选项：";
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
		case 9:cout<<"*****谢谢使用*****\n";return;break;                                                      
		default:error();
	   } 
		cout<<endl;
   }
}