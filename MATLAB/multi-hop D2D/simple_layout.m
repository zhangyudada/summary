%简化的布局
%蜂窝用户CUE和D2D用户D2DUE布局

clc;
clear all;
CUE_Num = 140;                                                              %蜂窝用户数量，密度约为300个/平方千米
D2DUE_Num = 110;                                                            %D2D用户数量，密度约为300个/平方千米
Radius = 400;                                                              %城区基站覆盖半径400m

%蜂窝用户布局
BS_Location = [0,0];                                                       %基站坐标
CUE_Container = ones(CUE_Num,2);                                           %存放基站的蜂窝用户横纵坐标
CUE_Distance = ones(1,CUE_Num);                                            %存放基站的蜂窝用户到基站的距离
for k = 1:CUE_Num
    CUE_R = unifrnd(Radius/4,Radius);                                    %蜂窝用户连续均匀随机分布在R/4到R的环内
    CUE_Theta = unifrnd(-pi,pi);                                           %蜂窝用户与基站的夹角连续均匀随机分布在-pi到pi的之间
    CUE_Container(k,1) = CUE_R*cos(CUE_Theta);                             %基站第k个蜂窝用户的横坐标
    CUE_Container(k,2) = CUE_R*sin(CUE_Theta);                             %基站第k个蜂窝用户的纵坐标
    CUE_Distance(k) = CUE_R;
end

%D2D用户布局
D2DUE_Container = ones(D2DUE_Num,2);                                       %存放基站的D2D用户横纵坐标
D2DUE_Distance = ones(1,D2DUE_Num);                                        %存放基站的D2D用户到基站的距离
D2DUE_Angle = ones(1,D2DUE_Num);                                           %存放基站的D2D用户到基站的角度，用于IAR算法
for k = 1:D2DUE_Num
    D2DUE_R = unifrnd(Radius/2,Radius);                                    %D2D用户连续均匀随机分布在R/2到R的环内
    D2DUE_Theta = unifrnd(-pi,pi);                                         %D2D用户与基站的夹角连续均匀随机分布在-pi到pi的之间
    D2DUE_Container(k,1) = D2DUE_R*cos(D2DUE_Theta);                       %基站第k个D2D用户的横坐标
    D2DUE_Container(k,2) = D2DUE_R*sin(D2DUE_Theta);                       %基站第k个D2D用户的纵坐标
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