#bar
import matplotlib.pyplot as  plt
import numpy as np

xp = np.array(["A", "B", "C", "D"])
yp = np.array([30, 80, 60, 70])

#plt.bar(xp, yp) #수직
#plt.barh(xp, yp) #수평
#plt.bar(xp, yp, color="green", width=0.3) #폭
plt.barh(xp, yp, color="blue", height=0.3) #높이

plt.show()