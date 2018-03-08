# -*- coding:utf-8 -*-

'''
@author: ZYU
@file: gen_new_csv.py
@time: 2017/11/05 16:44
'''

import pandas as pd
import numpy as np
from scipy import interpolate

def resample(df, max_length = 50):
	# max_length is the length needed to be resampled to of each segment in time domain
    
    segs = df.seg.unique()[:500]
    row_num = max_length*len(segs)
    cols = df.columns.values
    new_df = pd.DataFrame(data=np.zeros((row_num,6)), columns=cols)

    start = 0
    for seg in segs:
        seg_df = df[df['seg'] == seg]

        raw_x = seg_df['x'].values
        raw_y = seg_df['y'].values
        raw_z = seg_df['z'].values
        raw_index = np.linspace(0, max_length, raw_x.size)

        f_x = interpolate.interp1d(raw_index, raw_x, kind='cubic')
        f_y = interpolate.interp1d(raw_index, raw_y, kind='cubic')
        f_z = interpolate.interp1d(raw_index, raw_z, kind='cubic')

        new_index = np.arange(max_length)
        new_x = f_x(new_index)
        new_y = f_y(new_index)
        new_z = f_z(new_index)
        
        end = start + max_length
        new_df.iloc[start : end, 0] = new_x
        new_df.iloc[start : end, 1] = new_y
        new_df.iloc[start : end, 2] = new_z
        new_df.iloc[start : end, 3] = seg_df.iloc[0, 3]
        new_df.iloc[start : end, 4] = seg
        new_df.iloc[start : end, 5] = seg_df.iloc[0, 5]
        
        start = end
            
    return new_df