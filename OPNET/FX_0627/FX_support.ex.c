#include "FX_support.h"

//compute distance
double fx_gld_distance(const double x1, const double y1, const double x2, const double y2)
{
	double lvd_distance;

	FIN (fx_global_distance (const double, const double, const double, const double));

	lvd_distance = sqrt (pow ((x1 - x2), 2) + pow((y1 - y2), 2) );
	
	FRET (lvd_distance);
}

//generate random number from 0(inclusive) to para(exclusive)
double fx_gld_one_rand_num(const double para)
{
	double lvd_rand;

	FIN (fx_global_rand(const double));

	lvd_rand = para * (rand()/(RAND_MAX+1.0));

	FRET(lvd_rand);
}

//generate k int random numbers range in [m,n), store result in a
void fx_glv_multi_rand_nums(int *a, const int m, const int n, const int k)
{
    int i,j,t;

    FIN (fx_glv_multi_rand_nums(int *, const int, const int, const int));

    for(i = 0; i < k; )
    {
        // t = (int)( (n-m) * (rand()/(RAND_MAX+1.0)) + m );
        t = rand()%(n-m+1)+m;
        for(j = 0; j < i; j ++)
            if(a[j] == t) break;
        if(j == i)//不重复
            a[i++] = t;//记录随机数。
    }

    FOUT;
}