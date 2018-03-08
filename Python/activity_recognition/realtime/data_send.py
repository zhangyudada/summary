# -*- coding: utf-8 -*-
"""
Created on 2018-01-19 14:09:00

@author: zhangyu
"""

import pandas as pd
import numpy as np

import struct
import binascii
import ctypes

import time
#import msvcrt
import socket

# send accelerometer data to PC via SOCKET
# write the hexadecimal triaxial accelerometer data to a prebuffer
# when the prebuffer is full then send all data to designated SOCKET
def data_send(df):
    df_len = len(df)
    
    s = struct.Struct('<3h')
    sample_point_size = s.size
    sample_points = 100
    buffer_size = sample_point_size * sample_points
    prebuffer = ctypes.create_string_buffer(buffer_size)
    
    #ip_port = ('10.112.34.214',9999)
    ip_port = ('127.0.0.1',9999)
#    ip_port = ('10.112.98.150',9999)
    sk = socket.socket(socket.AF_INET,socket.SOCK_DGRAM,0)
    
    df_idx = 0
    buffer_idx = 0
    
    while True:
        if df_idx == df_len:
            break
#        # 用于读取一次按键操作,如果是“退出健”ASCII = 27 则终止程序
#        if  msvcrt.kbhit() and msvcrt.getch() == b'\x1b':
#            break
        time.sleep(0.04)
        arr = np.array(df.iloc[df_idx:df_idx+1]).reshape(3)
        arr = np.around((arr*32768/4/9.8/100)).astype(int)
        values = tuple(arr)
        s.pack_into(prebuffer,buffer_idx,*values)
        df_idx += 1
        buffer_idx += sample_point_size
        if buffer_idx == buffer_size:
            print('发送编码数据：%s' %binascii.hexlify(prebuffer))
            sk.sendto(binascii.hexlify(prebuffer),ip_port)
            buffer_idx = 0
        
        
#df = pd.read_csv('../data/processed_data/all/resample_to_50_per_act/file_split/test_xyz.csv')
df = pd.read_csv('../data/X3/zyu/test/allnolabel.csv')
data_send(df)