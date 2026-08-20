import matplotlib.pyplot as plt
import numpy as np

yp = np.array([2, 8, 1, 9, 5, 7])
#plt.plot(yp, 'o') #only 점
#plt.plot(yp, marker='o') #선+점
#plt.plot(yp, marker='D') #선+다이아몬드

#plt.plot(yp, 'o:r') #:점선+r레드
#plt.plot(yp, 'o:g') #:점선+g그린
#plt.plot(yp, 'o-r') #-실선+r
#plt.plot(yp, 'o--') #--dashed line
#plt.plot(yp, 'o-.') #-.dash-dot line

#plt.plot(yp, 'o-.', ms=20, mec='r', mfc='y') MarkerSize, MarkerEdgeColor, MarkerFaceColor
plt.plot(yp, 'o-.', ms=20, mec="#29e3ab", mfc='#e38f29') #colorpicker 16진수 코드

'''
plt.plot(yp, 'o-.', ms=20, mec='r', mfc='y',
        mew=3,        # 테두리 두께
        lw=2,         # 선 두께
        color='gray', # 선 색 (마커 색과 별개!)
        label='실적') # 범례에 표시될 이름
'''

plt.show()

