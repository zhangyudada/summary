clear
close all
 
column=[1209,1336,1477,1633];   %列频率值
line=[697,770,852,941];         %行频率值
 
fs=8000;                        %采样频率8kHZ
ts=1/fs;                        %采样周期

N=1024;                         %DFT长度 
n=0:N-1;
detf=fs/N;
f=0:detf:detf*(N-1);
 
key=zeros(16,N);                %16*N的全0矩阵，用于存放10数字的DTMF信号（长度为N）
key(1,:)=cos(2*pi*column(1)*ts*n)+cos(2*pi*line(1)*ts*n);
key(2,:)=cos(2*pi*column(2)*ts*n)+cos(2*pi*line(1)*ts*n);
key(3,:)=cos(2*pi*column(3)*ts*n)+cos(2*pi*line(1)*ts*n);
key(4,:)=cos(2*pi*column(1)*ts*n)+cos(2*pi*line(2)*ts*n);
key(5,:)=cos(2*pi*column(2)*ts*n)+cos(2*pi*line(2)*ts*n);
key(6,:)=cos(2*pi*column(3)*ts*n)+cos(2*pi*line(2)*ts*n);
key(7,:)=cos(2*pi*column(1)*ts*n)+cos(2*pi*line(3)*ts*n);
key(8,:)=cos(2*pi*column(2)*ts*n)+cos(2*pi*line(3)*ts*n);
key(9,:)=cos(2*pi*column(3)*ts*n)+cos(2*pi*line(3)*ts*n);
key(10,:)=cos(2*pi*column(2)*ts*n)+cos(2*pi*line(4)*ts*n);
 
 
figure; %打开新的图形窗口
for i=1:10
    subplot(5,2,i)
    plot(f,abs(fft(key(i,:))));
    axis([500,2000,0,600])   %设定图形窗的二维坐标边界
    grid;   %打上网格
end
