%主叫信关站通知中心站查询被叫信关站

%参数1是消息类型，参数2是主叫信关站ID，参数3是主叫用户站ID，参数4是被叫用户站ID
function lp_gs2gdb(msg_type,paging_gs,paging_ss,bepaged_ss)
    global GDB;
    
    %消息类型是'00001010'代表是主叫信关站到中心站的寻呼请求
    if strcmp(msg_type,'00001010')
        %若被叫用户站确实在GDB中有记录，则可以查询到被叫信关站
        if ismember(bepaged_ss,GDB(:,1))
            index = GDB(:,1)==bepaged_ss;
            bepaged_gs = GDB(index,2);
            switch paging_gs
                case 1
                    %中心站将查询到的被叫信关站ID发送给主叫信关站
                    %参数1是消息类型，参数2是主叫用户站ID，参数3是被叫用户站ID，参数4是被叫信关站ID
                    lp_gdb2gs1_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 2
                    lp_gdb2gs2_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 3
                    lp_gdb2gs3_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 4
                    lp_gdb2gs4_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 5
                    lp_gdb2gs5_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 6
                    lp_gdb2gs6_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 7
                    lp_gdb2gs7_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 8
                    lp_gdb2gs8_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                otherwise
            end
        %若被叫用户站在GDB中没有记录，则寻说明被叫用户站不存在，寻呼失败
        else
            switch paging_gs
                case 1
                    %参数1是消息类型，参数2是主叫用户站ID，参数3是被叫用户站ID，参数4是被叫信关站ID（为0说明被叫用户站不存在）
                    lp_gdb2gs1_response('00001011',paging_ss,bepaged_ss,0);
                case 2
                    lp_gdb2gs2_response('00001011',paging_ss,bepaged_ss,0);
                case 3
                    lp_gdb2gs3_response('00001011',paging_ss,bepaged_ss,0);
                case 4
                    lp_gdb2gs4_response('00001011',paging_ss,bepaged_ss,0);
                case 5
                    lp_gdb2gs5_response('00001011',paging_ss,bepaged_ss,0);
                case 6
                    lp_gdb2gs6_response('00001011',paging_ss,bepaged_ss,0);
                case 7
                    lp_gdb2gs7_response('00001011',paging_ss,bepaged_ss,0);
                case 8
                    lp_gdb2gs8_response('00001011',paging_ss,bepaged_ss,0);
                otherwise
            end
            
        end
    end
end


% %参数1是消息类型，参数2是主叫信关站ID，参数3是主叫用户站ID，参数4是被叫用户站ID
% function lp_gs2gdb(msg_type,paging_gs,paging_ss,bepaged_ss)
%     global GDB;
%     
%     %消息类型是'00001010'代表是用户站到信关站的寻呼请求
%     if strcmp(msg_type,'00001010')
%        index = GDB(:,1)==bepaged_ss;
%        bepaged_gs = GDB(index,2);
%        %中心站将查询到的被叫信关站ID发送给主叫信关站
%        %参数1是消息类型，参数2是主叫信关站ID，参数3是主叫用户站ID，参数4是被叫信关站ID，参数5是被叫用户站ID
%        lp_gdb2gs_response('00001011',paging_gs,paging_ss,bepaged_gs,bepaged_ss);
%     end
% end