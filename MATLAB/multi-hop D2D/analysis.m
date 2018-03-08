%�����㷨�ıȽ�

load SIMPLE_LAYOUT;

R_th = 80*10^6;
buffer = 0.1*2^20;                                                         %D2D�û���������С��0.1Mb������������ſ�ʼ��һ������˵ȴ�����������ʱ�伴Ϊ��ӦD2D��ʱ��
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
    delete = randperm(D2DUE_Num);                                              %��D2D�û�������ҷŵ�����d2d�У�������ǰ10��Ԫ�ض�Ӧ��D2D�û�����ɾ��
    D2DUE_Container(delete(1:10),:) = [];
    D2DUE_Distance(delete(1:10)) = [];
    D2DUE_Num = D2DUE_Num-10;
    d2dnum(i) = D2DUE_Num;
    
    %weight�����Ÿ���D2D�ڵ��֮���ʱ��ֵ
    weight = buffer./d2d_weight(CUE_Num,D2DUE_Num,CUE_Container,D2DUE_Container,CUE_Distance,D2DUE_Distance,R_th);
    
    hop_total1 = 0;                                                             %��ʼ��������
    delay_total1 = 0;                                                           %��ʼ����ʱ��
    outage1 = 0;                                                                %��ʼ���жϴ���
    
    hop_total2 = 0;                                                             %��ʼ��������
    delay_total2 = 0;                                                           %��ʼ����ʱ��
    outage2 = 0;                                                                %��ʼ���жϴ���
    
    hop_total3 = 0;                                                             %��ʼ��������
    delay_total3 = 0;                                                           %��ʼ����ʱ��
    outage3 = 0;                                                                %��ʼ���жϴ���
    
    hop_total4 = 0;                                                             %��ʼ��������
    delay_total4 = 0;                                                           %��ʼ����ʱ��
    outage4 = 0;                                                                %��ʼ���жϴ���
    
    cyc_num = 500;                                                             %���D2Dͨ�Ŵ���
    for j = 1:cyc_num                                                          %����100�������D2Dͨ�ţ�����ƽ��������ƽ��ʱ�Ӻ��жϸ���
        d2d = randperm(D2DUE_Num);                                             %��D2D�û�������ҷŵ�����d2d�У�������ǰ����Ԫ�طֱ�ΪD2Dͨ�ŵķ��ͷ��ͽ��շ�
        Tx = d2d(1);                                                           %D2Dͨ�ŷ��ͷ������
        Rx = d2d(2);                                                           %D2Dͨ�Ž��շ������
        
         %----------------------------------D�㷨����-------------------------------%
        [delay1 path1] = Dijk(weight,Tx,Rx);                                     %����D�㷨����������Tx��Rx֮������·��
        if delay1 == inf                                                     %����D�㷨�����ʱ��Ϊ�������˵��Ŀ���û����ɴ����D2Dͨ�ŷ����ж�
            outage1 = outage1+1;
        else
            hop_total1 = hop_total1+length(path1)-1;
            delay_total1 = delay_total1+delay1;
        end
        
        %--------------------------------CD�㷨����---------------------------------%
        [delay2 path2] = CD(weight,D_th,Tx,Rx,D2DUE_Container);
        if delay2 == inf
            outage2 = outage2+1;
        else
            hop_total2 = hop_total2+length(path2)-1;
            delay_total2 = delay_total2+delay2;
        end
        
        %--------------------------------IAR�㷨����---------------------------------%
        [delay3 path3] = IAR(weight,D_th,D2DUE_Distance,Tx,Rx,D2DUE_Container);
        if delay3 == inf
            outage3 = outage3+1;
        else
            hop_total3 = hop_total3+length(path3)-1;
            delay_total3 = delay_total3+delay3;
        end
        
        %--------------------------------IAR_D�㷨����---------------------------------%
        [delay4 path4] = IAR_D(weight,D2DUE_Distance,Tx,Rx,D2DUE_Container);
        if delay4 == inf
            outage4 = outage4+1;
        else
            hop_total4 = hop_total4+length(path4)-1;
            delay_total4 = delay_total4+delay4;
        end
        
    end
    hop_average1(i) = hop_total1/(cyc_num-outage1);                                  %ƽ������
    delay_average1(i) = delay_total1/(cyc_num-outage1);                              %ƽ��ʱ��
    P_out1(i) = outage1/cyc_num;                                                    %�жϸ���
    
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