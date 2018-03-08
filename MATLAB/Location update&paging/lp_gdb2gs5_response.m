%中心站将查询到的被叫信关站ID发送给主叫信关站

%参数1是消息类型，参数2是主叫用户站ID，参数3是被叫用户站ID，参数4是被叫信关站ID（为0说明被叫信关站不存在）
function lp_gdb2gs5_response(msg_type,paging_ss,bepaged_ss,bepaged_gs)
    paging_gs = 5;
    
    global lp_down_send_delay;
    global lp_delay;

    %消息类型是'00001011'代表中心站到主叫信关站的响应消息
    if strcmp(msg_type,'00001011')
        switch bepaged_gs
            %被叫信关站ID为0说明被叫用户站不存在，寻呼失败，主叫信关站通知主叫用户站
            case 0
                %寻呼时延需要加上 下行寻呼时延
                lp_delay = lp_delay+lp_down_send_delay;
                %参数1是消息类型，参数2是主叫用户站，参数3是寻呼响应结果（'0x00'表示寻呼成功，'0x01'表示未找到被叫用户站，'0x02'表示用户站忙）
                lp_gs2ss_response('00010000',paging_ss,'00000001');
            case 1
                %主叫信关站向被叫信关站发送寻呼请求
                %参数1是消息类型，参数2是主叫信关站ID，参数3是主叫用户站ID，参数4是被叫用户站ID
                lp_gs2gs1('00001100',paging_gs,paging_ss,bepaged_ss);
            case 2
                lp_gs2gs2('00001100',paging_gs,paging_ss,bepaged_ss);
            case 3
                lp_gs2gs3('00001100',paging_gs,paging_ss,bepaged_ss);
            case 4
                lp_gs2gs4('00001100',paging_gs,paging_ss,bepaged_ss);
            case 5
                lp_gs2gs5('00001100',paging_gs,paging_ss,bepaged_ss);
            case 6
                lp_gs2gs6('00001100',paging_gs,paging_ss,bepaged_ss);
            case 7
                lp_gs2gs7('00001100',paging_gs,paging_ss,bepaged_ss);
            case 8
                lp_gs2gs8('00001100',paging_gs,paging_ss,bepaged_ss);
            otherwise
        end
    end
end