/********************************
设计名称 ； 超声波测距

时     间 ： 2015/9/14-2015/9/25
*********************************/

#include <reg52.h>
#define uchar unsigned char
#define uint unsigned int

sbit Trig = P3^2;		//启动超声波测距的引脚     
sbit Echo = P3^3;		//接收超声波回传信号的引脚      
sbit Qian = P3^4;		//数码管最高位选信号引脚     
sbit Bai = P3^5;		//数码管次高位选信号引脚     
sbit Shi = P3^6;		//数码管次低位选信号引脚     
sbit Ge = P3^7;			//数码管最低位选信号引脚     
sbit S2 = P2^0;			//校准开关引脚   
sbit S3 = P2^1;			//加距离开关引脚    
sbit S4 = P2^2;			//减距离开关引脚    
sbit Beep = P2^3;		//蜂鸣器控制引脚    
int succeed_flag;		//接收到超声波回传信号与否的标志      
int time;				//回传信号持续时间    
float speed = 0.340;	//声速，单位mm/us   
uint STDDISTANCE = 1000;//校准用标准距离，1000mm   
uint distance;			//存放测量好的距离    
uchar timeH;			//16位定时器高8位数据    
uchar timeL;			//16位定时器低8位数据    
uchar code Table[10] = {0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};
						//4位共阳极数码管数字编码数组     
void delayms(uint z);	//延时z ms   
void delay_20us();		//延时20us  
void keyscan();			//按键扫描  
void display();			//数码管动态显示距离     

//按下一次复位键，进行一次测距     
void main()
{
	
	TMOD = 0x01;    	//定时器0，工作方式1，16位计数    
	Trig = 0;       	//首先拉低脉冲输入引脚    
	EA = 0;           	//关总中断 
  	Trig = 1;         	//超声波输入端送入高电平     
  	delay_20us();   	//延时20us 
  	Trig = 0;         	//产生一个20us的脉冲   
  	while(Echo == 0); 	//等待Echo回波引脚变高电平     
  	succeed_flag = 0; 	//清测量成功标志   
  	EA = 1;				//开总中断  
    IT1 = 1;			//外部中断1触发方式为下降沿触发         
  	EX1 = 1;      		//打开外部中断1     
  	TH0 = 0;          	//定时器0清零  
  	TL0 = 0;         	//定时器0清零  
  	TF0 = 0;          	//计数溢出标志  
  	TR0 = 1;          	//启动定时器0   
  	delayms(20);      	//等待测量的结果  
  	TR0 = 0;          	//关闭定时器0   
  	EX1 = 0;          	//关闭外部中断1   
	if(succeed_flag == 1)
  	{               
		time = timeH * 256 + timeL;
  		distance = time/2*speed; //毫米  
     }
  	if(succeed_flag == 0)
  	{            
		distance = 0;     		//没有回波则清零      
   	}
   	//循环检测按键并显示距离    
	while(1)
	{
		keyscan();
		if(distance < 500)
			Beep = 0;			//距离小于500mm，则蜂鸣器报警    
		if(distance >= 500)
			Beep = 1;
  		display();
	}
}

//外部中断1，用做判断回波电平      
void int1()  interrupt 2   	//外部中断1中断号是2     
{        
	EX1=0;         			//关闭外部中断   
	timeH =TH0;    			//取出定时器的值    
	timeL =TL0;    			//取出定时器的值   
	succeed_flag=1;			//至成功测量的标志    
}

//定时器0中断,用做超声波测距计时      
void timer0() interrupt 1   //定时器0中断号是1    
{           
	TH0=0;         
	TL0=0;     
}

//延时函数  
void delayms(uint z)
{   
	uint x,y;    
	for(x = z;x > 0;x--)   
		for(y = 110;y > 0;y--); 
}

//延时20us  
void delay_20us()
{       
	uchar a;      
	for(a = 0;a < 100;a++); 
}

//按键扫描   
void keyscan()
{
	//加距离，一次加10mm    
	if(S3 == 0)
	{
		delayms(10);		//按键防抖   
		if(S3 == 0)
		{
			distance += 20;
			while(!S3);		//等待按键释放   
		}
	}
	//减距离，一次减10mm   
	if(S4 == 0)
	{
		delayms(10);
		if(S4 == 0)
		{
			distance -= 20;
			while(!S4);
		}
	}
	//校准按键，测出实际声速   
	if(S2 == 0)
	{
		delayms(10);
		if(S2 == 0)
		{
			speed = 2 * STDDISTANCE / time;
			while(!S2);
		}
	}
}

//4位数码管显示测量距离    
void display()
{
	uint nTemp;
	uint nIndex;
	//显示个位，位选低电平有效    
	nTemp = distance;
	Ge = 0;
	nIndex = nTemp % 10;
	P1 = Table[nIndex];
	delayms(5);
	Ge = 1;
	//显示十位   
	nTemp /= 10;
	Shi = 0;
	nIndex = nTemp % 10;
	P1 = Table[nIndex];
	delayms(5);
	Shi = 1;
	//显示百位   
	nTemp /= 10;
	Bai = 0;
	nIndex = nTemp % 10;
	P1 = Table[nIndex];
	delayms(5);
	Bai = 1;
	//显示千位   
	nTemp /= 10; 
	Qian = 0;
	nIndex = nTemp % 10;
	P1 = Table[nIndex];
	delayms(5);
	Qian = 1;
} 



