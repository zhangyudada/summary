%�򻯵Ĳ���
%�����û�CUE��D2D�û�D2DUE����

clc;
clear all;
CUE_Num = 140;                                                              %�����û��������ܶ�ԼΪ300��/ƽ��ǧ��
D2DUE_Num = 110;                                                            %D2D�û��������ܶ�ԼΪ300��/ƽ��ǧ��
Radius = 400;                                                              %������վ���ǰ뾶400m

%�����û�����
BS_Location = [0,0];                                                       %��վ����
CUE_Container = ones(CUE_Num,2);                                           %��Ż�վ�ķ����û���������
CUE_Distance = ones(1,CUE_Num);                                            %��Ż�վ�ķ����û�����վ�ľ���
for k = 1:CUE_Num
    CUE_R = unifrnd(Radius/4,Radius);                                    %�����û�������������ֲ���R/4��R�Ļ���
    CUE_Theta = unifrnd(-pi,pi);                                           %�����û����վ�ļн�������������ֲ���-pi��pi��֮��
    CUE_Container(k,1) = CUE_R*cos(CUE_Theta);                             %��վ��k�������û��ĺ�����
    CUE_Container(k,2) = CUE_R*sin(CUE_Theta);                             %��վ��k�������û���������
    CUE_Distance(k) = CUE_R;
end

%D2D�û�����
D2DUE_Container = ones(D2DUE_Num,2);                                       %��Ż�վ��D2D�û���������
D2DUE_Distance = ones(1,D2DUE_Num);                                        %��Ż�վ��D2D�û�����վ�ľ���
D2DUE_Angle = ones(1,D2DUE_Num);                                           %��Ż�վ��D2D�û�����վ�ĽǶȣ�����IAR�㷨
for k = 1:D2DUE_Num
    D2DUE_R = unifrnd(Radius/2,Radius);                                    %D2D�û�������������ֲ���R/2��R�Ļ���
    D2DUE_Theta = unifrnd(-pi,pi);                                         %D2D�û����վ�ļн�������������ֲ���-pi��pi��֮��
    D2DUE_Container(k,1) = D2DUE_R*cos(D2DUE_Theta);                       %��վ��k��D2D�û��ĺ�����
    D2DUE_Container(k,2) = D2DUE_R*sin(D2DUE_Theta);                       %��վ��k��D2D�û���������
    D2DUE_Distance(k) = D2DUE_R;
    D2DUE_Angle(k) = D2DUE_Theta;
end

% save SIMPLE_LAYOUT

% save .\simple_layout\CUE.txt CUE_Container -ASCII
% save .\simple_layout\D2DUE.txt D2DUE_Container -ASCII
% 
plot(BS_Location(1),BS_Location(2),'ok');
hold on;
plot(CUE_Container(:,1),CUE_Container(:,2),'*r');
plot(D2DUE_Container(:,1),D2DUE_Container(:,2),'.g');
axis equal;
axis([-500, 500, -500, 500]);
grid;
legend('BS','CUE','D2DUE','location','northeast');