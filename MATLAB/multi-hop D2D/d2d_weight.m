%����D2D�û�֮���Ȩֵ����ȨֵΪ��D2D�û�֮������ݰ�����ʱ�䣬��D2D��ʱ��
%�����ÿ��D2D�û��趨һ��������������������ſ�ʼ�������ݣ��ȴ�����������ʱ��Ϊ����ʱ��
%����ʱ��ΪD2D�ڵ�Լ�ľ�����Ե�Ų��ڿռ��еĴ������ʣ����ڴ���ʱ��ԶС�ڷ���ʱ�ӣ���˺��Բ���
%��ʱ�Ӵ�����ֵ������������С��������ֵ��ʱ�����趨Ȩֵ�����ж�ӦԪ��λ�����inf

function [Rate] = d2d_weight(CUE_Num,D2DUE_Num,CUE_Container,D2DUE_Container,CUE_Distance,D2DUE_Distance,Rth)

B = 10^7;                                                                  %ϵͳ������10MHz
Gi = 0.25;                                                                 %˥�䳣����-6dB����0.25
P0 = 0.2;                                                                  %�����û����书�ʣ�23dBm����0.2W
alpha = 4;                                                                 %·��ָ��Ϊ4
N0 = 10^(-12.6);                                                           %��˹��������-96dBm����10^(-12.6)W
xi_th = 4;                                                                 %������С����ȣ�6dB����4
% Rth = 7*10^7;                                                                %��С����������ֵ��10Mbps
%buffer = 0.1*2^20;                                                             %D2D�û���������С��0.1Mb������������ſ�ʼ��һ������˵ȴ�����������ʱ�伴Ϊ��ӦD2D��ʱ��
                                                                           %������������ʱ�Ӻܴ� ��������С������ܻ�����ǰ�������ʲ�ƥ�䵼�»��������Rǰ>>R�󣩻򻺴�գ�Rǰ<<R��                                                                           
Rate = zeros(D2DUE_Num);                                              %Ȩֵ���󣬴�Ÿ��ߴ������ʣ�Ĭ��ȫΪ0

% m = randperm(CUE_Num);                                                     %�������û����������ҷŵ�����m�У�Ȼ�󽫵�m(i)�������û��ŵ��������i��D2D�û���
%                                                                            %��������ʵ�ǲ��׵ģ��������鷢�ֶ��ڲ�ͬ��m���жϸ��ʲ�ͬ����˴���һ������m��ʹ��������жϸ�����С
%                                                                            %��������ҵ�������ŵ�m����Ŀǰ������ȷ��������ŵ�m
%                                                                            
% %Ƕ��ѭ�������γ�D2D��ʱ�ӵ�Ȩֵ����
% for i = 1:D2DUE_Num
%     D_i = D2DUE_Distance(i);                                       %��i��D2D�û�����վ�ľ���
%     d_m = CUE_Distance(m(i));                                      %��m(i)�������û�����վ�ľ���
%     for j = 1:D2DUE_Num
%         if i~=j           
%             d_ij = sqrt((D2DUE_Container(i,1)-D2DUE_Container(j,1))^2+(D2DUE_Container(i,2)-D2DUE_Container(j,2))^2);%D2D�û�i��j֮��ľ���           
%             delta_j = sqrt((D2DUE_Container(j,1)-CUE_Container(m(i),1))^2+(D2DUE_Container(j,2)-CUE_Container(m(i),2))^2);%D2D�û�j�빲���ŵ��ķ����û�m(i)֮��ľ���
%             Rate_ij = B*log2(1+(Gi*P0*(d_m^(-alpha))*(d_ij^(-alpha)))/((N0+Gi*P0*(delta_j^(-alpha)))*(D_i^(-alpha))*xi_th));%����D2D�û�i��j֮����������
%             if Rate_ij >= Rth                                              %��Rate_ij��������������ʣ�����ת��Ϊʱ�Ӽ�¼��Ȩֵ�����У�������Ϊ��·��ͨ����ӦȨֵΪĬ�ϵ������
%                 Weight(i,j) = buffer/Rate_ij;
%             end
%         end
%     end
% end

