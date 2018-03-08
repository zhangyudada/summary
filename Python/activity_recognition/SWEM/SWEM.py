# -*- coding: utf-8 -*-
"""
Created on 2017-11-16 10:50:04

@author: zhangyu
"""

import sys  
sys.path.append('../') 

import pandas as pd
import numpy as np
import scipy.signal as signal

from feature.feature import feature_extraction
from feature.feature import feature_extraction_freq
from feature.feature import feature_normalization

from sklearn import svm
from xgboost.sklearn import XGBClassifier

#==============================================================================
# Get time domain features of time series
#==============================================================================
def SWEMMEMBERTRAIN(df, L, seg_length = 50, slidew_size = 10):
    M = []
    
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
    for l in L:
        training_data = pd.DataFrame(columns=cols)
        segs = df.seg.unique()
        for seg in segs:
            seg_df = df[df['seg'] == seg]
            label = seg.split('/')[0]
            for s in np.arange(0, seg_length-l+1, slidew_size):
                x = seg_df['x'].values[s:s+l]
                y = seg_df['y'].values[s:s+l]
                z = seg_df['z'].values[s:s+l]
                features = feature_extraction(x,y,z)
                len_training_data = len(training_data)
                training_data.loc[len_training_data, 'label'] = label
                training_data.loc[len_training_data, 1:] = features
             #end for
        #end for
        X = np.array(training_data.drop('label',axis=1))
        norm_X = feature_normalization(X)
        for ind in range(norm_X.shape[1]):
            training_data.iloc[:,ind+1] = norm_X[:,ind]
        
        M.append(training_data)
    #end for  
    return M

#==============================================================================
# Get frequency domain features of time series
#==============================================================================
def SWEMMEMBERTRAIN_FREQ(df, L, seg_length = 50, slidew_size = 10):
    M = []
    
    cols = ['label', 
            'dc_x', 'dc_y', 'dc_z', \
            'mean_x', 'mean_y', 'mean_z', \
            'var_x', 'var_y', 'var_z', \
            'std_x', 'std_y', 'std_z', \
            'skew_x', 'skew_y', 'skew_z', \
            'kurt_x', 'kurt_y', 'kurt_z', \
            'shape_mean_x', 'shape_mean_y', 'shape_mean_z', \
            'shape_var_x', 'shape_var_y', 'shape_var_z', \
            'shape_std_x', 'shape_std_y', 'shape_std_z', \
            'shape_skew_x', 'shape_skew_y', 'shape_skew_z', \
            'shape_kurt_x', 'shape_kurt_y', 'shape_kurt_z']
    for l in L:
        fft_size = l
        training_data = pd.DataFrame(columns=cols)
        segs = df.seg.unique()
        for seg in segs:
            seg_df = df[df['seg'] == seg]
            label = seg.split('/')[0]
            for s in np.arange(0, seg_length-l+1, slidew_size):
                x = seg_df['x'].values[s:s+l]
                y = seg_df['y'].values[s:s+l]
                z = seg_df['z'].values[s:s+l]
                xf = np.fft.rfft(x * signal.hann(fft_size, sym=0) * 2)/fft_size
                yf = np.fft.rfft(y * signal.hann(fft_size, sym=0) * 2)/fft_size
                zf = np.fft.rfft(z * signal.hann(fft_size, sym=0) * 2)/fft_size
                new_x = np.abs(xf)
                new_y = np.abs(yf)
                new_z = np.abs(zf)
                features = feature_extraction_freq(new_x,new_y,new_z)
                len_training_data = len(training_data)
                training_data.loc[len_training_data, 'label'] = label
                training_data.loc[len_training_data, 1:] = features
             #end for
        #end for
        X = np.array(training_data.drop('label',axis=1))
        norm_X = feature_normalization(X)
        for ind in range(norm_X.shape[1]):
            training_data.iloc[:,ind+1] = norm_X[:,ind]
        
        M.append(training_data)
    #end for  
    return M

#==============================================================================
# Predict time series using SVM based algorithm
#==============================================================================
def predict(train_data,train_labels,test_data):    
    
    svm_clf = svm.SVC(C=5, cache_size=1000)
    svm_clf.fit(train_data, train_labels)
    svm_predict_labels = svm_clf.predict(test_data)
    svm_p = sorted([( np.sum(svm_predict_labels==label),label ) \
                for label in np.unique(svm_predict_labels)])
    svm_predict_label = svm_p[-1][1]

    return svm_predict_label

# Predict time series using only one window size
def SWEMPREDICT_SINGLE(df, test_ratio, seg_num = 5026):
    test_num = int(np.round(seg_num*test_ratio))
    subw_num = int(df.shape[0] / seg_num)
    seg_indexes = np.random.randint(0, seg_num, test_num)
    
    df_data = np.array(df.drop('label',axis=1))
    df_labels = np.array(df['label'])
    
    test_labels = []
    svm_clf_labels = []
    # Adopt leave-on-out meathod of cross validation
    # In fact, it's equivalent to k-fold cross validation, just make k=seg_num here
    for seg_index in seg_indexes:
        start = subw_num*(seg_index)
        
        test_label = df_labels[start]
        test_data = df_data[start : start+subw_num]
        train_labels = np.delete(df_labels,np.arange(start, start+subw_num))
        train_data = np.delete(df_data,np.arange(start, start+subw_num),0)
        
        svm_predict_label = \
                    predict(train_data,train_labels,test_data)
        
        test_labels.append(test_label)
        svm_clf_labels.append(svm_predict_label)
        
    return test_labels,svm_clf_labels

