MIL_3_Tfile_Hdr_ 145A 140A modeler 9 58CA0021 5965C776 76 zhangyu-PC zhangyu 0 0 none none 0 0 none 12DD954A 2D6F 0 0 0 0 0 0 1bcc 1                                                                                                                                                                                                                                                                                                                                                                                            ��g�      @   D   H      �  +K  +O  +S  +W  +c  +g  +k  �           	   begsim intrpt         
   ����   
   doc file            	nd_module      endsim intrpt             ����      failure intrpts            disabled      intrpt interval         ԲI�%��}����      priority              ����      recovery intrpts            disabled      subqueue                     count    ���   
   ����   
      list   	���   
          
      super priority             ����             Objid	\svo_self_objid;       Objid	\svo_node_objid;       /* user id of this SS. */   int	\svi_user_id;          Boolean	tvb_init_fin;   Boolean	tvb_pk_rcv_up;   Boolean	tvb_res_alloc_req;   Boolean	tvb_res_alloc_handle;   Boolean	tvb_handover_handle;   !Boolean	tvb_random_access_handle;   Boolean	tvb_res_alloc_result;       int		tvi_intrpt_type;   int		tvi_intrpt_code;   int		tvi_serv_sat_user_id;   int		tvi_pk_type;   int		tvi_rcv_user_id;   int		tvi_pk_size;       )double	tvd_pk_tx_delay;		//transmit delay   .double	tvd_pk_prop_delay;		//propagation delay       Packet	*tvo_pk_ptr;       /* packet type pointer */   $FX_Profile_Pk_Type	*tvo_pk_info_ptr;   %FX_Profile_Pk_Type	*tvo_pk_info_ptr1;       #Objid	tvo_serv_sat_ss_proc_0_objid;      #include	"FX_defs.h"       4#define SS_RLC_INIT_FIN			(tvb_init_fin == OPC_TRUE)   0#define PK_RCV_UP				(tvb_pk_rcv_up == OPC_TRUE)   7#define RES_ALLOC_REQ			(tvb_res_alloc_req == OPC_TRUE)   <#define RES_ALLOC_HANDLE		(tvb_res_alloc_handle == OPC_TRUE)   ;#define HANDOVER_HANDLE			(tvb_handover_handle == OPC_TRUE)   C#define RANDOM_ACCESS_HANDLE	(tvb_random_access_handle == OPC_TRUE)       "#define HIGH_LAYER_INPUT_STREAM		0   !#define LOW_LAYER_INPUT_STREAM		1   "#define HIGH_LAYER_OUTPUT_STREAM	1       *#define SERV_SAT_SS_PROC_0_INPUT_STREAM		0   .//#define SERV_GS_RLC_LOW_LAYER_INPUT_STREAM	1                                                  Z            
   init   
       
       
       
      3//get user id of SS, then write it into svi_user_id   tvb_init_fin = OPC_FALSE;   M/* if the system has finished initlization, begin the local initialization */   _if ((op_intrpt_type() == OPC_INTRPT_MCAST) && (op_intrpt_code() == CONSTANT_SIG_GLOBAL_TIMING))   b//if ((op_intrpt_type() == OPC_INTRPT_REMOTE) && (op_intrpt_code() == CONSTANT_SIG_GLOBAL_TIMING))   {   	//get related object ID   	svo_self_objid = op_id_self();   1	svo_node_objid = op_topo_parent(svo_self_objid);   	   	//get user id of this SS   >	op_ima_obj_attr_get(svo_node_objid, "user id", &svi_user_id);   	tvb_init_fin = OPC_TRUE;   }   
       
    ����   
          pr_state                    
   idle   
                     
   6   tvb_pk_rcv_up = OPC_FALSE;   tvb_res_alloc_req = OPC_FALSE;   !tvb_res_alloc_handle = OPC_FALSE;    tvb_handover_handle = OPC_FALSE;   %tvb_random_access_handle = OPC_FALSE;       #tvi_intrpt_type = op_intrpt_type();   #tvi_intrpt_code = op_intrpt_code();       )if (tvi_intrpt_type == OPC_INTRPT_REMOTE)   {	   	if (tvi_intrpt_code >= 0)   	{   =		if (gvo_ss_info[svi_user_id].is_selected_by_ns == OPC_TRUE)   B			if (gvo_ss_info[svi_user_id].is_res_alloc_succeed == OPC_FALSE)   ?				if(gvo_ss_info[svi_user_id].is_res_alloc_send == OPC_FALSE)   "					tvb_res_alloc_req = OPC_TRUE;   	}   }       ,else if (tvi_intrpt_type == OPC_INTRPT_STRM)   {   1	if (op_intrpt_strm() == HIGH_LAYER_INPUT_STREAM)   		tvb_pk_rcv_up = OPC_TRUE;   5	else if (op_intrpt_strm() == LOW_LAYER_INPUT_STREAM)   	{   +		tvo_pk_ptr = op_pk_get(op_intrpt_strm());   >		op_pk_nfd_get(tvo_pk_ptr, "traffic info", &tvo_pk_info_ptr);   0		tvi_pk_type = tvo_pk_info_ptr -> message_type;       		op_pk_destroy(tvo_pk_ptr);       		switch(tvi_pk_type)   		{   			case DATA_PK_GS :	   3				tvi_rcv_user_id = tvo_pk_info_ptr->rcv_user_id;   +				tvi_pk_size = tvo_pk_info_ptr->pk_size;   7				tvo_pk_ptr = op_pk_create_fmt("FX_GS_RLC_Data_Pk");   �				op_pk_nfd_set_ptr(tvo_pk_ptr,"traffic info",tvo_pk_info_ptr, op_prg_mem_copy_create, op_prg_mem_free, sizeof(FX_Profile_Pk_Type));	   >				op_pk_nfd_set(tvo_pk_ptr, "rcv user id", tvi_rcv_user_id);   2				op_pk_total_size_set(tvo_pk_ptr, tvi_pk_size);   5				op_pk_send(tvo_pk_ptr, HIGH_LAYER_OUTPUT_STREAM);   									break;   8			case RES_ALLOC_RES :	tvb_res_alloc_handle = OPC_TRUE;   									break;   9			case HANDOVER_FAILED :	tvb_handover_handle = OPC_TRUE;   									break;   8			case HANDOVER_ORDER :	tvb_handover_handle = OPC_TRUE;   									break;   			default :				break;   		}   	}   		   }   
           ����             pr_state        J  �          
   handover   
       
      //�����ǵ�����       &//���״̬��ƽ̨���ڴ����л���Ϣ��״̬   >//�������Ź�վ���͹������л���Ϣ��������Ҫ���뵽�����ǵ���Ϣ��       7//�ֽ׶ε��л�ʵ�֣����Ź�վrlc������û�վ�����л�����   ///�û�վ��mac���յ������ϵ��뵱ǰ���ǵ�����   &//�����µ�������룬�Ӷ��ﵽ�л���Ŀ��   
                     
   ����   
          pr_state      	   �  �          
   	pk_rcv_up   
       
      ///��ҵ��ģ�鷢����PDU��������SDU����װ�ɱ���PDU       //1.����ҵ��������͵�mac��           //2.����ֹͣ��������ָ���   //IS_RA_FINISHED = false��   )tvo_pk_ptr = op_pk_get(op_intrpt_strm());   /tvi_pk_size = op_pk_total_size_get(tvo_pk_ptr);       Atvi_serv_sat_user_id = gvo_ss_info[svi_user_id].serv_sat_user_id;       Stvo_serv_sat_ss_proc_0_objid = gvo_sat_info[tvi_serv_sat_user_id].sat_ss_proc_0_id;       9tvd_pk_tx_delay = tvi_pk_size/CONSTANT_MAX_PK_SEND_SPEED;   	   6tvd_pk_prop_delay = CONSTANT_MAX_USER_LINK_PROP_DEALY;       �op_pk_deliver_delayed(tvo_pk_ptr, tvo_serv_sat_ss_proc_0_objid, SERV_SAT_SS_PROC_0_INPUT_STREAM, tvd_pk_tx_delay+tvd_pk_prop_delay);   //op_pk_destroy(tvo_pk_ptr);   
                     
   ����   
          pr_state        J   �          
   	res_alloc   
       
      Utvo_pk_info_ptr1 = (FX_Profile_Pk_Type*)op_prg_mem_alloc(sizeof(FX_Profile_Pk_Type));       4//tvo_pk_info_ptr1 -> message_type		= RES_ALLOC_REQ;   6tvo_pk_info_ptr1 -> message_type		= (FX_Packet_Type)0;   2tvo_pk_info_ptr1 -> create_time			= op_sim_time();   0tvo_pk_info_ptr1 -> xmt_user_id			= svi_user_id;   'tvo_pk_info_ptr1 -> rcv_user_id			= -1;   #tvo_pk_info_ptr1 -> pk_size				= 0;   1tvo_pk_info_ptr1 -> res_alloc_result	= OPC_FALSE;   +tvo_pk_info_ptr1 -> res_time_position	= -1;   +tvo_pk_info_ptr1 -> res_freq_position	= -1;       Atvi_serv_sat_user_id = gvo_ss_info[svi_user_id].serv_sat_user_id;   Stvo_serv_sat_ss_proc_0_objid = gvo_sat_info[tvi_serv_sat_user_id].sat_ss_proc_0_id;       9tvo_pk_ptr = op_pk_create_fmt("FX_SS_RLC_Res_Alloc_Req");   �op_pk_nfd_set_ptr(tvo_pk_ptr,"traffic info", tvo_pk_info_ptr1, op_prg_mem_copy_create, op_prg_mem_free, sizeof(FX_Profile_Pk_Type));       /tvi_pk_size = op_pk_total_size_get(tvo_pk_ptr);       :tvd_pk_tx_delay = tvi_pk_size/CONSTANT_MAX_PK_SEND_SPEED;	   6tvd_pk_prop_delay = CONSTANT_MAX_USER_LINK_PROP_DEALY;       �op_pk_deliver_delayed(tvo_pk_ptr, tvo_serv_sat_ss_proc_0_objid, SERV_SAT_SS_PROC_0_INPUT_STREAM, tvd_pk_tx_delay+tvd_pk_prop_delay);       $//op_prg_mem_free(tvo_pk_info_ptr1);       gvi_res_alloc_req_total_num++;       6gvo_ss_info[svi_user_id].is_res_alloc_send = OPC_TRUE;   
                     
   ����   
          pr_state         �   �          
   
