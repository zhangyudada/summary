clear
close all

N=5000;                 %���г���
n=1:1:N;
x=0.001*cos(0.45*pi*n)+sin(0.3*pi*n)-cos(0.302*pi*n-pi/4);
y=fft(x,N);
magy=abs(y(1:1:N));     %fft��ķ�ֵ
k=1:1:N;w=2*pi/N*k;
stem(w/pi,magy);        %������ͼ
axis([0.25,0.5,0,50])   %�趨ͼ�δ��Ķ�ά����߽�
