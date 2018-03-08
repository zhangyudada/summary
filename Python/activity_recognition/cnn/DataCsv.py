import numpy as np
import pandas as pd
from sklearn.preprocessing import MaxAbsScaler
import math
def data_csv():
    df = pd.read_csv('../data/cnndata/all_data.csv')
    
    df1 = df.drop('label',axis=1)
    df2 = df1**2
    df3 = df1**3
    #df4 = [np.exp(x) for x in np.array(df1/100)]
    #df5 = [np.exp(-x) for x in np.array(df1/100)]
    #df5 = np.sin(df1)
    #df6 = np.cos(df1)
    #df5 = [np.sqrt(abs(x)) for x in np.array(df1)]
    scaler = MaxAbsScaler()
    df1 = scaler.fit_transform(df1)
    df2 = scaler.fit_transform(df2)
    df3 = scaler.fit_transform(df3)
    
    #df4 = scaler.fit_transform(df4)
    #df5 = scaler.fit_transform(df5)
    #df6 = scaler.fit_transform(df6)
    x_df1 = np.array(df1).reshape(5026,3,77)
    x_df2 = np.array(df2).reshape(5026,3,77)
    x_df3 = np.array(df3).reshape(5026,3,77)
    #x_df4 = np.array(df4).reshape(5026,3,77)

    #x_df5 = np.array(df5).reshape(5026,3,77)
    #x_df6 = np.array(df6).reshape(5026,3,77)
    x_df = np.concatenate((x_df1,x_df2,x_df3),axis=1)
    
    x_data = np.transpose(x_df,(0,2,1))
    
    y_df = df['label']
    y0 = y_df.replace('walk',0)
    y1 = y0.replace('bweep',1)
    y2 = y1.replace('clean',2)
    y3 = y2.replace('sweep',3)
    y4 = y3.replace('daily',4)
    y5 = y4.replace('dump',5)
    y6 = y5.replace('run',6)
    y_data = y6.values.reshape(-1,1)
    
    return x_data,y_data