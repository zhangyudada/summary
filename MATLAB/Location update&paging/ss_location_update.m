%�û�վ�ƶ�ģ�͵Ľ���
%��ȡ�û�վ��ǰλ�á��ٶ���Ϣ�ϱ��Ź�վ
function ss_location_update()
    load LAYOUT;

    global LMB1;
    global LMB2;
    global LMB3;
    global LMB4;
    global LMB5;
    global LMB6;
    global LMB7;
    global LMB8;
    global GDB;
    global LU_NUM; 
    global CROSS_GS_LU_NUM; 
    global NOT_CROSS_GS_LU_NUM;
    global SUCCESS_LU_NUM; 
    global FAILURE_LU_NUM;
    global TASKSEQ_NUM;
    
    global SS_PAGE;

    %�û�վ���ƶ��ٶ��Ϸ�Ϊ�ĵ�
    %�ֱ�Ϊ��ֹ�����١����١�����
    %�û�վ�ٶȵ�λ��Ϊkm/min
    %SS_SPEED_STILL = 0;                %��ֹ�ٶ�Ϊ0
    SS_SPEED_LOW = 0.1;                %���٣��˵Ĳ����ٶȣ�Ϊ6km/h����0.1km/min
    SS_SPEED_MEDIUM = 2;               %���٣��������տ��г��ȣ�Ϊ120km/h����2km/min
    SS_SPEED_HIGH = 5;                 %���٣��������ɻ���Ϊ300km/h����5km/min

    %ѭ����������λ�ø��´�������ÿ��ѭ������ʱ���ƽ�T����ϵͳ�����ʱ����CYC_NUM*Tmin
    CYC_NUM = 12;
    global T;
    T = 5;

    %��̬�ֲ��Ĳ�������׼��delta
    %MATLAB����normrnd(mu,delata)��һ�������Ǿ�ֵ���ڶ��������Ǳ�׼���������ѧ����̬�ֲ��ķ���
    delta = 0.5;
    
    %1.���ss_location_paging.m
    %���ÿ��ѭ����Ѱ���ɹ����ʵ�����
    P_LP = ones(CYC_NUM+1,1);
    %���ÿ��ÿ��ѭ����ƽ��Ѱ��ʱ�ӵ�����
    lp_delay = ones(CYC_NUM+1,6);
    
