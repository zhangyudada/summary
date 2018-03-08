# -*- coding: utf-8 -*-
"""
Created on 2017-11-06 16:25:19

@author: zhangyu
"""

import pandas as pd
import numpy as np

def feature_extraction(load_csv, write_csv):
    # read the raw time series
    df = pd.read_csv(load_csv)

    # bulid a new dataframe to store features
    cols = ['label', 
            'sum_x', 'sum_y', 'sum_z', \
            'mean_x', 'mean_y', 'mean_z', \
            'std_x', 'std_y', 'std_z', \
            'cv_x', 'cv_y', 'cv_z', \
            'ptp_x', 'ptp_y', 'ptp_z', \
            'p10_x', 'p10_y', 'p10_z', \
            'p25_x', 'p25_y', 'p25_z', \
            'p50_x', 'p50_y', 'p50_z', \
            'p75_x', 'p75_y', 'p75_z', \
            'p90_x',' p90_y', 'p90_z', \
            'iq_x', 'iq_y', 'iq_z', \
            'lagone_autocor_x', 'lagone_autocor_y', 'lagone_autocor_z', \
            'sk_x', 'sk_y', 'sk_z', \
            'kurt_x', 'kurt_y', 'kurt_z', \
            'power_x', 'power_y', 'power_z', \
            'logpower_x', 'logpower_y', 'logpower_z', \
            'peak_x', 'peak_y', 'peak_z', \
            'cross0_x', 'cross0_y', 'cross0_z', \
            'cor_xy', 'cor_yz', 'cor_zx']
    new_df = pd.DataFrame(columns=cols)
    
    # extracte features from raw data
    segs = df.seg.unique()
    # traverse all segs in raw time series
    # and extract featuers for each seg
    for seg in segs:
        seg_df = df[df['seg'] == seg][['x', 'y', 'z']]
        
        # triaxial data of each seg
        x = seg_df['x'].values
        y = seg_df['y'].values
        z = seg_df['z'].values
        
        # calculate the 57 features of each seg
        sum_x = sum(x)
        sum_y = sum(y)
        sum_z = sum(z)
        
        mean_x = np.mean(x)
        mean_y = np.mean(y)
        mean_z = np.mean(z)
        
        std_x = np.std(x)
        std_y = np.std(y)
        std_z = np.std(z)
        
        cv_x = std_x / mean_x
        cv_y = std_y / mean_y
        cv_z = std_z / mean_z

        ptp_x = np.ptp(x)
        ptp_y = np.ptp(y)
        ptp_z = np.ptp(z)

        p10_x = x[int(np.round(0.1*x.size))]
        p10_y = y[int(np.round(0.1*y.size))]
        p10_z = z[int(np.round(0.1*z.size))]

        p25_x = x[int(np.round(0.25*x.size))]
        p25_y = y[int(np.round(0.25*y.size))]
        p25_z = z[int(np.round(0.25*z.size))]

        p50_x = x[int(np.round(0.5*x.size))]
        p50_y = y[int(np.round(0.5*y.size))]
        p50_z = z[int(np.round(0.5*z.size))]

        p75_x = x[int(np.round(0.75*x.size))]
        p75_y = y[int(np.round(0.75*y.size))]
        p75_z = z[int(np.round(0.75*z.size))]

        p90_x = x[int(np.round(0.9*x.size))]
        p90_y = y[int(np.round(0.9*y.size))]
        p90_z = z[int(np.round(0.9*z.size))]

        iq_x = p75_x - p25_x
        iq_y = p75_y - p25_y
        iq_z = p75_z - p25_z

        fz_sum_x = 0.0
        fz_sum_y = 0.0
        fz_sum_z = 0.0
        fm_sum_x = 0.0
        fm_sum_y = 0.0
        fm_sum_z = 0.0
        for i in range(x.size-1):
            fz_sum_x += (x[i]-mean_x) * (x[i+1]-mean_x)
            fz_sum_y += (y[i]-mean_y) * (y[i+1]-mean_y)
            fz_sum_z += (z[i]-mean_z) * (z[i+1]-mean_z)    
            fm_sum_x += (x[i]-mean_x) ** 2
            fm_sum_y += (y[i]-mean_y) ** 2
            fm_sum_z += (z[i]-mean_z) ** 2
        fm_sum_x += (x[x.size-1]-mean_x) ** 2
        fm_sum_y += (y[y.size-1]-mean_y) ** 2
        fm_sum_z += (z[z.size-1]-mean_z) ** 2
        lagone_autocor_x = fz_sum_x / fm_sum_x
        lagone_autocor_y = fz_sum_y / fm_sum_y
        lagone_autocor_z = fz_sum_z / fm_sum_z

        x2 = 0
        y2 = 0
        z2 = 0
        x3 = 0
        y3 = 0
        z3 = 0
        for i in range(x.size):
            x3 += (x[i]-mean_x) ** 3
            y3 += (y[i]-mean_y) ** 3
            z3 += (z[i]-mean_z) ** 3
            x2 += (x[i]-mean_x) ** 2
            y2 += (y[i]-mean_y) ** 2
            z2 += (z[i]-mean_z) ** 2           
        x2 = (x2 / x.size) ** 1.5
        y2 = (y2 / y.size) ** 1.5
        z2 = (z2 / z.size) ** 1.5
        sk_x = x3 / x.size / x2
        sk_y = y3 / y.size / y2
        sk_z = z3 / z.size / z2

        x2 = 0
        y2 = 0
        z2 = 0
        x4 = 0
        y4 = 0
        z4 = 0
        for i in range(x.size):
            x4 += (x[i]-mean_x) ** 4
            y4 += (y[i]-mean_y) ** 4
            z4 += (z[i]-mean_z) ** 4      
            x2 += (x[i]-mean_x) ** 2
            y2 += (y[i]-mean_y) ** 2
            z2 += (z[i]-mean_z) ** 2           
        x2 = (x2 / x.size) ** 3
        y2 = (y2 / y.size) ** 3
        z2 = (z2 / z.size) ** 3
        kurt_x = x4 / x.size / x2 - 3
        kurt_y = y4 / y.size / y2 - 3
        kurt_z = z4 / z.size / z2 - 3

        power_x = sum(x ** 2)
        power_y = sum(y ** 2)
        power_z = sum(z ** 2)

        rpls_x = np.where(x == 0, 10**-10, x)
        rpls_y = np.where(y == 0, 10**-10, y) 
        rpls_z = np.where(z == 0, 10**-10, z) 
        logpower_x = sum(np.log(rpls_x ** 2))
        logpower_y = sum(np.log(rpls_y ** 2))
        logpower_z = sum(np.log(rpls_z ** 2))

        peak_x = 0
        peak_y = 0
        peak_z = 0
        for i in np.arange(1,x.size-1):
            if x[i-1] < x[i] and x[i] > x[i+1]:
                peak_x += 1
            if y[i-1] < y[i] and y[i] > y[i+1]:
                peak_y += 1
            if z[i-1] < z[i] and z[i] > z[i+1]:
                peak_z += 1

        regu_x = x - mean_x
        regu_y = y - mean_y
        regu_z = z - mean_z
        cross0_x = 0
        cross0_y = 0
        cross0_z = 0
        for i in range(x.size-1):
            if (regu_x[i] > 0 and regu_x[i+1] < 0) or (regu_x[i] < 0 and regu_x[i+1] > 0):
                cross0_x += 1
            if (regu_y[i] > 0 and regu_y[i+1] < 0) or (regu_y[i] < 0 and regu_y[i+1] > 0):
                cross0_y += 1
            if (regu_z[i] > 0 and regu_z[i+1] < 0) or (regu_z[i] < 0 and regu_z[i+1] > 0):
                cross0_z += 1
                               
        cor_xy = np.corrcoef(np.array([x,y]))[0,1]
        cor_yz = np.corrcoef(np.array([y,z]))[0,1]
        cor_zx = np.corrcoef(np.array([z,x]))[0,1]

        # label of each seg
        label = seg.split('/')[0]

        # features extracted from each seg
        data = np.array([sum_x, sum_y, sum_z, \
                        mean_x, mean_y, mean_z, \
                        std_x, std_y, std_z, \
                        cv_x, cv_y, cv_z, \
                        ptp_x, ptp_y, ptp_z, \
                        p10_x, p10_y, p10_z, \
                        p25_x, p25_y, p25_z, \
                        p50_x, p50_y, p50_z, \
                        p75_x, p75_y, p75_z, \
                        p90_x, p90_y, p90_z, \
                        iq_x, iq_y, iq_z, \
                        lagone_autocor_x, lagone_autocor_y, lagone_autocor_z, \
                        sk_x, sk_y, sk_z, \
                        kurt_x, kurt_y, kurt_z, \
                        power_x, power_y, power_z, \
                        logpower_x, logpower_y, logpower_z, \
                        peak_x, peak_y, peak_z, \
                        cross0_x, cross0_y, cross0_z, \
                        cor_xy, cor_yz, cor_zx \
                        ]).reshape(57)

        # add features to the new dataframe
        len_new_df = len(new_df)
        new_df.loc[len_new_df, 'label'] = label
        new_df.loc[len_new_df, 1:] = data

    # write the new dataframe which store features of each seg in raw time series to a csv file
    new_df.to_csv(write_csv, index=False)

    # write features dataframe of different activities to different csv files respectivly
    labels = new_df.label.unique()
    for label in labels:
        temp_df = new_df[new_df['label'] == label]
        temp_df.to_csv('./data/processed_data/all/features_from_raw_data/{}.csv'.format(label), index=False)

load_csv = './data/all.csv'
write_csv = './data/processed_data/all/features_from_raw_data/all_data.csv'

feature_extraction(load_csv, write_csv)