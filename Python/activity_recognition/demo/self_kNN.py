# -*- coding:utf-8 -*-

'''
@author: ZYU
@file: kNN.py
@time: 2017/9/25 20:25
'''

import pandas as pd
import numpy as np
import operator
import csv

def loadData():
    train_df = pd.read_csv('./data/processed_data/part/train.csv')
    test_df = pd.read_csv('./data/processed_data/part/test.csv')
    # train_df = pd.read_csv('./data/processed_data/all/train.csv')
    # test_df = pd.read_csv('./data/processed_data/all/test.csv')
    train_data = train_df.drop('label', axis=1)
    test_data = test_df.drop('label', axis=1)
    train_labels = train_df['label']
    test_labels = test_df['label']
    return train_data, test_data, train_labels,test_labels

# a kNN realization
def classify(test_vector, train_data, train_labels, k):
    train_len = train_data.shape[0]
    testMat = np.tile(test_vector, (train_len,1))
    diffMat = testMat - train_data
    sqDiffMat = diffMat**2
    sqDistances = sqDiffMat.sum(axis=1)
    distances = sqDistances**0.5
    sortedDistIndicies = distances.argsort()
    classCount={}
    for i in range(k):
        voteIlabel = train_labels[sortedDistIndicies[i]]
        classCount[voteIlabel] = classCount.get(voteIlabel,0) + 1
    sortedClassCount = sorted(classCount.items(), key=operator.itemgetter(1), reverse=True)
    return sortedClassCount[0][0]


def saveResult(result):
    with open('./data/processed_data/part/raw_result.csv', 'w',newline ='') as myFile:
        myWriter = csv.writer(myFile)
        for i in result:
            tmp = []
            tmp.append(i)
            myWriter.writerow(tmp)


def recognition():
    train_data, test_data, train_labels, test_labels = loadData()
    test_len = test_data.shape[0]
    errorCount = 0
    resultList = []
    for i in range(test_len):
        classifierResult = classify(test_data.iloc[i], train_data, train_labels, 3)
        resultList.append(classifierResult)
        # print("the classifier came back with: %s, the real answer is: %s" % (classifierResult, test_labels[i]))
        print("result: %s    , real: %s" % (classifierResult, test_labels[i]))
        if (classifierResult != test_labels[i]): errorCount += 1.0
    print("\nthe total number of errors is: %d" % errorCount)
    print("\nthe total error rate is: %f" % (errorCount / float(test_len)))
    # saveResult(resultList)

recognition()