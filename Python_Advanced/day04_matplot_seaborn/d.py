import matplotlib.pyplot as plt
import numpy as np

yp = np.array([2, 8, 1, 9, 5, 7])

# (1)line style
#plt.plot(yp)
#plt.plot(yp, linestyle='dotted')
#plt.plot(yp, ls=':') #약자

#plt.plot(yp, linestyle='dashed')
#plt.plot(yp, ls='--')

#plt.plot(yp, linestyle='solid') #기본값
#plt.plot(yp, ls='-')

# (2)line color
#plt.plot(yp, color= 'r')
#plt.plot(yp, color= '#f514c4')

# (3)Multiple line
yp2 = np.array([4, 8, 2, 7, 6, 4])
plt.plot(yp2)

plt.show()
