%建立D2D用户之间的权值矩阵，权值为两D2D用户之间的数据包发送时间，即D2D对时延
%这里给每个D2D用户设定一个缓存区，缓存区满后才开始发送数据，等待缓存区满的时延为发送时延
%传播时延为D2D节点对间的距离除以电磁波在空间中的传播速率，由于传播时延远小于发送时延，因此忽略不计
%当时延大于阈值（即传输速率小于速率阈值）时，则设定权值矩阵中对应元素位无穷大inf

function [Rate] = d2d_weight(CUE_Num,D2DUE_Num,CUE_Container,D2DUE_Container,CUE_Distance,D2DUE_Distance,Rth)

B = 10^7;                                                                  %系统带宽是10MHz
Gi = 0.25;                                                                 %衰落常数，-6dB，即0.25
P0 = 0.2;                                                                  %蜂窝用户传输功率，23dBm，即0.2W
alpha = 4;                                                                 %路损指数为4
N0 = 10^(-12.6);                                                           %高斯白噪声，-96dBm，即10^(-12.6)W
xi_th = 4;                                                                 %蜂窝最小信噪比，6dB，即4
% Rth = 7*10^7;                                                                %最小传输速率阈值，10Mbps
%buffer = 0.1*2^20;                                                             %D2D用户缓存区大小，0.1Mb，缓存区满后才开始下一跳，因此等待缓存区满的时间即为对应D2D对时延
                                                                           %缓存区过大，则时延很大； 缓存区过小，则可能会由于前后跳速率不匹配导致缓存溢出（R前>>R后）或缓存空（R前<<R后）                                                                           
Rate = zeros(D2DUE_Num);                                              %权值矩阵，存放各边传输速率，默认全为0

% m = randperm(CUE_Num);                                                     %将蜂窝用户序号随机打乱放到数组m中，然后将第m(i)个蜂窝用户信道共享给第i个D2D用户对
%                                                                            %这样做其实是不妥的，几次试验发现对于不同的m，中断概率不同，因此存在一个数组m，使得求出的中断概率最小
%                                                                            %最好是能找到这个最优的m，但目前并不会确定这个最优的m
%                                                                            
% %嵌套循环用于形成D2D对时延的权值矩阵
% for i = 1:D2DUE_Num
%     D_i = D2DUE_Distance(i);                                       %第i个D2D用户到基站的距离
%     d_m = CUE_Distance(m(i));                                      %第m(i)个蜂窝用户到基站的距离
%     for j = 1:D2DUE_Num
%         if i~=j           
%             d_ij = sqrt((D2DUE_Container(i,1)-D2DUE_Container(j,1))^2+(D2DUE_Container(i,2)-D2DUE_Container(j,2))^2);%D2D用户i和j之间的距离           
%             delta_j = sqrt((D2DUE_Container(j,1)-CUE_Container(m(i),1))^2+(D2DUE_Container(j,2)-CUE_Container(m(i),2))^2);%D2D用户j与共享信道的蜂窝用户m(i)之间的距离
%             Rate_ij = B*log2(1+(Gi*P0*(d_m^(-alpha))*(d_ij^(-alpha)))/((N0+Gi*P0*(delta_j^(-alpha)))*(D_i^(-alpha))*xi_th));%计算D2D用户i和j之间的最大速率
%             if Rate_ij >= Rth                                              %若Rate_ij大于最低门限速率，则将其转换为时延记录到权值矩阵中，否则认为链路不通，对应权值为默认的无穷大
%                 Weight(i,j) = buffer/Rate_ij;
%             end
%         end
%     end
% end

m = 1:CUE_Num;                                                             %存放蜂窝用户的序号
%嵌套循环用于形成D2D对时延的权值矩阵
for i = 1:D2DUE_Num
    d2d_temp = zeros(1,D2DUE_Num);                                     %临时最大速率矩阵，存放指定D2D节点i后对于不同的j，复用所有剩余蜂窝信道时所得到的最大速率
    index = zeros(1,D2DUE_Num);                                     %蜂窝序号矩阵，存放指定D2D节点i后对于不同的j，复用所有剩余蜂窝信道时所得到的最大速率时对应的蜂窝用户 在m中的序号
    for j = 1:D2DUE_Num
        if i~=j           
            D_i = D2DUE_Distance(i);                                       %第i个D2D用户到基站的距离
            d_ij = sqrt((D2DUE_Container(i,1)-D2DUE_Container(j,1))^2+(D2DUE_Container(i,2)-D2DUE_Container(j,2))^2);%D2D用户i和j之间的距离

            c_temp = zeros(1,length(m));                                     %临时速率矩阵，存放指定D2D节点对ij复用所有剩余蜂窝信道时所得到的最大速率
            for k = 1:length(m)
                d_mk = CUE_Distance(m(k));                                  %第m(k)个蜂窝用户到基站的距离
                delta_j = sqrt((D2DUE_Container(j,1)-CUE_Container(m(k),1))^2+(D2DUE_Container(j,2)-CUE_Container(m(k),2))^2);%D2D用户j与共享信道的第m(k)个蜂窝用户之间的距离
                c_temp(k) = B*log2(1+(Gi*P0*(d_mk^(-alpha))*(d_ij^(-alpha)))/((N0+Gi*P0*(delta_j^(-alpha)))*(D_i^(-alpha))*xi_th));%计算D2D用户i和j之间的最大速率               
            end
            [d2d_temp(j),index(j)] = max(c_temp);                          %d2d_temp记录D2D节点对i、j间可达到的最大速率，index记录复用的蜂窝用户在c_temp中的序号
                                                                           %c_temp中第k个元素对应m中第k个元素
        else
            (j) = 0;
        end
    end
    
    [~,ind] = max(d2d_temp);                                       %找出节点i与某个节点j之间传输速率达到最大，复用的蜂窝用户序号
    mi = m(index(ind));                                                    %index(ind)记录的是该蜂窝用户在c_temp中的序号，对应着m中的序号
    d_mi = CUE_Distance(mi);                                      %第mi个蜂窝用户到基站的距离
    for l = 1:D2DUE_Num
        if i ~= l
            d_il = sqrt((D2DUE_Container(i,1)-D2DUE_Container(l,1))^2+(D2DUE_Container(i,2)-D2DUE_Container(l,2))^2);%D2D用户i和l之间的距离                   
            delta_l = sqrt((D2DUE_Container(l,1)-CUE_Container(mi,1))^2+(D2DUE_Container(l,2)-CUE_Container(mi,2))^2);%D2D用户l与共享信道的蜂窝用户mi之间的距离
            Rate_il = B*log2(1+(Gi*P0*(d_mi^(-alpha))*(d_il^(-alpha)))/((N0+Gi*P0*(delta_l^(-alpha)))*(D_i^(-alpha))*xi_th));%计算D2D用户i和l之间的最大速率
            if Rate_il >= Rth                                              %若Rate_il大于最低门限速率，则将其记录到权值矩阵中，否则认为链路不通，对应权值为默认的0
                Rate(i,l) = Rate_il;
            end
        end
    end
    m(index(ind)) = [];                                                 %被复用的蜂窝用户下一轮不再被复用，则在m中删除之
end

end