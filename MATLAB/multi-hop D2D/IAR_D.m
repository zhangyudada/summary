%IAR算法，每一步用D算法实现

function [distance path] = IAR_D(Delay,D2DUE_Distance,tx,rx,D2DUE)

Delta_D_tx = [];                                                               %存放满足发送速率要求的边缘D2D用户与发送方的距离
Delta_D_rx = [];                                                               %存放满足接收速率要求的边缘D2D用户与接收方的距离
N = length(Delay);                                                             %D2D用户数
index_tx = [];                                                                 %存放满足发送方速率要求的边缘D2D用户的序号
index_rx = [];                                                                 %存放满足接收方速率要求的边缘D2D用户的序号
edge = 350;                                                                    %蜂窝边缘界限，即大于等于edge、小于等于蜂窝半径的环形区域

%IAR算法第一步Escape选择离源用户最近的边缘D2D用户ex1
if D2DUE_Distance(tx) >= edge                                                  %若发送方本身就是边缘用户
    ex1 = tx;                                                                  %则IAR算法第一步省略，离源用户最近的边缘D2D用户ex1就设为源用户
else
    for i = 1:N
        if i ~= tx && D2DUE_Distance(i) >= edge                                %寻找离发送方最近的边缘D2D用户
            D_tx_i = sqrt((D2DUE(tx,1)-D2DUE(i,1))^2+(D2DUE(tx,2)-D2DUE(i,2))^2);
            Delta_D_tx = [Delta_D_tx D_tx_i];
            index_tx = [index_tx i];
        end
    end
    
    if isempty(Delta_D_tx)                                                         %若未找到满足发送方速率要求的边缘D2D用户
        ex1 = tx;                                                                  %则IAR算法第一步省略，离源用户最近的边缘D2D用户ex1就设为源用户
    else
        [~,index1] = min(Delta_D_tx);                                              %否则选择离源用户最近的边缘D2D用户
        ex1 = index_tx(index1);
    end
end

%IAR算法第三步Return选择离目标用户最近的边缘D2D用户ex2
if D2DUE_Distance(rx) >= edge                                                  %若接收方本身就是边缘用户
    ex2 = rx;                                                                  %则IAR算法第三步省略，离目标用户最近的边缘D2D用户ex2就设为目标用户
else
    for i = 1:N
        if i ~= rx && D2DUE_Distance(i) >= edge                                %寻找离接收方最近的边缘D2D用户
            D_rx_i = sqrt((D2DUE(rx,1)-D2DUE(i,1))^2+(D2DUE(rx,2)-D2DUE(i,2))^2);
            Delta_D_rx = [Delta_D_rx D_rx_i];
            index_rx = [index_rx i];
        end
    end

    if isempty(Delta_D_rx)                                                         %若未找到满足接收方速率要求的边缘D2D用户
        ex2 = rx;                                                                  %则IAR算法第三步省略，离目标用户最近的边缘D2D用户ex2就设为目标用户
    else
        [~,index2] = min(Delta_D_rx);                                              %否则选择离目标用户最近的边缘D2D用户
        ex2 = index_rx(index2);
    end
end

%IAR算法第一步Escape
if tx == ex1
    distance1 = 0;
    path1 = tx;
else
    [distance1 path1] = Dijk(Delay,tx,ex1);
end

%IAR算法第二步Migrate
if ex1 == ex2                                                                  %若ex1和ex2是同一用户，则IAR算法的第二步省略
    distance2 = 0;
    path2 = [ex1 ex2];
else
    [distance2 path2] = Dijk(Delay,ex1,ex2);
end

%IAR算法第三步Return
if ex2 == rx
    distance3 = 0;
    path3 = rx;
else
    [distance3 path3] = Dijk(Delay,ex2,rx);
end

distance = distance1+distance2+distance3;
if distance1 == inf || distance2 == inf || distance3 == inf
    path = [tx rx];
else
    path2([1 length(path2)]) = [];                                             %path2的首、尾分别为path1的尾和path3的首，重复，则删除
    path = [path1 path2 path3];
end    