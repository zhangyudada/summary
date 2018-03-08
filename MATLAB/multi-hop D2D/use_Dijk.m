%��ʼ����D�㷨Ѱ�����·��

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
buffer = 0.1*2^20;                                                             %D2D�û���������С��0.1Mb������������ſ�ʼ��һ������˵ȴ�����������ʱ�伴Ϊ��ӦD2D��ʱ��

for i = 1:step_num
    Rate_th(i) = R_min+(i-1)*step;
    weight = buffer./d2d_weight(CUE_Num,D2DUE_Num,CUE_Container,D2DUE_Container,CUE_Distance,D2DUE_Distance,Rate_th(i));
    
    hop_total = 0;                                                             %��ʼ��������
    delay_total = 0;                                                           %��ʼ����ʱ��
    outage = 0;                                                                %��ʼ���жϴ���
    cyc_num = 100;                                                             %���D2Dͨ�Ŵ���
    for k = 1:cyc_num                                                          %����100�������D2Dͨ�ţ�����ƽ��������ƽ��ʱ�Ӻ��жϸ���
        d2d = randperm(D2DUE_Num);                                             %��D2D�û�������ҷŵ�����d2d�У�������ǰ����Ԫ�طֱ�ΪD2Dͨ�ŵķ��ͷ��ͽ��շ�
        Tx = d2d(1);                                                           %D2Dͨ�ŷ��ͷ������
        Rx = d2d(2);                                                           %D2Dͨ�Ž��շ������
        [delay path] = Dijk(weight,Tx,Rx);                                     %����D�㷨����������Tx��Rx֮������·��
        if(delay == inf)                                                       %����D�㷨�����ʱ��Ϊ�������˵��Ŀ���û����ɴ����D2Dͨ�ŷ����ж�
            outage = outage+1;continue;                                        %��������ѭ��
        end
        hop_total = hop_total+length(path)-1;
        delay_total = delay_total+delay;
    end
    hop_average(i) = hop_total/(cyc_num-outage);                                  %ƽ������
    delay_average(i) = delay_total/(cyc_num-outage);                              %ƽ��ʱ��
    P_out(i) = outage/cyc_num;                                                    %�жϸ���

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
