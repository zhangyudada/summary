%旧信关站向中心站反馈位置信息删除消息的响应消息

%参数1是消息类型，参数2是删除结果（成功或失败），参数3是进行位置更新的用户站所属的新信关站ID
function gs2gdb_response(msg_type,delete_result,gs_id)
    %消息类型是'00000011'代表是旧信关站发来的位置信息删除消息的响应消息
    if strcmp(msg_type,'00000011')
        switch gs_id
            case 1
                %中心站向新信关站发送位置更新证实消息，参数1是消息类型，参数2是是否为跨信关站位置更新的标志（'1'代表是，'0'代表否），参数3是位置更新证实消息
                gdb2gs1_response('00000100','1',delete_result);
            case 2
                gdb2gs2_response('00000100','1',delete_result);
            case 3
                gdb2gs3_response('00000100','1',delete_result);
            case 4
                gdb2gs4_response('00000100','1',delete_result);
            case 5
                gdb2gs5_response('00000100','1',delete_result);
            case 6
                gdb2gs6_response('00000100','1',delete_result);
            case 7
                gdb2gs7_response('00000100','1',delete_result);
            case 8
                gdb2gs8_response('00000100','1',delete_result);
            otherwise
        end
    end
end