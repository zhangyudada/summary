%�����Ź�վ�򱻽��û�վ����Ѱ������

%����1����Ϣ���ͣ�����2�������Ź�վID������3�������û�վID������4�Ǳ����û�վID������5�Ǳ����Ź�վID
function lp_gs2ss(msg_type,paging_gs,paging_ss,bepaged_ss,bepaged_gs)

    global lp_delay;
    global lp_up_send_delay;
    %Ѱ��ʱ����Ҫ���ϵ���������·�������û���·����ʱ��
    lp_delay = lp_delay+(2089+2838.9)/(3e2);

    %ȫ�ֱ���SS_PAGE��SS_NUM��2�У���������û�վѰ���ͱ�Ѱ����״̬
    %��1��ΪIS_PAGING��1��������Ѱ����0����δѰ����
    %��2��ΪIS_BEPAGED��1�����Ѿ���ӦѰ����0����δ��Ѱ����
    global SS_PAGE;

    %��Ϣ������'00001101�������Ź�վ�򱻽��û�վ�����Ѱ������
    if strcmp(msg_type,'00001101')
        lp_delay = lp_delay+lp_up_send_delay;
        
        %�������û�վ��û�з���Ѱ��Ҳû�б�Ѱ������˴�Ѱ���ɹ�
        if SS_PAGE(bepaged_ss,1) == 0 && SS_PAGE(bepaged_ss,2) == 0
            SS_PAGE(bepaged_ss,2) = 1;
            switch bepaged_gs
                case 1
                    %�����û�վ�������Ź�վ����Ӧ��Ϣ
                    %����1����Ϣ���ͣ�����2�������Ź�վ������3�������û�վ
                    %����4���û�վ״̬��'0x00'��ʾѰ���ɹ���'0x01'��ʾδ�ҵ������û�վ��'0x02'��ʾ�û�վæ��
                    lp_ss2gs1_response('00001110',paging_gs,paging_ss,'00000000');
                case 2
                    lp_ss2gs2_response('00001110',paging_gs,paging_ss,'00000000');
                case 3
                    lp_ss2gs3_response('00001110',paging_gs,paging_ss,'00000000');
                case 4
                    lp_ss2gs4_response('00001110',paging_gs,paging_ss,'00000000');
                case 5
                    lp_ss2gs5_response('00001110',paging_gs,paging_ss,'00000000');
                case 6
                    lp_ss2gs6_response('00001110',paging_gs,paging_ss,'00000000');
                case 7
                    lp_ss2gs7_response('00001110',paging_gs,paging_ss,'00000000');
                case 8
                    lp_ss2gs8_response('00001110',paging_gs,paging_ss,'00000000');
                otherwise
            end
        %�����û�վæ    
        else
            switch bepaged_gs
                case 1
                    lp_ss2gs1_response('00001110',paging_gs,paging_ss,'00000010');
                case 2
                    lp_ss2gs2_response('00001110',paging_gs,paging_ss,'00000010');
                case 3
                    lp_ss2gs3_response('00001110',paging_gs,paging_ss,'00000010');
                case 4
                    lp_ss2gs4_response('00001110',paging_gs,paging_ss,'00000010');
                case 5
                    lp_ss2gs5_response('00001110',paging_gs,paging_ss,'00000010');
                case 6
                    lp_ss2gs6_response('00001110',paging_gs,paging_ss,'00000010');
                case 7
                    lp_ss2gs7_response('00001110',paging_gs,paging_ss,'00000010');
                case 8
                    lp_ss2gs8_response('00001110',paging_gs,paging_ss,'00000010');
                otherwise
            end
        end
    end
end