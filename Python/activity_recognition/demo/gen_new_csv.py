# -*- coding:utf-8 -*-

'''
@author: ZYU
@file: gen_new_csv.py
@time: 2017/9/25 16:44
'''

import pandas as pd
import numpy as np
from scipy import interpolate

# generate new data with features(which are extracted from the input raw data ) and corresponding label 
def gen_new_csv(load_csv, write_csv):
    df = pd.read_csv(load_csv)

    length = []
    for g, m in df.groupby('seg'):
        length +=[len(m)]
    max_length = max(length)
	
	# new dataframe
    cols = [str(i) for i in np.arange(max_length*3)]
    cols.insert(0, "label")
    new_df = pd.DataFrame(columns=cols)

    segs = df.seg.unique()
    for seg in segs:
        seg_df = df[df['seg'] == seg][['x', 'y', 'z']]

        raw_x = seg_df['x'].values
        raw_y = seg_df['y'].values
        raw_z = seg_df['z'].values
        raw_index = np.linspace(0, max_length, raw_x.size)

        f_x = interpolate.interp1d(raw_index, raw_x, kind='cubic')
        f_y = interpolate.interp1d(raw_index, raw_y, kind='cubic')
        f_z = interpolate.interp1d(raw_index, raw_z, kind='cubic')
		
		# resample the segment(which represents a kind of activity) of raw data to fixed length
        new_index = np.arange(max_length)
        new_x = f_x(new_index)
        new_y = f_y(new_index)
        new_z = f_z(new_index)

        label = seg.split('/')[0]
        data = np.array([new_x, new_y, new_z]).reshape(max_length * 3)

        len_new_df = len(new_df)
        new_df.loc[len_new_df, 'label'] = label
        new_df.loc[len_new_df, 1:] = data

    new_df.to_csv(write_csv, index=False)

    labels = new_df.label.unique()

    train_df = pd.DataFrame()
    test_df = pd.DataFrame()
    for label in labels:
        temp_df = new_df[new_df['label'] == label]
        # temp_df.to_csv('./data/processed_data/part/{}.csv'.format(label), index=False)
        temp_df.to_csv('./data/processed_data/all/{}.csv'.format(label), index=False)
        temp_len = int(len(temp_df) * 2 / 3)
        temp_train_df = temp_df.iloc[:temp_len]
        train_df = pd.concat([train_df, temp_train_df])
        temp_test_df = temp_df.iloc[temp_len:]
        test_df = pd.concat([test_df, temp_test_df])

    # train_df.to_csv('./data/processed_data/part/train.csv', index=False)
    # test_df.to_csv('./data/processed_data/part/test.csv', index=False)
    train_df.to_csv('./data/processed_data/all/train.csv', index=False)
    test_df.to_csv('./data/processed_data/all/test.csv', index=False)

# load_csv = './data/dataset.csv'
# write_csv = './data/format_data/part/all_data.csv'
load_csv = './data/all.csv'
write_csv = './data/processed_data/all/all_data.csv'
gen_new_csv(load_csv, write_csv)