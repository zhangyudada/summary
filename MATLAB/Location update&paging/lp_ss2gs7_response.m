%�����û�վ�������Ź�վ����Ӧ��Ϣ

%����1����Ϣ���ͣ�����2�������Ź�վ������3�������û�վ
%����4���û�վ״̬��'0x00'��ʾѰ���ɹ���'0x01'��ʾδ�ҵ������û�վ��'0x02'��ʾ�û�վæ��
function lp_ss2gs7_response(msg_type,paging_gs,paging_ss,ss_state)

    global lp_delay;
    %Ѱ��ʱ����Ҫ���ϵ���������·�������û���·����ʱ��
    lp_delay = lp_delay+(2089+2838.9)/(3e2);

    %��Ϣ������'00001110'�������û�վ�������Ź�վ����Ӧ��Ϣ
    if strcmp(msg_type,'00001110')
        switch paging_gs
            case 1
                %�����Ź�վ�������Ź�վ����Ӧ��Ϣ
                %����1����Ϣ���ͣ�����2�������û�վ������3��Ѱ����Ӧ�����'0x00'��ʾѰ���ɹ���'0x01'��ʾδ�ҵ������û�վ��'0x02'��ʾ�û�վæ��
                lp_gs2gs1_response('00001111',paging_ss,ss_state);
            case 2
                lp_gs2gs2_response('00001111',paging_ss,ss_state);
            case 3
                lp_gs2gs3_response('00001111',paging_ss,ss_state);
            case 4
                lp_gs2gs4_response('00001111',paging_ss,ss_state);
            case 5
                lp_gs2gs5_response('00001111',paging_ss,ss_state);
            case 6
                lp_gs2gs6_response('00001111',paging_ss,ss_state);
            case 7
                lp_gs2gs7_response('00001111',paging_ss,ss_state);
            case 8
                lp_gs2gs8_response('00001111',paging_ss,ss_state);
            otherwise
        end
    end
end