m = 1:CUE_Num;                                                             %��ŷ����û������
%Ƕ��ѭ�������γ�D2D��ʱ�ӵ�Ȩֵ����
for i = 1:D2DUE_Num
    d2d_temp = zeros(1,D2DUE_Num);                                     %��ʱ������ʾ��󣬴��ָ��D2D�ڵ�i����ڲ�ͬ��j����������ʣ������ŵ�ʱ���õ����������
    index = zeros(1,D2DUE_Num);                                     %������ž��󣬴��ָ��D2D�ڵ�i����ڲ�ͬ��j����������ʣ������ŵ�ʱ���õ����������ʱ��Ӧ�ķ����û� ��m�е����
    for j = 1:D2DUE_Num
        if i~=j           
            D_i = D2DUE_Distance(i);                                       %��i��D2D�û�����վ�ľ���
            d_ij = sqrt((D2DUE_Container(i,1)-D2DUE_Container(j,1))^2+(D2DUE_Container(i,2)-D2DUE_Container(j,2))^2);%D2D�û�i��j֮��ľ���

            c_temp = zeros(1,length(m));                                     %��ʱ���ʾ��󣬴��ָ��D2D�ڵ��ij��������ʣ������ŵ�ʱ���õ����������
            for k = 1:length(m)
                d_mk = CUE_Distance(m(k));                                  %��m(k)�������û�����վ�ľ���
                delta_j = sqrt((D2DUE_Container(j,1)-CUE_Container(m(k),1))^2+(D2DUE_Container(j,2)-CUE_Container(m(k),2))^2);%D2D�û�j�빲���ŵ��ĵ�m(k)�������û�֮��ľ���
                c_temp(k) = B*log2(1+(Gi*P0*(d_mk^(-alpha))*(d_ij^(-alpha)))/((N0+Gi*P0*(delta_j^(-alpha)))*(D_i^(-alpha))*xi_th));%����D2D�û�i��j֮����������               
            end
            [d2d_temp(j),index(j)] = max(c_temp);                          %d2d_temp��¼D2D�ڵ��i��j��ɴﵽ��������ʣ�index��¼���õķ����û���c_temp�е����
                                                                           %c_temp�е�k��Ԫ�ض�Ӧm�е�k��Ԫ��
        else
            (j) = 0;
        end
    end
    
    [~,ind] = max(d2d_temp);                                       %�ҳ��ڵ�i��ĳ���ڵ�j֮�䴫�����ʴﵽ��󣬸��õķ����û����
    mi = m(index(ind));                                                    %index(ind)��¼���Ǹ÷����û���c_temp�е���ţ���Ӧ��m�е����
    d_mi = CUE_Distance(mi);                                      %��mi�������û�����վ�ľ���
    for l = 1:D2DUE_Num
        if i ~= l
            d_il = sqrt((D2DUE_Container(i,1)-D2DUE_Container(l,1))^2+(D2DUE_Container(i,2)-D2DUE_Container(l,2))^2);%D2D�û�i��l֮��ľ���                   
            delta_l = sqrt((D2DUE_Container(l,1)-CUE_Container(mi,1))^2+(D2DUE_Container(l,2)-CUE_Container(mi,2))^2);%D2D�û�l�빲���ŵ��ķ����û�mi֮��ľ���
            Rate_il = B*log2(1+(Gi*P0*(d_mi^(-alpha))*(d_il^(-alpha)))/((N0+Gi*P0*(delta_l^(-alpha)))*(D_i^(-alpha))*xi_th));%����D2D�û�i��l֮����������
            if Rate_il >= Rth                                              %��Rate_il��������������ʣ������¼��Ȩֵ�����У�������Ϊ��·��ͨ����ӦȨֵΪĬ�ϵ�0
                Rate(i,l) = Rate_il;
            end
        end
    end
    m(index(ind)) = [];                                                 %�����õķ����û���һ�ֲ��ٱ����ã�����m��ɾ��֮
end

end