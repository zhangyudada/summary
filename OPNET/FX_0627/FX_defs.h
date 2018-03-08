#ifndef _FX_GLOBAL_VARIABLES_H_
#define _FX_GLOBAL_VARIABLES_H_

#include	<opnet.h>
#include	<math.h>
#include	<time.h>
#include	<stdlib.h>

/*-------------------
1. macros declaration
-------------------*/

//multicast intrupt code
#define CONSTANT_SIG_GLOBAL_TIMING		-1

//system minimum time slot, i.e. length of uplink time slot
//length of downlink time slot is five times of this macro
#define CONSTANT_25_ms  				25.0e-3

//number of nodes
#define CONSTANT_SS_NUM					1000
#define CONSTANT_GS_NUM					2
#define CONSTANT_SAT_NUM				2

//profile intensity of current simulation scenario
//i.e. ratio of SS be selected every time slot
//#define	CONSTANT_PROFILE_INTENSITY		0.05

//number of time slots in a uplink superframe
#define CONSTANT_UPLINK_TIME_SLOT_NUM	40
//number of maximum frequency resources in a time slot
#define CONSTANT_FREQ_RES_NUM			24

#define	CONSTANT_MAX_USER_LINK_PROP_DEALY	6.963e-3
#define	CONSTANT_MAX_FEED_LINK_PROP_DEALY	9.463e-3

#define CONSTANT_MAX_PK_SEND_SPEED			1e6

/*----------------------------
2. data structures declaration
----------------------------*/

/*-----type : enum-----*/

//packet type
typedef enum FX_Packet_Type
{
	//random access packet type
	//RANDOM_ACCESS_REQ,		//request
	//RANDOM_ACCESS_RES,		//response
	//RANDOM_ACCESS_CID,		//CID
	//RANDOM_ACCESS_FDB,		//feedback
	//PK_SEND_BGN,			//inform upper layer begin to send packet

	//resource allocation packet type
	RES_ALLOC_REQ,			//request
	RES_ALLOC_RES,			//response

	//data packet type
	DATA_PK_SS,				//packet sent by SS
	DATA_PK_GS,				//packet sent by GS

	//handover packet type
	HANDOVER_FAILED,
	HANDOVER_ORDER			//order SS to begin handover
}FX_Packet_Type;

//traffic type
typedef enum FX_Traffic_Type
{
	FullQueue,
	HTTP,
	FTP,
	NRTV			//None real time video
}FX_Traffic_Type;

/*-----type : struct-----*/

//SS information 
typedef struct FX_SS_Info_struct
{
	//Object ID of different modules in SS
	Objid		ss_id;
	Objid		ss_profile_id;
	Objid		ss_rlc_id;
	Objid		ss_mac_id;
	Objid		ss_mac_phy_api_id;
	//cartesian coordinate of SS
	double		x_position;
	double		y_position;
	//SS user id
	int			ss_user_id;
	//serving GS user id
	int			serv_gs_user_id;
	//serving SAT user id
	int			serv_sat_user_id;
	//profile type
	int 		profile_type;
	//wheather a SS is handling packet in current time slot
	Boolean		is_pk_handling;
	//whether a SS is selected by Network_Setup node in every time slot
	Boolean		is_selected_by_ns;
	//whether a SS performs random access successfully
	Boolean		is_random_access_succeed;
	//whether there is a resource block be allocated to this SS or not
	Boolean 	is_res_alloc_succeed;
	//whether a SS is refused to be allocated a resource block, default value is OPC_FALSE
	Boolean		is_res_alloc_send;
	//position of time frequency resource block allocted to this SS
	//i.e. X&Y ordinates of this SS in matrix gvi_time_freq_res_block[][]
	//default values should be -1 which indicates that there is no resource block be allocated to this SS
	int 		res_alloc_pos[2];
}FX_SS_Info_struct;

//GS information
typedef struct FX_GS_Info_struct
{
	//Object ID of different modules in GS
	Objid	    gs_id;
	Objid		gs_rlc_id;
	Objid		gs_mac_id;
	//cartesian coordinate of GS
	double		x_position;
	double		y_position;
	//GS user id
	int			gs_user_id;
	// //number of satellite connetted to this GS
	// int 		serv_sat_num;
	//serving SAT user id
	int			serv_sat_user_id;
	//serving SS user id, i.e. LMB, default values are -1
	int			serv_ss_user_id[CONSTANT_SS_NUM];
}FX_GS_Info_struct;

