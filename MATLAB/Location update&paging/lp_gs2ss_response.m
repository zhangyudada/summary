%�����Ź�վ�������û�վ����Ӧ��Ϣ

%����1����Ϣ���ͣ�����2�������û�վ������3��Ѱ����Ӧ�����'0x00'��ʾѰ���ɹ���'0x01'��ʾδ�ҵ������û�վ��'0x02'��ʾ�û�վæ�� 
function lp_gs2ss_response(msg_type,paging_ss,lp_result)

    global LP_SUCCESS_NUM;
    
    global lp_delay;
    %Ѱ��ʱ����Ҫ���ϵ���������·�������û���·����ʱ��
    lp_delay = lp_delay+(2089+2838.9)/(3e2);
    
    %��Ϣ������'00010000'���������Ź�վ�������û�վ����Ӧ��Ϣ
    if strcmp(msg_type,'00010000')
        %Ѱ��ʧ����Ҫ��Ѱ���ɹ�����1
        if strcmp(lp_result,'00000001') || strcmp(lp_result,'00000010')
            LP_SUCCESS_NUM = LP_SUCCESS_NUM-1;
        end
    end
end