/********************************
������� �� ���������

ʱ     �� �� 2015/9/14-2015/9/25
*********************************/

#include <reg52.h>
#define uchar unsigned char
#define uint unsigned int

sbit Trig = P3^2;		//������������������     
sbit Echo = P3^3;		//���ճ������ش��źŵ�����      
sbit Qian = P3^4;		//��������λѡ�ź�����     
sbit Bai = P3^5;		//����ܴθ�λѡ�ź�����     
sbit Shi = P3^6;		//����ܴε�λѡ�ź�����     
sbit Ge = P3^7;			//��������λѡ�ź�����     
sbit S2 = P2^0;			//У׼��������   
sbit S3 = P2^1;			//�Ӿ��뿪������    
sbit S4 = P2^2;			//�����뿪������    
sbit Beep = P2^3;		//��������������    
int succeed_flag;		//���յ��������ش��ź����ı�־      
int time;				//�ش��źų���ʱ��    
float speed = 0.340;	//���٣���λmm/us   
uint STDDISTANCE = 1000;//У׼�ñ�׼���룬1000mm   
uint distance;			//��Ų����õľ���    
uchar timeH;			//16λ��ʱ����8λ����    
uchar timeL;			//16λ��ʱ����8λ����    
uchar code Table[10] = {0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};
						//4λ��������������ֱ�������     
void delayms(uint z);	//��ʱz ms   
void delay_20us();		//��ʱ20us  
void keyscan();			//����ɨ��  
void display();			//����ܶ�̬��ʾ����     

//����һ�θ�λ��������һ�β��     
void main()
{
	
	TMOD = 0x01;    	//��ʱ��0��������ʽ1��16λ����    
	Trig = 0;       	//��������������������    
	EA = 0;           	//�����ж� 
  	Trig = 1;         	//���������������ߵ�ƽ     
  	delay_20us();   	//��ʱ20us 
  	Trig = 0;         	//����һ��20us������   
  	while(Echo == 0); 	//�ȴ�Echo�ز����ű�ߵ�ƽ     
  	succeed_flag = 0; 	//������ɹ���־   
  	EA = 1;				//�����ж�  
    IT1 = 1;			//�ⲿ�ж�1������ʽΪ�½��ش���         
  	EX1 = 1;      		//���ⲿ�ж�1     
  	TH0 = 0;          	//��ʱ��0����  
  	TL0 = 0;         	//��ʱ��0����  
  	TF0 = 0;          	//���������־  
  	TR0 = 1;          	//������ʱ��0   
  	delayms(20);      	//�ȴ������Ľ��  
  	TR0 = 0;          	//�رն�ʱ��0   
  	EX1 = 0;          	//�ر��ⲿ�ж�1   
	if(succeed_flag == 1)
  	{               
		time = timeH * 256 + timeL;
  		distance = time/2*speed; //����  
     }
  	if(succeed_flag == 0)
  	{            
		distance = 0;     		//û�лز�������      
   	}
   	//ѭ����ⰴ������ʾ����    
	while(1)
	{
		keyscan();
		if(distance < 500)
			Beep = 0;			//����С��500mm�������������    
		if(distance >= 500)
			Beep = 1;
  		display();
	}
}

//�ⲿ�ж�1�������жϻز���ƽ      
void int1()  interrupt 2   	//�ⲿ�ж�1�жϺ���2     
{        
	EX1=0;         			//�ر��ⲿ�ж�   
	timeH =TH0;    			//ȡ����ʱ����ֵ    
	timeL =TL0;    			//ȡ����ʱ����ֵ   
	succeed_flag=1;			//���ɹ������ı�־    
}

//��ʱ��0�ж�,��������������ʱ      
void timer0() interrupt 1   //��ʱ��0�жϺ���1    
{           
	TH0=0;         
	TL0=0;     
}

//��ʱ����  
void delayms(uint z)
{   
	uint x,y;    
	for(x = z;x > 0;x--)   
		for(y = 110;y > 0;y--); 
}

//��ʱ20us  
void delay_20us()
{       
	uchar a;      
	for(a = 0;a < 100;a++); 
}

//����ɨ��   
void keyscan()
{
	//�Ӿ��룬һ�μ�10mm    
	if(S3 == 0)
	{
		delayms(10);		//��������   
		if(S3 == 0)
		{
			distance += 20;
			while(!S3);		//�ȴ������ͷ�   
		}
	}
	//�����룬һ�μ�10mm   
	if(S4 == 0)
	{
		delayms(10);
		if(S4 == 0)
		{
			distance -= 20;
			while(!S4);
		}
	}
	//У׼���������ʵ������   
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

//4λ�������ʾ��������    
void display()
{
	uint nTemp;
	uint nIndex;
	//��ʾ��λ��λѡ�͵�ƽ��Ч    
	nTemp = distance;
	Ge = 0;
	nIndex = nTemp % 10;
	P1 = Table[nIndex];
	delayms(5);
	Ge = 1;
	//��ʾʮλ   
	nTemp /= 10;
	Shi = 0;
	nIndex = nTemp % 10;
	P1 = Table[nIndex];
	delayms(5);
	Shi = 1;
	//��ʾ��λ   
	nTemp /= 10;
	Bai = 0;
	nIndex = nTemp % 10;
	P1 = Table[nIndex];
	delayms(5);
	Bai = 1;
	//��ʾǧλ   
	nTemp /= 10; 
	Qian = 0;
	nIndex = nTemp % 10;
	P1 = Table[nIndex];
	delayms(5);
	Qian = 1;
} 



