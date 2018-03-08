%Ѱ������

function P_LP = ss_location_paging_lpnum(SS_LOCATION_PARA,START_NUM,STEP,STEP_NUM)

    %ȫ�ֱ���SS_PAGE��SS_NUM��2�У���������û�վѰ���ͱ�Ѱ����״̬
    %��1��ΪIS_PAGING��1��������Ѱ����0����δѰ����
    %��2��ΪIS_BEPAGED��1�����Ѿ���ӦѰ����0����δ��Ѱ����
    global SS_PAGE;
    
    global PAGING_NUM;
    global LP_SUCCESS_NUM;

    %ÿ��ѭ���У��û�վ����Ѱ������ĸ������Ӳ��ɷֲ�
    %ϵͳ���û�վ��ΪSS_NUM������ǿ�ȣ���ÿ��ѭ������T�з���Ѱ����ƽ���û�վ������ΪLAMBDA
    SS_NUM = length(SS_LOCATION_PARA);

    %���ÿ��ѭ����Ѱ���ɹ����ʵ�����
    P_LP = ones(1,STEP_NUM);
    
    for cyc = 1:STEP_NUM
        PAGING_NUM = START_NUM + (cyc-1)*STEP;
        PAGING_ARY = randperm(SS_NUM,PAGING_NUM);           %��������û�վ��ID
        BEPAGED_ARY = zeros(PAGING_NUM,1);                  %��ű����û�վ��ID
        LP_SUCCESS_NUM = PAGING_NUM;                        %Ѱ���ɹ��Ĵ���
        for i = 1:PAGING_NUM
            bepaged_temp = randperm(SS_NUM,1);              %�������һ�������Ź�վID
            BEPAGED_ARY(i) = bepaged_temp;
            %�����û�վ�ͱ����û�վ������ͬһ�������������û�վ�����Ѿ������Ѱ�����ѱ�Ѱ��
            if PAGING_ARY(i)~=BEPAGED_ARY(i) && SS_PAGE(PAGING_ARY(i),1)==0 && SS_PAGE(PAGING_ARY(i),2)==0
                %������Ѱ�����û�վ��Ѱ����־��Ϣ��Ϊ"1"
                SS_PAGE(PAGING_ARY(i),1) = 1;

                %�ҳ������û�վ���û�վ���������ڵ�����
                index = SS_LOCATION_PARA(:,6)==PAGING_ARY(i);
                %���������û�վ�����Ź�վ��Ϣ����ʼ����Ϣ���͵���Ӧ�Ź�վ
                switch SS_LOCATION_PARA(index,5)
                    case 1
                        %����1����Ϣ���ͣ�����2�������û�վID������3�Ǳ����û�վID
                        lp_ss2gs1('00001001',PAGING_ARY(i),BEPAGED_ARY(i));
                    case 2
                        lp_ss2gs2('00001001',PAGING_ARY(i),BEPAGED_ARY(i));
                    case 3
                        lp_ss2gs3('00001001',PAGING_ARY(i),BEPAGED_ARY(i));
                    case 4
                        lp_ss2gs4('00001001',PAGING_ARY(i),BEPAGED_ARY(i));
                    case 5
                        lp_ss2gs5('00001001',PAGING_ARY(i),BEPAGED_ARY(i));
                    case 6
                        lp_ss2gs6('00001001',PAGING_ARY(i),BEPAGED_ARY(i));
                    case 7
                        lp_ss2gs7('00001001',PAGING_ARY(i),BEPAGED_ARY(i));
                    case 8
                        lp_ss2gs8('00001001',PAGING_ARY(i),BEPAGED_ARY(i));
                    otherwise
                end

            %�����û�վ�ͱ����Ź�վ��ͬһ����Ѱ����Ч��������
            else
                PAGING_NUM = PAGING_NUM-1;
                LP_SUCCESS_NUM = LP_SUCCESS_NUM-1;
            end
        end
        P_LP(cyc) = LP_SUCCESS_NUM/PAGING_NUM;
    end
       
end