%λ�ø���ȷ����Ϣ�������Ź�վ֪ͨ�û�վλ�ø��µĽ��
%�������������ͳ�����е�λ�ø��½����
%��gs����λ�ø��½����Ϣ���͵�ÿ��ss������ͳһ���͵��������
%Ȼ�����������¼���Ź�վ��λ�ø�������δ���Ź�վ��λ�ø��������Լ����е�λ�ø��³ɹ�������ʧ�ܴ���
%�Ӷ�ȷ��ÿ��λ�ø��������һ���ж��ٸ�ss������λ�ø��������Լ����Ź�վλ�ø����ʡ�����λ�ø��³ɹ��ʵ�ָ��

%����1����Ϣ���ͣ�����2���Ƿ�Ϊ���Ź�վλ�ø��µı�־��'1'�����ǣ�'0'����񣩣�����3��λ�ø��½��
function gs2ss(msg_type,is_cross_gs,lu_result)

    %ȫ�ֱ���LU_NUM��¼ÿ��ѭ�������У��ܵ�λ�ø����������
    global LU_NUM; 
    %ȫ�ֱ���CROSS_GS_LU_NUM��¼ÿ��ѭ�������У����Ź�վ��λ�ø����������
    global CROSS_GS_LU_NUM; 
    global NOT_CROSS_GS_LU_NUM;
    %ȫ�ֱ���SUCCESS_LU_NUM��¼ÿ��ѭ�������У�λ�ø��³ɹ��Ĵ���
    global SUCCESS_LU_NUM; 
    global FAILURE_LU_NUM;

    %��Ϣ������'00000101'�������Ź�վ������λ�ø���֤ʵ��Ϣ
    if strcmp(msg_type,'00000101')
        %ÿ�յ�һ���Ź�վ������λ�ø���֤ʵ��Ϣ��˵��ϵͳ�ڷ�����һ��λ�ø�������
        LU_NUM = LU_NUM+1;
        
        %��¼�����Ŀ��Ź�վλ�ø��µĴ���
        if strcmp(is_cross_gs,'1')
            CROSS_GS_LU_NUM = CROSS_GS_LU_NUM+1;
        elseif strcmp(is_cross_gs,'0')
            NOT_CROSS_GS_LU_NUM  = NOT_CROSS_GS_LU_NUM+1;
        end
        
        %��¼λ�ø��³ɹ��Ĵ���
        if strcmp(lu_result,'00000000')
            SUCCESS_LU_NUM = SUCCESS_LU_NUM+1;
        elseif strcmp(lu_result,'00000001')
            FAILURE_LU_NUM = FAILURE_LU_NUM+1;
        end
        
    end

end