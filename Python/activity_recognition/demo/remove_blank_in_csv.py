# -*- coding:utf-8 -*-

'''
@author: ZYU
@file: remove_blank_in_csv.py
@time: 2017/9/12 15:37
'''

import csv

def readcsv():
    rtn = []
    with open('raw_result.csv', 'r') as myFile:
        lines = csv.reader(myFile)
        for line in lines:
            if line != []:
                rtn.append(line[0])
    return rtn


def saveResult(result):
    with open('result.csv', 'w',newline ='') as myFile:
        myWriter = csv.writer(myFile)
        myWriter.writerow(['ImageId','Label'])
        for i, val in enumerate(result, 2):
            val = int(float(val))
            tmp = []
            tmp.append(i-1)
            tmp.append(val)
            myWriter.writerow(tmp)

saveResult(readcsv())