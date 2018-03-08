# -*- coding: utf-8 -*-
"""
Created on 2017-11-26 15:48:08

@author: zhangyu
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import learning_curve #加载学习曲线  
from sklearn.model_selection import ShuffleSplit #加载数据处理  
from sklearn import svm


def plot_learning_curve(estimator, title, X, y, ylim=(0.7, 1.01), cv=None,
                        n_jobs=1, train_sizes=np.linspace(.1, 1.0, 5)):

    train_sizes, train_scores, test_scores = learning_curve(
        estimator, X, y, cv=cv, n_jobs=n_jobs, train_sizes=train_sizes)
    train_scores_mean = np.mean(train_scores, axis=1)
    train_scores_std = np.std(train_scores, axis=1)
    test_scores_mean = np.mean(test_scores, axis=1)
    test_scores_std = np.std(test_scores, axis=1)
    
    #    plt.figure()
    plt.title(title)
    plt.xlabel("Training examples")
    plt.ylabel("Score")
    plt.ylim(ylim)
    plt.grid()
    plt.plot(train_sizes, train_scores_mean, 'o-', color="r",
             label="Training score")
    plt.fill_between(train_sizes, train_scores_mean - train_scores_std,
                     train_scores_mean + train_scores_std, alpha=0.1,
                     color="r")
    plt.plot(train_sizes, test_scores_mean, 'o-', color="g",
             label="Cross-validation score") 
    plt.fill_between(train_sizes, test_scores_mean - test_scores_std,
                     test_scores_mean + test_scores_std, alpha=0.1, color="g")
    plt.legend(loc="best")
    plt.show()


# 读取数据并分为数据和标签
df = pd.read_csv('./data/processed_data/all/resample_to_50_per_act/SVM/SVM_w50.csv')
df_data = np.array(df.drop('label',axis=1))
df_labels = df['label']

title = "Learning Curves (SVM, RBF kernel, $\gamma=auto$)"
# 处理数据，测试数据比例为0.2，10折交叉
cv = ShuffleSplit(n_splits=10, test_size=0.2, random_state=0)
estimator = svm.SVC()
plot_learning_curve(estimator, title, df_data, df_labels, cv=cv, n_jobs=4)
