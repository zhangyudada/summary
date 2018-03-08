%处理用户站上报给中心站GDB的数据，更新中心GDB，并通知就LMB删除相应用户站的位置信息

%参数1是消息类型，参数2是用户站编号，参数3是用户站所属新信关站编号
function gs2gdb(msg_type,ss_id,gs_id)
%     %GDB声明为静态变量，在函数的多次调用中能够保存存储的数据，用于存储用户站和所属信关站的相关信息
%     persistent GDB;

    %GDB声明为全局变量，能够保存变量值并被其他函数调用，用于存储用户站和所属信关站的相关信息
    global GDB;
    if strcmp(msg_type,'00000001')
        if isempty(GDB)
            GDB = [ss_id,gs_id];
            %位置更新成功，通知信关站
            switch gs_id
                case 1
                    %中心站向新信关站发送位置更新证实消息，参数1是消息类型，参数2是是否为跨信关站位置更新的标志（'1'代表是，'0'代表否），参数3是位置更新证实消息
                    gdb2gs1_response('00000100','0','00000000');
                case 2
                    gdb2gs2_response('00000100','0','00000000');
                case 3
                    gdb2gs3_response('00000100','0','00000000');
                case 4
                    gdb2gs4_response('00000100','0','00000000');
                case 5
                    gdb2gs5_response('00000100','0','00000000');
                case 6
                    gdb2gs6_response('00000100','0','00000000');
                case 7
                    gdb2gs7_response('00000100','0','00000000');
                case 8
                    gdb2gs8_response('00000100','0','00000000');
                otherwise
            end
            
        else
            %GDB中不含当前用户站
            if ~ismember(ss_id,GDB(:,1));
                GDB = [GDB;ss_id,gs_id];
                %位置更新成功，通知信关站
                switch gs_id
                    case 1
                        %中心站向新信关站发送位置更新证实消息，参数1是消息类型，参数2是是否为跨信关站位置更新的标志（'1'代表是，'0'代表否），参数3是位置更新证实消息
                        gdb2gs1_response('00000100','0','00000000');
                    case 2
                        gdb2gs2_response('00000100','0','00000000');
                    case 3
                        gdb2gs3_response('00000100','0','00000000');
                    case 4
                        gdb2gs4_response('00000100','0','00000000');
                    case 5
                        gdb2gs5_response('00000100','0','00000000');
                    case 6
                        gdb2gs6_response('00000100','0','00000000');
                    case 7
                        gdb2gs7_response('00000100','0','00000000');
                    case 8
                        gdb2gs8_response('00000100','0','00000000');
                    otherwise
                end
                
            %GDB中含当前用户站，这属于用户站发生信关站切换的情况
            %需要通知原信关站LMB删除相应的用户站信息，并更新GDB
            else
                %在GDB中找到ss_id所在行
                index = GDB(:,1)==ss_id;
                %得到ss_id原所属信关站编号old_gs_id
                old_gs_id = GDB(index,2);
                %更新GDB中ss_id所属信关站编号为新的gs_id
                GDB(index,2) = gs_id;
                %根据old_gs_id选择通知相应的信关站删除ss_id所在行
                switch old_gs_id
                    case 1
                        gdb2gs1('00000010',ss_id,gs_id);
                    case 2
                        gdb2gs2('00000010',ss_id,gs_id);
                    case 3
                        gdb2gs3('00000010',ss_id,gs_id);
                    case 4
                        gdb2gs4('00000010',ss_id,gs_id);
                    case 5
                        gdb2gs5('00000010',ss_id,gs_id);
                    case 6
                        gdb2gs6('00000010',ss_id,gs_id);
                    case 7
                        gdb2gs7('00000010',ss_id,gs_id);
                    case 8
                        gdb2gs8('00000010',ss_id,gs_id);
                    otherwise
                end
            end
        end
    end
    
end