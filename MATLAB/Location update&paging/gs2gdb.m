%�����û�վ�ϱ�������վGDB�����ݣ���������GDB����֪ͨ��LMBɾ����Ӧ�û�վ��λ����Ϣ

%����1����Ϣ���ͣ�����2���û�վ��ţ�����3���û�վ�������Ź�վ���
function gs2gdb(msg_type,ss_id,gs_id)
%     %GDB����Ϊ��̬�������ں����Ķ�ε������ܹ�����洢�����ݣ����ڴ洢�û�վ�������Ź�վ�������Ϣ
%     persistent GDB;

    %GDB����Ϊȫ�ֱ������ܹ��������ֵ���������������ã����ڴ洢�û�վ�������Ź�վ�������Ϣ
    global GDB;
    if strcmp(msg_type,'00000001')
        if isempty(GDB)
            GDB = [ss_id,gs_id];
            %λ�ø��³ɹ���֪ͨ�Ź�վ
            switch gs_id
                case 1
                    %����վ�����Ź�վ����λ�ø���֤ʵ��Ϣ������1����Ϣ���ͣ�����2���Ƿ�Ϊ���Ź�վλ�ø��µı�־��'1'�����ǣ�'0'����񣩣�����3��λ�ø���֤ʵ��Ϣ
                    gdb2gs1_response('00000100','0','00000000');
                case 2
                    gdb2gs2_response('00000100','0','00000000');
                case 3
                    gdb2gs3_response('00000100','0','00000000');
                case 4
                    gdb2gs4_response('00000100','0','00000000');
                case 5
                    gdb2gs5_response('00000100','0','00000000');
                case 6
                    gdb2gs6_response('00000100','0','00000000');
                case 7
                    gdb2gs7_response('00000100','0','00000000');
                case 8
                    gdb2gs8_response('00000100','0','00000000');
                otherwise
            end
            
        else
            %GDB�в�����ǰ�û�վ
            if ~ismember(ss_id,GDB(:,1));
                GDB = [GDB;ss_id,gs_id];
                %λ�ø��³ɹ���֪ͨ�Ź�վ
                switch gs_id
                    case 1
                        %����վ�����Ź�վ����λ�ø���֤ʵ��Ϣ������1����Ϣ���ͣ�����2���Ƿ�Ϊ���Ź�վλ�ø��µı�־��'1'�����ǣ�'0'����񣩣�����3��λ�ø���֤ʵ��Ϣ
                        gdb2gs1_response('00000100','0','00000000');
                    case 2
                        gdb2gs2_response('00000100','0','00000000');
                    case 3
                        gdb2gs3_response('00000100','0','00000000');
                    case 4
                        gdb2gs4_response('00000100','0','00000000');
                    case 5
                        gdb2gs5_response('00000100','0','00000000');
                    case 6
                        gdb2gs6_response('00000100','0','00000000');
                    case 7
                        gdb2gs7_response('00000100','0','00000000');
                    case 8
                        gdb2gs8_response('00000100','0','00000000');
                    otherwise
                end
                
            %GDB�к���ǰ�û�վ���������û�վ�����Ź�վ�л������
            %��Ҫ֪ͨԭ�Ź�վLMBɾ����Ӧ���û�վ��Ϣ��������GDB
            else
                %��GDB���ҵ�ss_id������
                index = GDB(:,1)==ss_id;
                %�õ�ss_idԭ�����Ź�վ���old_gs_id
                old_gs_id = GDB(index,2);
                %����GDB��ss_id�����Ź�վ���Ϊ�µ�gs_id
                GDB(index,2) = gs_id;
                %����old_gs_idѡ��֪ͨ��Ӧ���Ź�վɾ��ss_id������
                switch old_gs_id
                    case 1
                        gdb2gs1('00000010',ss_id,gs_id);
                    case 2
                        gdb2gs2('00000010',ss_id,gs_id);
                    case 3
                        gdb2gs3('00000010',ss_id,gs_id);
                    case 4
                        gdb2gs4('00000010',ss_id,gs_id);
                    case 5
                        gdb2gs5('00000010',ss_id,gs_id);
                    case 6
                        gdb2gs6('00000010',ss_id,gs_id);
                    case 7
                        gdb2gs7('00000010',ss_id,gs_id);
                    case 8
                        gdb2gs8('00000010',ss_id,gs_id);
                    otherwise
                end
            end
        end
    end
    
end