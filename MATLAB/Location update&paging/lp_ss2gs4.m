%�����û�վ���Ź�վ��ʼ����Ϣ

%����1����Ϣ���ͣ�����2�������û�վID������3�Ǳ����û�վID
function lp_ss2gs4(msg_type,paging_ss,bepaged_ss)
    paging_gs = 4;
    
    global lp_down_send_delay;
    global lp_delay;
    %Ѱ��ʱ����Ҫ���ϵ���������·�������û���·����ʱ��
    lp_delay = lp_delay+(2089+2838.9)/(3e2);
    
    %LMB1����Ϊȫ�ֱ������ܹ��������ֵ���������������ã����ڴ洢�û�վ�����Ϣ
    global LMB4;

    %��Ϣ������'00000101'�������û�վ���Ź�վ��Ѱ������
    if strcmp(msg_type,'00001001')
        %�������û�վ���ڱ��Ź�վ��Χ�ڣ���֪ͨ����վ��ѯ�����û�վ�����Ź�վ
        if ~ismember(bepaged_ss,LMB4(:,6))
            %֪ͨ����վ��ѯ�����û�վ�����Ź�վ
            %����1����Ϣ���ͣ�����2�������Ź�վID������3�������û�վID������4�Ǳ����û�վID
            lp_gs2gdb('00001010',paging_gs,paging_ss,bepaged_ss);
            
        %�������û�վ�ڱ��Ź�վ��Χ�ڣ���ֱ�Ӻ��б����û�վ
        else
            %Ѱ��ʱ����Ҫ���� ����Ѱ��ʱ��
            lp_delay = lp_delay+lp_down_send_delay;
            
            %����1����Ϣ���ͣ�����2�������Ź�վID������3�������û�վID������4�Ǳ����û�վID������5�Ǳ����Ź�վID
            lp_gs2ss('00001101',paging_gs,paging_ss,bepaged_ss,paging_gs);
        end
    end
            
end