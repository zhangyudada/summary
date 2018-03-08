clear
close all

fs=32000;
nbits=16;
snr=20;
[x,fs,nbits]=wavread('.\myvoice.wav');
x2=awgn(x,snr,'measured');      %叠加噪声后的信号
wavwrite(x2,fs,nbits,'.\myvoice_noise.wav');

wp=8000*pi/32000;
ws=9000*pi/32000;
deltaw=ws-wp;
wc=(wp+ws)/2;
N=ceil(11*pi/deltaw);           %取整,11*pi表明选用布莱克曼窗,N=352
b=fir1(N,wc/pi,blackman(N+1));  %选择窗函数，并归一化截止频率，N为偶数，取N+1

x3=filter(b,1,x2);              %滤波去噪
wavwrite(x3,fs,nbits,'.\myvoice_nonoise.wav');

figure(1);
freqz(b,1,512);                 %画出滤波器频率响应
title('滤波器频率响应');

figure(2);
f=fs*(1:512)/1024;
y2=fft(x2,1024);                %对噪声信号进行fft运算
y3=fft(x3,1024);                %对滤噪信号进行fft运算
subplot(2,1,1);
plot(f,abs(y2(1:512)));
title('滤波前频谱');
xlabel('Hz');
ylabel('幅度');
subplot(2,1,2);
F2=plot(f,abs(y3(1:512)));
title('滤波后频谱');
xlabel('Hz');
ylabel('幅度'); 

figure(3);
t=0:1/fs:(size(x2)-1)/fs;
subplot(2,1,1);
plot(t,x2);
title('滤波前时域波形');
subplot(2,1,2);
plot(t,x3);
title('滤波后时域波形');
