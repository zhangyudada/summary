%��һ����������������û�վ�������Ź�վ

clc;
clear all;

SS_NUM = 1000;                      %�û�վ�����ݶ�Ϊ1000��
SS_LOCATION = ones(SS_NUM,6);       %SS_LOCATION��1�д���û�վ�����꣬��2�д���û�վ������
                                    %��3�д���û�վ���ʴ�С����4�д���û�վ�ٶȷ��򣨽Ƕ�ֵ��
                                    %��5�д���û�վ�����Ź�վ��ID,��6�д���Լ����û�վID
GS_NUM = 8;                         %�Ź�վ�����ݶ�Ϊ8��
GS_LOCATION = ones(GS_NUM,2);       %����Ź�վԲ�ĵĺ�������
Radius = 500;                       %�Ź�վ���ǰ뾶Ϊ500km

%�Ź�վ��Բ�ķֲ�
UNIT = Radius*sin(pi/4);
GS_LOCATION(1,:) = [-UNIT*3,UNIT];
GS_LOCATION(2,:) = [-UNIT*3,-UNIT];
GS_LOCATION(3,:) = [-UNIT,UNIT];
GS_LOCATION(4,:) = [-UNIT,-UNIT];
GS_LOCATION(5,:) = [UNIT,UNIT];
GS_LOCATION(6,:) = [UNIT,-UNIT];
GS_LOCATION(7,:) = [UNIT*3,UNIT];
GS_LOCATION(8,:) = [UNIT*3,-UNIT];

%���������Ź�վ�ĸ��Ƿ�Χ
for i = 1:GS_NUM
    circle(GS_LOCATION(i,1),GS_LOCATION(i,2),Radius);
end

%�û�վ�ֲ�����Ľ���
X_MIN = -4*UNIT;
X_MAX = 4*UNIT;
Y_MIN = -2*UNIT;
Y_MAX = 2*UNIT;

%����û�վ���������
for i = 1:SS_NUM
    x = unifrnd(X_MIN,X_MAX);
    y = unifrnd(Y_MIN,Y_MAX);
    SS_LOCATION(i,:) = [x,y,0,0,0,i];
end

% save LAYOUT;
% save .\SS_LOCATION.txt SS_LOCATION -ASCII
%
plot(SS_LOCATION(:,1),SS_LOCATION(:,2),'.r');
xlabel('km');
ylabel('km');
title('�Ź�վ���û�վ�ֲ�');
hold on;
axis equal;
axis([-4*Radius, 4*Radius, -2*Radius, 2*Radius]);
grid on;
% legend('SS_LOCATION');