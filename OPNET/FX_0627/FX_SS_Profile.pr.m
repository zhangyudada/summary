MIL_3_Tfile_Hdr_ 145A 140A modeler 9 58CA0021 595B0831 99 zhangyu-PC zhangyu 0 0 none none 0 0 none F1EB5B28 2E19 0 0 0 0 0 0 1bcc 1                                                                                                                                                                                                                                                                                                                                                                                            ��g�      @   D   H      	  ).  )r  +�  ,  ,  ,  ,  	           	   begsim intrpt         
   ����   
   doc file            	nd_module      endsim intrpt             ����      failure intrpts            disabled      intrpt interval         ԲI�%��}����      priority              ����      recovery intrpts            disabled      subqueue                     count    ���   
   ����   
      list   	���   
          
      super priority             ����          '   Objid	\svo_self_objid;       Objid	\svo_node_objid;       Objid	\svo_subnet_objid;       Objid	\svo_network_setup_objid;       /* user id of this SS. */   int	\svi_user_id;       #/* Count total recieved packets. */   int	\svi_thp_pks;       */* total delay of all recieved packets. */   double	\svd_total_pk_delay;       )/* total bits of all recieved packets. */   double	\svd_thp_kbits;       Prohandle *	\child_proc;       ./* Statistic to record single packet delay. */   $Stathandle	\svo_pk_delay_stathandle;       //* Statistic to record average packet delay. */   (Stathandle	\svo_ave_pk_delay_stathandle;       (/* Statistic to record bits received. */   %Stathandle	\svo_thp_kbits_stathandle;       3/* Statistic to record bits received per second. */   $Stathandle	\svo_thp_kbps_stathandle;       +/* Statistic to record packets received. */   #Stathandle	\svo_thp_pks_stathandle;       6/* Statistic to record packets received per second. */   (Stathandle	\svo_thp_pks_rate_stathandle;      Boolean	tvb_init_fin;   Boolean	tvb_pk_send;   Boolean	tvb_pk_handle;       int		tvi_HTTP_selection;   int		tvi_FTP_selection;   int		tvi_NRTV_selection;   int		tvi_FullQueue_selection;   int		tvi_intrpt_type;   int		tvi_intrpt_code;   int		tvi_pk_type;   int		tvi_rcv_user_id;       )/* delay of a single recieved packets. */   double	tvd_pk_delay;   double	tvd_pk_size;       Packet	*tvo_pk_ptr;       /* packet type pointer */   $FX_Profile_Pk_Type	*tvo_pk_info_ptr;       Objid	tvo_comp_attr_id;   $Objid	tvo_comp_traffic_selection_id;      #include	"FX_defs.h"       6#define SS_PROFILE_INIT_FIN	(tvb_init_fin == OPC_TRUE)   ,#define PK_SEND				(tvb_pk_send == OPC_TRUE)   /#define PK_HANDLE			(tvb_pk_handle == OPC_TRUE)                                              Z            
   init   
       
       
       
   $   tvb_init_fin = OPC_FALSE;   M/* if the system has finished initlization, begin the local initialization */   _if ((op_intrpt_type() == OPC_INTRPT_MCAST) && (op_intrpt_code() == CONSTANT_SIG_GLOBAL_TIMING))   b//if ((op_intrpt_type() == OPC_INTRPT_REMOTE) && (op_intrpt_code() == CONSTANT_SIG_GLOBAL_TIMING))   {   	//get related object ID   	svo_self_objid = op_id_self();   1	svo_node_objid = op_topo_parent(svo_self_objid);   3	svo_subnet_objid = op_topo_parent(svo_node_objid);   d	svo_network_setup_objid = op_id_from_name(svo_subnet_objid, OPC_OBJTYPE_NODE_FIX, "Network_Setup");   	   	//get user id of this SS   >	op_ima_obj_attr_get(svo_node_objid, "user id", &svi_user_id);   	    	//initialize related statistics   	svi_thp_pks = 0;   	svd_total_pk_delay = 0.0;   	svd_thp_kbits = 0.0;   	   	//create four child processes   C	child_proc = (Prohandle *)op_prg_mem_alloc(4 * sizeof(Prohandle));   7	child_proc[0] = op_pro_create("FX_App_HTTP", OPC_NIL);   6	child_proc[1] = op_pro_create("FX_App_FTP", OPC_NIL);   7	child_proc[2] = op_pro_create("FX_App_NRTV", OPC_NIL);   <	child_proc[3] = op_pro_create("FX_App_FullQueue", OPC_NIL);       @	//register statistics handle for collecting simulation results    n	svo_pk_delay_stathandle = op_stat_reg("Single packet delay(ms/packet)", OPC_STAT_INDEX_NONE, OPC_STAT_LOCAL);   s	svo_ave_pk_delay_stathandle = op_stat_reg("Average packet delay(ms/packet)", OPC_STAT_INDEX_NONE, OPC_STAT_LOCAL);   m	svo_thp_kbits_stathandle = op_stat_reg("Total bits throughput(kbits)", OPC_STAT_INDEX_NONE, OPC_STAT_LOCAL);   m	svo_thp_kbps_stathandle = op_stat_reg("Average bits throughput(kbps)", OPC_STAT_INDEX_NONE, OPC_STAT_LOCAL);   o	svo_thp_pks_stathandle = op_stat_reg("Total packet throughput(packets)", OPC_STAT_INDEX_NONE, OPC_STAT_LOCAL);   y	svo_thp_pks_rate_stathandle = op_stat_reg("Average packets throughput(packets/s)", OPC_STAT_INDEX_NONE, OPC_STAT_LOCAL);   	   	tvb_init_fin = OPC_TRUE;   }   
       
    ����   
          pr_state                    
   idle   
                     J   *   tvb_pk_send = OPC_FALSE;   tvb_pk_handle = OPC_FALSE;       #tvi_intrpt_type = op_intrpt_type();   #tvi_intrpt_code = op_intrpt_code();   .//tvi_intrpt_code = gvi_glb_frame_intrpt_code;       *//if (tvi_intrpt_type == OPC_INTRPT_MCAST)   )if (tvi_intrpt_type == OPC_INTRPT_REMOTE)   {   	if (tvi_intrpt_code >= 0)   	{   =		if (gvo_ss_info[svi_user_id].is_selected_by_ns == OPC_TRUE)   A			if (gvo_ss_info[svi_user_id].is_res_alloc_succeed == OPC_TRUE)   			{   E				if (tvi_intrpt_code == gvo_ss_info[svi_user_id].res_alloc_pos[0])   					tvb_pk_send = OPC_TRUE;   I				else if (tvi_intrpt_code > gvo_ss_info[svi_user_id].res_alloc_pos[0])   <					gvo_ss_info[svi_user_id].is_selected_by_ns = OPC_FALSE;   			}   	}   }       ,else if (tvi_intrpt_type == OPC_INTRPT_STRM)   {   *	tvo_pk_ptr = op_pk_get(op_intrpt_strm());   W	//tvo_pk_info_ptr = (FX_Profile_Pk_Type*)op_prg_mem_alloc(sizeof(FX_Profile_Pk_Type));   =	op_pk_nfd_get(tvo_pk_ptr, "traffic info", &tvo_pk_info_ptr);   	op_pk_destroy(tvo_pk_ptr);   /	tvi_pk_type = tvo_pk_info_ptr -> message_type;   	switch(tvi_pk_type)   	{   		case DATA_PK_GS :   <			if (gvo_ss_info[svi_user_id].is_pk_handling == OPC_FALSE)   			{   7				gvo_ss_info[svi_user_id].is_pk_handling = OPC_TRUE;   				tvb_pk_handle = OPC_TRUE;   			}   				break;   		default :			break;   	}   }   J           ����             pr_state        �            
   pk_send   
       
   ,   L//generate data packets based on profile type of current simulation scenario   Zop_ima_obj_attr_get(svo_network_setup_objid, "Traffic type selection", &tvo_comp_attr_id);   Ytvo_comp_traffic_selection_id = op_topo_child (tvo_comp_attr_id, OPC_OBJTYPE_GENERIC, 0);       Pop_ima_obj_attr_get(tvo_comp_traffic_selection_id, "HTTP", &tvi_HTTP_selection);   Nop_ima_obj_attr_get(tvo_comp_traffic_selection_id, "FTP", &tvi_FTP_selection);   Pop_ima_obj_attr_get(tvo_comp_traffic_selection_id, "NRTV", &tvi_NRTV_selection);   Zop_ima_obj_attr_get(tvo_comp_traffic_selection_id, "FullQueue", &tvi_FullQueue_selection);       ;if ((tvi_HTTP_selection != 0) && (tvi_HTTP_selection != 1))   {   x	op_sim_end("FX simulation error!", "Please select the Traffic Type.", "1 for selecting that and 0 for none!", OPC_NIL);   }   9if ((tvi_FTP_selection != 0) && (tvi_FTP_selection != 1))   {   x	op_sim_end("FX simulation error!", "Please select the Traffic Type.", "1 for selecting that and 0 for none!", OPC_NIL);   }   ;if ((tvi_NRTV_selection != 0) && (tvi_NRTV_selection != 1))   {   x	op_sim_end("FX simulation error!", "Please select the Traffic Type.", "1 for selecting that and 0 for none!", OPC_NIL);   }   Eif ((tvi_FullQueue_selection != 0) && (tvi_FullQueue_selection != 1))   {   �	op_sim_end("FX FullQueue simulation error!", "Please select the Traffic Type.", "1 for selecting that and 0 for none!", OPC_NIL);   }           if (tvi_HTTP_selection == 1)   {   (	op_pro_invoke(child_proc[0], OPC_NIL) ;   }       if (tvi_FTP_selection == 1)   {   (	op_pro_invoke(child_proc[1], OPC_NIL) ;   }   if (tvi_NRTV_selection == 1)   {   (	op_pro_invoke(child_proc[2], OPC_NIL) ;   }   !if (tvi_FullQueue_selection == 1)   {   (	op_pro_invoke(child_proc[3], OPC_NIL) ;   }   
                     
   ����   
          pr_state        J   �          
   	pk_handle   
       
      //handle data packet from GS   5//destroy it and then write it into related statistic   =//op_pk_nfd_get(tvo_pk_ptr, "rcv user id", &tvi_rcv_user_id);   1tvi_rcv_user_id = tvo_pk_info_ptr -> rcv_user_id;   #if (tvi_rcv_user_id == svi_user_id)   {   F	//tvd_pk_delay = op_sim_time() - op_pk_creation_time_get(tvo_pk_ptr);   ?	tvd_pk_delay = op_sim_time() - tvo_pk_info_ptr -> create_time;   6	//op_pk_nfd_get(tvo_pk_ptr, "pk size", &tvd_pk_size);   *	tvd_pk_size = tvo_pk_info_ptr -> pk_size;   	++svi_thp_pks;   $	svd_total_pk_delay += tvd_pk_delay;   #	svd_thp_kbits += tvd_pk_size/1000;   	   	//op_pk_destroy(tvo_pk_ptr);   	   =	op_stat_write(svo_pk_delay_stathandle, tvd_pk_delay * 1000);   U	op_stat_write(svo_ave_pk_delay_stathandle, svd_total_pk_delay / svi_thp_pks * 1000);   8	op_stat_write(svo_thp_kbits_stathandle, svd_thp_kbits);   G	op_stat_write(svo_thp_kbps_stathandle, svd_thp_kbits / op_sim_time());   4	op_stat_write(svo_thp_pks_stathandle, svi_thp_pks);   I	op_stat_write(svo_thp_pks_rate_stathandle, svi_thp_pks / op_sim_time());   	   	++gvi_ss_pk_send_success_num;   )	++gvi_ss_pk_send_success_num_superframe;   )	//the follow sentences may be MT-unsafe?   ,	gvd_ss_pk_send_total_delay += tvd_pk_delay;   /	gvd_ss_pk_send_thp_kbits += tvd_pk_size/1000;	   }   
                     
   ����   
          pr_state                        �        l     �            
   tr_0   
       
   SS_PROFILE_INIT_FIN   
       ����          
    ����   
          ����                       pr_transition              N       q                
   tr_2   
       ����          ����          
    ����   
          ����                       pr_transition              2   �     :   �     �          
   tr_23   
       ����          ����          
    ����   
          ����                       pr_transition               �   �      �   �   �   �   �   �   �            
   tr_25   
       
   default   
       ����          
    ����   
          ����                       pr_transition      !        P  F          N  1  s            
   tr_33   
       
   PK_SEND   
       ����          
    ����   
          ����                       pr_transition      #        P   �        �     �  C   �          
   tr_35   
       
   	PK_HANDLE   
       ����          
    ����   
          ����                       pr_transition      $           O   �      O   �   ,   �   y   �   d   �          
   tr_36   
       
   default   
       ����          
    ����   
          ����                       pr_transition         %      
FX_App_FTP   FX_App_FullQueue   FX_App_HTTP   FX_App_NRTV      Single packet delay(ms/packet)          "Delay of a single received packet.������������        ԲI�%��}   Average packet delay(ms/packet)          &Average delay of all received packets.������������        ԲI�%��}   Total bits throughput(kbits)          Number of bits received.������������        ԲI�%��}   Average bits throughput(kbps)          #Number of bits received per second.������������        ԲI�%��}    Total packet throughput(packets)          Number of packets received.������������        ԲI�%��}   %Average packets throughput(packets/s)          &Number of packets received per second.������������        ԲI�%��}                            