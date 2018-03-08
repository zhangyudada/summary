# -*- coding: utf-8 -*-
"""
Created on 2018-01-17 15:24:30

@author: zhangyu
"""

import pandas as pd
import numpy as np
from sklearn.externals import joblib

import feature_project as fp

## old data
#def norm_feature_matrix():
#    
#    all_df = pd.read_csv('../data/processed_data/all/resample_to_50_per_act/file_split/all.csv')
#    all_data = fp.feature_matrix(all_df) 
#    all_X = np.array(all_data.drop('label',axis=1))
#    scaler, norm_all_X = fp.feature_normalization(all_X)
#    for ind in range(norm_all_X.shape[1]):
#        all_data.iloc[:,ind+1] = norm_all_X[:,ind]
#    all_data.to_csv('../data/processed_data/all/resample_to_50_per_act/file_split/fm/feature_matrix_all.csv', \
#                    encoding='utf-8', index=False)
#    
#    training_df = pd.read_csv('../data/processed_data/all/resample_to_50_per_act/file_split/train.csv')
#    training_data = fp.feature_matrix(training_df) 
#    training_X = np.array(training_data.drop('label',axis=1))
#    norm_training_X = scaler.transform(training_X)
#    for ind in range(norm_training_X.shape[1]):
#        training_data.iloc[:,ind+1] = norm_training_X[:,ind]
#    training_data.to_csv('../data/processed_data/all/resample_to_50_per_act/file_split/fm/feature_matrix_train.csv',\
#                         encoding='utf-8', index=False)
#    
#    test_df = pd.read_csv('../data/processed_data/all/resample_to_50_per_act/file_split/test.csv')
#    test_data = fp.feature_matrix(test_df)
#    test_X = np.array(test_data.drop('label',axis=1))
#    norm_test_X = scaler.transform(test_X)
#    for ind in range(norm_test_X.shape[1]):
#        test_data.iloc[:,ind+1] = norm_test_X[:,ind]
#    test_data.to_csv('../data/processed_data/all/resample_to_50_per_act/file_split/fm/feature_matrix_test.csv',\
#                     encoding='utf-8', index=False)
#    
#    joblib.dump(scaler, '../data/processed_data/all/resample_to_50_per_act/file_split/fm/scaler.pkl')

# standardize features    
# X3 data
def norm_feature_matrix():

    training_df =  pd.read_csv('../data/X3/zyu/train/all.csv')
    training_data = fp.feature_matrix(training_df) 
    training_X = np.array(training_data.drop('label',axis=1))
    scaler, norm_training_X = fp.feature_normalization(training_X)
    for ind in range(norm_training_X.shape[1]):
        training_data.iloc[:,ind+1] = norm_training_X[:,ind]
    training_data.to_csv('../data/X3/zyu/fm/feature_matrix_train.csv', encoding='utf-8', index=False)
    
    test_df = pd.read_csv('../data/X3/zyu/test/all.csv')
    test_data = fp.feature_matrix(test_df)
    test_X = np.array(test_data.drop('label',axis=1))
    norm_test_X = scaler.transform(test_X)
    for ind in range(norm_test_X.shape[1]):
        test_data.iloc[:,ind+1] = norm_test_X[:,ind]
    test_data.to_csv('../data/X3/zyu/fm/feature_matrix_test.csv', encoding='utf-8', index=False)
    
    joblib.dump(scaler, '../data/X3/zyu/fm/scaler_train.pkl')
      
norm_feature_matrix()   