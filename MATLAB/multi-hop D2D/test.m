%测试文件

load SIMPLE_LAYOUT;

R_th = 60*10^6;
buffer = 0.1*2^20;                                                             %D2D用户缓存区大小，0.1Mb，缓存区满后才开始下一跳，因此等待缓存区满的时间即为对应D2D对时延
D_th = buffer/R_th;

weight = buffer./d2d_weight(CUE_Num,D2DUE_Num,CUE_Container,D2DUE_Container,CUE_Distance,D2DUE_Distance,R_th);
    
    hop_total1 = 0;                                                             %初始化总跳数
    delay_total1 = 0;                                                           %初始化总时延
    outage1 = 0;                                                                %初始化中断次数
    
    hop_total2 = 0;                                                             %初始化总跳数
    delay_total2 = 0;                                                           %初始化总时延
    outage2 = 0;                                                                %初始化中断次数
    
    cyc_num = 100;                                                             %随机D2D通信次数
    for k = 1:cyc_num                                                          %进行100次随机的D2D通信，计算平均跳数、平均时延和中断概率
        d2d = randperm(D2DUE_Num);                                             %将D2D用户随机打乱放到数组d2d中，该数组前两个元素分别为D2D通信的发送方和接收方
        Tx = d2d(1);                                                           %D2D通信发送方的序号
        Rx = d2d(2);                                                           %D2D通信接收方的序号
        
        
        [delay1 path1] = Dijk(weight,Tx,Rx);                                     %调用D算法函数，计算Tx和Rx之间的最短路径
        if delay1 == inf                                                       %经过D算法算出的时延为无穷大，则说明目的用户不可达，本次D2D通信发生中断
            outage1 = outage1+1;                                        
        else
            hop_total1 = hop_total1+length(path1)-1;
            delay_total1 = delay_total1+delay1;
        end  
        
        [delay2 path2] = CD(weight,D_th,Tx,Rx,D2DUE_Container);
        if delay2 == inf
            outage2 = outage2+1;
        else
            hop_total2 = hop_total2+length(path2)-1;
            delay_total2 = delay_total2+delay2;
        end
        
    end
    hop_average1 = hop_total1/(cyc_num-outage1);                                  %平均跳数
    delay_average1 = delay_total1/(cyc_num-outage1);                              %平均时延
    P_out1 = outage1/cyc_num;
    
    hop_average2 = hop_total2/(cyc_num-outage2);                                  %平均跳数
    delay_average2 = delay_total2/(cyc_num-outage2);                              %平均时延
    P_out2 = outage2/cyc_num;