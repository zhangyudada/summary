MIL_3_Tfile_Hdr_ 145A 140A modeler 9 57D02793 5949DA69 2F zhangyu-PC zhangyu 0 0 none none 0 0 none F1629142 F7E 0 0 0 0 0 0 1bcc 1                                                                                                                                                                                                                                                                                                                                                                                             ��g�      @   D   H      u  Z  ^  b  f  r  v  z  i           	   begsim intrpt         
   ����   
   doc file            	nd_module      endsim intrpt             ����      failure intrpts            disabled      intrpt interval         ԲI�%��}����      priority              ����      recovery intrpts            disabled      subqueue                     count    ���   
   ����   
      list   	���   
          
      super priority             ����                 int		tvi_serv_ss_user_id;   int		tvi_pk_size;   )double	tvd_pk_tx_delay;		//transmit delay   .double	tvd_pk_prop_delay;		//propagation delay       Objid	tvo_serv_ss_rlc_objid;       Packet	*tvo_pk_ptr;      #include	"FX_defs.h"       #define SS2RT		1   #define SS2QUEUE	0   #define RR2SS		0   #define QUEUE2SS 	1       Z#define FROM_HIGH (op_intrpt_type() == OPC_INTRPT_STRM && (op_intrpt_strm() == QUEUE2SS))    U#define FROM_LOW (op_intrpt_type() == OPC_INTRPT_STRM && (op_intrpt_strm() == RR2SS))       -#define SERV_SS_RLC_LOW_LAYER_INPUT_STREAM		1                                              Z   �          
   init   
                                   
   ����   
          pr_state         �   �          
   idle   
                                       ����             pr_state         �   Z          
   to_usr   
       J      )tvo_pk_ptr = op_pk_get(op_intrpt_strm());   /tvi_pk_size = op_pk_total_size_get(tvo_pk_ptr);       //get the rcv usr id   =op_pk_nfd_get(tvo_pk_ptr,"rcv user id",&tvi_serv_ss_user_id);   Ctvo_serv_ss_rlc_objid = gvo_ss_info[tvi_serv_ss_user_id].ss_rlc_id;       9tvd_pk_tx_delay = tvi_pk_size/CONSTANT_MAX_PK_SEND_SPEED;   6tvd_pk_prop_delay = CONSTANT_MAX_USER_LINK_PROP_DEALY;       op_pk_deliver_delayed(tvo_pk_ptr, tvo_serv_ss_rlc_objid, SERV_SS_RLC_LOW_LAYER_INPUT_STREAM,tvd_pk_tx_delay+tvd_pk_prop_delay);       //op_pk_destroy(tvo_pk_ptr);   J                     
   ����   
          pr_state         �  J          
   from_usr   
       
      )tvo_pk_ptr = op_pk_get(op_intrpt_strm());        op_pk_send(tvo_pk_ptr,SS2QUEUE);       //op_pk_destroy(tvo_pk_ptr);   
                     
   ����   
          pr_state                       �   �      �   s   �   �          
   tr_0   
       ����          ����          
    ����   
          ����                       pr_transition                �   �      l   �   �   �          
   tr_2   
       ����          ����          
    ����   
          ����                       pr_transition               �        �   �   �  6          
   tr_3   
       
   FROM_LOW   
       ����          
    ����   
          ����                       pr_transition               �        �  4   �     �   �          
   tr_4   
       ����          ����          
    ����   
          ����                       pr_transition               �   �      �   �   �   �   �   h          
   tr_8   
       
   	FROM_HIGH   
       ����          
    ����   
          ����                       pr_transition                 �      �   �   �   �      �   �   �   �   �          
   tr_14   
       
   default   
       ����          
    ����   
          ����                       pr_transition                                             