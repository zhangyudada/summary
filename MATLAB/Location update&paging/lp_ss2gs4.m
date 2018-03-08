%主叫用户站到信关站的始呼消息

%参数1是消息类型，参数2是主叫用户站ID，参数3是被叫用户站ID
function lp_ss2gs4(msg_type,paging_ss,bepaged_ss)
    paging_gs = 4;
    
    global lp_down_send_delay;
    global lp_delay;
    %寻呼时延需要加上单次馈电链路、单次用户链路传播时延
    lp_delay = lp_delay+(2089+2838.9)/(3e2);
    
    %LMB1声明为全局变量，能够保存变量值并被其他函数调用，用于存储用户站相关信息
    global LMB4;

    %消息类型是'00000101'代表是用户站到信关站的寻呼请求
    if strcmp(msg_type,'00001001')
        %若被叫用户站不在本信关站范围内，则通知中心站查询被叫用户站所在信关站
        if ~ismember(bepaged_ss,LMB4(:,6))
            %通知中心站查询被叫用户站所在信关站
            %参数1是消息类型，参数2是主叫信关站ID，参数3是主叫用户站ID，参数4是被叫用户站ID
            lp_gs2gdb('00001010',paging_gs,paging_ss,bepaged_ss);
            
        %若被叫用户站在本信关站范围内，则直接呼叫被叫用户站
        else
            %寻呼时延需要加上 下行寻呼时延
            lp_delay = lp_delay+lp_down_send_delay;
            
            %参数1是消息类型，参数2是主叫信关站ID，参数3是主叫用户站ID，参数4是被叫用户站ID，参数5是被叫信关站ID
            lp_gs2ss('00001101',paging_gs,paging_ss,bepaged_ss,paging_gs);
        end
    end
            
end