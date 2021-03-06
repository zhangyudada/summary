MIL_3_Tfile_Hdr_ 145A 140A modeler 9 5862198E 59322FE3 4 zhangyu-PC zhangyu 0 0 none none 0 0 none 944CCBC1 1D5E 0 0 0 0 0 0 1bcc 1                                                                                                                                                                                                                                                                                                                                                                                             ��g�      @  9  =    	  �  Z  ^  b  f  �  V  Z  �      service_rate   �������      bits/sec      @��        9,600              ����              ����         9,600   @��     ����         OThe number of bits that can complete service in one second of simulation time. �Z                 	   begsim intrpt         
   ����   
   doc file            	nd_module      endsim intrpt             ����      failure intrpts            disabled      intrpt interval         ԲI�%��}����      priority              ����      recovery intrpts            disabled      subqueue         
            count    ���   
   ����   
      list   	���   
          
   
   super priority             ����             int      \server_busy;   double   \service_rate;   Objid    \own_id;          Packet*          pkptr;   OpT_Packet_Size  pk_len;   double          pk_svc_time;   int             insert_ok;      #define QUE2PROC 0   #define RR2QUE 0   '#define QUEUE_EMPTY     (op_q_empty ())   <#define SVC_COMPLETION  op_intrpt_type () == OPC_INTRPT_SELF   X#define USR_ARRIVAL (op_intrpt_type () == OPC_INTRPT_STRM && op_intrpt_strm() == RR2QUE)                                            	   �   �          
   init   
       
   
   #/* initially the server is idle 	*/   server_busy = 0;       &/* get queue module's own object id	*/   own_id = op_id_self ();     						   #/* get assigned value of server 	*/   /* processing rate 					*/   <op_ima_obj_attr_get (own_id, "service_rate", &service_rate);       
                     
   ����   
          pr_state           �          
   arrival   
       
      %/* acquire the arriving packet 				*/   ./* multiple arriving streams are supported. */   &pkptr = op_pk_get (op_intrpt_strm ());           ,/* attempt to enqueue the packet at tail 	*/   /* of subqueue 0.							*/   ?if (op_subq_pk_insert (0, pkptr, OPC_QPOS_TAIL) != OPC_QINS_OK)       {   +    /* the inserton failed (due to to a 	*/   )	/* full queue) deallocate the packet.	*/       op_pk_destroy (pkptr);       *	/* set flag indicating insertion fail 	*/   '	/* this flag is used to determine 		*/   %	/* transition out of this state 		*/       insert_ok = 0;       }   else{   "	/* insertion was successful 			*/       insert_ok = 1;       }           
                     
   ����   
          pr_state        J            
   idle   
                                       ����             pr_state        �   �          
   	svc_start   
       
      2/* get a handle on packet at head of subqueue 0 */   */* (this does not remove the packet) 			*/   -pkptr = op_subq_pk_access (0, OPC_QPOS_HEAD);       ./* determine the packets length (in bits) 		*/   &pk_len = op_pk_total_size_get (pkptr);       //* determine the time required to complete 		*/   !/* service of the packet 						*/   -pk_svc_time = (double) pk_len / service_rate;       ./* schedule an interrupt for this process 		*/   )/* at the time where service ends. 				*/   :op_intrpt_schedule_self (op_sim_time () + pk_svc_time, 0);       #/* the server is now busy. 						*/   server_busy = 1;           
                     
   ����   
          pr_state        �   �          
   	svc_compl   
       
   
   +/* extract packet at head of queue; this	*/   +/* is the packet just finishing service 	*/   -pkptr = op_subq_pk_remove (0, OPC_QPOS_HEAD);       ./* forward the packet on stream 0, causing 	*/   ,/* an immediate interrupt at destination.	*/   $op_pk_send_forced (pkptr, QUE2PROC);        /* server is idle again. 					*/   server_busy = 0;   
                     
   ����   
          pr_state      	   
       	      �   �      �   �   �   �          
   tr_1   
       
   USR_ARRIVAL   
       ����          
   0����   
       
    ����   
                    pr_transition         	      �        �   �   �   �   �  	  -            
   tr_2   
       
   default   
       ����              ����             ����                       pr_transition              -   h     #   �  H   q  r             
   tr_3   
       
   !server_busy && insert_ok   
       ����          
   0����   
          ����                       pr_transition              +   �     
   �     �  5   �          
   tr_4   
       
   default   
       ����          
   0����   
          ����                       pr_transition               �   �     ,     �   �      �          
   tr_5   
       
   USR_ARRIVAL   
       ����          
   0����   
          ����                       pr_transition              �       d    �   �     �          
   tr_6   
       
   SVC_COMPLETION   
       ����          
   0����   
          ����                       pr_transition              ~   �     y   �  O   �          
   tr_7   
       ����          ����          
   0����   
       
    ����   
                    pr_transition              �   k     �     �   r  �   |          
   tr_8   
       
   !QUEUE_EMPTY   
       ����          
   0����   
          ����                       pr_transition              �   �     �   �  �   �  c   �          
   tr_9   
       
   default   
       ����          
   0����   
          ����                       pr_transition              K  ]     <  "    N  v  N  X            J   tr_13   J       J   default   J       ����          J    ����   J          ����                       pr_transition                           
link_delay           ,   General Process Description:   ----------------------------       �The acb_fifo queuing process model accepts packets from any number of sources and autonomously forwards them to a single destination module after holding each one for a simulated duration referred to as the packet's service time. The service time may vary from packet to packet and is computed by dividing the packet lengths (measured in bits) by the value of the process model attribute "service rate" (given in bits/sec).        �Enqueued packets wait for the completion of earlier arriving packets before they themselves may begin service and eventually be forwarded.  Thus, the queue is said to operate with a first-in-first-out (FIFO) discipline.               ICI Interfaces:    ---------------        None               Packet Formats:    ---------------        None               Statistic Wires:    ----------------        None               Process Registry:    -----------------        Not Applicable               Restrictions:    -------------        G1. The acb_fifo process model must be contained within a queue module.        c2. The source stream index of the output packet stream of the surrounding queue module should be 0.            