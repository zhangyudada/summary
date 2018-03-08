%位置更新证实消息，用于GDB通知新LMB：旧LMB删除相关用户站位置信息成功与否（lu_result）

%参数1是消息类型，参数2是是否为跨信关站位置更新的标志（'1'代表是，'0'代表否），参数3是位置更新结果信息
function gdb2gs6_response(msg_type,is_cross_gs,lu_result)
    %消息类型是'00000100'代表是中心站发来的位置更新证实消息
    if strcmp(msg_type,'00000100')
        %新信关站通知用户站位置更新确认消息
        %参数1是消息类型，参数2是是否为跨信关站位置更新的标志（'1'代表是，'0'代表否），参数3是位置更新结果
        gs2ss('00000101',is_cross_gs,lu_result);
    end
end