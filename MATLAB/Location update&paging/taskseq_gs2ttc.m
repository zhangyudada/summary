%任务序列线程，信关站到测控站的消息

%参数1是消息类型，参数2、3分别是ss_id、gs_id，参数4是更新周期
function taskseq_gs2ttc(msg_type,ss_id,gs_id,period)
    %消息类型是'00000110'代表是信关站发来的任务序列请求消息
    if strcmp(msg_type,'00000110')
        %测控站将反馈消息发送给信关站
        %参数1是消息类型，参数2、3是ss_id、gs_id，参数4是任务序列
        taskseq_ttc2gs('00000111',ss_id,gs_id,2*period);
    end

end