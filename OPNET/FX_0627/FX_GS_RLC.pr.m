MIL_3_Tfile_Hdr_ 145A 140A modeler 9 58CA0021 595C52F4 55 zhangyu-PC zhangyu 0 0 none none 0 0 none DA77092 31C0 0 0 0 0 0 0 1bcc 1                                                                                                                                                                                                                                                                                                                                                                                             ��g�      @   D   H        /�  /�  /�  /�  /�  /�  /�  
           	   begsim intrpt         
   ����   
   doc file            	nd_module      endsim intrpt             ����      failure intrpts            disabled      intrpt interval         ԲI�%��}����      priority              ����      recovery intrpts            disabled      subqueue                     count    ���   
   ����   
      list   	���   
          
      super priority             ����             Objid	\svo_self_objid;       Objid	\svo_node_objid;       /* user id of this GS. */   int	\svi_user_id;       &   ,//double 	tvd_ss2sat_dist[CONSTANT_SAT_NUM];           Boolean	tvb_init_fin;   Boolean	tvb_pk_rcv_up;   Boolean	tvb_handover;   Boolean	tvb_res_alloc;   Boolean	tvb_pk_handle;    Boolean	tvb_is_rcv_user_include;   Boolean tvb_res_alloc_result;           int		tvi_intrpt_type;   int		tvi_intrpt_code;   int		tvi_pk_type;   int		tvi_serv_sat_user_id;   int		tvi_rcv_user_id;   int		tvi_pk_size;   int		tvi_rcv_gs_user_id;   int		tvi_loop;   int		tvi_loop1;       )double	tvd_pk_tx_delay;		//transmit delay   .double	tvd_pk_prop_delay;		//propagation delay       Packet	*tvo_pk_ptr;       /* packet type pointer */   $FX_Profile_Pk_Type	*tvo_pk_info_ptr;   %FX_Profile_Pk_Type	*tvo_pk_info_ptr1;   %FX_Profile_Pk_Type	*tvo_pk_info_ptr2;       !Objid	tvo_serv_sat_gs_proc_objid;   Objid	tvo_rcv_gs_rlc_objid;       //int		tvi_temp;   //FX_Profile_Pk_Type	*tvo_temp;   //Boolean tvb_temp;      #include	"FX_defs.h"       4#define GS_RLC_INIT_FIN			(tvb_init_fin == OPC_TRUE)   0#define PK_RCV_UP				(tvb_pk_rcv_up == OPC_TRUE)   /#define HAND_OVER				(tvb_handover == OPC_TRUE)   0#define RES_ALLOC				(tvb_res_alloc == OPC_TRUE)   0#define PK_HANDLE				(tvb_pk_handle == OPC_TRUE)       !#define HIGH_LAYER_INPUT_STREAM	0    #define LOW_LAYER_INPUT_STREAM	1       (#define SERV_SAT_GS_PROC_INPUT_STREAM		1   ,#define SERV_GS_RLC_LOW_LAYER_INPUT_STREAM	1                                                   �          
   idle   
                     
   (   tvb_pk_rcv_up = OPC_FALSE;   tvb_handover = OPC_FALSE;   tvb_res_alloc = OPC_FALSE;   tvb_pk_handle = OPC_FALSE;       #tvi_intrpt_type = op_intrpt_type();   #tvi_intrpt_code = op_intrpt_code();       (if (tvi_intrpt_type == OPC_INTRPT_MCAST)   {   	   }       ,else if (tvi_intrpt_type == OPC_INTRPT_STRM)   {   1	if (op_intrpt_strm() == HIGH_LAYER_INPUT_STREAM)   		tvb_pk_rcv_up = OPC_TRUE;   5	else if (op_intrpt_strm() == LOW_LAYER_INPUT_STREAM)   	{   +		tvo_pk_ptr = op_pk_get(op_intrpt_strm());   X		//tvo_pk_info_ptr = (FX_Profile_Pk_Type*)op_prg_mem_alloc(sizeof(FX_Profile_Pk_Type));   >		op_pk_nfd_get(tvo_pk_ptr, "traffic info", &tvo_pk_info_ptr);   .		tvi_pk_type = tvo_pk_info_ptr->message_type;   1		tvi_pk_size = op_pk_total_size_get(tvo_pk_ptr);   		op_pk_destroy(tvo_pk_ptr);	       		switch(tvi_pk_type)   .		//switch(tvo_pk_info_ptr_temp->message_type)   		{   .			case DATA_PK_SS :	tvb_pk_handle = OPC_TRUE;   								break;   .			case DATA_PK_GS :	tvb_pk_handle = OPC_TRUE;   								break;   0			case RES_ALLOC_REQ :tvb_res_alloc = OPC_TRUE;   								break;   			default :			break;   		}       	}   }   
           ����             pr_state         �   Z          
   	res_alloc   
       J   )   !tvb_res_alloc_result = OPC_FALSE;   1tvi_rcv_user_id = tvo_pk_info_ptr -> xmt_user_id;       Hfor (tvi_loop = 0; tvi_loop < CONSTANT_UPLINK_TIME_SLOT_NUM; tvi_loop++)   {   D	for (tvi_loop1 = 0; tvi_loop1 < CONSTANT_FREQ_RES_NUM; tvi_loop1++)   9		if (gvi_time_freq_res_block[tvi_loop][tvi_loop1] == -1)   		{   B			gvi_time_freq_res_block[tvi_loop][tvi_loop1] = tvi_rcv_user_id;   #			tvb_res_alloc_result = OPC_TRUE;   				break;   		}   &	if (tvb_res_alloc_result == OPC_TRUE)   		break;   }       Utvo_pk_info_ptr2 = (FX_Profile_Pk_Type*)op_prg_mem_alloc(sizeof(FX_Profile_Pk_Type));   /tvo_pk_info_ptr2->message_type	= RES_ALLOC_RES;   .tvo_pk_info_ptr2->create_time	= op_sim_time();   	   =tvo_pk_info_ptr2->xmt_user_id	= tvo_pk_info_ptr->xmt_user_id;   =tvo_pk_info_ptr2->rcv_user_id	= tvo_pk_info_ptr->rcv_user_id;   6tvo_pk_info_ptr2->pk_size		= tvo_pk_info_ptr->pk_size;       ;tvo_pk_info_ptr2->res_alloc_result		= tvb_res_alloc_result;   0tvo_pk_info_ptr2->res_time_position		= tvi_loop;   1tvo_pk_info_ptr2->res_freq_position		= tvi_loop1;       !op_prg_mem_free(tvo_pk_info_ptr);       9tvo_pk_ptr = op_pk_create_fmt("FX_GS_RLC_Res_Alloc_Res");   �op_pk_nfd_set_ptr(tvo_pk_ptr,"traffic info",tvo_pk_info_ptr2, op_prg_mem_copy_create, op_prg_mem_free, sizeof(FX_Profile_Pk_Type));   :op_pk_nfd_set(tvo_pk_ptr, "rcv user id", tvi_rcv_user_id);       Atvi_serv_sat_user_id = gvo_gs_info[svi_user_id].serv_sat_user_id;   Otvo_serv_sat_gs_proc_objid = gvo_sat_info[tvi_serv_sat_user_id].sat_gs_proc_id;       9tvd_pk_tx_delay = tvi_pk_size/CONSTANT_MAX_PK_SEND_SPEED;   6tvd_pk_prop_delay = CONSTANT_MAX_FEED_LINK_PROP_DEALY;       op_pk_deliver_delayed(tvo_pk_ptr, tvo_serv_sat_gs_proc_objid, SERV_SAT_GS_PROC_INPUT_STREAM,tvd_pk_tx_delay+tvd_pk_prop_delay);   J                     
   ����   
          pr_state        J  J          
   handover   
       
      //�����ǵ�����       //�����Ե������л�����   $//�Ź�վ������ѯ��Ҫ�����л����û�վ   <//���л���Ϣ��������Ҫ���뵽�����ǵ���Ϣ�����͵���Ӧ���û�վ       //���ϲ�����ƽ̨������Ҫ��ɵ�        //���ڰ������¼򵥵ķ����������   H//�Ź�վ��rlc����л���ʼ���һ���򵥵����ݰ������͵���Ӧ���û�վmac��   ;//�յ���Ϣ���û�վmac�㣬�ϵ������ǵ����ӣ����½����������   
                     
   ����   
          pr_state         Z   �          
   init   
                     
      3//get user id of GS, then write it into svi_user_id   tvb_init_fin = OPC_FALSE;   M/* if the system has finished initlization, begin the local initialization */   _if ((op_intrpt_type() == OPC_INTRPT_MCAST) && (op_intrpt_code() == CONSTANT_SIG_GLOBAL_TIMING))   b//if ((op_intrpt_type() == OPC_INTRPT_REMOTE) && (op_intrpt_code() == CONSTANT_SIG_GLOBAL_TIMING))   {   	//get related object ID   	svo_self_objid = op_id_self();   1	svo_node_objid = op_topo_parent(svo_self_objid);   	   	//get user id of this SS   >	op_ima_obj_attr_get(svo_node_objid, "user id", &svi_user_id);   	tvb_init_fin = OPC_TRUE;   }   
       
    ����   
          pr_state        J   Z          
   	pk_handle   
       
   T       "//1.���Դ��������û�վ���������ݰ�   O//�������û�վ�ڱ���LMB�У���ҵ���ת���������û�վ�����û�վ��ҵ��ģ�鴦����   //�������û�վ���ڱ���LMB��   B//���ѯGDB��pk_deliveryת���������Ź�վ���ɱ����Ź�վ��2.���ִ���       *//2.�����Ź�վ���������Ź�վ��������ҵ���   '//��ѯ����LMB����ҵ���ת���������û�վ           K//����3,4�����ڵ�ǰƽ̨�в��迼�ǣ���Ϊ�����û�վ���᷵��һ�����������û�վ   8//3.���������û�վ�����Ľ���ҵ���������绰ҵ��Ļػ���   0//�������û�վ�Ǳ��صģ��򽫻ػ�ת���������û�վ   N//�������û�վ���Ǳ��صģ��򽫻ػ�ת���������Ź�վ�������Ź�վ��4.���ֽ��д���       *//4.���������Ź�վת�����ı����û�վ�Ļػ�   2//���ػ�ת���������û�վ�����û�վ��ҵ��ģ�鴦����       $tvb_is_rcv_user_include = OPC_FALSE;   /tvi_rcv_user_id = tvo_pk_info_ptr->rcv_user_id;   'tvi_pk_size = tvo_pk_info_ptr->pk_size;       9tvd_pk_tx_delay = tvi_pk_size/CONSTANT_MAX_PK_SEND_SPEED;       C//query if the rcv user belongs to this GS, equivalent to query LMB   :for (tvi_loop = 0; tvi_loop < CONSTANT_SS_NUM; tvi_loop++)   K	if (gvo_gs_info[svi_user_id].serv_ss_user_id[tvi_loop] == tvi_rcv_user_id)   	{   %		tvb_is_rcv_user_include = OPC_TRUE;   		break;   	}       Utvo_pk_info_ptr1 = (FX_Profile_Pk_Type*)op_prg_mem_alloc(sizeof(FX_Profile_Pk_Type));   ,tvo_pk_info_ptr1->message_type	= DATA_PK_GS;   =tvo_pk_info_ptr1->create_time	= tvo_pk_info_ptr->create_time;   	   =tvo_pk_info_ptr1->xmt_user_id	= tvo_pk_info_ptr->xmt_user_id;   =tvo_pk_info_ptr1->rcv_user_id	= tvo_pk_info_ptr->rcv_user_id;   6tvo_pk_info_ptr1->pk_size		= tvo_pk_info_ptr->pk_size;       Htvo_pk_info_ptr1->res_alloc_result		= tvo_pk_info_ptr->res_alloc_result;   Jtvo_pk_info_ptr1->res_time_position		= tvo_pk_info_ptr->res_time_position;   Jtvo_pk_info_ptr1->res_freq_position		= tvo_pk_info_ptr->res_freq_position;       !op_prg_mem_free(tvo_pk_info_ptr);       3tvo_pk_ptr = op_pk_create_fmt("FX_GS_RLC_Data_Pk");   �op_pk_nfd_set_ptr(tvo_pk_ptr,"traffic info",tvo_pk_info_ptr1, op_prg_mem_copy_create, op_prg_mem_free, sizeof(FX_Profile_Pk_Type));   :op_pk_nfd_set(tvo_pk_ptr, "rcv user id", tvi_rcv_user_id);   .op_pk_total_size_set(tvo_pk_ptr, tvi_pk_size);       !//the rcv user belongs to this GS   (if (tvb_is_rcv_user_include == OPC_TRUE)   {   B	tvi_serv_sat_user_id = gvo_gs_info[svi_user_id].serv_sat_user_id;   P	tvo_serv_sat_gs_proc_objid = gvo_sat_info[tvi_serv_sat_user_id].sat_gs_proc_id;   	   7	tvd_pk_prop_delay = CONSTANT_MAX_FEED_LINK_PROP_DEALY;   	   �	op_pk_deliver_delayed(tvo_pk_ptr, tvo_serv_sat_gs_proc_objid, SERV_SAT_GS_PROC_INPUT_STREAM,tvd_pk_tx_delay+tvd_pk_prop_delay);   	   	//op_pk_destroy(tvo_pk_ptr);   }       (//the rcv user do not belongs to this GS   R//maybe it belongs to another GS, or maybe it is out of range and belongs to no GS   else   {   %	//the rcv user belongs to another GS   6	//then query this another GS and deliver packet to it   !	//if (tvi_pk_type == DATA_PK_SS)   	if (tvi_pk_type == DATA_PK_SS)   	{   		//equivalent to query GDB   D		tvi_rcv_gs_user_id = gvo_ss_info[tvi_rcv_user_id].serv_gs_user_id;   C		tvo_rcv_gs_rlc_objid = gvo_gs_info[tvi_rcv_gs_user_id].gs_rlc_id;   		   n		op_pk_deliver_delayed(tvo_pk_ptr, tvo_rcv_gs_rlc_objid, SERV_GS_RLC_LOW_LAYER_INPUT_STREAM,tvd_pk_tx_delay);   	   		//op_pk_destroy(tvo_pk_ptr);   	}       C	//the rcv user belongs to no GS, then just leave it and do nothing   }   
                     
   ����   
          pr_state         �  J          
   	pk_rcv_up   
       
      //���ϲ��������ת����MAC��       
                     
   ����   
          pr_state                    ,       ;  8     �          
   tr_11   
       ����          ����          
    ����   
          ����                       pr_transition      	         �   �      �   �   �   �   �   �   �   �          
   tr_12   
       
   default   
       ����          
    ����   
          ����                       pr_transition                �   �      m   �   �   �          
   tr_0   
       
   GS_RLC_INIT_FIN   
       ����          
    ����   
          ����                       pr_transition               �   �      �   i     �          
   tr_22   
       ����          ����          
    ����   
          ����                       pr_transition               �   �        �   �   j          
   tr_23   
       
   	RES_ALLOC   
       ����          
    ����   
          ����                       pr_transition              �   K     7   j     �          
   tr_27   
       ����          ����          
    ����   
          ����                       pr_transition               �        �   �   �  7          
   tr_28   
       
   	PK_RCV_UP   
       ����          
    ����   
          ����                       pr_transition               �        �  /   �   �          
   tr_29   
       ����          ����          
    ����   
          ����                       pr_transition              \          �  ?  2          
   tr_30   
       
   	HAND_OVER   
       ����          
    ����   
          ����                       pr_transition              C   �        �  ;   n          
   tr_31   
       
   	PK_HANDLE   
       ����          
    ����   
          ����                       pr_transition      !         Z   �      R   �   9   �   �   �   g   �          
   tr_33   
       
   default   
       ����          
    ����   
          ����                       pr_transition         "                                    