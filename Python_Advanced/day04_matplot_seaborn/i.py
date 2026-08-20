#pie chart
import matplotlib.pyplot as  plt
import numpy as np

yp = np.array([30, 20, 40, 10])

mylabels = ['tiger', 'rabbit', 'lion', 'mouse']
mycolors = ['red', 'green', 'blue', 'yellow']
myexplode = [0.3, 0, 0.1, 0]
#plt.pie(yp, labels=mylabels)
#plt.pie(yp, labels=mylabels, colors=mycolors)
plt.pie(yp, labels=mylabels, colors=mycolors, explode=myexplode, startangle=90)
#plt.pie(yp, labels=mylabels, colors=mycolors, startangle=90)
#plt.legend()
plt.legend(title='Animals', loc='upper right')

plt.show()
