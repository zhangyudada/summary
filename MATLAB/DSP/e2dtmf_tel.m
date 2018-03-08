clear
close all

d=input('请键入电话号码： ','s');   %输入电话号码（字符串）
sum=length(d);                     %计算电话号码长度 
total_x=[];
M=500;
%以下for循环完成对输入号码的编码工作
for a=1:sum                        %循环sum次
    %DTMF表中键的16个ASCII码
    tm=[49,50,51,65;52,53,54,66;55,56,57,67;42,48,35,68];    
    for p=1:4;
        for q=1:4;
            if tm(p,q)==abs(d(a));break,end     %检测码相符的列号q
                                                %abs(d(a))为求字符的ASCII码
        end
       if tm(p,q)==abs(d(a));break,end          %检测码相符的行号p
    end
    f1=[697,770,852,941];                       %行频率向量
    f2=[1209,1336,1477,1633];                   %列频率向量                    
    n=1:M;
    x=sin(2*pi*n*f1(p)/8000)+sin(2*pi*n*f2(q)/8000);   %构成双频信号
    x=[x,zeros(1,M)];      %行向量前一半为信号，后一半为静音
    total_x=[total_x,x];   %将所编码连接起来,是一个行向量
end
wavwrite(total_x,'tel_voice')   %将编码的号码存为音频文件
sound(total_x);                 %发出声音

subplot(2,1,1);
plot(total_x);                  %画出编好码的号码的时域波形图
xlabel('时间');
title('DTMF信号时域波形图');
disp('双频信号已生成并发出');

% 接收检测端的程序
k=[18 20 22 24 31 34 38 42];            %要求的DFT样本序号（N=205）
N=205;
disp('接收端检测到的号码为')
for a=1:sum  
    m=2*M*(a-1);   
    X=goertzel(total_x(m+1:m+N),k+1);   %用Goertzel算法计算八点DFT样本
    val=abs(X);                         %列出八点DFT向量的幅度值
    limit=80;                           %判决门限
    for r=1:4;
        if val(r)>limit, break,end      %查找行号
    end
    for s=5:8;
        if val(s)>limit, break,end      %查找列号
    end
    disp(char(tm(r,s-4)))               %显示接收到的字符
    
    subplot(2,1,2);
    stem(k,val,'.');                    %画出DFT(k)幅度，k与val都是长度为8的行向量
    grid;
    xlabel('k');
    ylabel('|X(k)|^2');            
    disp('图上显示的是该解码信号近似基频的DFT幅度');
    pause;
end
