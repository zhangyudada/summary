# -*- coding: utf-8 -*-
"""
Created on 2018-01-17 15:46:24

@author: zhangyu
"""

import pandas as pd
import numpy as np

from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn import svm
from sklearn.externals import joblib

##old data
#def train(training_data):
#    
#    X = np.array(training_data.drop('label',axis=1))
#    y = training_data['label']
#    
#    knn = KNeighborsClassifier()
#    knn.fit(X, y)
#    joblib.dump(knn, './model/knn.pkl')
#    
#    dt = DecisionTreeClassifier(criterion='entropy')
#    dt.fit(X, y)
#    joblib.dump(dt, './model/dt.pkl')
#    
#    gnb = GaussianNB()
#    gnb.fit(X, y)
#    joblib.dump(gnb, './model/gnb.pkl')
#    
#    svm_clf = svm.SVC(C=5, cache_size=1000)
#    svm_clf.fit(X, y)
#    joblib.dump(svm_clf, './model/svm_clf.pkl')
#training_data = pd.read_csv('./feature_matrix_all.csv')

#X3 data
# generate predict models using training data and machine learning algorithms
def train(training_data):
    
    X = np.array(training_data.drop('label',axis=1))
    y = training_data['label']
    
    knn = KNeighborsClassifier()
    knn.fit(X, y)
    joblib.dump(knn, './modelX3/knn.pkl')
    
    dt = DecisionTreeClassifier(criterion='entropy')
    dt.fit(X, y)
    joblib.dump(dt, './modelX3/dt.pkl')
    
    gnb = GaussianNB()
    gnb.fit(X, y)
    joblib.dump(gnb, './modelX3/gnb.pkl')
    
    svm_clf = svm.SVC(C=5, cache_size=1000)
    svm_clf.fit(X, y)
    joblib.dump(svm_clf, './modelX3/svm_clf.pkl')
training_data = pd.read_csv('../data/X3/zyu/fm/feature_matrix_train.csv')

train(training_data)
    