%����վ����ѯ���ı����Ź�վID���͸������Ź�վ

%����1����Ϣ���ͣ�����2�������û�վID������3�Ǳ����û�վID������4�Ǳ����Ź�վID��Ϊ0˵�������Ź�վ�����ڣ�
function lp_gdb2gs5_response(msg_type,paging_ss,bepaged_ss,bepaged_gs)
    paging_gs = 5;
    
    global lp_down_send_delay;
    global lp_delay;

    %��Ϣ������'00001011'��������վ�������Ź�վ����Ӧ��Ϣ
    if strcmp(msg_type,'00001011')
        switch bepaged_gs
            %�����Ź�վIDΪ0˵�������û�վ�����ڣ�Ѱ��ʧ�ܣ������Ź�վ֪ͨ�����û�վ
            case 0
                %Ѱ��ʱ����Ҫ���� ����Ѱ��ʱ��
                lp_delay = lp_delay+lp_down_send_delay;
                %����1����Ϣ���ͣ�����2�������û�վ������3��Ѱ����Ӧ�����'0x00'��ʾѰ���ɹ���'0x01'��ʾδ�ҵ������û�վ��'0x02'��ʾ�û�վæ��
                lp_gs2ss_response('00010000',paging_ss,'00000001');
            case 1
                %�����Ź�վ�򱻽��Ź�վ����Ѱ������
                %����1����Ϣ���ͣ�����2�������Ź�վID������3�������û�վID������4�Ǳ����û�վID
                lp_gs2gs1('00001100',paging_gs,paging_ss,bepaged_ss);
            case 2
                lp_gs2gs2('00001100',paging_gs,paging_ss,bepaged_ss);
            case 3
                lp_gs2gs3('00001100',paging_gs,paging_ss,bepaged_ss);
            case 4
                lp_gs2gs4('00001100',paging_gs,paging_ss,bepaged_ss);
            case 5
                lp_gs2gs5('00001100',paging_gs,paging_ss,bepaged_ss);
            case 6
                lp_gs2gs6('00001100',paging_gs,paging_ss,bepaged_ss);
            case 7
                lp_gs2gs7('00001100',paging_gs,paging_ss,bepaged_ss);
            case 8
                lp_gs2gs8('00001100',paging_gs,paging_ss,bepaged_ss);
            otherwise
        end
    end
end