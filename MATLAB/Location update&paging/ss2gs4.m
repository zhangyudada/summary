%信关站接收到用户站上报的位置信息
%启动位置更新和规划序列两个线程
%这两个线程用两个大块语句分别实现

%用户站发位置信息给信关站是在MAC层
%信关站缓存用户站位置信息也是在MAC层
%所以仿真中的某一用户站位置信息数组SS_LOCATION实际代表MAC层数据

%参数1是消息类型，参数2是新的用户站信息（1行6列）
function ss2gs4(msg_type,SS_LOCATION_ONE)
    %LMB4声明为全局变量，能够保存变量值并被其他函数调用，用于存储用户站相关信息
    global LMB4;
    
    global T;

    %消息类型是'00000000'代表来自用户站的位置更新消息
    if strcmp(msg_type,'00000000')
        %SS_LOCATION_ONE存放用户站位置信息的矩阵SS_LOCATION的某一行
        %即信关站缓存某一个具体的用户站上报的位置信息

        %这里按顺序依次启动两个线程，实际上两个线程应该是并发执行的
        %即需要考虑如何在MATLAB中实现这两个函数的并发执行

        %信关站启用位置更新线程
    %     %LMB4声明为静态变量，在函数的多次调用中能够保存存储的数据，用于存储用户站相关信息
    %     persistent LMB4;

        %第一次调用ss2gs4()函数时，即第一次有用户站上报位置信息时，LMB是空的
        %则令LMB4 = SS_LOCATION_ONE以记录第一条用户站位置信息
        if isempty(LMB4)
            LMB4 = [SS_LOCATION_ONE,0];
            %把这条新的用户站信息传给中心站，形参1是消息类型，形参2是用户站编号，形参3是用户站所属新信关站编号
            gs2gdb('00000001',SS_LOCATION_ONE(6),SS_LOCATION_ONE(5));
        else
            %判断本地LMB已有的SS_ID中是否含有需要位置更新的这个用户站的SS_ID
            %若本地LMB不含当前用户站，则在本地LMB增加一条记录
            if ~ismember(SS_LOCATION_ONE(6),LMB4(:,6))
                LMB4 = [LMB4;SS_LOCATION_ONE,0];
                %通知中心站，形参1是消息类型，形参2是用户站编号，形参3是信关站编号
                gs2gdb('00000001',SS_LOCATION_ONE(6),SS_LOCATION_ONE(5));
            else
                %若本地LMB含当前用户站，说明是非跨信关站的位置更新，通知ss
                %更新已有用户站的信息，注意index是一个只含一个“1”其余全是“0”的数组
                index = LMB4(:,6)==SS_LOCATION_ONE(6);
                LMB4(index,:) = [SS_LOCATION_ONE,0];
                %通知ss位置更新的结果
                %参数1是消息类型，参数2是是否为跨信关站位置更新的标志（'1'代表是，'0'代表否），参数3是位置更新结果（‘00000000’成功，'00000001'失败）
                gs2ss('00000101','0','00000000');
            end
        end

        %信关站启用任务规划序列线程，将用户站位置信息发送到测控站
        %参数1是消息类型，参数2、3分别是ss_id、gs_id，参数4是更新周期
        taskseq_gs2ttc('00000110',SS_LOCATION_ONE(6),SS_LOCATION_ONE(5),T);
        
    end

end