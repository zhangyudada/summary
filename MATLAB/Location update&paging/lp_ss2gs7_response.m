%被叫用户站到被叫信关站的响应消息

%参数1是消息类型，参数2是主叫信关站，参数3是主叫用户站
%参数4是用户站状态（'0x00'表示寻呼成功，'0x01'表示未找到被叫用户站，'0x02'表示用户站忙）
function lp_ss2gs7_response(msg_type,paging_gs,paging_ss,ss_state)

    global lp_delay;
    %寻呼时延需要加上单次馈电链路、单次用户链路传播时延
    lp_delay = lp_delay+(2089+2838.9)/(3e2);

    %消息类型是'00001110'代表被叫用户站到被叫信关站的响应消息
    if strcmp(msg_type,'00001110')
        switch paging_gs
            case 1
                %被叫信关站到主叫信关站的响应消息
                %参数1是消息类型，参数2是主叫用户站，参数3是寻呼响应结果（'0x00'表示寻呼成功，'0x01'表示未找到被叫用户站，'0x02'表示用户站忙）
                lp_gs2gs1_response('00001111',paging_ss,ss_state);
            case 2
                lp_gs2gs2_response('00001111',paging_ss,ss_state);
            case 3
                lp_gs2gs3_response('00001111',paging_ss,ss_state);
            case 4
                lp_gs2gs4_response('00001111',paging_ss,ss_state);
            case 5
                lp_gs2gs5_response('00001111',paging_ss,ss_state);
            case 6
                lp_gs2gs6_response('00001111',paging_ss,ss_state);
            case 7
                lp_gs2gs7_response('00001111',paging_ss,ss_state);
            case 8
                lp_gs2gs8_response('00001111',paging_ss,ss_state);
            otherwise
        end
    end
end