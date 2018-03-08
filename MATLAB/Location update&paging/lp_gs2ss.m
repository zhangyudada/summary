%被叫信关站向被叫用户站发起寻呼请求

%参数1是消息类型，参数2是主叫信关站ID，参数3是主叫用户站ID，参数4是被叫用户站ID，参数5是被叫信关站ID
function lp_gs2ss(msg_type,paging_gs,paging_ss,bepaged_ss,bepaged_gs)

    global lp_delay;
    global lp_up_send_delay;
    %寻呼时延需要加上单次馈电链路、单次用户链路传播时延
    lp_delay = lp_delay+(2089+2838.9)/(3e2);

    %全局变量SS_PAGE有SS_NUM行2列，存放所有用户站寻呼和被寻呼的状态
    %第1列为IS_PAGING（1代表正在寻呼，0代表未寻呼）
    %第2列为IS_BEPAGED（1代表已经响应寻呼，0代表未被寻呼）
    global SS_PAGE;

    %消息类型是'00001101代表被叫信关站向被叫用户站发起的寻呼请求
    if strcmp(msg_type,'00001101')
        lp_delay = lp_delay+lp_up_send_delay;
        
        %若被叫用户站既没有发起寻呼也没有被寻呼，则此次寻呼成功
        if SS_PAGE(bepaged_ss,1) == 0 && SS_PAGE(bepaged_ss,2) == 0
            SS_PAGE(bepaged_ss,2) = 1;
            switch bepaged_gs
                case 1
                    %被叫用户站到被叫信关站的响应消息
                    %参数1是消息类型，参数2是主叫信关站，参数3是主叫用户站
                    %参数4是用户站状态（'0x00'表示寻呼成功，'0x01'表示未找到被叫用户站，'0x02'表示用户站忙）
                    lp_ss2gs1_response('00001110',paging_gs,paging_ss,'00000000');
                case 2
                    lp_ss2gs2_response('00001110',paging_gs,paging_ss,'00000000');
                case 3
                    lp_ss2gs3_response('00001110',paging_gs,paging_ss,'00000000');
                case 4
                    lp_ss2gs4_response('00001110',paging_gs,paging_ss,'00000000');
                case 5
                    lp_ss2gs5_response('00001110',paging_gs,paging_ss,'00000000');
                case 6
                    lp_ss2gs6_response('00001110',paging_gs,paging_ss,'00000000');
                case 7
                    lp_ss2gs7_response('00001110',paging_gs,paging_ss,'00000000');
                case 8
                    lp_ss2gs8_response('00001110',paging_gs,paging_ss,'00000000');
                otherwise
            end
        %被叫用户站忙    
        else
            switch bepaged_gs
                case 1
                    lp_ss2gs1_response('00001110',paging_gs,paging_ss,'00000010');
                case 2
                    lp_ss2gs2_response('00001110',paging_gs,paging_ss,'00000010');
                case 3
                    lp_ss2gs3_response('00001110',paging_gs,paging_ss,'00000010');
                case 4
                    lp_ss2gs4_response('00001110',paging_gs,paging_ss,'00000010');
                case 5
                    lp_ss2gs5_response('00001110',paging_gs,paging_ss,'00000010');
                case 6
                    lp_ss2gs6_response('00001110',paging_gs,paging_ss,'00000010');
                case 7
                    lp_ss2gs7_response('00001110',paging_gs,paging_ss,'00000010');
                case 8
                    lp_ss2gs8_response('00001110',paging_gs,paging_ss,'00000010');
                otherwise
            end
        end
    end
end