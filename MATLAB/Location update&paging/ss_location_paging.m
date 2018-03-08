%寻呼函数

function [P_LP,lp_delay_avg] = ss_location_paging(SS_LOCATION_PARA)

    %全局变量SS_PAGE有SS_NUM行2列，存放所有用户站寻呼和被寻呼的状态
    %第1列为IS_PAGING（1代表正在寻呼，0代表未寻呼）
    %第2列为IS_BEPAGED（1代表已经响应寻呼，0代表未被寻呼）
    global SS_PAGE;
    
    global PAGING_NUM;
    global LP_SUCCESS_NUM;

    %每次循环中，用户站产生寻呼请求的个数服从泊松分布
    %系统中用户站数为SS_NUM，呼叫强度（即每次循环周期T中发起寻呼的平均用户站数）定为LAMBDA
    SS_NUM = length(SS_LOCATION_PARA);
    LAMBDA = SS_NUM/20;
    
    PAGING_NUM = random('poisson',LAMBDA);              %本次寻呼用户站数
    PAGING_ARY = randperm(SS_NUM,PAGING_NUM);           %存放主叫用户站的ID
    BEPAGED_ARY = zeros(PAGING_NUM,1);                  %存放被叫用户站的ID
    LP_SUCCESS_NUM = PAGING_NUM;                        %寻呼成功的次数
    
    % 上行发送速率（BPSK，r=0.6）
    up=[3.82,5.73,7.65,9.18,10.04,11.47];
    %寻呼上行发送时延
    global lp_up_send_delay;
    lp_up_send_delay = (112*2)./(up*1000)+(128*2)./(up*1000);
    
    % 下行发送速率（BPSK，r=0.6）
    down = [4.49,6.75,9.00,10.8,11.8,13.5];
    %寻呼下行发送时延
    global lp_down_send_delay;
    lp_down_send_delay = (72*2)./(down*1000)+(16*2)./(down*1000);
    
    lp_delay_all = zeros(PAGING_NUM,length(up));
    
    %记录本次循环中所有寻呼时延的数组
    global lp_delay;
    
    
    %循环次数等于初始PAGING_NUM的值
    cyc_num = PAGING_NUM;
    for i = 1:cyc_num 
        bepaged_temp = randperm(SS_NUM,1);              %随机生成一个被叫信关站ID
        BEPAGED_ARY(i) = bepaged_temp;
        
        %主叫用户站和被叫用户站不能是同一个，并且主叫用户站不能已经发起过寻呼或已被寻呼
        if PAGING_ARY(i)~=BEPAGED_ARY(i) && SS_PAGE(PAGING_ARY(i),1)==0 && SS_PAGE(PAGING_ARY(i),2)==0
            
            lp_delay = lp_up_send_delay;
            
            %将发起寻呼的用户站的寻呼标志信息置为"1"
            SS_PAGE(PAGING_ARY(i),1) = 1;
            
            %找出主叫用户站在用户站数组中所在的行数
            index = SS_LOCATION_PARA(:,6)==PAGING_ARY(i);
            %根据主叫用户站所属信关站信息，将始呼消息发送到对应信关站
            switch SS_LOCATION_PARA(index,5)
                case 1
                    %参数1是消息类型，参数2是主叫用户站ID，参数3是被叫用户站ID
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
            
            lp_delay_all(i,:) = lp_delay;
                    
        %主叫用户站和被叫信关站是同一个的寻呼无效，不计数
        else
            lp_delay_all(i,:) = [];
            PAGING_NUM = PAGING_NUM-1;
            LP_SUCCESS_NUM = LP_SUCCESS_NUM-1;
        end
        
    end
    
    lp_delay_avg = mean(lp_delay_all);
    P_LP = LP_SUCCESS_NUM/PAGING_NUM;
    
    
end