%�����ļ�

load SIMPLE_LAYOUT;

R_th = 60*10^6;
buffer = 0.1*2^20;                                                             %D2D�û���������С��0.1Mb������������ſ�ʼ��һ������˵ȴ�����������ʱ�伴Ϊ��ӦD2D��ʱ��
D_th = buffer/R_th;

weight = buffer./d2d_weight(CUE_Num,D2DUE_Num,CUE_Container,D2DUE_Container,CUE_Distance,D2DUE_Distance,R_th);
    
    hop_total1 = 0;                                                             %��ʼ��������
    delay_total1 = 0;                                                           %��ʼ����ʱ��
    outage1 = 0;                                                                %��ʼ���жϴ���
    
    hop_total2 = 0;                                                             %��ʼ��������
    delay_total2 = 0;                                                           %��ʼ����ʱ��
    outage2 = 0;                                                                %��ʼ���жϴ���
    
    cyc_num = 100;                                                             %���D2Dͨ�Ŵ���
    for k = 1:cyc_num                                                          %����100�������D2Dͨ�ţ�����ƽ��������ƽ��ʱ�Ӻ��жϸ���
        d2d = randperm(D2DUE_Num);                                             %��D2D�û�������ҷŵ�����d2d�У�������ǰ����Ԫ�طֱ�ΪD2Dͨ�ŵķ��ͷ��ͽ��շ�
        Tx = d2d(1);                                                           %D2Dͨ�ŷ��ͷ������
        Rx = d2d(2);                                                           %D2Dͨ�Ž��շ������
        
        
        [delay1 path1] = Dijk(weight,Tx,Rx);                                     %����D�㷨����������Tx��Rx֮������·��
        if delay1 == inf                                                       %����D�㷨�����ʱ��Ϊ�������˵��Ŀ���û����ɴ����D2Dͨ�ŷ����ж�
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
    hop_average1 = hop_total1/(cyc_num-outage1);                                  %ƽ������
    delay_average1 = delay_total1/(cyc_num-outage1);                              %ƽ��ʱ��
    P_out1 = outage1/cyc_num;
    
    hop_average2 = hop_total2/(cyc_num-outage2);                                  %ƽ������
    delay_average2 = delay_total2/(cyc_num-outage2);                              %ƽ��ʱ��
    P_out2 = outage2/cyc_num;