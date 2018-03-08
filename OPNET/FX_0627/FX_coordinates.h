#ifndef _FX_COORDINATES_H_
#define _FX_COORDINATES_H_

#include <math.h>
#include <stdlib.h>

#define SS_NUM_COUNT	2000
#define GS_NUM_COUNT	40
#define SAT_NUM_COUNT	156
#define X_SPAN			360.0
#define Y_SPAN			180.0
struct node_template
{
	double x_position;
	double y_position;
};

double rand1(double);

struct node_template SS[SS_NUM_COUNT];
struct node_template GS[GS_NUM_COUNT];
struct node_template SAT[SAT_NUM_COUNT];


void set_SS_GS_SAT_Position()
{
	double	temp_x, temp_y, x_step, y_step;
	int i, j;

	/*set SS position*/
	for(i = 0; i < SS_NUM_COUNT; i++)
	{
		temp_x = rand1(X_SPAN) - X_SPAN/2;
		temp_y = rand1(Y_SPAN) - Y_SPAN/2;
		SS[i].x_position = temp_x;
		SS[i].y_position = temp_y;
	}

	/*set GS position*/
	x_step = 45.0;
	y_step = 30.0;
	temp_x = -150.0;
	for(i = 0; i < GS_NUM_COUNT/5; i++)
	{
		temp_y =60.0;
		for (j = 0; j < 5; j++)
		{
			GS[i*5+j].x_position = temp_x;
			GS[i*5+j].y_position = temp_y;
			temp_y -= y_step;
		}
		temp_x += x_step;	
	}

	/*set SAT position*/
	x_step = X_SPAN/13;
	y_step = Y_SPAN/12;
	temp_x = -166.0;
	for(i = 0; i < 13; i++)
	{
		temp_y =85.0;
		for (j = 0; j < 12; j++)
		{
			SAT[i*12+j].x_position = temp_x;
			SAT[i*12+j].y_position = temp_y;
			temp_y -= y_step;
		}
		temp_x += x_step;
	}

	return;
}

double rand1(double para)
{
	return para * rand()/(RAND_MAX+1.0);
}

#endif
