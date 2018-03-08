%位置更新确认消息，用于信关站通知用户站位置更新的结果
%这个函数是用来统计所有的位置更新结果的
%即gs不将位置更新结果消息发送到每个ss，而是统一发送到这个函数
%然后这个函数记录跨信关站的位置更新数和未跨信关站的位置更新数，以及所有的位置更新成功次数和失败次数
%从而确定每次位置更新周期里：一共有多少个ss发起了位置更新请求，以及跨信关站位置更新率、总体位置更新成功率等指标

%参数1是消息类型，参数2是是否为跨信关站位置更新的标志（'1'代表是，'0'代表否），参数3是位置更新结果
function gs2ss(msg_type,is_cross_gs,lu_result)

    %全局变量LU_NUM记录每次循环周期中，总的位置更新请求次数
    global LU_NUM; 
    %全局变量CROSS_GS_LU_NUM记录每次循环周期中，跨信关站的位置更新请求次数
    global CROSS_GS_LU_NUM; 
    global NOT_CROSS_GS_LU_NUM;
    %全局变量SUCCESS_LU_NUM记录每次循环周期中，位置更新成功的次数
    global SUCCESS_LU_NUM; 
    global FAILURE_LU_NUM;

    %消息类型是'00000101'代表是信关站发来的位置更新证实消息
    if strcmp(msg_type,'00000101')
        %每收到一次信关站发来的位置更新证实消息，说明系统内发起了一次位置更新请求
        LU_NUM = LU_NUM+1;
        
        %记录发生的跨信关站位置更新的次数
        if strcmp(is_cross_gs,'1')
            CROSS_GS_LU_NUM = CROSS_GS_LU_NUM+1;
        elseif strcmp(is_cross_gs,'0')
            NOT_CROSS_GS_LU_NUM  = NOT_CROSS_GS_LU_NUM+1;
        end
        
        %记录位置更新成功的次数
        if strcmp(lu_result,'00000000')
            SUCCESS_LU_NUM = SUCCESS_LU_NUM+1;
        elseif strcmp(lu_result,'00000001')
            FAILURE_LU_NUM = FAILURE_LU_NUM+1;
        end
        
    end

end