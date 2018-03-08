# -*- coding: utf-8 -*-
"""
Created on 2018-01-18 17:06:46

@author: zhangyu
"""
import pandas as pd

from sklearn.externals import joblib
import feature_project as fp

# show the predicted labels of test data in console
def predict_test(df, scaler = joblib.load('./model/scaler.pkl'), \
                      clf = joblib.load('./model/svm_clf.pkl')):
     
    subw_size = 50
    subw_step = 50
    start = 0
    df_len = len(df)
    end_index = df_len - subw_size + 1
#    end_index = 500 + 1
    predict_num = 0

    while start < end_index:
        end = start + subw_size
        seg_df = df.iloc[start : end]
        x = seg_df['x'].values
        y = seg_df['y'].values
        z = seg_df['z'].values
        X = fp.feature_extraction(x,y,z).reshape(1, -1)
        X = scaler.transform(X)
        predict_label = clf.predict(X)[0]
        predict_num += 1
        print('[%3d]predict: %s' %(predict_num,predict_label))
        start += subw_step    

df = pd.read_csv('../data/processed_data/all/resample_to_50_per_act/file_split/test_xyz.csv')       
predict_test(df)