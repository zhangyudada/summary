%���Ź�վ������վ����λ����Ϣɾ����Ϣ����Ӧ��Ϣ

%����1����Ϣ���ͣ�����2��ɾ��������ɹ���ʧ�ܣ�������3�ǽ���λ�ø��µ��û�վ���������Ź�վID
function gs2gdb_response(msg_type,delete_result,gs_id)
    %��Ϣ������'00000011'�����Ǿ��Ź�վ������λ����Ϣɾ����Ϣ����Ӧ��Ϣ
    if strcmp(msg_type,'00000011')
        switch gs_id
            case 1
                %����վ�����Ź�վ����λ�ø���֤ʵ��Ϣ������1����Ϣ���ͣ�����2���Ƿ�Ϊ���Ź�վλ�ø��µı�־��'1'�����ǣ�'0'����񣩣�����3��λ�ø���֤ʵ��Ϣ
                gdb2gs1_response('00000100','1',delete_result);
            case 2
                gdb2gs2_response('00000100','1',delete_result);
            case 3
                gdb2gs3_response('00000100','1',delete_result);
            case 4
                gdb2gs4_response('00000100','1',delete_result);
            case 5
                gdb2gs5_response('00000100','1',delete_result);
            case 6
                gdb2gs6_response('00000100','1',delete_result);
            case 7
                gdb2gs7_response('00000100','1',delete_result);
            case 8
                gdb2gs8_response('00000100','1',delete_result);
            otherwise
        end
    end
end