MIL_3_Tfile_Hdr_ 145A 140A modeler 9 583CE66A 5949D77F 18 zhangyu-PC zhangyu 0 0 none none 0 0 none 9E0147D8 137B 0 0 0 0 0 0 1bcc 1                                                                                                                                                                                                                                                                                                                                                                                            ��g�      @   D   H      M  W  [  _  c  o  s  w  A           	   begsim intrpt         
   ����   
   doc file            	nd_module      endsim intrpt             ����      failure intrpts            disabled      intrpt interval         ԲI�%��}����      priority              ����      recovery intrpts            disabled      subqueue                     count    ���   
   ����   
      list   	���   
          
      super priority             ����             Objid	\svo_self_objid;       Objid	\svo_node_objid;       /* user id of this SS. */   int	\svi_user_id;           
   Boolean	tvb_init_fin;       Packet	*tvo_pk_ptr;       int		tvi_serv_gs_user_id;   int		tvi_pk_size;   )double	tvd_pk_tx_delay;		//transmit delay   .double	tvd_pk_prop_delay;		//propagation delay       Objid	tvo_serv_gs_rlc_objid;      #include	"FX_defs.h"       #define GS2QUEUE	1   #define GS2RT 		0   #define QUEUE2GS	0   #define RR2GS		1       -#define SERV_GS_RLC_LOW_LAYER_INPUT_STREAM		1       7#define SAT_GS_PROC_INIT_FIN	(tvb_init_fin == OPC_TRUE)   _#define FROM_QUEUE				((op_intrpt_type() == OPC_INTRPT_STRM) && (op_intrpt_strm() == QUEUE2GS))   Z#define FROM_GS					((op_intrpt_type() == OPC_INTRPT_STRM) && (op_intrpt_strm() == RR2GS))                                              Z   �          
   init   
                     
      4//get user id of SAT, then write it into svi_user_id   tvb_init_fin = OPC_FALSE;   M/* if the system has finished initlization, begin the local initialization */   _if ((op_intrpt_type() == OPC_INTRPT_MCAST) && (op_intrpt_code() == CONSTANT_SIG_GLOBAL_TIMING))   c//if ((op_intrpt_type() == OPC_INTRPT_REMOTE ) && (op_intrpt_code() == CONSTANT_SIG_GLOBAL_TIMING))   {   	//get related object ID   	svo_self_objid = op_id_self();   1	svo_node_objid = op_topo_parent(svo_self_objid);   	   	//get user id of this SS   >	op_ima_obj_attr_get(svo_node_objid, "user id", &svi_user_id);   	tvb_init_fin = OPC_TRUE;   }   
       
    ����   
          pr_state           �          
   idle   
                                       ����             pr_state           Z          
   
from_queue   
       
      )tvo_pk_ptr = op_pk_get(op_intrpt_strm());   /tvi_pk_size = op_pk_total_size_get(tvo_pk_ptr);       @tvi_serv_gs_user_id = gvo_sat_info[svi_user_id].serv_gs_user_id;   Ctvo_serv_gs_rlc_objid = gvo_gs_info[tvi_serv_gs_user_id].gs_rlc_id;       9tvd_pk_tx_delay = tvi_pk_size/CONSTANT_MAX_PK_SEND_SPEED;   6tvd_pk_prop_delay = CONSTANT_MAX_FEED_LINK_PROP_DEALY;       op_pk_deliver_delayed(tvo_pk_ptr, tvo_serv_gs_rlc_objid, SERV_GS_RLC_LOW_LAYER_INPUT_STREAM,tvd_pk_tx_delay+tvd_pk_prop_delay);       //op_pk_destroy(tvo_pk_ptr);       
                     
   ����   
          pr_state          J          
   from_gs   
       
      )tvo_pk_ptr = op_pk_get(op_intrpt_strm());        op_pk_send(tvo_pk_ptr,GS2QUEUE);       //op_pk_destroy(tvo_pk_ptr);   
                     
   ����   
          pr_state                         �        g     �          
   tr_0   
       ����          ����          
    ����   
          ����                       pr_transition                �   �      l   �     �          
   tr_2   
       
   SAT_GS_PROC_INIT_FIN   
       ����          
    ����   
          ����                       pr_transition               �          �    9          
   tr_3   
       
   FROM_GS   
       ����          
    ����   
          ����                       pr_transition                       8     �          
   tr_4   
       ����          ����          
    ����   
          ����                       pr_transition               �   �        �     j          
   tr_8   
       
   
FROM_QUEUE   
       ����          
    ����   
          ����                       pr_transition              �   �         �  d   �  Z   �     �          
   tr_12   
       
   default   
       ����          
    ����   
          ����                       pr_transition                 a   �      I   �   8   �   �   �   g   �          
   tr_13   
       
   default   
       ����          
    ����   
          ����                       pr_transition                                             