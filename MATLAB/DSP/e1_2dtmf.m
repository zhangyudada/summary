clear
close all
 
column=[1209,1336,1477,1633];   %��Ƶ��ֵ
line=[697,770,852,941];         %��Ƶ��ֵ
 
fs=8000;                        %����Ƶ��8kHZ
ts=1/fs;                        %��������

N=1024;                         %DFT���� 
n=0:N-1;
detf=fs/N;
f=0:detf:detf*(N-1);
 
key=zeros(16,N);                %16*N��ȫ0�������ڴ��10���ֵ�DTMF�źţ�����ΪN��
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
 
 
figure; %���µ�ͼ�δ���
for i=1:10
    subplot(5,2,i)
    plot(f,abs(fft(key(i,:))));
    axis([500,2000,0,600])   %�趨ͼ�δ��Ķ�ά����߽�
    grid;   %��������
end