//SAT information
typedef struct FX_SAT_Info_struct
{
	//Object ID of different modules in SAT
	Objid	    sat_id;
	Objid		sat_queue_id;
	Objid		sat_ss_proc_0_id;
	Objid		sat_gs_proc_id;
	//cartesian coordinate of SAT
	double		x_position;
	double		y_position;
	//SAT user id
	int			sat_user_id;
	//serving GS user id
	int			serv_gs_user_id;
	//number of being severed ss by this satellite
	int 		serv_ss_num;
	//max num of being severed ss by satellite
	//default value is 100
	int 		serv_max_ss_num;
	//whether this satllite have serverd enough ss already
	Boolean		is_sat_saturated;
}FX_SAT_Info_struct;

//traffic packet type which is generated in the profile layer of each SS
//and is inserted into the list in each SS's profile buffer
typedef struct FX_Profile_Pk_Type
{
	//FX_Traffic_Type		traffic_type;
	FX_Packet_Type		message_type;
	double				create_time;			//this generated pkt's gen time
	//int					session_id;				//session ID
	//int					pkt_call_num_in_session;
	//int					pkt_call_id;			//packet call ID in current session
	//int					pkt_call_index;			//packet call ID in all sessions			
	//int					pkt_num_in_pkt_call;	//packet number in current packet call
	//int					pkt_id;					//packet ID in curren packet call
	int 				xmt_user_id;
	int 				rcv_user_id;
	int					pk_size;				//in bits

	Boolean				res_alloc_result;
	int 				res_time_position;
	int 				res_freq_position;
}FX_Profile_Pk_Type;


/*-----------------------------
3. global variables declaration
-----------------------------*/

//global frame intrupt code, begins from 0, ranges from 0 to 39
int 		gvi_glb_frame_intrpt_code;

//2D matrix, record each time frequency resource block in a superframe is taken by which SS
//when this matrix is initialized, all values should be -1
int 		gvi_time_freq_res_block[CONSTANT_UPLINK_TIME_SLOT_NUM][CONSTANT_FREQ_RES_NUM];

/*************************************************
global variables used to record related statistics 
on resources allocte in a superframe(i.e. 1 second)
*************************************************/
//total number of packets sent by SS in a superframe
int 		gvi_res_alloc_req_total_num;
//number of packets sent successfully by SS in a superframe
int 		gvi_res_alloc_req_success_num;
//gvd_res_alloc_req_success_rate = \
//gvi_res_alloc_req_success_num / gvi_res_alloc_req_total_num
double 		gvd_res_alloc_req_success_rate;

/*************************************************
global variables used to record related statistics 
on packets send in a superframe(i.e. 1 second)
*************************************************/
//total number of packets sent by SS in the whole simulation time
int 		gvi_ss_pk_send_total_num;
//number of packets sent successfully by SS in the whole simulation time
int 		gvi_ss_pk_send_success_num;
//number of packets sent successfully by SS in a superframe
int 		gvi_ss_pk_send_success_num_superframe;
// //gvd_pk_send_success_rate = gvi_ss_pk_send_success_num / gvi_ss_pk_send_total_num
// double 		gvd_ss_pk_send_success_rate;
//total delay of packets sent by SS in the whole simulation time
double 		gvd_ss_pk_send_total_delay;
// //gvd_ss_pk_send_ave_delay = gvd_ss_pk_send_total_delay / gvi_ss_pk_send_success_num
// double 		gvd_ss_pk_send_ave_delay;
//total size of packets sent successfully by SS in the whole simulation time
double 		gvd_ss_pk_send_thp_kbits;
//gvd_time_freq_res_use_rate = \
//gvi_ss_pk_send_success_num / (CONSTANT_UPLINK_TIME_SLOT_NUM*CONSTANT_FREQ_RES_NUM)
double 		gvd_time_freq_res_use_rate;

/*************************************************
global variables used to record related statistics 
on handover in a superframe(i.e. 1 second)
*************************************************/
//total number of handover in a superframe
int 		gvi_handover_total_num;
//number of handover successfully in a superframe
int 		gvi_handover_success_num;
//gvd_handover_success_rate = \
//gvi_handover_success_num / gvi_handover_total_num
double 		gvd_handover_success_rate;

//Object ID of module 'Initialization' in node 'Network Setup'
Objid					gvo_ns_init_id;
//store SS information, size:[CONSTANT_SS_NUM]
FX_SS_Info_struct		*gvo_ss_info;
//store GS information, size:[CONSTANT_GS_NUM]
FX_GS_Info_struct		*gvo_gs_info;
//store SAT information, size:[CONSTANT_SAT_NUM]
FX_SAT_Info_struct		*gvo_sat_info;

//each SS's service profile, size=CONSTANT_SS_NUM
Sbhandle				*gvo_ul_profile_buf;				

#endif