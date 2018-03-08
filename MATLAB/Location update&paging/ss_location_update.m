%用户站移动模型的建立
%获取用户站当前位置、速度信息上报信关站
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

    %用户站在移动速度上分为四档
    %分别为静止、低速、中速、高速
    %用户站速度单位设为km/min
    %SS_SPEED_STILL = 0;                %静止速度为0
    SS_SPEED_LOW = 0.1;                %低速（人的步行速度）为6km/h，即0.1km/min
    SS_SPEED_MEDIUM = 2;               %中速（汽车、普快列车等）为120km/h，即2km/min
    SS_SPEED_HIGH = 5;                 %高速（高铁、飞机）为300km/h，即5km/min

    %循环次数（即位置更新次数），每次循环仿真时间推进T，则系统仿真的时间是CYC_NUM*Tmin
    CYC_NUM = 12;
    global T;
    T = 5;

    %正态分布的参数：标准差delta
    %MATLAB函数normrnd(mu,delata)第一个参数是均值，第二个参数是标准差而不是数学上正态分布的方差
    delta = 0.5;
    
    %1.针对ss_location_paging.m
    %存放每次循环中寻呼成功概率的数组
    P_LP = ones(CYC_NUM+1,1);
    %存放每次每次循环中平均寻呼时延的数组
    lp_delay = ones(CYC_NUM+1,6);
    
%     %2.针对ss_location_paging_lpnum.m
%     %存放每次循环中寻呼成功概率的数组
%     START_NUM = SS_NUM/50;
%     STEP = SS_NUM/100;
%     STEP_NUM = 11;
%     P_LP = ones(CYC_NUM+1,STEP_NUM);

    %用户站按速度分成四组
    %静止组有SS_NUM/4个用户站，它们静止不动

    %低速组有SS_NUM/4个用户站
    %第一次位置更新时，某一个用户站A的运动速率是满足[0.5*SS_SPEED_LOW,1.5*SS_SPEED_LOW]内均匀分布的某一具体速率speed_A
    %该用户站A的运动方向是满足[-pi,pi]内均匀分布的某一具体角度angle_A
    %%运动方向有待商榷，由于“一带一路”区域内用户站运动方向较为统一，向东或向西，因此这里的[-pi,pi]可能没有[-pi/6,pi/6]更切合实际
    %该用户站的加速度大小为零，即默认两次位置更新之间是匀速运动，故不设置加速度这一属性
    %之后该用户站每次位置更新
    %都生成一个运动速率是满足[speed_A,0.5]正态分布的某一随机速率
    %运动方向是满足[angle_A,0.5]正态分布的某一随机角度进行匀速运动，直到下一次位置更新到来再改变速度
    %将矢量速度（速率大小和角度）写入存储用户站位置的数组SS_LOCATION中
    %实际系统中，位置、速度、加速度信息每次位置更新时由用户站的惯性测量组合获得，这样在下次位置更新前的某一时刻就利用这三组数据估算用户站的位置
    %但是在仿真中，没有惯性测量组合，每次位置更新时，就用自己设定的随机矢量速度来更新

    %中速组和高速组设定类似低速组
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

    % %画出各个信关站的覆盖范围
    % for i = 1:GS_NUM
    %     circle(GS_LOCATION(i,1),GS_LOCATION(i,2),Radius);
    % end

    %第一次位置更新前先确定各个用户站所属信关站
    TEMP_DISTANCE = 1./zeros(GS_NUM,1);
    for j = 1:SS_NUM
        for k = 1:GS_NUM
            TEMP_DISTANCE(k) = sqrt( ( SS_LOCATION(j,1)-GS_LOCATION(k,1) )^2 + ( SS_LOCATION(j,2)-GS_LOCATION(k,2) )^2 );
        end
        [~,index] = min(TEMP_DISTANCE);
        SS_LOCATION(j,5) = index;                   %index为离当前用户站距离最近的信关站的编号，填写进用户站位置信息数组的第5列
    end

    % %以不同的颜色显示各个信关站的用户站
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
    %第一次把用户站位置信息上报信关站
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
            %初次上报信关站时，每个用户站都属于某个信关站，即不存在失联的用户站，故该otherwise应该不会用上
            otherwise
                %continue;
        end
    end
    
    %1.针对ss_location_paging.m
    %每次位置更新完成后，进行一次寻呼，主要目的是求出寻呼时延
    %全局变量SS_PAGE有SS_NUM行2列，存放所有用户站寻呼和被寻呼的状态
    %第1列为IS_PAGING（1代表正在寻呼，0代表未寻呼）
    %第2列为IS_BEPAGED（1代表已经响应寻呼，0代表未被寻呼）
    SS_PAGE = zeros(SS_NUM,2);
    [P_LP(1),lp_delay(1,:)] = ss_location_paging(SS_LOCATION);

