# -*- coding: utf-8 -*-
"""
Created on 2017-12-21 15:17:08

@author: zhangyu
"""

import pandas as pd
import numpy as np
import scipy.signal as signal

# convert time domain data to frequency domain data
def time2freq(df, fft_size = 50, max_length = 26):
    # the length of each segment in time domain is 50
	# so the length of each segment in frequency domain is 50/2+1=26
	# max_length is the length of each segment in frequency domain
    
    segs = df.seg.unique()[:500]
    row_num = max_length*len(segs)
    cols = df.columns.values
    new_df = pd.DataFrame(data=np.zeros((row_num,6)), columns=cols)

    start = 0
    for seg in segs:
        seg_df = df[df['seg'] == seg]

        x = seg_df['x'].values
        y = seg_df['y'].values
        z = seg_df['z'].values
        
        xf = np.fft.rfft(x * signal.hann(fft_size, sym=0) * 2)/fft_size
        yf = np.fft.rfft(y * signal.hann(fft_size, sym=0) * 2)/fft_size
        zf = np.fft.rfft(z * signal.hann(fft_size, sym=0) * 2)/fft_size
        new_x = 20*np.log10(np.clip(np.abs(xf), 1e-20, 1e100))
        new_y = 20*np.log10(np.clip(np.abs(yf), 1e-20, 1e100))
        new_z = 20*np.log10(np.clip(np.abs(zf), 1e-20, 1e100))
        
        end = start + max_length
        new_df.iloc[start : end, 0] = new_x
        new_df.iloc[start : end, 1] = new_y
        new_df.iloc[start : end, 2] = new_z
        new_df.iloc[start : end, 3] = seg_df.iloc[0, 3]
        new_df.iloc[start : end, 4] = seg
        new_df.iloc[start : end, 5] = seg_df.iloc[0, 5]
        
        start = end
            
    return new_df