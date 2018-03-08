%���������㷨

load SIMPLE_LAYOUT;

R_th = 50*10^6;
buffer = 0.1*2^20;                                                             %D2D�û���������С��0.1Mb������������ſ�ʼ��һ������˵ȴ�����������ʱ�伴Ϊ��ӦD2D��ʱ��
D_th = buffer/R_th;
Tx = 1;
Rx = 11;

rate = d2d_weight(CUE_Num,D2DUE_Num,CUE_Container,D2DUE_Container,CUE_Distance,D2DUE_Distance,R_th);
weight = buffer./rate;
[delay1 path1] = Dijk(weight,Tx,Rx);
[delay2 path2] = CD(weight,D_th,Tx,Rx,D2DUE_Container);
[delay3 path3] = IAR(weight,D_th,D2DUE_Distance,Tx,Rx,D2DUE_Container);
[delayd3 pathd3] = IAR_D(weight,D2DUE_Distance,Tx,Rx,D2DUE_Container);

hold off;
plot(BS_Location(1),BS_Location(2),'ok');
hold on;
plot(CUE_Container(:,1),CUE_Container(:,2),'*r');
plot(D2DUE_Container(:,1),D2DUE_Container(:,2),'.g');
plot(D2DUE_Container(path1,1),D2DUE_Container(path1,2),'-ok');
plot(D2DUE_Container(path2,1),D2DUE_Container(path2,2),'--sb');
plot(D2DUE_Container(path3,1),D2DUE_Container(path3,2),':dm');
plot(D2DUE_Container(pathd3,1),D2DUE_Container(pathd3,2),'-..y');
axis equal;
axis([-500, 500, -500, 500]);
grid;
legend('BS','CUE','D2DUE','D Algorithm','CD Algorithm','IAR Algorithm','IAR\_D Algorithm','location','northeast');