%     %2.���ss_location_paging_lpnum.m
%     %���ÿ��ѭ����Ѱ���ɹ����ʵ�����
%     START_NUM = SS_NUM/50;
%     STEP = SS_NUM/100;
%     STEP_NUM = 11;
%     P_LP = ones(CYC_NUM+1,STEP_NUM);

    %�û�վ���ٶȷֳ�����
    %��ֹ����SS_NUM/4���û�վ�����Ǿ�ֹ����

    %��������SS_NUM/4���û�վ
    %��һ��λ�ø���ʱ��ĳһ���û�վA���˶�����������[0.5*SS_SPEED_LOW,1.5*SS_SPEED_LOW]�ھ��ȷֲ���ĳһ��������speed_A
    %���û�վA���˶�����������[-pi,pi]�ھ��ȷֲ���ĳһ����Ƕ�angle_A
    %%�˶������д���ȶ�����ڡ�һ��һ·���������û�վ�˶������Ϊͳһ���򶫻���������������[-pi,pi]����û��[-pi/6,pi/6]���к�ʵ��
    %���û�վ�ļ��ٶȴ�СΪ�㣬��Ĭ������λ�ø���֮���������˶����ʲ����ü��ٶ���һ����
    %֮����û�վÿ��λ�ø���
    %������һ���˶�����������[speed_A,0.5]��̬�ֲ���ĳһ�������
    %�˶�����������[angle_A,0.5]��̬�ֲ���ĳһ����ǶȽ��������˶���ֱ����һ��λ�ø��µ����ٸı��ٶ�
    %��ʸ���ٶȣ����ʴ�С�ͽǶȣ�д��洢�û�վλ�õ�����SS_LOCATION��
    %ʵ��ϵͳ�У�λ�á��ٶȡ����ٶ���Ϣÿ��λ�ø���ʱ���û�վ�Ĺ��Բ�����ϻ�ã��������´�λ�ø���ǰ��ĳһʱ�̾��������������ݹ����û�վ��λ��
    %�����ڷ����У�û�й��Բ�����ϣ�ÿ��λ�ø���ʱ�������Լ��趨�����ʸ���ٶ�������

    %������͸������趨���Ƶ�����
    INIT_SPEED_LOW = unifrnd(0.5*SS_SPEED_LOW,1.5*SS_SPEED_LOW,SS_NUM/4,1);
    INIT_SPEED_MEDIUM = unifrnd(0.5*SS_SPEED_MEDIUM,1.5*SS_SPEED_MEDIUM,SS_NUM/4,1);
    INIT_SPEED_HIGH = unifrnd(0.5*SS_SPEED_HIGH,1.5*SS_SPEED_HIGH,SS_NUM/4,1);
    INIT_ANGLE = unifrnd(-pi/6,pi/6,0.75*SS_NUM,1);

    SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,3) = INIT_SPEED_LOW;
    SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,4) = INIT_ANGLE(1:0.25*SS_NUM);

    SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,3) = INIT_SPEED_MEDIUM;
    SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,4) = INIT_ANGLE(0.25*SS_NUM+1:0.5*SS_NUM);

    SS_LOCATION(0.75*SS_NUM+1:SS_NUM,3) = INIT_SPEED_HIGH;
    SS_LOCATION(0.75*SS_NUM+1:SS_NUM,4) = INIT_ANGLE(0.5*SS_NUM+1:0.75*SS_NUM);

    % %���������Ź�վ�ĸ��Ƿ�Χ
    % for i = 1:GS_NUM
    %     circle(GS_LOCATION(i,1),GS_LOCATION(i,2),Radius);
    % end

    %��һ��λ�ø���ǰ��ȷ�������û�վ�����Ź�վ
    TEMP_DISTANCE = 1./zeros(GS_NUM,1);
    for j = 1:SS_NUM
        for k = 1:GS_NUM
            TEMP_DISTANCE(k) = sqrt( ( SS_LOCATION(j,1)-GS_LOCATION(k,1) )^2 + ( SS_LOCATION(j,2)-GS_LOCATION(k,2) )^2 );
        end
        [~,index] = min(TEMP_DISTANCE);
        SS_LOCATION(j,5) = index;                   %indexΪ�뵱ǰ�û�վ����������Ź�վ�ı�ţ���д���û�վλ����Ϣ����ĵ�5��
    end

    % %�Բ�ͬ����ɫ��ʾ�����Ź�վ���û�վ
    % for i = 1:SS_NUM
    %     switch SS_LOCATION(i,5)
    %         case 1
    %             plot(SS_LOCATION(i,1),SS_LOCATION(i,2),'.y');
    %         case 2
    %             plot(SS_LOCATION(i,1),SS_LOCATION(i,2),'.m');
    %         case 3
    %             plot(SS_LOCATION(i,1),SS_LOCATION(i,2),'.c');
    %         case 4
    %             plot(SS_LOCATION(i,1),SS_LOCATION(i,2),'.r');
    %         case 5
    %             plot(SS_LOCATION(i,1),SS_LOCATION(i,2),'.g');
    %         case 6
    %             plot(SS_LOCATION(i,1),SS_LOCATION(i,2),'.b');
    %         case 7
    %             plot(SS_LOCATION(i,1),SS_LOCATION(i,2),'.k');
    %         case 8
    %             plot(SS_LOCATION(i,1),SS_LOCATION(i,2),'.c');
    %         otherwise
    %             continue;
    %     end
    % end

    LU_NUM = 0;
    CROSS_GS_LU_NUM = 0;
    NOT_CROSS_GS_LU_NUM = 0;
    SUCCESS_LU_NUM = 0;
    FAILURE_LU_NUM = 0;
    TASKSEQ_NUM = 0;
    %��һ�ΰ��û�վλ����Ϣ�ϱ��Ź�վ
    for i = 1:SS_NUM
        switch SS_LOCATION(i,5)
            case 1
                ss2gs1('00000000',SS_LOCATION(i,:));
            case 2
                ss2gs2('00000000',SS_LOCATION(i,:));
            case 3
                ss2gs3('00000000',SS_LOCATION(i,:));
            case 4
                ss2gs4('00000000',SS_LOCATION(i,:));
            case 5
                ss2gs5('00000000',SS_LOCATION(i,:));
            case 6
                ss2gs6('00000000',SS_LOCATION(i,:));
            case 7
                ss2gs7('00000000',SS_LOCATION(i,:));
            case 8
                ss2gs8('00000000',SS_LOCATION(i,:));
            %�����ϱ��Ź�վʱ��ÿ���û�վ������ĳ���Ź�վ����������ʧ�����û�վ���ʸ�otherwiseӦ�ò�������
            otherwise
                %continue;
        end
    end
    
    %1.���ss_location_paging.m
    %ÿ��λ�ø�����ɺ󣬽���һ��Ѱ������ҪĿ�������Ѱ��ʱ��
    %ȫ�ֱ���SS_PAGE��SS_NUM��2�У���������û�վѰ���ͱ�Ѱ����״̬
    %��1��ΪIS_PAGING��1��������Ѱ����0����δѰ����
    %��2��ΪIS_BEPAGED��1�����Ѿ���ӦѰ����0����δ��Ѱ����
    SS_PAGE = zeros(SS_NUM,2);
    [P_LP(1),lp_delay(1,:)] = ss_location_paging(SS_LOCATION);

