%信关站处理中心站发过来的位置信息删除消息，删除对应的用户站记录，并返回删除结果到中心站

%参数1是消息类型，参数2是进行位置更新的用户站ID，参数3是进行位置更新的用户站所属的新信关站ID
function gdb2gs8(msg_type,ss_id,gs_id)
    %在函数ss2gs8()中已经声明LMB为全局变量，这里需要使用这个全局变量，则需要再次声明一次
    global LMB8;
    if strcmp(msg_type,'00000010')
        %若LMB8含有需要删除的ss_id，则删除之
        if ismember(ss_id,LMB8)
            index = LMB8(:,6)==ss_id;
            LMB8(index,:) = [];
            %删除成功，返回删除成功消息，参数1是消息类型，参数2是删除结果（成功）
            gs2gdb_response('00000011','00000000',gs_id);
        else
            %删除失败，返回删除失败消息，参数1是消息类型，参数2是删除结果（失败）
            gs2gdb_response('00000011','00000001',gs_id);
        end
    end
end