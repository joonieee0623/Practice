#pip install matplotlib
import matplotlib.pyplot as plt
import numpy as np

xp = np.array([0,5])
yp = np.array([0,300])
print(xp)
print(yp)

#plt.plot(xp, yp) #line chart
plt.plot(xp, yp, 'o') #o점
#plt.plot(xp, yp, 'x')  #x점

plt.show()

