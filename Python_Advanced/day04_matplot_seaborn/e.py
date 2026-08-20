import matplotlib.pyplot as plt
import numpy as np

xp = np.array([60, 60, 60, 45, 45, 60, 60, 45, 30])
yp = np.array([409, 479, 340, 282, 406, 300, 374, 253, 195])
plt.plot(xp, yp)

f1 = {'family': 'Arial Black', 'color':'red', 'size':17}
f2 = {'family': 'serif', 'color':'green', 'size':15}

plt.title('<Times & Calories>', fontdict=f1)
plt.xlabel('Times', fontdict=f2)
plt.ylabel('Calories', fontdict=f2)

#plt.grid()
#plt.grid(axis='x') #세로줄
plt.grid(axis='y')  #가로줄

plt.grid(color='green', ls='--', linewidth=0.5)

plt.show()