%     %2.���ss_location_paging_lpnum.m
%     %ȫ�ֱ���SS_PAGE��SS_NUM��2�У���������û�վѰ���ͱ�Ѱ����״̬
%     %��1��ΪIS_PAGING��1��������Ѱ����0����δѰ����
%     %��2��ΪIS_BEPAGED��1�����Ѿ���ӦѰ����0����δ��Ѱ����
%     SS_PAGE = zeros(SS_NUM,2);
%     P_LP(1,:) = ss_location_paging_lpnum(SS_LOCATION,START_NUM,STEP,STEP_NUM);
    
%     fprintf('LMB1:\n');disp(LMB1);
%     fprintf('LMB2:\n');disp(LMB2);
%     fprintf('LMB3:\n');disp(LMB3);
%     fprintf('LMB4:\n');disp(LMB4);
%     fprintf('LMB5:\n');disp(LMB5);
%     fprintf('LMB6:\n');disp(LMB6);
%     fprintf('LMB7:\n');disp(LMB7);
%     fprintf('LMB8:\n');disp(LMB8);
%     fprintf('SS_LOCATION:\n');disp(SS_LOCATION);
%     fprintf('GDB:\n');disp(GDB);
    fprintf('LU_NUM:%d\n',LU_NUM)
    fprintf('SUCCESS_LU_NUM:%d\n',SUCCESS_LU_NUM);
    fprintf('FAILURE_LU_NUM:%d\n',FAILURE_LU_NUM);
    fprintf('SUCCESS + FAILURE = %d\n',SUCCESS_LU_NUM+FAILURE_LU_NUM);
    fprintf('CROSS_GS_LU_NUM:%d\n',CROSS_GS_LU_NUM);
    fprintf('NOT_CROSS_GS_LU_NUM:%d\n',NOT_CROSS_GS_LU_NUM);
    fprintf('CROSS + NOT_CROSS = %d\n',CROSS_GS_LU_NUM+NOT_CROSS_GS_LU_NUM);
    fprintf('TASKSEQ_NUM:%d\n',TASKSEQ_NUM);
    fprintf('LMB_LENGTH_SUM:%d\n',length(LMB1)+length(LMB2)+length(LMB3)+length(LMB4)+length(LMB5)+length(LMB6)+length(LMB7)+length(LMB8));
    fprintf('GDB_LENGTH:%d\n\n',length(GDB));

    %ÿ��ѭ��������һ��λ�ø��²��ϱ��Ź�վ��֮���ٽ���Ѱ��
    for i = 1:CYC_NUM
