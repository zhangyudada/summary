%在一定区域内随机撒点用户站并布置信关站

clc;
clear all;

SS_NUM = 1000;                      %用户站数量暂定为1000个
SS_LOCATION = ones(SS_NUM,6);       %SS_LOCATION第1列存放用户站横坐标，第2列存放用户站纵坐标
                                    %第3列存放用户站速率大小，第4列存放用户站速度方向（角度值）
                                    %第5列存放用户站所属信关站的ID,第6列存放自己的用户站ID
GS_NUM = 8;                         %信关站数量暂定为8个
GS_LOCATION = ones(GS_NUM,2);       %存放信关站圆心的横纵坐标
Radius = 500;                       %信关站覆盖半径为500km

%信关站的圆心分布
UNIT = Radius*sin(pi/4);
GS_LOCATION(1,:) = [-UNIT*3,UNIT];
GS_LOCATION(2,:) = [-UNIT*3,-UNIT];
GS_LOCATION(3,:) = [-UNIT,UNIT];
GS_LOCATION(4,:) = [-UNIT,-UNIT];
GS_LOCATION(5,:) = [UNIT,UNIT];
GS_LOCATION(6,:) = [UNIT,-UNIT];
GS_LOCATION(7,:) = [UNIT*3,UNIT];
GS_LOCATION(8,:) = [UNIT*3,-UNIT];

%画出各个信关站的覆盖范围
for i = 1:GS_NUM
    circle(GS_LOCATION(i,1),GS_LOCATION(i,2),Radius);
end

%用户站分布区域的界限
X_MIN = -4*UNIT;
X_MAX = 4*UNIT;
Y_MIN = -2*UNIT;
Y_MAX = 2*UNIT;

%完成用户站的随机撒点
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
title('信关站和用户站分布');
hold on;
axis equal;
axis([-4*Radius, 4*Radius, -2*Radius, 2*Radius]);
grid on;
% legend('SS_LOCATION');