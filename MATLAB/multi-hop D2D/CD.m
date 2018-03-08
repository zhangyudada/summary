%CD�㷨
function [distance path] = 	CD(Delay,Dth,tx,rx,D2DUE)

omega(1) = tx;
N = length(Delay);                                                         %N��Ȩֵ�����������Ҳ��D2D�û���
H = 1:N;                                                                   %ʣ���ѡ�ڵ�
H(tx) = [];                                                                %���ͷ��������ں�ѡ�ڵ���

for k =1:N
    if Delay(omega(k),rx) <=Dth                                            %�����ǰ�ڵ㵽Ŀ�Ľڵ��ֱ��ʱ������Ҫ������һ�ڵ�ѡΪĿ�Ľڵ㣬������ѭ��
        omega(k+1) = rx;
        break;
    else
        delete =[];
        for i = 1:length(H)
            if Delay(omega(k),H(i)) > Dth
                delete = [delete i];                                       %��¼H�в�����ʱ��Ҫ��Ľڵ����
            end
        end
        H(delete(1:length(delete))) = [];                                  %ɾ��H�в�����ʱ��Ҫ��Ľڵ�
        
        if length(H) == 0;                                                 %��ѡ�ڵ�Ϊ�գ�˵��·��ѡ��ʧ�ܣ������жϣ�����ѭ��
            break;
        else
            d_omega2rx = 1./zeros(1,length(H));                                 %��Ÿ���ѡ�ڵ㵽Ŀ�Ľڵ�ľ��룬��ʼ��Ϊ�����
            for s = 1:length(H)
                d_omega2rx(s) = sqrt((D2DUE(H(s),1)-D2DUE(rx,1))^2+(D2DUE(H(s),2)-D2DUE(rx,2))^2);
            end
            [~,index] = min(d_omega2rx);                                   %ѡ����Ŀ�Ľڵ������С�ĺ�ѡ�ڵ㣬��¼����H�е����
            omega(k+1) = H(index);                                             %��һ�ڵ�ѡΪ��Ŀ�Ľڵ������С�ĺ�ѡ�ڵ�
            H(index) = [];                                                     %��H��ɾ����ѡ�еĽڵ�
        end
    end
end
    
distance = 0;
if length(omega) > 1 && omega(length(omega)) == rx
    for k = 1:length(omega)-1
        distance = distance+Delay(omega(k),omega(k+1));
    end
    path = omega;
else
    distance = inf;
    path = [tx rx];
end

        