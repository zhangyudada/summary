%���վ���Ź�վ���������з���

%����1����Ϣ���ͣ�����2��3��ss_id��gs_id������4����������
function taskseq_ttc2gs(msg_type,ss_id,gs_id,task_seq)
    global LMB1;
    global LMB2;
    global LMB3;
    global LMB4;
    global LMB5;
    global LMB6;
    global LMB7;
    global LMB8;
    
    %��Ϣ������'00000111'�����ǲ��վ���Ź�վ���������з�����Ϣ
    if strcmp(msg_type,'00000111')
        switch gs_id
            case 1
                %����ӦLMB���ҵ�Ŀ���û�վ������LMB��7�У�������������Ϣ
                %ע��index��һ��ֻ��һ����1������ȫ�ǡ�0��������
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
        
        %�Ź�վ���������з��͸��û�վ
        taskseq_gs2ss('00001000',ss_id);
        
    end
    
end