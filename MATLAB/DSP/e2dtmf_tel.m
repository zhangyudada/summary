clear
close all

d=input('�����绰���룺 ','s');   %����绰���루�ַ�����
sum=length(d);                     %����绰���볤�� 
total_x=[];
M=500;
%����forѭ����ɶ��������ı��빤��
for a=1:sum                        %ѭ��sum��
    %DTMF���м���16��ASCII��
    tm=[49,50,51,65;52,53,54,66;55,56,57,67;42,48,35,68];    
    for p=1:4;
        for q=1:4;
            if tm(p,q)==abs(d(a));break,end     %�����������к�q
                                                %abs(d(a))Ϊ���ַ���ASCII��
        end
       if tm(p,q)==abs(d(a));break,end          %�����������к�p
    end
    f1=[697,770,852,941];                       %��Ƶ������
    f2=[1209,1336,1477,1633];                   %��Ƶ������                    
    n=1:M;
    x=sin(2*pi*n*f1(p)/8000)+sin(2*pi*n*f2(q)/8000);   %����˫Ƶ�ź�
    x=[x,zeros(1,M)];      %������ǰһ��Ϊ�źţ���һ��Ϊ����
    total_x=[total_x,x];   %����������������,��һ��������
end
wavwrite(total_x,'tel_voice')   %������ĺ����Ϊ��Ƶ�ļ�
sound(total_x);                 %��������

subplot(2,1,1);
plot(total_x);                  %���������ĺ����ʱ����ͼ
xlabel('ʱ��');
title('DTMF�ź�ʱ����ͼ');
disp('˫Ƶ�ź������ɲ�����');

% ���ռ��˵ĳ���
k=[18 20 22 24 31 34 38 42];            %Ҫ���DFT������ţ�N=205��
N=205;
disp('���ն˼�⵽�ĺ���Ϊ')
for a=1:sum  
    m=2*M*(a-1);   
    X=goertzel(total_x(m+1:m+N),k+1);   %��Goertzel�㷨����˵�DFT����
    val=abs(X);                         %�г��˵�DFT�����ķ���ֵ
    limit=80;                           %�о�����
    for r=1:4;
        if val(r)>limit, break,end      %�����к�
    end
    for s=5:8;
        if val(s)>limit, break,end      %�����к�
    end
    disp(char(tm(r,s-4)))               %��ʾ���յ����ַ�
    
    subplot(2,1,2);
    stem(k,val,'.');                    %����DFT(k)���ȣ�k��val���ǳ���Ϊ8��������
    grid;
    xlabel('k');
    ylabel('|X(k)|^2');            
    disp('ͼ����ʾ���Ǹý����źŽ��ƻ�Ƶ��DFT����');
    pause;
end