%     %2.针对ss_location_paging_lpnum.m
%     %全局变量SS_PAGE有SS_NUM行2列，存放所有用户站寻呼和被寻呼的状态
%     %第1列为IS_PAGING（1代表正在寻呼，0代表未寻呼）
%     %第2列为IS_BEPAGED（1代表已经响应寻呼，0代表未被寻呼）
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

    %每次循环，进行一次位置更新并上报信关站，之后再进行寻呼
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

        %假设信关站覆盖的横纵方向均是筒状的，则用户站移出左边界相当于进入右边界，移出上边界相当于移入下边界
        %需要重新计算移出边界的用户站的位置
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

        %计算可运动用户站（编号从0.25*SS_NUM+1到SS_NUM）距离各个信关站的距离，选出最短的距离
        %当该最短距离小于信关站覆盖半径（即在信关站覆盖范围内）时
        %则该信关站为该用户站的所属信关站，完成位置更新
        TEMP_DISTANCE = 1./zeros(GS_NUM,1);
        for j = 0.25*SS_NUM+1:SS_NUM
            for k = 1:GS_NUM
                TEMP_DISTANCE(k) = sqrt( ( SS_LOCATION(j,1)-GS_LOCATION(k,1) )^2 + ( SS_LOCATION(j,2)-GS_LOCATION(k,2) )^2 );
            end
            [min_distance,index] = min(TEMP_DISTANCE);
            %只有当最短距离小于信关站覆盖半径时，才更新用户站所属信关站，否则用户站位置信息数组的第5列置0，表示不在任何信关站覆盖范围内
            if min_distance <= Radius
                SS_LOCATION(j,5) = index;                   %index为离当前用户站距离最近的信关站的编号，填写进用户站位置信息数组的第5列
            else
                SS_LOCATION(j,5) = 0;
            end         
        end

    %     %以不同的颜色显示各个信关站的用户站
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
    % %     %把上次的点和这次的点连线
    % %     plot([OLD_SS_LOCATION(j,1),SS_LOCATION(j,1)],[OLD_SS_LOCATION(j,2),SS_LOCATION(j,2)]);
    % %     xlabel('km');
    % %     ylabel('km');
    %     end
    % 
    %     
    %     title('用户站移动模型');


        %每次位置更新周期（循环）开始时，将记录每次位置更新周期中相关信息的全局变量置零
        LU_NUM = 0;
        CROSS_GS_LU_NUM = 0;
        NOT_CROSS_GS_LU_NUM = 0;
        SUCCESS_LU_NUM = 0;
        FAILURE_LU_NUM = 0;
        TASKSEQ_NUM = 0;
        %每次用户站完成位置更新，均需要把更新后的用户站位置信息上报信关站，消息类型是'00000000'
        %这里假设每次位置更新都是所有用户站同时更新，实际上各个用户站更新的时间是不同的，更新时间分布应该服从泊松分布
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
                    %这种情况属于用户站不在任何信关站的覆盖范围内，即失联的情况
                    %本应该通知原所属信关站删除自己的信息的
                    %但用户站已经失联，故无法通知任何信关站
                    %那就不做处理，若要寻呼这种不在任何信关站的覆盖范围内的用户站SS_OUT
                    %则被呼信关站，即SS_OUT之前所属的信关站仍会试图向SS_OUT发寻呼请求
                    %只不过该寻呼请求消息无法传达，过了一定时间后还未收到应答消息的被呼信关站
                    %即可确认SS_OUT已经失联，然后删除LMB中的SS_OUT记录，并通知中心站
                    %告知中心站寻呼失败并删除GDB中的SS_OUT记录
                    %虽然这样处理，LMB和GDB删除失联用户站信息会有滞后（取决于什么时候有主叫用户站向失联用户站发起寻呼）
                    %但是并不影响系统的正常运行
                    %continue;
            end
        end
        
        %1.针对ss_location_paging.m
        %每次位置更新完成后，进行一次寻呼，主要目的是求出寻呼时延
        SS_PAGE = zeros(SS_NUM,2);
        [P_LP(i+1),lp_delay(i+1,:)] = ss_location_paging(SS_LOCATION);
        
%         %2.针对ss_location_paging_lpnum.m
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

    %     %把更新后的位置信息存起来，用于以后的寻呼
    %     SAVE SS_LOCATION_UPDATE;

    end
%     fprintf('SS_LOCATION_LENGTH:%d\n\n',length(SS_LOCATION));

    %1.针对ss_location_paging.m
    figure;
    plot(0:5:5*CYC_NUM, P_LP,'r.-');
    grid on;
    xlabel('时间/min');
    ylabel('寻呼成功率');
    title('寻呼成功率随仿真时间的变化关系');
    
%     figure;
%     plot(mean(lp_delay),'-ok','Linewidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);
%     set(gca,'xticklabel',{'1/3' '1/2' '2/3' '4/5' '7/8' '无编码'});
%     title('寻呼时延（BPSK,r=0.6）');
%     xlabel('信道编码码率');
%     ylabel('时延（ms）');
    
    figure;
    bar(mean(lp_delay));
    set(gca,'xticklabel',{'1/3' '1/2' '2/3' '4/5' '7/8' '无编码'});
    title('寻呼时延（BPSK，r=0.6）');
    xlabel('信道编码码率');
    ylabel('时延（ms）');

%     %2.针对ss_location_paging_lpnum.m
%     P = mean(P_LP);
%     figure;
%     plot(START_NUM:STEP:START_NUM+(STEP_NUM-1)*STEP, P,'r.-');
%     grid on;
%     xlabel('发起寻呼用户站数量');
%     ylabel('寻呼成功率');
%     title('单位时间平均寻呼成功率随发起寻呼用户站数量的变化关系');

end