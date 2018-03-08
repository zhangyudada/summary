# -*- coding: utf-8 -*-
"""
Created on 2018-01-17 13:56:28

@author: zhangyu
"""

import pandas as pd

# split the data into training data and test data
def file_split(df):

    segs =df.seg.unique()
    
    cols = df.columns.values[:5]
    all_df = pd.DataFrame(columns=cols)
    train_df = pd.DataFrame(columns=cols)
    test_df = pd.DataFrame(columns=cols)
    
    seg_len = 50
    for seg in segs:
        seg_df = df[df['seg']==seg][['x', 'y', 'z', 'label', 'seg']]
        
        train_num = round(len(seg_df)/seg_len*9/10)  
        train_len = train_num * seg_len
        
        tmp_train_df = seg_df.iloc[:train_len]
        tmp_test_df = seg_df.iloc[train_len:]
        
        all_df = pd.concat([all_df, seg_df], axis=0)
        train_df = pd.concat([train_df, tmp_train_df], axis=0)
        test_df = pd.concat([test_df, tmp_test_df], axis=0)
        
    all_df.to_csv('../data/processed_data/all/resample_to_50_per_act/file_split/all.csv', index=False)
    train_df.to_csv('../data/processed_data/all/resample_to_50_per_act/file_split/train.csv', index=False)
    test_df.to_csv('../data/processed_data/all/resample_to_50_per_act/file_split/test.csv', index=False)

df = pd.read_csv('../data/processed_data/all/resample_to_50_per_act/resample_to_50_with_big_seg.csv')
file_split(df)