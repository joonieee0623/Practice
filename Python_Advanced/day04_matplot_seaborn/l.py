# pip install seaborn

import seaborn as sns
import matplotlib.pyplot as plt


df = sns.load_dataset('tips')
#print(df) #앞5줄, 뒤5줄
print(df.to_string()) #전체

#1. Hist Plot
#sns.histplot(x=df['total_bill'])
#sns.histplot(x=df['total_bill'], y=df['tip'])

#2. KDE(kernel density estimate : 핵심 밀도 평가) Plot
'''
Kernel Density Plot의 약자이며, 히스토그램의 단점을 보완하기 위해 제안된 방식.
히스토그램이 구간별 데이터 수를 bar plot으로 표현하는 방식이라면 KDE plot은 각 데이터로 밀도
분포를 추정하여 합산하는 방식.
'''
#sns.kdeplot(x=df['total_bill']) #like 산
#sns.kdeplot(x=df['total_bill'], y=df['tip']) #like 등고선

#3. ECDF Plot
#sns.ecdfplot(x=df['total_bill']) #누적
#sns.kdeplot(x=df["total_bill"]) #파란색 선이 kdeplot

#4. Rug Plot
#ns.rugplot(x=df["total_bill"]) #주황 색선이 rugplot

#5. Bar Plot
#sns.barplot(x = df['sex'], y = df['tip'])

#6. Count Plot
#sns.countplot(x = df['sex']) #카테로리별 막대그래프

#7. Box Plot
#sns.boxplot(x = df['total_bill'])
#sns.boxplot(y = df['total_bill'], x = df['smoker'])

#8. Violin Plot
#sns.violinplot(y = df['total_bill'], x = df['smoker']) #바이올린 모양

#9. Strip Plot
#sns.stripplot(y = df['total_bill'], x = df['smoker']) #점뿌리기 모양

#10. Swarm Plot
#sns.swarmplot(y = df['total_bill'], x = df['smoker']) #점뿌리기 + 바이올린

#11. Heat Map
#sns.heatmap(df.corr(), annot = True, cmap = 'viridis') #컬럼간의 관계지수 시각화

#12. Cluster Map
#sns.clustermap(df.corr(), annot=True, cmap='viridis') #pip install scipy

#13. Facet Grid
#sns.FacetGrid(df, col = 'smoker', row = 'sex').map(sns.distplot, 'total_bill')

#14. Joint Plot
#sns.jointplot(x=df['total_bill'], y=df['tip'], kind = 'scatter')
#sns.jointplot(x=df['total_bill'], y=df['tip'], kind = 'hex') #진형이가 좋아함

#15. Pair Plot
#sns.pairplot(df)

#16. Reg Plot
#sns.regplot(x = 'tip', y = 'total_bill', data = df) #방향성은 선으로 일반화

#7. LM Plot
sns.lmplot(x = 'tip', y = 'total_bill', data = df, hue = 'sex') #regplot()과 faceGrid

plt.show()
