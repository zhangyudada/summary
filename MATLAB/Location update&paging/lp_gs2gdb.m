%�����Ź�վ֪ͨ����վ��ѯ�����Ź�վ

%����1����Ϣ���ͣ�����2�������Ź�վID������3�������û�վID������4�Ǳ����û�վID
function lp_gs2gdb(msg_type,paging_gs,paging_ss,bepaged_ss)
    global GDB;
    
    %��Ϣ������'00001010'�����������Ź�վ������վ��Ѱ������
    if strcmp(msg_type,'00001010')
        %�������û�վȷʵ��GDB���м�¼������Բ�ѯ�������Ź�վ
        if ismember(bepaged_ss,GDB(:,1))
            index = GDB(:,1)==bepaged_ss;
            bepaged_gs = GDB(index,2);
            switch paging_gs
                case 1
                    %����վ����ѯ���ı����Ź�վID���͸������Ź�վ
                    %����1����Ϣ���ͣ�����2�������û�վID������3�Ǳ����û�վID������4�Ǳ����Ź�վID
                    lp_gdb2gs1_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 2
                    lp_gdb2gs2_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 3
                    lp_gdb2gs3_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 4
                    lp_gdb2gs4_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 5
                    lp_gdb2gs5_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 6
                    lp_gdb2gs6_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 7
                    lp_gdb2gs7_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                case 8
                    lp_gdb2gs8_response('00001011',paging_ss,bepaged_ss,bepaged_gs);
                otherwise
            end
        %�������û�վ��GDB��û�м�¼����Ѱ˵�������û�վ�����ڣ�Ѱ��ʧ��
        else
            switch paging_gs
                case 1
                    %����1����Ϣ���ͣ�����2�������û�վID������3�Ǳ����û�վID������4�Ǳ����Ź�վID��Ϊ0˵�������û�վ�����ڣ�
                    lp_gdb2gs1_response('00001011',paging_ss,bepaged_ss,0);
                case 2
                    lp_gdb2gs2_response('00001011',paging_ss,bepaged_ss,0);
                case 3
                    lp_gdb2gs3_response('00001011',paging_ss,bepaged_ss,0);
                case 4
                    lp_gdb2gs4_response('00001011',paging_ss,bepaged_ss,0);
                case 5
                    lp_gdb2gs5_response('00001011',paging_ss,bepaged_ss,0);
                case 6
                    lp_gdb2gs6_response('00001011',paging_ss,bepaged_ss,0);
                case 7
                    lp_gdb2gs7_response('00001011',paging_ss,bepaged_ss,0);
                case 8
                    lp_gdb2gs8_response('00001011',paging_ss,bepaged_ss,0);
                otherwise
            end
            
        end
    end
end


% %����1����Ϣ���ͣ�����2�������Ź�վID������3�������û�վID������4�Ǳ����û�վID
% function lp_gs2gdb(msg_type,paging_gs,paging_ss,bepaged_ss)
%     global GDB;
%     
%     %��Ϣ������'00001010'�������û�վ���Ź�վ��Ѱ������
%     if strcmp(msg_type,'00001010')
%        index = GDB(:,1)==bepaged_ss;
%        bepaged_gs = GDB(index,2);
%        %����վ����ѯ���ı����Ź�վID���͸������Ź�վ
%        %����1����Ϣ���ͣ�����2�������Ź�վID������3�������û�վID������4�Ǳ����Ź�վID������5�Ǳ����û�վID
%        lp_gdb2gs_response('00001011',paging_gs,paging_ss,bepaged_gs,bepaged_ss);
%     end
% end