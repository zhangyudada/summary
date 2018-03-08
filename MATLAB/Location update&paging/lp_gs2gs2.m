%主叫信关站向被叫信关站发送寻呼请求

%参数1是消息类型，参数2是主叫信关站ID，参数3是主叫用户站ID，参数4是被叫用户站ID
function lp_gs2gs2(msg_type,paging_gs,paging_ss,bepaged_ss)  
    global LMB2;
    
    %消息类型是'00001100代表中心站到主叫信关站的响应消息
    if strcmp(msg_type,'00001100')
        %若被叫用户站确实在本地LMB中有记录，则向被叫用户站发起寻呼请求
        if ismember(bepaged_ss,LMB2(:,6))
            %被叫信关站向被叫用户站发起寻呼请求
            %参数1是消息类型，参数2是主叫信关站ID，参数3是主叫用户站ID，参数4是被叫用户站ID，参数5是被叫信关站ID
            lp_gs2ss('00001101',paging_gs,paging_ss,bepaged_ss,2);
        
        %被叫用户站不在被叫信关站LMB中，即未找到被叫用户站，则被叫信关站通知主叫信关站
        else
            switch paging_gs
                case 1
                    %参数1是消息类型，参数2是主叫用户站，参数3是寻呼响应结果（'0x00'表示寻呼成功，'0x01'表示未找到被叫用户站，'0x02'表示用户站忙）
                    lp_gs2gs1_response('00001111',paging_ss,'00000001');
                case 2
                    lp_gs2gs2_response('00001111',paging_ss,'00000001');
                case 3
                    lp_gs2gs3_response('00001111',paging_ss,'00000001');
                case 4
                    lp_gs2gs4_response('00001111',paging_ss,'00000001');
                case 5
                    lp_gs2gs5_response('00001111',paging_ss,'00000001');
                case 6
                    lp_gs2gs6_response('00001111',paging_ss,'00000001');
                case 7
                    lp_gs2gs7_response('00001111',paging_ss,'00000001');
                case 8
                    lp_gs2gs8_response('00001111',paging_ss,'00000001');
                otherwise
            end
        end
        
    end
end