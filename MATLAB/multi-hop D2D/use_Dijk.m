%开始利用D算法寻找最短路径

load SIMPLE_LAYOUT;

i = 1;
R_max = 200*10^6;
R_min = 80*10^6;
step = 5*10^6;
step_num = (R_max-R_min)/step+1;
Rate_th = zeros(1,step_num);
hop_average = zeros(1,step_num);
delay_average = zeros(1,step_num);
P_out = zeros(1,step_num);
buffer = 0.1*2^20;                                                             %D2D用户缓存区大小，0.1Mb，缓存区满后才开始下一跳，因此等待缓存区满的时间即为对应D2D对时延

for i = 1:step_num
    Rate_th(i) = R_min+(i-1)*step;
    weight = buffer./d2d_weight(CUE_Num,D2DUE_Num,CUE_Container,D2DUE_Container,CUE_Distance,D2DUE_Distance,Rate_th(i));
    
    hop_total = 0;                                                             %初始化总跳数
    delay_total = 0;                                                           %初始化总时延
    outage = 0;                                                                %初始化中断次数
    cyc_num = 100;                                                             %随机D2D通信次数
    for k = 1:cyc_num                                                          %进行100次随机的D2D通信，计算平均跳数、平均时延和中断概率
        d2d = randperm(D2DUE_Num);                                             %将D2D用户随机打乱放到数组d2d中，该数组前两个元素分别为D2D通信的发送方和接收方
        Tx = d2d(1);                                                           %D2D通信发送方的序号
        Rx = d2d(2);                                                           %D2D通信接收方的序号
        [delay path] = Dijk(weight,Tx,Rx);                                     %调用D算法函数，计算Tx和Rx之间的最短路径
        if(delay == inf)                                                       %经过D算法算出的时延为无穷大，则说明目的用户不可达，本次D2D通信发生中断
            outage = outage+1;continue;                                        %跳出本次循环
        end
        hop_total = hop_total+length(path)-1;
        delay_total = delay_total+delay;
    end
    hop_average(i) = hop_total/(cyc_num-outage);                                  %平均跳数
    delay_average(i) = delay_total/(cyc_num-outage);                              %平均时延
    P_out(i) = outage/cyc_num;                                                    %中断概率

end

figure(1);
plot(Rate_th,hop_average,'-dg','Linewidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);
xlabel('Rth');
ylabel('Average hop');
grid;
figure(2);
plot(Rate_th,delay_average,'-dg','Linewidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);
xlabel('Rth');
ylabel('Average delay');
grid;
figure(3);
plot(Rate_th,P_out,'-dg','Linewidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);
xlabel('Rth');
ylabel('Outage Probility');
grid;