random_acc   
       
      //��ٻ������   +//�յ�֡�жϣ�����1�룩������������������   N//Ȼ�����ձ���������Ϣ��ѡ�����ǣ�����������루������������������ָ�����ǣ�       <//���������ɹ�������������ʱ�ӣ��������䵽��CID֪ͨrlc��   0//ͬʱ���ɻ�����Ϣ���Ź�վ���൱����Դ��������   //������ʧ�ܣ��򲻴���       //���漸�е������Ƶ�mac��ʵ��       
//���㹦��   (//�յ�mac������������õ�CID���ݲ�����    //֪ͨ�ϲ�ҵ��ģ�鿪ʼ�������ݰ�   
                     
   ����   
          pr_state        �            
   res_alloc_handle   
       J      ;tvb_res_alloc_result = tvo_pk_info_ptr -> res_alloc_result;   %if (tvb_res_alloc_result == OPC_TRUE)   {   :	gvo_ss_info[svi_user_id].is_res_alloc_succeed = OPC_TRUE;   R	gvo_ss_info[svi_user_id].res_alloc_pos[0] = tvo_pk_info_ptr -> res_time_position;   R	gvo_ss_info[svi_user_id].res_alloc_pos[1] = tvo_pk_info_ptr -> res_freq_position;   	   !	gvi_res_alloc_req_success_num++;   }       else   {   ;	gvo_ss_info[svi_user_id].is_res_alloc_succeed = OPC_FALSE;   8	gvo_ss_info[svi_user_id].is_res_alloc_send = OPC_FALSE;   }       !op_prg_mem_free(tvo_pk_info_ptr);   J                     
   ����   
          pr_state                        �        m     �            
   tr_0   
       
   SS_RLC_INIT_FIN   
       ����          
    ����   
          ����                       pr_transition              2  O     ,  `  %  6          
   tr_4   
       ����          ����          
    ����   
          ����                       pr_transition            	   �  D      �     �  o          
   tr_7   
       
   	PK_RCV_UP   
       ����          
    ����   
          ����                       pr_transition         	      �  K      �  m   �  !          
   tr_11   
       ����          ����          
    ����   
          ����                       pr_transition               �   �      �   �   �   �   �     �            
   tr_12   
       
   default   
       ����          
    ����   
          ����                       pr_transition              .   �     :   �     �          
   tr_19   
       ����          ����          
    ����   
          ����                       pr_transition               �   �      �   �     �          
   tr_2   
       ����          ����          
    ����   
          ����                       pr_transition              P   �        �  A   �          
   tr_25   
       
   RES_ALLOC_REQ   
       ����          
    ����   
          ����                       pr_transition                 U   �      P   �   2   �   {   �   b   �          
   tr_26   
       
   default   
       ����          
    ����   
          ����                       pr_transition              �  w     �    &            
   tr_28   
       ����          ����          
    ����   
          ����                       pr_transition              f  N         @  q          
   tr_29   
       
   HANDOVER_HANDLE   
       ����          
    ����   
          ����                       pr_transition               �   �        �   �   �          
   tr_30   
       
   RANDOM_ACCESS_HANDLE   
       ����          
    ����   
          ����                       pr_transition              �            �            
   tr_31   
       
   RES_ALLOC_HANDLE   
       ����          
    ����   
          ����                       pr_transition                                              