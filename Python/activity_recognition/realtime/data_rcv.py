# -*- coding: utf-8 -*-
"""
Created on 2018-01-19 18:21:35

@author: zhangyu
"""

import numpy as np
import matplotlib.pyplot as plt

import socket
import struct
import time
import binascii

from sklearn.externals import joblib
import feature_project as fp

#ip_port = ('10.112.34.214',9999)
ip_port = ('127.0.0.1',9999)
#ip_port = ('10.112.98.150',9999)
sk = socket.socket(socket.AF_INET,socket.SOCK_DGRAM,0)
sk.bind(ip_port)

# decode the received hexadecimal triaxial accelerometer data to decimal data
def rcv_decode(data):
#    s = struct.Struct('<150h')
    s = struct.Struct('<300h')
    rcv_arr = np.array(s.unpack_from(binascii.unhexlify(data),0))
    rcv_arr = rcv_arr/32768*4*9.8*100
#    x = rcv_arr[0:150:3]
#    y = rcv_arr[1:150:3]
#    z = rcv_arr[2:150:3]
    x = rcv_arr[0:300:3]
    y = rcv_arr[1:300:3]
    z = rcv_arr[2:300:3]
    return x, y, z

# old data
#def real_time_predict(x,y,z, \
#    scaler = joblib.load('../data/processed_data/all/resample_to_50_per_act/file_split/fm/scaler.pkl'), \
#    clf = joblib.load('./model/svm_clf.pkl')):
# X3 data
def real_time_predict(x,y,z, \
                      scaler = joblib.load('../data/X3/zyu/fm/scaler_train.pkl'), \
                      clf = joblib.load('./modelX3/svm_clf.pkl')):
    X = fp.feature_extraction(x,y,z).reshape(1, -1).astype(float)
    X = scaler.transform(X)
    predict_label = clf.predict(X)[0]
    return predict_label

# show the predicted label of received data in one graph in real time
def p_label(t, v, a, b, ax, line):
    t.append(a)
    v.append(b)
    ax.set_xlim(min(t), max(t) + 1)
#    ax.set_ylim(2, 38)
#    ax.set_yticklabels(['0','daily','run','walk','clean','dump','bweep','sweep'])
    ax.set_ylim(0, 70)
    ax.set_yticklabels(['0','brush','eat','run','sit','stand','walk',\
                        'bweep','dump','mop','sweep','window','wipe','other'])
    line.set_data(t, v)
    plt.pause(0.001)
    ax.figure.canvas.draw()
 
# show the wave pattern of triaxial accelerometer data in one graph in real time 
def p_acc(dataRec,accx,accy,accz,fig_list,line_list):
    dataRec['acc_x'] = np.concatenate((dataRec['acc_x'],accx),axis = 0)
    dataRec['acc_y'] = np.concatenate((dataRec['acc_y'],accy),axis = 0)
    dataRec['acc_z'] = np.concatenate((dataRec['acc_z'],accz),axis = 0)
    start = 0
    end = len(dataRec['acc_x'])
    fig_list[0].set_xlim(start, end)
    fig_list[1].set_xlim(start, end)
    fig_list[2].set_xlim(start, end)
    fig_list[0].set_title("Accelerometer XYZ")
#    fig_list[1].set_title("加速度-Y")
#    fig_list[2].set_title("加速度-Z")
    fig_list[0].set_ylim(min(dataRec['acc_x']), max(dataRec['acc_x']) + 1)
    fig_list[1].set_ylim(min(dataRec['acc_y']), max(dataRec['acc_y']) + 1)
    fig_list[2].set_ylim(min(dataRec['acc_z']), max(dataRec['acc_z']) + 1)
    line_list[0].set_data(range(start,end), dataRec['acc_x'])
    line_list[1].set_data(range(start,end), dataRec['acc_y'])
    line_list[2].set_data(range(start,end), dataRec['acc_z'])
    plt.pause(0.001)
    fig_list[0].figure.canvas.draw()
    fig_list[1].figure.canvas.draw()
    fig_list[2].figure.canvas.draw()

# convert the labels to numbers, so the labels could be drawed in a graph by p_label()
def get_p_idx(label):
#    if label == 'daily':
#        p_idx = 5
#    elif label == 'run':
#        p_idx = 10
#    elif label == 'walk':
#        p_idx = 15
#    elif label == 'clean':
#        p_idx = 20
#    elif label == 'dump':
#        p_idx = 25
#    elif label == 'bweep':
#        p_idx = 30
#    elif label == 'sweep':
#        p_idx = 35
#    else:
#        p_idx = 0
    if label == 'brush':
        p_idx = 5
    elif label == 'eat':
        p_idx = 10
    elif label == 'run':
        p_idx = 15
    elif label == 'sit':
        p_idx = 20
    elif label == 'stand':
        p_idx = 25
    elif label == 'walk':
        p_idx = 30
    elif label == 'bweep':
        p_idx = 35
    elif label == 'dump':
        p_idx = 40
    elif label == 'mop':
        p_idx = 45
    elif label == 'sweep':
        p_idx = 50
    elif label == 'window':
        p_idx = 55
    elif label == 'wipe':
        p_idx = 60
    elif label == 'other':
        p_idx = 65
    else:
        p_idx = 0
    return p_idx

# receive and decode data from the SCOCKET, then draw the wave pattern and predicted label
## old data
#def data_rcv(data_len = 600):
# X3 data
def data_rcv(data_len = 1200):
    
#    plt.rcParams['font.sans-serif']=['SimHei'] #用来正常显示中文标签
#    plt.rcParams['axes.unicode_minus']=False #用来正常显示负号
    plt.ion()
    
    # settings for p_label()
    tx = []
    vy = []
    fig1 = plt.figure(figsize=(8, 6), facecolor='white')
    ax1 = fig1.add_subplot(111)
    line1, = ax1.plot(tx, vy, '*', color="r")
    
    # settings for p_acc()
    dataRecord = {"acc_x":np.array([]),
                  "acc_y":np.array([]),
                  "acc_z":np.array([])}
    fig2 = plt.figure(figsize = (8,6))
    acc_x_subfig = fig2.add_subplot(311)
    acc_y_subfig = fig2.add_subplot(312)
    acc_z_subfig = fig2.add_subplot(313)
    subfig_list = [acc_x_subfig,acc_y_subfig,acc_z_subfig]
    accX_line, = acc_x_subfig.plot([], [], linestyle="-", color="r")
    accY_line, = acc_y_subfig.plot([], [], linestyle="-", color="g")
    accZ_line, = acc_z_subfig.plot([], [], linestyle="-", color="b")
    subline_list = [accX_line,accY_line,accZ_line]
    
    predict_num = 0
    while True:
        data = sk.recv(2048)
        if len(data) == data_len:
            x,y,z = rcv_decode(data)
            predict_label = real_time_predict(x,y,z)
            predict_num += 1
            tim = time.strftime('%Y-%m-%d %H:%M:%S')
            print(tim+' [%3d]predict: %s' %(predict_num,predict_label))
            
            p_idx = get_p_idx(predict_label)
            p_label(tx,vy,predict_num,p_idx,ax1,line1)
            p_acc(dataRecord,x,y,z,subfig_list,subline_list)
            
            plt.ioff()
            plt.show()
            
data_rcv()