%�����Ź�վ�򱻽��Ź�վ����Ѱ������

%����1����Ϣ���ͣ�����2�������Ź�վID������3�������û�վID������4�Ǳ����û�վID
function lp_gs2gs2(msg_type,paging_gs,paging_ss,bepaged_ss)  
    global LMB2;
    
    %��Ϣ������'00001100��������վ�������Ź�վ����Ӧ��Ϣ
    if strcmp(msg_type,'00001100')
        %�������û�վȷʵ�ڱ���LMB���м�¼�����򱻽��û�վ����Ѱ������
        if ismember(bepaged_ss,LMB2(:,6))
            %�����Ź�վ�򱻽��û�վ����Ѱ������
            %����1����Ϣ���ͣ�����2�������Ź�վID������3�������û�վID������4�Ǳ����û�վID������5�Ǳ����Ź�վID
            lp_gs2ss('00001101',paging_gs,paging_ss,bepaged_ss,2);
        
        %�����û�վ���ڱ����Ź�վLMB�У���δ�ҵ������û�վ���򱻽��Ź�վ֪ͨ�����Ź�վ
        else
            switch paging_gs
                case 1
                    %����1����Ϣ���ͣ�����2�������û�վ������3��Ѱ����Ӧ�����'0x00'��ʾѰ���ɹ���'0x01'��ʾδ�ҵ������û�վ��'0x02'��ʾ�û�վæ��
                    lp_gs2gs1_response('00001111',paging_ss,'00000001');
                case 2
                    lp_gs2gs2_response('00001111',paging_ss,'00000001');
                case 3
                    lp_gs2gs3_response('00001111',paging_ss,'00000001');
                case 4
                    lp_gs2gs4_response('00001111',paging_ss,'00000001');
                case 5
                    lp_gs2gs5_response('00001111',paging_ss,'00000001');
                case 6
                    lp_gs2gs6_response('00001111',paging_ss,'00000001');
                case 7
                    lp_gs2gs7_response('00001111',paging_ss,'00000001');
                case 8
                    lp_gs2gs8_response('00001111',paging_ss,'00000001');
                otherwise
            end
        end
        
    end
end