%         OLD_SS_LOCATION = SS_LOCATION;

        SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,1) = SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,1) + SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,3) .* cos(SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,4))*T;
        SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,2) = SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,2) + SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,3) .* sin(SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,4))*T;
        SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,3) = normrnd(INIT_SPEED_LOW,delta);
        SS_LOCATION(0.25*SS_NUM+1:0.5*SS_NUM,4) = normrnd(INIT_ANGLE(1:0.25*SS_NUM),delta);

        SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,1) = SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,1) + SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,3) .* cos(SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,4))*T;
        SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,2) = SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,2) + SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,3) .* sin(SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,4))*T;
        SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,3) = normrnd(INIT_SPEED_MEDIUM,delta);
        SS_LOCATION(0.5*SS_NUM+1:0.75*SS_NUM,4) = normrnd(INIT_ANGLE(0.25*SS_NUM+1:0.5*SS_NUM),delta);

        SS_LOCATION(0.75*SS_NUM+1:SS_NUM,1) = SS_LOCATION(0.75*SS_NUM+1:SS_NUM,1) + SS_LOCATION(0.75*SS_NUM+1:SS_NUM,3) .* cos(SS_LOCATION(0.75*SS_NUM+1:SS_NUM,4))*T;
        SS_LOCATION(0.75*SS_NUM+1:SS_NUM,2) = SS_LOCATION(0.75*SS_NUM+1:SS_NUM,2) + SS_LOCATION(0.75*SS_NUM+1:SS_NUM,3) .* sin(SS_LOCATION(0.75*SS_NUM+1:SS_NUM,4))*T;
        SS_LOCATION(0.75*SS_NUM+1:SS_NUM,3) = normrnd(INIT_SPEED_HIGH,delta);
        SS_LOCATION(0.75*SS_NUM+1:SS_NUM,4) = normrnd(INIT_ANGLE(0.5*SS_NUM+1:0.75*SS_NUM),delta);

        %�����Ź�վ���ǵĺ��ݷ������Ͳ״�ģ����û�վ�Ƴ���߽��൱�ڽ����ұ߽磬�Ƴ��ϱ߽��൱�������±߽�
        %��Ҫ���¼����Ƴ��߽���û�վ��λ��
        for j = 0.25*SS_NUM+1:SS_NUM
            if SS_LOCATION(j,1) < -4*UNIT
                SS_LOCATION(j,1) = SS_LOCATION(j,1) + 8*UNIT;
            end
            if SS_LOCATION(j,1) > 4*UNIT
                SS_LOCATION(j,1) = SS_LOCATION(j,1) - 8*UNIT;
            end
            if SS_LOCATION(j,2) < -2*UNIT
                SS_LOCATION(j,2) = SS_LOCATION(j,2) + 4*UNIT;
            end
            if SS_LOCATION(j,2) > 2*UNIT
                SS_LOCATION(j,2) = SS_LOCATION(j,2) - 4*UNIT;
            end
        end

        %������˶��û�վ����Ŵ�0.25*SS_NUM+1��SS_NUM����������Ź�վ�ľ��룬ѡ����̵ľ���
        %������̾���С���Ź�վ���ǰ뾶�������Ź�վ���Ƿ�Χ�ڣ�ʱ
        %����Ź�վΪ���û�վ�������Ź�վ�����λ�ø���
        TEMP_DISTANCE = 1./zeros(GS_NUM,1);
        for j = 0.25*SS_NUM+1:SS_NUM
            for k = 1:GS_NUM
                TEMP_DISTANCE(k) = sqrt( ( SS_LOCATION(j,1)-GS_LOCATION(k,1) )^2 + ( SS_LOCATION(j,2)-GS_LOCATION(k,2) )^2 );
            end
            [min_distance,index] = min(TEMP_DISTANCE);
            %ֻ�е���̾���С���Ź�վ���ǰ뾶ʱ���Ÿ����û�վ�����Ź�վ�������û�վλ����Ϣ����ĵ�5����0����ʾ�����κ��Ź�վ���Ƿ�Χ��
            if min_distance <= Radius
                SS_LOCATION(j,5) = index;                   %indexΪ�뵱ǰ�û�վ����������Ź�վ�ı�ţ���д���û�վλ����Ϣ����ĵ�5��
            else
                SS_LOCATION(j,5) = 0;
            end         
        end

    %     %�Բ�ͬ����ɫ��ʾ�����Ź�վ���û�վ
    %     for j = 1:SS_NUM
    %         switch SS_LOCATION(j,5)
    %             case 1
    %                 plot(SS_LOCATION(j,1),SS_LOCATION(j,2),'.y');
    %                 axis([-4*Radius, 4*Radius, -2*Radius, 2*Radius]);
    %             case 2
    %                 plot(SS_LOCATION(j,1),SS_LOCATION(j,2),'.m');
    %                 axis([-4*Radius, 4*Radius, -2*Radius, 2*Radius]);
    %             case 3
    %                 plot(SS_LOCATION(j,1),SS_LOCATION(j,2),'.c');
    %                 axis([-4*Radius, 4*Radius, -2*Radius, 2*Radius]);
    %             case 4
    %                 plot(SS_LOCATION(j,1),SS_LOCATION(j,2),'.r');
    %                 axis([-4*Radius, 4*Radius, -2*Radius, 2*Radius]);
    %             case 5
    %                 plot(SS_LOCATION(j,1),SS_LOCATION(j,2),'.g');
    %                 axis([-4*Radius, 4*Radius, -2*Radius, 2*Radius]);
    %             case 6
    %                 plot(SS_LOCATION(j,1),SS_LOCATION(j,2),'.b');
    %                 axis([-4*Radius, 4*Radius, -2*Radius, 2*Radius]);
    %             case 7
    %                 plot(SS_LOCATION(j,1),SS_LOCATION(j,2),'.k');
    %                 axis([-4*Radius, 4*Radius, -2*Radius, 2*Radius]);
    %             case 8
    %                 plot(SS_LOCATION(j,1),SS_LOCATION(j,2),'.c');
    %                 axis([-4*Radius, 4*Radius, -2*Radius, 2*Radius]);
    %             otherwise
    %                 continue;
    %         end
    % %     %���ϴεĵ����εĵ�����
    % %     plot([OLD_SS_LOCATION(j,1),SS_LOCATION(j,1)],[OLD_SS_LOCATION(j,2),SS_LOCATION(j,2)]);
    % %     xlabel('km');
    % %     ylabel('km');
    %     end
    % 
    %     
    %     title('�û�վ�ƶ�ģ��');


        %ÿ��λ�ø������ڣ�ѭ������ʼʱ������¼ÿ��λ�ø��������������Ϣ��ȫ�ֱ�������
        LU_NUM = 0;
        CROSS_GS_LU_NUM = 0;
        NOT_CROSS_GS_LU_NUM = 0;
        SUCCESS_LU_NUM = 0;
        FAILURE_LU_NUM = 0;
        TASKSEQ_NUM = 0;
        %ÿ���û�վ���λ�ø��£�����Ҫ�Ѹ��º���û�վλ����Ϣ�ϱ��Ź�վ����Ϣ������'00000000'
        %�������ÿ��λ�ø��¶��������û�վͬʱ���£�ʵ���ϸ����û�վ���µ�ʱ���ǲ�ͬ�ģ�����ʱ��ֲ�Ӧ�÷��Ӳ��ɷֲ�
        for l = 1:SS_NUM
            switch SS_LOCATION(l,5)
                case 1
                    ss2gs1('00000000',SS_LOCATION(l,:));
                case 2
                    ss2gs2('00000000',SS_LOCATION(l,:));
                case 3
                    ss2gs3('00000000',SS_LOCATION(l,:));
                case 4
                    ss2gs4('00000000',SS_LOCATION(l,:));
                case 5
                    ss2gs5('00000000',SS_LOCATION(l,:));
                case 6
                    ss2gs6('00000000',SS_LOCATION(l,:));
                case 7
                    ss2gs7('00000000',SS_LOCATION(l,:));
                case 8
                    ss2gs8('00000000',SS_LOCATION(l,:));
                otherwise
                    %������������û�վ�����κ��Ź�վ�ĸ��Ƿ�Χ�ڣ���ʧ�������
                    %��Ӧ��֪ͨԭ�����Ź�վɾ���Լ�����Ϣ��
                    %���û�վ�Ѿ�ʧ�������޷�֪ͨ�κ��Ź�վ
                    %�ǾͲ���������ҪѰ�����ֲ����κ��Ź�վ�ĸ��Ƿ�Χ�ڵ��û�վSS_OUT
                    %�򱻺��Ź�վ����SS_OUT֮ǰ�������Ź�վ�Ի���ͼ��SS_OUT��Ѱ������
                    %ֻ������Ѱ��������Ϣ�޷��������һ��ʱ���δ�յ�Ӧ����Ϣ�ı����Ź�վ
                    %����ȷ��SS_OUT�Ѿ�ʧ����Ȼ��ɾ��LMB�е�SS_OUT��¼����֪ͨ����վ
                    %��֪����վѰ��ʧ�ܲ�ɾ��GDB�е�SS_OUT��¼
                    %��Ȼ��������LMB��GDBɾ��ʧ���û�վ��Ϣ�����ͺ�ȡ����ʲôʱ���������û�վ��ʧ���û�վ����Ѱ����
                    %���ǲ���Ӱ��ϵͳ����������
                    %continue;
            end
        end
        
        %1.���ss_location_paging.m
        %ÿ��λ�ø�����ɺ󣬽���һ��Ѱ������ҪĿ�������Ѱ��ʱ��
        SS_PAGE = zeros(SS_NUM,2);
        [P_LP(i+1),lp_delay(i+1,:)] = ss_location_paging(SS_LOCATION);
        
