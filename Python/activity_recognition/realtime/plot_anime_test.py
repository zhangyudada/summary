# -*- coding: utf-8 -*-
"""
Created on 2018-01-20 11:50:38

@author: zhangyu
"""

##==============================================================================
## Example 1
## Reference: http://blog.csdn.net/yc_1993/article/details/54933751
##==============================================================================
#import numpy as np  
#import matplotlib.pyplot as plt  
#import matplotlib.animation as animation  
#
#x = []
#y = []
#fig = plt.figure(figsize=(8, 4), facecolor='white')
#ax1 = fig.add_subplot(111)
#p1, = ax1.plot(x, y, linestyle='-', color='c')
#
#xs = np.arange(0, 1000, 1)
#ys = np.random.normal(100, 10, 1000)
#
#def update(i):
#    x.append(xs[i])
#    y.append(ys[i])
#    ax1.set_xlim(min(x),max(x)+1)
#    ax1.set_ylim(min(y),max(y)+1)
#    p1.set_data(x,y)
#    ax1.figure.canvas.draw()
#    return p1
#
#ani = animation.FuncAnimation(fig=fig,func=update,frames=len(xs),interval=1)
#plt.show()

#==============================================================================
# Example 2
# Reference: http://blog.csdn.net/yc_1993/article/details/54933751
#==============================================================================
import matplotlib.pyplot as plt
import numpy as np

t = []
v = []
plt.ion()
fig = plt.figure(figsize=(12, 4), facecolor='white')
ax1 = fig.add_subplot(111)
line, = ax1.plot(t, v, linestyle="-", color="r")

ys = np.random.normal(100, 10, 1000)

def p(a, b):
    t.append(a)
    v.append(b)
    ax1.set_xlim(min(t), max(t) + 1)
    ax1.set_ylim(min(v), max(v) + 1)
    line.set_data(t, v)
    plt.pause(0.001)
    ax1.figure.canvas.draw()

for i in np.arange(len(ys)):
    p(i, ys[i])
    
plt.ioff()
plt.show()