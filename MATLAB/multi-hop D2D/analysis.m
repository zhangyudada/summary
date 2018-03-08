%三种算法的比较

load SIMPLE_LAYOUT;

R_th = 80*10^6;
buffer = 0.1*2^20;                                                         %D2D用户缓存区大小，0.1Mb，缓存区满后才开始下一跳，因此等待缓存区满的时间即为对应D2D对时延
D_th = buffer/R_th;

d2dnum = zeros(1,9);

hop_average1 = zeros(1,9);
delay_average1 = zeros(1,9);
P_out1 = zeros(1,9);

hop_average2 = zeros(1,9);
delay_average2 = zeros(1,9);
P_out2 = zeros(1,9);

hop_average3 = zeros(1,9);
delay_average3 = zeros(1,9);
P_out3 = zeros(1,9);

hop_average4 = zeros(1,9);
delay_average4 = zeros(1,9);
P_out4 = zeros(1,9);

for i = 1:9
    delete = randperm(D2DUE_Num);                                              %将D2D用户随机打乱放到数组d2d中，该数组前10个元素对应的D2D用户将被删除
    D2DUE_Container(delete(1:10),:) = [];
    D2DUE_Distance(delete(1:10)) = [];
    D2DUE_Num = D2DUE_Num-10;
    d2dnum(i) = D2DUE_Num;
    
    %weight矩阵存放各个D2D节点对之间的时延值
    weight = buffer./d2d_weight(CUE_Num,D2DUE_Num,CUE_Container,D2DUE_Container,CUE_Distance,D2DUE_Distance,R_th);
    
    hop_total1 = 0;                                                             %初始化总跳数
    delay_total1 = 0;                                                           %初始化总时延
    outage1 = 0;                                                                %初始化中断次数
    
    hop_total2 = 0;                                                             %初始化总跳数
    delay_total2 = 0;                                                           %初始化总时延
    outage2 = 0;                                                                %初始化中断次数
    
    hop_total3 = 0;                                                             %初始化总跳数
    delay_total3 = 0;                                                           %初始化总时延
    outage3 = 0;                                                                %初始化中断次数
    
    hop_total4 = 0;                                                             %初始化总跳数
    delay_total4 = 0;                                                           %初始化总时延
    outage4 = 0;                                                                %初始化中断次数
    
    cyc_num = 500;                                                             %随机D2D通信次数
    for j = 1:cyc_num                                                          %进行100次随机的D2D通信，计算平均跳数、平均时延和中断概率
        d2d = randperm(D2DUE_Num);                                             %将D2D用户随机打乱放到数组d2d中，该数组前两个元素分别为D2D通信的发送方和接收方
        Tx = d2d(1);                                                           %D2D通信发送方的序号
        Rx = d2d(2);                                                           %D2D通信接收方的序号
        
         %----------------------------------D算法部分-------------------------------%
        [delay1 path1] = Dijk(weight,Tx,Rx);                                     %调用D算法函数，计算Tx和Rx之间的最短路径
        if delay1 == inf                                                     %经过D算法算出的时延为无穷大，则说明目的用户不可达，本次D2D通信发生中断
            outage1 = outage1+1;
        else
            hop_total1 = hop_total1+length(path1)-1;
            delay_total1 = delay_total1+delay1;
        end
        
        %--------------------------------CD算法部分---------------------------------%
        [delay2 path2] = CD(weight,D_th,Tx,Rx,D2DUE_Container);
        if delay2 == inf
            outage2 = outage2+1;
        else
            hop_total2 = hop_total2+length(path2)-1;
            delay_total2 = delay_total2+delay2;
        end
        
        %--------------------------------IAR算法部分---------------------------------%
        [delay3 path3] = IAR(weight,D_th,D2DUE_Distance,Tx,Rx,D2DUE_Container);
        if delay3 == inf
            outage3 = outage3+1;
        else
            hop_total3 = hop_total3+length(path3)-1;
            delay_total3 = delay_total3+delay3;
        end
        
        %--------------------------------IAR_D算法部分---------------------------------%
        [delay4 path4] = IAR_D(weight,D2DUE_Distance,Tx,Rx,D2DUE_Container);
        if delay4 == inf
            outage4 = outage4+1;
        else
            hop_total4 = hop_total4+length(path4)-1;
            delay_total4 = delay_total4+delay4;
        end
        
    end
    hop_average1(i) = hop_total1/(cyc_num-outage1);                                  %平均跳数
    delay_average1(i) = delay_total1/(cyc_num-outage1);                              %平均时延
    P_out1(i) = outage1/cyc_num;                                                    %中断概率
    
    hop_average2(i) = hop_total2/(cyc_num-outage2);
    delay_average2(i) = delay_total2/(cyc_num-outage2);
    P_out2(i) = outage2/cyc_num;
    
    hop_average3(i) = hop_total3/(cyc_num-outage3);
    delay_average3(i) = delay_total3/(cyc_num-outage3);
    P_out3(i) = outage3/cyc_num;
    
    hop_average4(i) = hop_total4/(cyc_num-outage4);
    delay_average4(i) = delay_total4/(cyc_num-outage4);
    P_out4(i) = outage4/cyc_num;
    
end

figure(1);
plot(d2dnum,hop_average1,'-ok','Linewidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);
hold on;
plot(d2dnum,hop_average2,'--sb','Linewidth',2,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
plot(d2dnum,hop_average3,':dm','Linewidth',2,'MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);
plot(d2dnum,hop_average4,'-.*y','Linewidth',2,'MarkerEdgeColor','y','MarkerFaceColor','y','MarkerSize',4);
xlabel('D2DUE Num');
ylabel('Average Hop');
grid;
legend('D Algorithm','CD Algorithm','IAR Algorithm','IAR\_D Algorithm','location','northwest');

figure(2);
plot(d2dnum,delay_average1,'-ok','Linewidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);
hold on;
plot(d2dnum,delay_average2,'--sb','Linewidth',2,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
plot(d2dnum,delay_average3,':dm','Linewidth',2,'MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);
plot(d2dnum,delay_average4,'-.*y','Linewidth',2,'MarkerEdgeColor','y','MarkerFaceColor','y','MarkerSize',4);
xlabel('D2DUE Num');
ylabel('Average Delay');
grid;
legend('D Algorithm','CD Algorithm','IAR Algorithm','IAR\_D Algorithm','location','northwest');

figure(3);
plot(d2dnum,P_out1,'-ok','Linewidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);
hold on;
plot(d2dnum,P_out2,'--sb','Linewidth',2,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
plot(d2dnum,P_out3,':dm','Linewidth',2,'MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);
plot(d2dnum,P_out4,'-.*y','Linewidth',2,'MarkerEdgeColor','y','MarkerFaceColor','y','MarkerSize',4);
xlabel('D2DUE Num');
ylabel('Outage Probility');
grid;
legend('D Algorithm','CD Algorithm','IAR Algorithm','IAR\_D Algorithm','location','northwest');