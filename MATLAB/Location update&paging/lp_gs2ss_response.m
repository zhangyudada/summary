%主叫信关站到主叫用户站的响应消息

%参数1是消息类型，参数2是主叫用户站，参数3是寻呼响应结果（'0x00'表示寻呼成功，'0x01'表示未找到被叫用户站，'0x02'表示用户站忙） 
function lp_gs2ss_response(msg_type,paging_ss,lp_result)

    global LP_SUCCESS_NUM;
    
    global lp_delay;
    %寻呼时延需要加上单次馈电链路、单次用户链路传播时延
    lp_delay = lp_delay+(2089+2838.9)/(3e2);
    
    %消息类型是'00010000'代表主叫信关站到主叫用户站的响应消息
    if strcmp(msg_type,'00010000')
        %寻呼失败则要将寻呼成功数减1
        if strcmp(lp_result,'00000001') || strcmp(lp_result,'00000010')
            LP_SUCCESS_NUM = LP_SUCCESS_NUM-1;
        end
    end
end