%         %2.���ss_location_paging_lpnum.m
%         SS_PAGE = zeros(SS_NUM,2);
%         P_LP(i+1,:) = ss_location_paging_lpnum(SS_LOCATION,START_NUM,STEP,STEP_NUM);
        
    %     fprintf('LMB1:\n');disp(LMB1);
    %     fprintf('LMB2:\n');disp(LMB2);
    %     fprintf('LMB3:\n');disp(LMB3);
    %     fprintf('LMB4:\n');disp(LMB4);
    %     fprintf('LMB5:\n');disp(LMB5);
    %     fprintf('LMB6:\n');disp(LMB6);
    %     fprintf('LMB7:\n');disp(LMB7);
    %     fprintf('LMB8:\n');disp(LMB8);
    %     fprintf('SS_LOCATION:\n');disp(SS_LOCATION);
    %     fprintf('GDB:\n');disp(GDB);
        fprintf('LU_NUM:%d\n',LU_NUM);
        fprintf('SUCCESS_LU_NUM:%d\n',SUCCESS_LU_NUM);
        fprintf('FAILURE_LU_NUM:%d\n',FAILURE_LU_NUM);
        fprintf('SUCCESS + FAILURE = %d\n',SUCCESS_LU_NUM+FAILURE_LU_NUM);
        fprintf('CROSS_GS_LU_NUM:%d\n',CROSS_GS_LU_NUM);
        fprintf('NOT_CROSS_GS_LU_NUM:%d\n',NOT_CROSS_GS_LU_NUM);
        fprintf('CROSS + NOT_CROSS = %d\n',CROSS_GS_LU_NUM+NOT_CROSS_GS_LU_NUM);
        fprintf('TASKSEQ_NUM:%d\n',TASKSEQ_NUM);
        fprintf('LMB_LENGTH_SUM:%d\n',length(LMB1)+length(LMB2)+length(LMB3)+length(LMB4)+length(LMB5)+length(LMB6)+length(LMB7)+length(LMB8));
        fprintf('GDB_LENGTH:%d\n\n',length(GDB));

    %     %�Ѹ��º��λ����Ϣ�������������Ժ��Ѱ��
    %     SAVE SS_LOCATION_UPDATE;

    end
