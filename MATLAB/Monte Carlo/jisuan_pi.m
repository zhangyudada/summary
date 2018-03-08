%面积法求PI值

clc;
clear all;

%进行随机投点实验的次数
Test_num = 1e6;
%点落在正方形内1/4圆内的次数
Success_num = 0;
%正方形内1/4圆的半径，也即正方形边长
R = 10;

for i = 1:Test_num
    x = unifrnd(0,R);
    y = unifrnd(0,R);
    if sqrt(x*x+y*y) <= R
        Success_num = Success_num + 1;
    end
end

%计算PI值，用频率（Success_num/Test_num）代替概率
my_PI = 4*Success_num/Test_num;
fprintf('PI = %d\n', my_PI); 