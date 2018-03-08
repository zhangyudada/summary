% 利用ACO解决TSP问题
% 北京市海淀区拥有许多高校，选出部分高校，设计一条最短的旅行线路
% 能够遍历所有所选的高校，并且仅经过每个高校一次
% 这是一个典型的TSP（旅行商）问题，可利用蚁群优化算法（ACO）来解决

clc;
clear all;

%读取同目录下含有所选学校名字和经纬度坐标的excel表格
[clg_coord,clg_name] = xlsread('college');clc
clg_rad = clg_coord/180*pi;          % 角度坐标转换为弧度坐标

Re = 6371.004;                       % 地球平均半径为6371.004km
n = size(clg_name,1);                % 学校的数量
D = zeros(n,n);                      % n行n列的矩阵，存放任意二个学校之间的距离
% 根据两点的经纬度计算两点之间的距离，单位是km
for i = 1:n 
    for j = 1:n 
        if i ~= j
            C = sin(clg_rad(i,2))*sin(clg_rad(j,2)) + cos(clg_rad(i,2))*cos(clg_rad(j,2))*cos(clg_rad(i,1)-clg_rad(j,1));
            D(i,j) = Re*acos(C);
        end 
    end
end

% 初始化参数
m = 100;                             % 蚂蚁数量
alpha = 1;                           % 信息素重要程度因子
beta = 2;                            % 启发函数重要程度因子
rho = 0.2;                           % 信息素挥发因子
Q = 1;                               % 常系数
Eta = 1./D;                          % 启发函数
Tau = ones(n,n);                     % 信息素矩阵,全1矩阵
Table = zeros(m,n);                  % 路径记录表，全0矩阵，每只蚂蚁依次走过的学校
iter = 1;                            % 迭代次数初值
iter_max = 100;                      % 最大迭代次数
Route_best = zeros(iter_max,n);      % 各代最佳路径
Length_best = zeros(iter_max,1);     % 各代最佳路径的长度
Length_ave = zeros(iter_max,1);      % 各代路径的平均长度

% 迭代寻找最佳路径
while iter <= iter_max
    % 随机产生各个蚂蚁的起点学校
    start = zeros(m,1);              % m是蚂蚁的个数，m行1列的矩阵，记录每个蚂蚁的学校编号
    for i = 1:m
        temp = randperm(n); 
        start(i) = temp(1); 
    end
    Table(:,1) = start;              % 路径记录表的1列，为每个蚂蚁的起点学校
    % 构建解空间
    clg_rad_index = 1:n;
    % 逐个蚂蚁路径选择
    for i = 1:m
        % 逐个学校路径选择
        for j = 2:n
            tabu = Table(i,1:(j - 1));                        % 已访问的学校集合(禁忌表)
            allow_index = ~ismember(clg_rad_index,tabu);      % 不是tabu学校就是要访问的学校
            allow = clg_rad_index(allow_index);               % 待访问的学校集合
            P = allow;
            % 计算学校间转移概率
            for k = 1:length(allow)
                P(k)  =  Tau(tabu(end),allow(k))^alpha*Eta(tabu(end),allow(k))^beta; 
            end
                P = P/sum(P);                         % 归一化
                % 轮盘赌法选择下一个访问学校
                Pc = cumsum(P);                       % 依次累加，是实现轮盘赌法选择的方法
                target_index = find(Pc >= rand);
                target = allow(target_index(1)); 
                Table(i,j) = target; 
        end 
    end
    
    % 计算各个蚂蚁的路径距离
    Length = zeros(m,1);                              % m行1列的矩阵
    for i = 1:m
        Route = Table(i,:);                           % 第i只蚂蚁的路线
        for j = 1:(n - 1)                             % 依次计算第i只蚂蚁所走过的各学校间的距离j-j+1
            Length(i) = Length(i) + D(Route(j),Route(j + 1)); 
        end
        Length(i) = Length(i) + D(Route(n),Route(1)); % 加上最后学校到首个学校的距离
    end
    
    % 计算最短路径距离及平均距离
    if iter == 1
        [min_Length,min_index] = min(Length);         % 各只蚂蚁中路长的最小值
        Length_best(iter) = min_Length;   
        Length_ave(iter) = mean(Length);
        Route_best(iter,:) = Table(min_index,:);      % 取最短路线
    else 
        [min_Length,min_index] = min(Length);         % 如果不是第一轮，则要与上轮最小路长进行比较
        Length_best(iter) = min(Length_best(iter - 1),min_Length); 
        Length_ave(iter) = mean(Length); 
        if Length_best(iter) == min_Length
            Route_best(iter,:) = Table(min_index,:);
        else 
            Route_best(iter,:) = Route_best((iter-1),:); 
        end 
    end
    
    % 更新信息素
    Delta_Tau = zeros(n,n);
    % 逐个蚂蚁计算
    for i = 1:m
        % 逐个学校计算
        for j = 1:(n - 1) 
              Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i); 
        end 
        Delta_Tau(Table(i,n),Table(i,1))= Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i); 
    end 
    Tau = (1-rho) * Tau + Delta_Tau;
    % 迭代次数加1，清空路径记录表
    iter = iter + 1; 
    Table = zeros(m,n);
end

% 结果显示
[Shortest_Length,index] = min(Length_best); 
Shortest_Route = Route_best(index,:);
disp(['最短距离:' num2str(Shortest_Length) 'km']);
disp(['最短路径:' num2str([Shortest_Route Shortest_Route(1)])]); 
%  for i = 1:n
%     disp(clg_name(Shortest_Route(i))); 
%  end


% 绘图
figure(1) 
plot([clg_coord(Shortest_Route,1);clg_coord(Shortest_Route(1),1)],... 
     [clg_coord(Shortest_Route,2);clg_coord(Shortest_Route(1),2)],'ko-'); 
grid on;
hold on;
for i = 1:n
    text(clg_coord(i,1),clg_coord(i,2),['  ' num2str(i)]); 
end
text(clg_coord(Shortest_Route(1),1),clg_coord(Shortest_Route(1),2),'      （起点）'); 
text(clg_coord(Shortest_Route(end),1),clg_coord(Shortest_Route(end),2),'      （终点）');
xlabel('学校位置横坐标');
ylabel('学校位置纵坐标');
title(['蚁群优化算法最优路径(最短距离:' num2str(Shortest_Length) 'km)']) ;
figure(2)
plot(1:iter_max,Length_best,'b',1:iter_max,Length_ave,'r:');
legend('最短距离','平均距离');
xlabel('迭代次数');
ylabel('距离：km');
title('各代最短距离与平均距离对比')