%     fprintf('SS_LOCATION_LENGTH:%d\n\n',length(SS_LOCATION));

    %1.���ss_location_paging.m
    figure;
    plot(0:5:5*CYC_NUM, P_LP,'r.-');
    grid on;
    xlabel('ʱ��/min');
    ylabel('Ѱ���ɹ���');
    title('Ѱ���ɹ��������ʱ��ı仯��ϵ');
    
%     figure;
%     plot(mean(lp_delay),'-ok','Linewidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);
%     set(gca,'xticklabel',{'1/3' '1/2' '2/3' '4/5' '7/8' '�ޱ���'});
%     title('Ѱ��ʱ�ӣ�BPSK,r=0.6��');
%     xlabel('�ŵ���������');
%     ylabel('ʱ�ӣ�ms��');
    
    figure;
    bar(mean(lp_delay));
    set(gca,'xticklabel',{'1/3' '1/2' '2/3' '4/5' '7/8' '�ޱ���'});
    title('Ѱ��ʱ�ӣ�BPSK��r=0.6��');
    xlabel('�ŵ���������');
    ylabel('ʱ�ӣ�ms��');

%     %2.���ss_location_paging_lpnum.m
%     P = mean(P_LP);
%     figure;
%     plot(START_NUM:STEP:START_NUM+(STEP_NUM-1)*STEP, P,'r.-');
%     grid on;
%     xlabel('����Ѱ���û�վ����');
%     ylabel('Ѱ���ɹ���');
%     title('��λʱ��ƽ��Ѱ���ɹ����淢��Ѱ���û�վ�����ı仯��ϵ');

end