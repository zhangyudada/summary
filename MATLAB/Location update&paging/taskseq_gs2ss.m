%�Ź�վ���û�վ���������з�����Ϣ

function taskseq_gs2ss(msg_type,ss_id)
    global TASKSEQ_NUM;

    if strcmp(msg_type,'00001000')
       if ss_id ~= 0
           TASKSEQ_NUM = TASKSEQ_NUM+1;
       end
    end
end