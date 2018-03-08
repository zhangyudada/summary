%信关站到用户站的任务序列反馈消息

function taskseq_gs2ss(msg_type,ss_id)
    global TASKSEQ_NUM;

    if strcmp(msg_type,'00001000')
       if ss_id ~= 0
           TASKSEQ_NUM = TASKSEQ_NUM+1;
       end
    end
end