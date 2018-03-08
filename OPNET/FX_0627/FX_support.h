#ifndef _FX_SUPPORT_H_
#define _FX_SUPPORT_H_

#include	<opnet.h>
#include	<math.h>
#include	<time.h>
#include	<stdlib.h>
#include	"FX_defs.h"

//compute distance
extern double fx_gld_distance(const double, const double, const double, const double);

//generate random number
extern double fx_gld_one_rand_num(const double);

//generate k random numbers range in (m,n), store result in a
//fx_glv_multi_rand_nums(int *a, int m, int n, int k)
extern void fx_glv_multi_rand_nums(int *, const int, const int, const int);

#endif