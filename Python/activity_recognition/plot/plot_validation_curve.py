# -*- coding: utf-8 -*-
"""
Created on 2017-11-26 15:48:08

@author: zhangyu
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import validation_curve #加载验证曲线  
from sklearn.model_selection import ShuffleSplit #加载数据处理  
from sklearn import svm


def plot_validation_curve(estimator, X, y, title, xlabel, ylim=(0.0, 1.1),
                          param_name="gamma", param_range = np.logspace(-3,1,5),
                          cv=10, scoring="accuracy", n_jobs=1):
    train_scores, test_scores = validation_curve(
            estimator, X, y, param_name=param_name, param_range=param_range,
            cv=cv, scoring=scoring, n_jobs=n_jobs)
    train_scores_mean = np.mean(train_scores, axis=1)
    train_scores_std = np.std(train_scores, axis=1)
    test_scores_mean = np.mean(test_scores, axis=1)
    test_scores_std = np.std(test_scores, axis=1)
    
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel("Score")
    plt.ylim(ylim)
    plt.grid()
    plt.plot(param_range, train_scores_mean, 'o-', color="r",
             label="Training score")
    plt.fill_between(param_range, train_scores_mean - train_scores_std,
                     train_scores_mean + train_scores_std, alpha=0.1,
                     color="r")
    plt.plot(param_range, test_scores_mean, 'o-', color="g",
             label="Cross-validation score")
    plt.fill_between(param_range, test_scores_mean - test_scores_std,
                     test_scores_mean + test_scores_std, alpha=0.1,
                     color="g")
    plt.legend(loc="best")
    plt.show()


# 读取数据并分为数据和标签
df = pd.read_csv('./data/processed_data/all/resample_to_50_per_act/SVM/SVM_w50.csv')
df_data = np.array(df.drop('label',axis=1))
df_labels = df['label']

cv = ShuffleSplit(n_splits=10, test_size=0.25, random_state=0)
estimator = svm.SVC()
#ylim = (0.85,1.0)
#param_range = np.arange(0.01,0.1,0.01)
ylim = (0.8,1.1)
param_range = np.arange(1,21)

title = "Validation Curve with SVM"
#xlabel = "$\gamma$"
#plot_validation_curve(estimator, df_data, df_labels, title, xlabel,
#                      ylim=ylim, param_range=param_range, cv=cv)
xlabel = "C"
plot_validation_curve(estimator, df_data, df_labels, title, xlabel,
                      ylim=ylim, param_name="C", param_range=param_range, cv=cv)