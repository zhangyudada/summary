function [distance path] = Dijk( W,st,e )
%DIJK Summary of this function goes here
%   W  权值矩阵   st 搜索的起点   e 搜索的终点
n=length(W);%权值矩阵行数，即节点数
D = W(st,:);%源节点与其他各节点的距离
visit= ones(1,n); visit(st)=0;%节点访问与否标识矩阵
parent = zeros(1,n);%记录每个节点的上一个节点

path =[];

for i=1:n-1
    temp = 1./zeros(1,n);
    %从起点出发，找最短距离的下一个点，每次不会重复原来的轨迹，设置visit判断节点是否访问
    for j=1:n
       if visit(j)
           temp(j) =D(j);
       end
       
    end
    
    [~,index] = min(temp);%为了获得temp中最小值的序号必须用这种形式，value值不需要
   
    visit(index) = 0;
    
    %更新 如果经过index节点，从起点到每个节点的路径长度更小，则更新，记录前趋节点，方便后面回溯循迹
    for k=1:n
        if D(k)>D(index)+W(index,k)
           D(k) = D(index)+W(index,k);
           parent(k) = index;
        end
    end
    
   
end

distance = D(e);%最短距离
%回溯法  从尾部往前寻找搜索路径
t = e;
while t~=st && t>0
 path =[t,path];
  p=parent(t);t=p;
end
path =[st,path];%最短路径


end
