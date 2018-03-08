%CD算法
function [distance path] = 	CD(Delay,Dth,tx,rx,D2DUE)

omega(1) = tx;
N = length(Delay);                                                         %N是权值矩阵的列数，也即D2D用户数
H = 1:N;                                                                   %剩余候选节点
H(tx) = [];                                                                %发送方不可能在候选节点中

for k =1:N
    if Delay(omega(k),rx) <=Dth                                            %如果当前节点到目的节点的直达时延满足要求，则下一节点选为目的节点，并结束循环
        omega(k+1) = rx;
        break;
    else
        delete =[];
        for i = 1:length(H)
            if Delay(omega(k),H(i)) > Dth
                delete = [delete i];                                       %记录H中不满足时延要求的节点序号
            end
        end
        H(delete(1:length(delete))) = [];                                  %删除H中不满足时延要求的节点
        
        if length(H) == 0;                                                 %候选节点为空，说明路由选择失败，发生中断，结束循环
            break;
        else
            d_omega2rx = 1./zeros(1,length(H));                                 %存放各候选节点到目的节点的距离，初始化为无穷大
            for s = 1:length(H)
                d_omega2rx(s) = sqrt((D2DUE(H(s),1)-D2DUE(rx,1))^2+(D2DUE(H(s),2)-D2DUE(rx,2))^2);
            end
            [~,index] = min(d_omega2rx);                                   %选出到目的节点距离最小的候选节点，记录其在H中的序号
            omega(k+1) = H(index);                                             %下一节点选为到目的节点距离最小的候选节点
            H(index) = [];                                                     %在H中删除被选中的节点
        end
    end
end
    
distance = 0;
if length(omega) > 1 && omega(length(omega)) == rx
    for k = 1:length(omega)-1
        distance = distance+Delay(omega(k),omega(k+1));
    end
    path = omega;
else
    distance = inf;
    path = [tx rx];
end

        