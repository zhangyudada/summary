%测控站到信关站的任务序列反馈

%参数1是消息类型，参数2、3是ss_id、gs_id，参数4是任务序列
function taskseq_ttc2gs(msg_type,ss_id,gs_id,task_seq)
    global LMB1;
    global LMB2;
    global LMB3;
    global LMB4;
    global LMB5;
    global LMB6;
    global LMB7;
    global LMB8;
    
    %消息类型是'00000111'代表是测控站到信关站的任务序列反馈消息
    if strcmp(msg_type,'00000111')
        switch gs_id
            case 1
                %在相应LMB中找到目标用户站，更新LMB第7列，即任务序列信息
                %注意index是一个只含一个“1”其余全是“0”的数组
                index = LMB1(:,6)==ss_id;
                LMB1(index,7) = task_seq;
            case 2
                index = LMB2(:,6)==ss_id;
                LMB2(index,7) = task_seq;
            case 3
                index = LMB3(:,6)==ss_id;
                LMB3(index,7) = task_seq;
            case 4
                index = LMB4(:,6)==ss_id;
                LMB4(index,7) = task_seq;
            case 5
                index = LMB5(:,6)==ss_id;
                LMB5(index,7) = task_seq;
            case 6
                index = LMB6(:,6)==ss_id;
                LMB6(index,7) = task_seq;
            case 7
                index = LMB7(:,6)==ss_id;
                LMB7(index,7) = task_seq;
            case 8
                index = LMB8(:,6)==ss_id;
                LMB8(index,7) = task_seq;
            otherwise
        end
        
        %信关站将任务序列发送给用户站
        taskseq_gs2ss('00001000',ss_id);
        
    end
    
end