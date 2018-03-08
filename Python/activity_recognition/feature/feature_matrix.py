# -*- coding: utf-8 -*-
"""
Created on 2018-01-17 15:24:30

@author: zhangyu
"""

import pandas as pd
import numpy as np
import math

import feature_project as fp

# generate features from raw data
def feature_matrix(tmp_df):
    tmp_df_len = len(tmp_df)
    
    # subwindow size and sliding step 
    subw_size = 50
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
#    end_index = df_len - subw_size + 1
    end_index = 5000 + 1
    # feature extraction
    while start < end_index:
        end = start + subw_size
        seg_df = df.iloc[start : end]
        label = seg_df.label.unique()[0] if len(seg_df.label.unique())==1 else 'other'
        x = seg_df['x'].values
        y = seg_df['y'].values
        z = seg_df['z'].values
        features = fp.feature_extraction(x,y,z)
        len_training_data = len(training_data)
        training_data.loc[len_training_data, 'label'] = label
        training_data.loc[len_training_data, 1:] = features
    
        start += subw_step
        
    return training_data

# standardize features
def norm_feature_matrix():
    
    all_df = pd.read_csv('../data/processed_data/all/resample_to_50_per_act/file_split/all.csv')
    all_data = feature_matrix(all_df) 
    all_X = np.array(all_data.drop('label',axis=1))
    scaler, norm_all_X = fp.feature_normalization(all_X)
    for ind in range(norm_all_X.shape[1]):
        all_data.iloc[:,ind+1] = norm_all_X[:,ind]
    all_data.to_csv('../realtime_fixedseg/feature_matrix_all.csv', encoding='utf-8', index=False)
    
    training_df = pd.read_csv('../data/processed_data/all/resample_to_50_per_act/file_split/train.csv')
    training_data = feature_matrix(training_df) 
    training_X = np.array(training_data.drop('label',axis=1))
    norm_training_X = scaler.transform(training_X)
    for ind in range(norm_training_X.shape[1]):
        training_data.iloc[:,ind+1] = norm_training_X[:,ind]
    training_data.to_csv('../realtime_fixedseg/feature_matrix_train.csv', encoding='utf-8', index=False)
    
    test_df = pd.read_csv('../data/processed_data/all/resample_to_50_per_act/file_split/test.csv')
    test_data = feature_matrix(test_df)
    test_X = np.array(test_data.drop('label',axis=1))
    norm_test_X = scaler.transform(test_X)
    for ind in range(norm_test_X.shape[1]):
        test_data.iloc[:,ind+1] = norm_test_X[:,ind]
    test_data.to_csv('../realtime_fixedseg/feature_matrix_test.csv', encoding='utf-8', index=False)
      
norm_feature_matrix()   