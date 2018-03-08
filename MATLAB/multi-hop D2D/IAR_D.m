%IAR�㷨��ÿһ����D�㷨ʵ��

function [distance path] = IAR_D(Delay,D2DUE_Distance,tx,rx,D2DUE)

Delta_D_tx = [];                                                               %������㷢������Ҫ��ı�ԵD2D�û��뷢�ͷ��ľ���
Delta_D_rx = [];                                                               %��������������Ҫ��ı�ԵD2D�û�����շ��ľ���
N = length(Delay);                                                             %D2D�û���
index_tx = [];                                                                 %������㷢�ͷ�����Ҫ��ı�ԵD2D�û������
index_rx = [];                                                                 %���������շ�����Ҫ��ı�ԵD2D�û������
edge = 350;                                                                    %���ѱ�Ե���ޣ������ڵ���edge��С�ڵ��ڷ��Ѱ뾶�Ļ�������

%IAR�㷨��һ��Escapeѡ����Դ�û�����ı�ԵD2D�û�ex1
if D2DUE_Distance(tx) >= edge                                                  %�����ͷ�������Ǳ�Ե�û�
    ex1 = tx;                                                                  %��IAR�㷨��һ��ʡ�ԣ���Դ�û�����ı�ԵD2D�û�ex1����ΪԴ�û�
else
    for i = 1:N
        if i ~= tx && D2DUE_Distance(i) >= edge                                %Ѱ���뷢�ͷ�����ı�ԵD2D�û�
            D_tx_i = sqrt((D2DUE(tx,1)-D2DUE(i,1))^2+(D2DUE(tx,2)-D2DUE(i,2))^2);
            Delta_D_tx = [Delta_D_tx D_tx_i];
            index_tx = [index_tx i];
        end
    end
    
    if isempty(Delta_D_tx)                                                         %��δ�ҵ����㷢�ͷ�����Ҫ��ı�ԵD2D�û�
        ex1 = tx;                                                                  %��IAR�㷨��һ��ʡ�ԣ���Դ�û�����ı�ԵD2D�û�ex1����ΪԴ�û�
    else
        [~,index1] = min(Delta_D_tx);                                              %����ѡ����Դ�û�����ı�ԵD2D�û�
        ex1 = index_tx(index1);
    end
end

%IAR�㷨������Returnѡ����Ŀ���û�����ı�ԵD2D�û�ex2
if D2DUE_Distance(rx) >= edge                                                  %�����շ�������Ǳ�Ե�û�
    ex2 = rx;                                                                  %��IAR�㷨������ʡ�ԣ���Ŀ���û�����ı�ԵD2D�û�ex2����ΪĿ���û�
else
    for i = 1:N
        if i ~= rx && D2DUE_Distance(i) >= edge                                %Ѱ������շ�����ı�ԵD2D�û�
            D_rx_i = sqrt((D2DUE(rx,1)-D2DUE(i,1))^2+(D2DUE(rx,2)-D2DUE(i,2))^2);
            Delta_D_rx = [Delta_D_rx D_rx_i];
            index_rx = [index_rx i];
        end
    end

    if isempty(Delta_D_rx)                                                         %��δ�ҵ�������շ�����Ҫ��ı�ԵD2D�û�
        ex2 = rx;                                                                  %��IAR�㷨������ʡ�ԣ���Ŀ���û�����ı�ԵD2D�û�ex2����ΪĿ���û�
    else
        [~,index2] = min(Delta_D_rx);                                              %����ѡ����Ŀ���û�����ı�ԵD2D�û�
        ex2 = index_rx(index2);
    end
end

%IAR�㷨��һ��Escape
if tx == ex1
    distance1 = 0;
    path1 = tx;
else
    [distance1 path1] = Dijk(Delay,tx,ex1);
end

%IAR�㷨�ڶ���Migrate
if ex1 == ex2                                                                  %��ex1��ex2��ͬһ�û�����IAR�㷨�ĵڶ���ʡ��
    distance2 = 0;
    path2 = [ex1 ex2];
else
    [distance2 path2] = Dijk(Delay,ex1,ex2);
end

%IAR�㷨������Return
if ex2 == rx
    distance3 = 0;
    path3 = rx;
else
    [distance3 path3] = Dijk(Delay,ex2,rx);
end

distance = distance1+distance2+distance3;
if distance1 == inf || distance2 == inf || distance3 == inf
    path = [tx rx];
else
    path2([1 length(path2)]) = [];                                             %path2���ס�β�ֱ�Ϊpath1��β��path3���ף��ظ�����ɾ��
    path = [path1 path2 path3];
end    