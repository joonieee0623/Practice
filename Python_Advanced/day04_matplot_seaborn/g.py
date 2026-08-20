# scatter
import matplotlib.pyplot as  plt
import numpy as np

xp = np.array([60, 60, 60, 45, 45, 60, 60, 45, 30])
yp = np.array([409, 479, 340, 282, 406, 300, 374, 253, 195])
#plt.plot(xp, yp) #선
#plt.scatter(xp, yp) #점뿌리기
#plt.scatter(xp, yp, color='gray')

colors = np.array(["red", "green", "blue", "yellow", "pink", "orange", "brown", "magenta", "cyan"])
#plt.scatter(xp, yp, c=colors)

sizes = np.array([30, 40, 50, 60, 70, 80, 90, 100, 300])
plt.scatter(xp, yp, c=colors, s=sizes, alpha=0.3)
plt.colorbar()

plt.show()