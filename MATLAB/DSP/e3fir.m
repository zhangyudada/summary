clear
close all

fs=32000;
nbits=16;
snr=20;
[x,fs,nbits]=wavread('.\myvoice.wav');
x2=awgn(x,snr,'measured');      %������������ź�
wavwrite(x2,fs,nbits,'.\myvoice_noise.wav');

wp=8000*pi/32000;
ws=9000*pi/32000;
deltaw=ws-wp;
wc=(wp+ws)/2;
N=ceil(11*pi/deltaw);           %ȡ��,11*pi����ѡ�ò���������,N=352
b=fir1(N,wc/pi,blackman(N+1));  %ѡ�񴰺���������һ����ֹƵ�ʣ�NΪż����ȡN+1

x3=filter(b,1,x2);              %�˲�ȥ��
wavwrite(x3,fs,nbits,'.\myvoice_nonoise.wav');

figure(1);
freqz(b,1,512);                 %�����˲���Ƶ����Ӧ
title('�˲���Ƶ����Ӧ');

figure(2);
f=fs*(1:512)/1024;
y2=fft(x2,1024);                %�������źŽ���fft����
y3=fft(x3,1024);                %�������źŽ���fft����
subplot(2,1,1);
plot(f,abs(y2(1:512)));
title('�˲�ǰƵ��');
xlabel('Hz');
ylabel('����');
subplot(2,1,2);
F2=plot(f,abs(y3(1:512)));
title('�˲���Ƶ��');
xlabel('Hz');
ylabel('����'); 

figure(3);
t=0:1/fs:(size(x2)-1)/fs;
subplot(2,1,1);
plot(t,x2);
title('�˲�ǰʱ����');
subplot(2,1,2);
plot(t,x3);
title('�˲���ʱ����');