# Predict time series using all window sizes
def SWEMPREDICT(M, test_ratio, seg_num = 5026):
    test_num = int(np.round(seg_num*test_ratio))
    seg_indexes = np.random.randint(0, seg_num, test_num)
    
    test_labels = []
    svm_clf_labels = []
    # Adopt leave-on-out meathod of cross validation
    for seg_index in seg_indexes:
        
        svm_predict_labels = []
        for df in M:
            df_data = np.array(df.drop('label',axis=1))
            df_labels = np.array(df['label'])
            
            subw_num = int(df.shape[0] / seg_num)
            start = subw_num*(seg_index)
            
            test_label = df_labels[start]
            test_data = df_data[start : start+subw_num]
            train_labels = np.delete(df_labels,np.arange(start, start+subw_num))
            train_data = np.delete(df_data,np.arange(start, start+subw_num),0)
            
            svm_predict_label = \
                        predict(train_data,train_labels,test_data)
                        
            svm_predict_labels.append(svm_predict_label)
            
        svm_p = sorted([( np.sum(svm_predict_labels==label),label ) \
                for label in np.unique(svm_predict_labels)])
        svm_clf_label = svm_p[-1][1]
            
        test_labels.append(test_label)
        svm_clf_labels.append(svm_clf_label)
        
    return test_labels,svm_clf_labels

#==============================================================================
# Predict time series using XGBoost based algorithm
#==============================================================================
def predict_xgb(train_data,train_labels,test_data):    
    
    xgb_clf = XGBClassifier(
                learning_rate =0.1,
                n_estimators=600,
                max_depth=5,
                min_child_weight=1,
                gamma=0,
                subsample=0.6,
                colsample_bytree=0.8,
                objective= 'reg:linear',
                nthread=4,
                scale_pos_weight=1,
                reg_alpha=0,
                reg_lambda=1,
                seed=27)
    xgb_clf.fit(train_data, train_labels)
    xgb_predict_labels = xgb_clf.predict(test_data)
    xgb_p = sorted([( np.sum(xgb_predict_labels==label),label ) \
                for label in np.unique(xgb_predict_labels)])
    xgb_predict_label = xgb_p[-1][1]

    return xgb_predict_label

# Predict time series using only one window size
def SWEMPREDICT_SINGLE_XGB(df, test_ratio, seg_num = 5026):
    test_num = int(np.round(seg_num*test_ratio))
    subw_num = int(df.shape[0] / seg_num)
    seg_indexes = np.random.randint(0, seg_num, test_num)
    
    df_data = np.array(df.drop('label',axis=1))
    df_labels = np.array(df['label'])
    
    test_labels = []
    xgb_clf_labels = []

    for seg_index in seg_indexes:
        start = subw_num*(seg_index)
        
        test_label = df_labels[start]
        test_data = df_data[start : start+subw_num]
        train_labels = np.delete(df_labels,np.arange(start, start+subw_num))
        train_data = np.delete(df_data,np.arange(start, start+subw_num),0)
        
        xgb_predict_label = \
                    predict(train_data,train_labels,test_data)
        
        test_labels.append(test_label)
        xgb_clf_labels.append(xgb_predict_label)
        
    return test_labels,xgb_clf_labels

# Predict time series using all window sizes
def SWEMPREDICT_XGB(M, test_ratio, seg_num = 5026):
    test_num = int(np.round(seg_num*test_ratio))
    seg_indexes = np.random.randint(0, seg_num, test_num)
    
    test_labels = []
    xgb_clf_labels = []

    for seg_index in seg_indexes:
        
        xgb_predict_labels = []
        for df in M:
            df_data = np.array(df.drop('label',axis=1))
            df_labels = np.array(df['label'])
            
            subw_num = int(df.shape[0] / seg_num)
            start = subw_num*(seg_index)
            
            test_label = df_labels[start]
            test_data = df_data[start : start+subw_num]
            train_labels = np.delete(df_labels,np.arange(start, start+subw_num))
            train_data = np.delete(df_data,np.arange(start, start+subw_num),0)
            
            xgb_predict_label = \
                        predict(train_data,train_labels,test_data)
                        
            xgb_predict_labels.append(xgb_predict_label)
            
        xgb_p = sorted([( np.sum(xgb_predict_labels==label),label ) \
                for label in np.unique(xgb_predict_labels)])
        xgb_clf_label = xgb_p[-1][1]
            
        test_labels.append(test_label)
        xgb_clf_labels.append(xgb_clf_label)
        
    return test_labels,xgb_clf_labels