% ����ACO���TSP����
% �����к�����ӵ������У��ѡ�����ָ�У�����һ����̵�������·
% �ܹ�����������ѡ�ĸ�У�����ҽ�����ÿ����Уһ��
% ����һ�����͵�TSP�������̣����⣬��������Ⱥ�Ż��㷨��ACO�������

clc;
clear all;

%��ȡͬĿ¼�º�����ѡѧУ���ֺ;�γ�������excel���
[clg_coord,clg_name] = xlsread('college');clc
clg_rad = clg_coord/180*pi;          % �Ƕ�����ת��Ϊ��������

Re = 6371.004;                       % ����ƽ���뾶Ϊ6371.004km
n = size(clg_name,1);                % ѧУ������
D = zeros(n,n);                      % n��n�еľ��󣬴���������ѧУ֮��ľ���
% ��������ľ�γ�ȼ�������֮��ľ��룬��λ��km
for i = 1:n 
    for j = 1:n 
        if i ~= j
            C = sin(clg_rad(i,2))*sin(clg_rad(j,2)) + cos(clg_rad(i,2))*cos(clg_rad(j,2))*cos(clg_rad(i,1)-clg_rad(j,1));
            D(i,j) = Re*acos(C);
        end 
    end
end

% ��ʼ������
m = 100;                             % ��������
alpha = 1;                           % ��Ϣ����Ҫ�̶�����
beta = 2;                            % ����������Ҫ�̶�����
rho = 0.2;                           % ��Ϣ�ػӷ�����
Q = 1;                               % ��ϵ��
Eta = 1./D;                          % ��������
Tau = ones(n,n);                     % ��Ϣ�ؾ���,ȫ1����
Table = zeros(m,n);                  % ·����¼��ȫ0����ÿֻ���������߹���ѧУ
iter = 1;                            % ����������ֵ
iter_max = 100;                      % ����������
Route_best = zeros(iter_max,n);      % �������·��
Length_best = zeros(iter_max,1);     % �������·���ĳ���
Length_ave = zeros(iter_max,1);      % ����·����ƽ������

% ����Ѱ�����·��
while iter <= iter_max
    % ��������������ϵ����ѧУ
    start = zeros(m,1);              % m�����ϵĸ�����m��1�еľ��󣬼�¼ÿ�����ϵ�ѧУ���
    for i = 1:m
        temp = randperm(n); 
        start(i) = temp(1); 
    end
    Table(:,1) = start;              % ·����¼���1�У�Ϊÿ�����ϵ����ѧУ
    % ������ռ�
    clg_rad_index = 1:n;
    % �������·��ѡ��
    for i = 1:m
        % ���ѧУ·��ѡ��
        for j = 2:n
            tabu = Table(i,1:(j - 1));                        % �ѷ��ʵ�ѧУ����(���ɱ�)
            allow_index = ~ismember(clg_rad_index,tabu);      % ����tabuѧУ����Ҫ���ʵ�ѧУ
            allow = clg_rad_index(allow_index);               % �����ʵ�ѧУ����
            P = allow;
            % ����ѧУ��ת�Ƹ���
            for k = 1:length(allow)
                P(k)  =  Tau(tabu(end),allow(k))^alpha*Eta(tabu(end),allow(k))^beta; 
            end
                P = P/sum(P);                         % ��һ��
                % ���̶ķ�ѡ����һ������ѧУ
                Pc = cumsum(P);                       % �����ۼӣ���ʵ�����̶ķ�ѡ��ķ���
                target_index = find(Pc >= rand);
                target = allow(target_index(1)); 
                Table(i,j) = target; 
        end 
    end
    
    % ����������ϵ�·������
    Length = zeros(m,1);                              % m��1�еľ���
    for i = 1:m
        Route = Table(i,:);                           % ��iֻ���ϵ�·��
        for j = 1:(n - 1)                             % ���μ����iֻ�������߹��ĸ�ѧУ��ľ���j-j+1
            Length(i) = Length(i) + D(Route(j),Route(j + 1)); 
        end
        Length(i) = Length(i) + D(Route(n),Route(1)); % �������ѧУ���׸�ѧУ�ľ���
    end
    
    % �������·�����뼰ƽ������
    if iter == 1
        [min_Length,min_index] = min(Length);         % ��ֻ������·������Сֵ
        Length_best(iter) = min_Length;   
        Length_ave(iter) = mean(Length);
        Route_best(iter,:) = Table(min_index,:);      % ȡ���·��
    else 
        [min_Length,min_index] = min(Length);         % ������ǵ�һ�֣���Ҫ��������С·�����бȽ�
        Length_best(iter) = min(Length_best(iter - 1),min_Length); 
        Length_ave(iter) = mean(Length); 
        if Length_best(iter) == min_Length
            Route_best(iter,:) = Table(min_index,:);
        else 
            Route_best(iter,:) = Route_best((iter-1),:); 
        end 
    end
    
    % ������Ϣ��
    Delta_Tau = zeros(n,n);
    % ������ϼ���
    for i = 1:m
        % ���ѧУ����
        for j = 1:(n - 1) 
              Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i); 
        end 
        Delta_Tau(Table(i,n),Table(i,1))= Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i); 
    end 
    Tau = (1-rho) * Tau + Delta_Tau;
    % ����������1�����·����¼��
    iter = iter + 1; 
    Table = zeros(m,n);
end

% �����ʾ
[Shortest_Length,index] = min(Length_best); 
Shortest_Route = Route_best(index,:);
disp(['��̾���:' num2str(Shortest_Length) 'km']);
disp(['���·��:' num2str([Shortest_Route Shortest_Route(1)])]); 
%  for i = 1:n
%     disp(clg_name(Shortest_Route(i))); 
%  end


% ��ͼ
figure(1) 
plot([clg_coord(Shortest_Route,1);clg_coord(Shortest_Route(1),1)],... 
     [clg_coord(Shortest_Route,2);clg_coord(Shortest_Route(1),2)],'ko-'); 
grid on;
hold on;
for i = 1:n
    text(clg_coord(i,1),clg_coord(i,2),['  ' num2str(i)]); 
end
text(clg_coord(Shortest_Route(1),1),clg_coord(Shortest_Route(1),2),'      ����㣩'); 
text(clg_coord(Shortest_Route(end),1),clg_coord(Shortest_Route(end),2),'      ���յ㣩');
xlabel('ѧУλ�ú�����');
ylabel('ѧУλ��������');
title(['��Ⱥ�Ż��㷨����·��(��̾���:' num2str(Shortest_Length) 'km)']) ;
figure(2)
plot(1:iter_max,Length_best,'b',1:iter_max,Length_ave,'r:');
legend('��̾���','ƽ������');
xlabel('��������');
ylabel('���룺km');
title('������̾�����ƽ������Ա�')