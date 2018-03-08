# -*- coding: utf-8 -*-
"""
Created on 2017-11-13 13:33:32

@author: zhangyu
"""

import numpy as np
import pandas as pd
from sklearn import preprocessing
import math

# extract time features
def feature_extraction(x,y,z):
    x = x.astype(float)
    y = y.astype(float)
    z = z.astype(float)
    
    # calculate the 57 features
    sum_x = sum(x)
    sum_y = sum(y)
    sum_z = sum(z)
    
    mean_x = np.mean(x) if np.mean(x)!=0 else 1e-5
    mean_y = np.mean(y) if np.mean(y)!=0 else 1e-5
    mean_z = np.mean(z) if np.mean(z)!=0 else 1e-5
    
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
    fm_sum_x = fm_sum_x if fm_sum_x!=0 else 1e-5
    fm_sum_y = fm_sum_y if fm_sum_y!=0 else 1e-5
    fm_sum_z = fm_sum_z if fm_sum_z!=0 else 1e-5
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
    x2 = x2 if x2!=0 else 1e-5
    y2 = y2 if y2!=0 else 1e-5
    z2 = z2 if z2!=0 else 1e-5
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
    x2 = x2 if x2!=0 else 1e-5
    y2 = y2 if y2!=0 else 1e-5
    z2 = z2 if z2!=0 else 1e-5
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

    #  package the features into a ndarray
    rtn_arr = np.array([sum_x, sum_y, sum_z, \
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
        
    return rtn_arr.astype(float)

# extract frequency features
def feature_extraction_freq(x,y,z):
    x = x.astype(float)
    y = y.astype(float)
    z = z.astype(float)
    
    freq_spectrum_x = x[1:]
    freq_spectrum_y = y[1:]
    freq_spectrum_z = z[1:]
    
    _freq_sum_x_ = np.sum(freq_spectrum_x)
    _freq_sum_y_ = np.sum(freq_spectrum_y)
    _freq_sum_z_ = np.sum(freq_spectrum_z)
    
    # calculate the 33 features
    dc_x = x[0]
    dc_y = y[0]
    dc_z = z[0]
    
    mean_x = np.mean(freq_spectrum_x)
    mean_y = np.mean(freq_spectrum_y)
    mean_z = np.mean(freq_spectrum_z)
    
    var_x = np.var(freq_spectrum_x)
    var_y = np.var(freq_spectrum_y)
    var_z = np.var(freq_spectrum_z)
    
    std_x = np.std(freq_spectrum_x)
    std_y = np.std(freq_spectrum_y)
    std_z = np.std(freq_spectrum_z)
    
    skew_x = np.mean([0 if std_x == 0 else np.power((x - mean_x) / std_x, 3)
                        for x in freq_spectrum_x])
    skew_y = np.mean([0 if std_y == 0 else np.power((y - mean_y) / std_y, 3)
                        for y in freq_spectrum_y])
    skew_z = np.mean([0 if std_z == 0 else np.power((z - mean_z) / std_z, 3)
                        for z in freq_spectrum_z])
    
    kurt_x = np.mean([0 if std_x == 0 else np.power((x - mean_x) / std_x, 4) - 3
                        for x in freq_spectrum_x])
    kurt_y = np.mean([0 if std_y == 0 else np.power((y - mean_y) / std_y, 4) - 3
                        for y in freq_spectrum_y])
    kurt_z = np.mean([0 if std_z == 0 else np.power((z - mean_z) / std_z, 4) - 3
                        for z in freq_spectrum_z])
    
    shape_sum_x = np.sum([x * freq_spectrum_x[x]
                            for x in range(len(freq_spectrum_x))])
    shape_mean_x = 0 if _freq_sum_x_ == 0 else shape_sum_x * 1.0 / _freq_sum_x_
    shape_sum_y = np.sum([y * freq_spectrum_y[y]
                            for y in range(len(freq_spectrum_y))])
    shape_mean_y = 0 if _freq_sum_y_ == 0 else shape_sum_y * 1.0 / _freq_sum_y_
    shape_sum_z = np.sum([z * freq_spectrum_z[z]
                            for z in range(len(freq_spectrum_z))])
    shape_mean_z = 0 if _freq_sum_z_ == 0 else shape_sum_z * 1.0 / _freq_sum_z_
     
    shape_var_x = np.sum([0 if _freq_sum_x_ == 0 else np.power((x - shape_mean_x), 2) * freq_spectrum_x[x]
                  for x in range(len(freq_spectrum_x))]) / _freq_sum_x_
    shape_var_y = np.sum([0 if _freq_sum_y_ == 0 else np.power((y - shape_mean_y), 2) * freq_spectrum_y[y]
                  for y in range(len(freq_spectrum_y))]) / _freq_sum_y_
    shape_var_z = np.sum([0 if _freq_sum_z_ == 0 else np.power((z - shape_mean_z), 2) * freq_spectrum_z[z]
                  for z in range(len(freq_spectrum_z))]) / _freq_sum_z_
    
    shape_std_x = np.sqrt(shape_var_x)
    shape_std_y = np.sqrt(shape_var_y)
    shape_std_z = np.sqrt(shape_var_z)

    shape_skew_x = np.sum([np.power((x - shape_mean_x), 3) * freq_spectrum_x[x]
                       for x in range(len(freq_spectrum_x))]) / _freq_sum_x_
    shape_skew_y = np.sum([np.power((y - shape_mean_y), 3) * freq_spectrum_y[y]
                       for y in range(len(freq_spectrum_y))]) / _freq_sum_y_
    shape_skew_z = np.sum([np.power((z - shape_mean_z), 3) * freq_spectrum_z[z]
                       for z in range(len(freq_spectrum_z))]) / _freq_sum_z_
    
    shape_kurt_x = np.sum([np.power((x - shape_mean_x), 4) * freq_spectrum_x[x] - 3
                for x in range(len(freq_spectrum_x))]) / _freq_sum_x_
    shape_kurt_y = np.sum([np.power((y - shape_mean_y), 4) * freq_spectrum_y[y] - 3
                for y in range(len(freq_spectrum_y))]) / _freq_sum_y_
    shape_kurt_z = np.sum([np.power((z - shape_mean_z), 4) * freq_spectrum_z[z] - 3
                for z in range(len(freq_spectrum_z))]) / _freq_sum_z_

    #  package the features into a ndarray
    rtn_arr = np.array([dc_x, dc_y, dc_z, \
                    mean_x, mean_y, mean_z, \
                    var_x, var_y, var_z, \
                    std_x, std_y, std_z, \
                    skew_x, skew_y, skew_z, \
                    kurt_x, kurt_y, kurt_z, \
                    shape_mean_x, shape_mean_y, shape_mean_z, \
                    shape_var_x, shape_var_y, shape_var_z, \
                    shape_std_x, shape_std_y, shape_std_z, \
                    shape_skew_x, shape_skew_y, shape_skew_z, \
                    shape_kurt_x, shape_kurt_y, shape_kurt_z\
                    ]).reshape(33)
        
    return rtn_arr.astype(float)

# standardize features
def feature_normalization(X):
    #X = X.reshape(-1, 1).astype(float)
    X = X.astype(float)
    scaler = preprocessing.StandardScaler().fit(X)
    #data = scaler.transform(X).reshape(X.shape[0])
    data = scaler.transform(X)
    return scaler, data

# generate features from raw data
def feature_matrix(tmp_df):
    tmp_df_len = len(tmp_df)
    
    # subwindow size and sliding step
    subw_size = 100
    subw_step = 50
    subw_num = math.floor(tmp_df_len/subw_step)-1
    df_len = subw_step*(subw_num+1)
    df = tmp_df.iloc[:df_len]
    
    # labels
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
    
    training_data = pd.DataFrame(columns=cols)
    start = 0
#    end_index = 5001
    end_index = df_len - subw_size + 1
    while start < end_index:
        end = start + subw_size
        seg_df = df.iloc[start : end]
        label = seg_df.label.unique()[0] if len(seg_df.label.unique())==1 else 'other'
        x = seg_df['AccelerometerX'].values
        y = seg_df['AccelerometerY'].values
        z = seg_df['AccelerometerZ'].values
        features = feature_extraction(x,y,z)
        len_training_data = len(training_data)
        training_data.loc[len_training_data, 'label'] = label
        training_data.loc[len_training_data, 1:] = features
    
        start += subw_step
        
    return training_data
    
    
    
    
    
  