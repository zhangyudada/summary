%被叫信关站到主叫信关站的响应消息

%参数1是消息类型，参数2是主叫用户站，参数3是寻呼响应结果（'0x00'表示寻呼成功，'0x01'表示未找到被叫用户站，'0x02'表示用户站忙）
function lp_gs2gs8_response(msg_type,paging_ss,lp_result)

    global lp_down_send_delay;
    global lp_delay;

    %消息类型是'00001111'代表被叫用户站到被叫信关站的响应消息
    if strcmp(msg_type,'00001111')
        
        %寻呼时延需要加上 下行寻呼时延
        lp_delay = lp_delay+lp_down_send_delay;
        
        %主叫信关站到主叫用户站的响应消息
        %参数1是消息类型，参数2是主叫用户站，参数3是寻呼响应结果（'0x00'表示寻呼成功，'0x01'表示未找到被叫用户站，'0x02'表示用户站忙）
        lp_gs2ss_response('00010000',paging_ss,lp_result);
    end
end