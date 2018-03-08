#include <opnet.h>
#include <ema.h>
#include <opnet_emadefs.h>
#include <opnet_constants.h>
#include <stdlib.h>
#include <time.h>
#include "FX_coordinates.h"

/* array for all textlist attributes in model */
Prg_List*		prg_lptr [5];

/* array for all objects in model */
EmaT_Object_Id		obj [8+ 1+SS_NUM_COUNT+GS_NUM_COUNT+SAT_NUM_COUNT];



int
main (int argc, char* argv [])
	{
	EmaT_Model_Id			model_id;
	int					i;
	char			tempname[50];

	/* initialize EMA package */
	Ema_Init (EMAC_MODE_ERR_PRINT | EMAC_MODE_REL_60, argc, argv);

	/* create an empty model */
	model_id = Ema_Model_Create (MOD_NETWORK);


	/* create all objects */
	obj [0] = Ema_Object_Create (model_id, OBJ_NT_SUBNET_FIX);
	obj [1] = Ema_Object_Create (model_id, OBJ_NT_SUBNET_VIEW);
	obj [2] = Ema_Object_Create (model_id, OBJ_NT_ANNOT_TEXT);
	obj [3] = Ema_Object_Create (model_id, OBJ_NT_ISO_ELEV_MAP_COLOR_SETTING);
	obj [4] = Ema_Object_Create (model_id, OBJ_NT_ISO_ELEV_MAP_COLOR_SETTING);
	obj [5] = Ema_Object_Create (model_id, OBJ_NT_ISO_ELEV_MAP_COLOR_SETTING);
	obj [6] = Ema_Object_Create (model_id, OBJ_NT_ISO_ELEV_MAP_COLOR_SETTING);
	obj [7] = Ema_Object_Create (model_id, OBJ_NT_ISO_ELEV_MAP_COLOR_SETTING);

	/*create user objects*/
	obj [8] = Ema_Object_Create (model_id, OBJ_NT_NODE_FIXED);

	for (i = 0; i < SS_NUM_COUNT; i++)
	{
		obj [9+i] = Ema_Object_Create (model_id, OBJ_NT_NODE_FIXED);
	}

	for (i = 0; i < GS_NUM_COUNT; i++)
	{
		obj [9+SS_NUM_COUNT+i] = Ema_Object_Create (model_id, OBJ_NT_NODE_FIXED);
	}

	for (i = 0; i < SAT_NUM_COUNT; i++)
	{
		obj [9+SS_NUM_COUNT+GS_NUM_COUNT+i] = Ema_Object_Create (model_id, OBJ_NT_NODE_SAT);
	}


	set_SS_GS_SAT_Position();


	/* set the model level attributes */
	/* create and init prg list 'prg_lptr [0]' */
	prg_lptr [0] = (Prg_List *)prg_list_create ();
	/* create and init prg list 'prg_lptr [1]' */
	prg_lptr [1] = (Prg_List *)prg_list_create ();
	prg_list_strings_append (prg_lptr [1], 
		"custom_model_list",
		"FX_0424",
		PRGC_NIL);

	/* create and init prg list 'prg_lptr [2]' */
	prg_lptr [2] = (Prg_List *)prg_list_create ();
	Ema_Model_Attr_Set (model_id,
		"ext fileset",          COMP_CONTENTS, prg_lptr [0],
		"keywords list",        COMP_CONTENTS, prg_lptr [1],
		"view subnet",          COMP_CONTENTS, obj [0],
		"tmm propagation models",COMP_INTENDED, EMAC_DISABLED,
		"iso elev map color levels",COMP_ARRAY_CONTENTS (0), obj [3],
		"iso elev map color levels",COMP_ARRAY_CONTENTS (1), obj [4],
		"iso elev map color levels",COMP_ARRAY_CONTENTS (2), obj [5],
		"iso elev map color levels",COMP_ARRAY_CONTENTS (3), obj [6],
		"iso elev map color levels",COMP_ARRAY_CONTENTS (4), obj [7],
		"iso elev map label color",COMP_CONTENTS, 0,
		"view index list",      COMP_CONTENTS, prg_lptr [2],
		EMAC_EOL);



	/* assign attrs for object 'obj [0]' */
	/* create and init prg list 'prg_lptr [3]' */
	prg_lptr [3] = (Prg_List *)prg_list_create ();
	Ema_Object_Attr_Set (model_id, obj [0], 
		"name",                 COMP_CONTENTS, "top",
		"x position",           COMP_CONTENTS, (double) 0,
		"y position",           COMP_CONTENTS, (double) 0,
		"x span",               COMP_CONTENTS, (double) 360,
		"y span",               COMP_CONTENTS, (double) 180,
		"icon name",            COMP_CONTENTS, "subnet",
		"icon name",            COMP_INTENDED, EMAC_DISABLED,
		"map",                  COMP_CONTENTS, "world",
		"subnet",               COMP_CONTENTS, EMAC_NULL_OBJ_ID,
		"view stack",           COMP_ARRAY_CONTENTS (0), obj [1],
		"grid unit",            COMP_CONTENTS, 5,
		"grid division",        COMP_CONTENTS, (double) 15,
		"grid resolution",      COMP_CONTENTS, (double) 2.5,
		"grid style",           COMP_CONTENTS, 2,
		"grid color",           COMP_CONTENTS, 21,
		"ui status",            COMP_CONTENTS, 0,
		"iso-elev-map list",    COMP_CONTENTS, prg_lptr [3],
		"iso-elev-map line threshold",COMP_CONTENTS, (double) 50,
		"view",                 COMP_CONTENTS, "Default View",
		"view mode",            COMP_CONTENTS, 0,
		"view positions",       COMP_INTENDED, EMAC_DISABLED,
		EMAC_EOL);


/* assign attrs for object 'obj [1]' */
	Ema_Object_Attr_Set (model_id, obj [1], 
		"min x",                COMP_CONTENTS, (double) -134.164716879633,
		"min y",                COMP_CONTENTS, (double) 45.7452438837839,
		"sbar x",               COMP_CONTENTS, (double) 0,
		"sbar y",               COMP_CONTENTS, (double) 0,
		"grid step",            COMP_CONTENTS, (double) 15,
		"resolution",           COMP_CONTENTS, (double) 2.5,
		"grid style",           COMP_CONTENTS, 2,
		"grid color",           COMP_CONTENTS, 21,
		EMAC_EOL);


	/* assign attrs for object 'obj [2]' */
	/* create and init prg list 'prg_lptr [4]' */
	prg_lptr [4] = (Prg_List *)prg_list_create ();
	prg_list_strings_append (prg_lptr [4], 
		"FX satellite communication system network layer",
		PRGC_NIL);

	Ema_Object_Attr_Set (model_id, obj [2], 
		"name",                 COMP_CONTENTS, "FX_text_0",
		"text",                 COMP_CONTENTS, prg_lptr [4],
		"color",                COMP_CONTENTS, 5,
		"color",                COMP_INTENDED, EMAC_DISABLED,
		"x position",           COMP_CONTENTS, (double) 0,
		"y position",           COMP_CONTENTS, (double) -70,
		"width",                COMP_CONTENTS, (double) 45,
		"height",               COMP_CONTENTS, (double) 10,
		"subnet",               COMP_CONTENTS, obj [0],
		"annot rect view positions",COMP_INTENDED, EMAC_DISABLED,
		EMAC_EOL);


	/* assign attrs for object 'obj [3]' */
	Ema_Object_Attr_Set (model_id, obj [3], 
		"elevation",            COMP_CONTENTS, (double) 1e+100,
		"color",                COMP_CONTENTS, 1090519039,
		EMAC_EOL);


	/* assign attrs for object 'obj [4]' */
	Ema_Object_Attr_Set (model_id, obj [4], 
		"elevation",            COMP_CONTENTS, (double) 5000,
		"color",                COMP_CONTENTS, 1073741824,
		EMAC_EOL);


	/* assign attrs for object 'obj [5]' */
	Ema_Object_Attr_Set (model_id, obj [5], 
		"elevation",            COMP_CONTENTS, (double) 3000,
		"color",                COMP_CONTENTS, 1086806624,
		EMAC_EOL);


	/* assign attrs for object 'obj [6]' */
	Ema_Object_Attr_Set (model_id, obj [6], 
		"elevation",            COMP_CONTENTS, (double) 1000,
		"color",                COMP_CONTENTS, 1073745152,
		EMAC_EOL);


	/* assign attrs for object 'obj [7]' */
	Ema_Object_Attr_Set (model_id, obj [7], 
		"elevation",            COMP_CONTENTS, (double) 1,
		"color",                COMP_CONTENTS, 1079591136,
		EMAC_EOL);


	/* assign attrs for object 'obj [8]' */
	Ema_Object_Attr_Set (model_id, obj [8], 
		"name",                 COMP_CONTENTS, "Network_Setup",
		// "name",                 COMP_USER_INTENDED, EMAC_ENABLED,
		"model",                COMP_CONTENTS, "FX_Network_Init",
		// "model",                COMP_USER_INTENDED, EMAC_ENABLED,
		"user id",              COMP_CONTENTS, 8,
		"user id",              COMP_USER_INTENDED, EMAC_ENABLED,
		"x position",           COMP_CONTENTS, (double) 0,
		// "x position",           COMP_USER_INTENDED, EMAC_ENABLED,
		"y position",           COMP_CONTENTS, (double) 0,
		// "y position",           COMP_USER_INTENDED, EMAC_ENABLED,
		"threshold",            COMP_CONTENTS, (double) 0,
		// "threshold",            COMP_USER_INTENDED, EMAC_ENABLED,
		"icon name",           	COMP_CONTENTS, "util_app",
		// "icon name",            COMP_USER_INTENDED, EMAC_ENABLED,
		"doc file",             COMP_CONTENTS, "",
		"doc file",             COMP_INTENDED, EMAC_DISABLED,
		// "doc file",             COMP_USER_INTENDED, EMAC_ENABLED,
		"subnet",               COMP_CONTENTS, obj [0],
		"alias",                COMP_INTENDED, EMAC_DISABLED,
		"tooltip",              COMP_CONTENTS, "",
		// "tooltip",              COMP_INTENDED, EMAC_DISABLED,
		// "tooltip",              COMP_USER_INTENDED, EMAC_ENABLED,
		"ui status",            COMP_CONTENTS, 0,
		"view positions",       COMP_INTENDED, EMAC_DISABLED,
		EMAC_EOL);


	for (i = 0; i < SS_NUM_COUNT; i++)
		{
			sprintf(tempname, "SS_%i",i);
			Ema_Object_Attr_Set (model_id, obj [9+i], 
			"name",                 COMP_CONTENTS, tempname,
			// "name",                 COMP_USER_INTENDED, EMAC_ENABLED,
			"model",                COMP_CONTENTS, "FX_SS",
			// "model",                COMP_USER_INTENDED, EMAC_ENABLED,
			"user id",              COMP_CONTENTS, i,
			"user id",              COMP_USER_INTENDED, EMAC_ENABLED,
			"x position",           COMP_CONTENTS, (double) SS[i].x_position,
			// "x position",           COMP_USER_INTENDED, EMAC_ENABLED,
			"y position",           COMP_CONTENTS, (double) SS[i].y_position,
			// "y position",           COMP_USER_INTENDED, EMAC_ENABLED,
			"threshold",            COMP_CONTENTS, (double) 0,
			// "threshold",            COMP_USER_INTENDED, EMAC_ENABLED,
			"doc file",             COMP_CONTENTS, "",
			"doc file",             COMP_INTENDED, EMAC_DISABLED,
			// "doc file",             COMP_USER_INTENDED, EMAC_ENABLED,
			"subnet",               COMP_CONTENTS, obj [0],
			"alias",                COMP_INTENDED, EMAC_DISABLED,
			"tooltip",              COMP_CONTENTS, "",
			// "tooltip",              COMP_INTENDED, EMAC_DISABLED,
			// "tooltip",              COMP_USER_INTENDED, EMAC_ENABLED,
			"ui status",            COMP_CONTENTS, 0,
			"view positions",       COMP_INTENDED, EMAC_DISABLED,
			EMAC_EOL);
		}

		for (i = 0; i < GS_NUM_COUNT; i++)
		{
			sprintf(tempname, "GS_%i",i);
			Ema_Object_Attr_Set (model_id, obj [9+SS_NUM_COUNT+i], 
			"name",                 COMP_CONTENTS, tempname,
			// "name",                 COMP_USER_INTENDED, EMAC_ENABLED,
			"model",                COMP_CONTENTS, "FX_GS",
			// "model",                COMP_USER_INTENDED, EMAC_ENABLED,
			"user id",              COMP_CONTENTS, i,
			"user id",              COMP_USER_INTENDED, EMAC_ENABLED,
			"x position",           COMP_CONTENTS, (double) GS[i].x_position,
			// "x position",           COMP_USER_INTENDED, EMAC_ENABLED,
			"y position",           COMP_CONTENTS, (double) GS[i].y_position,
			// "y position",           COMP_USER_INTENDED, EMAC_ENABLED,
			"threshold",            COMP_CONTENTS, (double) 0.05,
			// "threshold",            COMP_USER_INTENDED, EMAC_ENABLED,
			"doc file",             COMP_CONTENTS, "",
			"doc file",             COMP_INTENDED, EMAC_DISABLED,
			// "doc file",             COMP_USER_INTENDED, EMAC_ENABLED,
			"subnet",               COMP_CONTENTS, obj [0],
			"alias",                COMP_INTENDED, EMAC_DISABLED,
			"tooltip",              COMP_CONTENTS, "",
			// "tooltip",              COMP_INTENDED, EMAC_DISABLED,
			// "tooltip",              COMP_USER_INTENDED, EMAC_ENABLED,
			"ui status",            COMP_CONTENTS, 0,
			"view positions",       COMP_INTENDED, EMAC_DISABLED,
			EMAC_EOL);
		}

		for (i = 0; i < SAT_NUM_COUNT; i++)
		{
			sprintf(tempname, "SAT_%i",i);
			Ema_Object_Attr_Set (model_id, obj [9+SS_NUM_COUNT+GS_NUM_COUNT+i], 
			"name",                 COMP_CONTENTS, tempname,
			// "name",                 COMP_USER_INTENDED, EMAC_ENABLED,
			"model",                COMP_CONTENTS, "FX_SAT",
			// "model",                COMP_USER_INTENDED, EMAC_ENABLED,
			"user id",              COMP_CONTENTS, i,
			"user id",              COMP_USER_INTENDED, EMAC_ENABLED,
			"x position",           COMP_CONTENTS, (double) SAT[i].x_position,
			// "x position",           COMP_USER_INTENDED, EMAC_ENABLED,
			"y position",           COMP_CONTENTS, (double) SAT[i].y_position,
			// "y position",           COMP_USER_INTENDED, EMAC_ENABLED,
			"threshold",            COMP_CONTENTS, (double) 0.05,
			// "threshold",            COMP_USER_INTENDED, EMAC_ENABLED,
			// "orbit",                COMP_CONTENTS, "Satellite211",
			// "orbit",                COMP_USER_INTENDED, EMAC_ENABLED,
			"doc file",             COMP_CONTENTS, "",
			"doc file",             COMP_INTENDED, EMAC_DISABLED,
			// "doc file",             COMP_USER_INTENDED, EMAC_ENABLED,
			"subnet",               COMP_CONTENTS, obj [0],
			"alias",                COMP_INTENDED, EMAC_DISABLED,
			"tooltip",              COMP_CONTENTS, "",
			// "tooltip",              COMP_INTENDED, EMAC_DISABLED,
			// "tooltip",              COMP_USER_INTENDED, EMAC_ENABLED,
			"ui status",            COMP_CONTENTS, 0,
			"view positions",       COMP_INTENDED, EMAC_DISABLED,
			EMAC_EOL);
		}


	/* write the model to application-readable form */
	sprintf(tempname, "FX_%i_sat_%i_gs_%i_ss",SAT_NUM_COUNT, GS_NUM_COUNT, SS_NUM_COUNT);
	Ema_Model_Write (model_id, tempname);

	return 0;
	}

