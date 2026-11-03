"""
정의 -> 컴파일 -> 학습 -> 평가 -> 예측

1. 계산식 
	가격 = (면적 * 금액) + (층 * 금액) + (건축년도 * 금액) + (자치구 * 금액) + 기본값
	금액 : 가중치(w), 기본값 : 편향(b)

2. model.fit
	정답과 비교하면서 w를 조금씩 고치는 과정

3. 찾은 w를 .keras 파일에 저장

"""

# 1. 데이터 불러오고 합치기

import pandas as pd

df1 = pd.read_csv('/content/2025_서울시 부동산 실거래가 정보.csv', encoding='cp949')	#read_csv는 csv파일을 표(df)로 읽음. cp949는 한글 깨지지 않게.
df2 = pd.read_csv('/content/2026_서울시 부동산 실거래가 정보.csv', encoding='cp949')

print(df1.shape, df2.shape)                    # 각각 몇 행인지 확인
print(df1.columns.tolist() == df2.columns.tolist())   # 컬럼이 같은지 확인

df = pd.concat([df1, df2], ignore_index=True)  # 위아래로 이어 붙이기(2025년도 표 밑에 2026년도 표)
print(df.shape)                                # 두 개의 행 수를 더한 값이 나와야 함(잘 합쳐졌는지 확인)
print(df.columns.tolist())
print(df.head())

# 2. 데이터 살펴보기//tf01

print(df['건물용도'].value_counts())
print(df['취소일'].notnull().sum())     # 취소된 거래 수
print(df['권리구분'].value_counts())
print(df[['물건금액(만원)', '건물면적(㎡)', '층', '건축년도']].isnull().sum())
print(df[['물건금액(만원)', '건물면적(㎡)']].describe())

# 3. 전처리(필요한 데이터만 남기기)	-> (아파트, 취소 안 된 거래, 분양권 제외, 면적 300㎡ 이하만)

# 1) 아파트, 정상 거래만 남기기
data = df[df['건물용도'] == '아파트']
data = data[data['취소일'].isnull()]        # 취소 안 된 거래
data = data[data['권리구분'].isnull()]      # 분양권/입주권 제외
data = data[data['건물면적(㎡)'] <= 300]    # 너무 큰 면적 제외

# 2) 필요한 컬럼만 고르고 빈칸 있는 행 지우기		//필요한 컬럼 5개, 빈칸은 dropna()로 지움.
data = data[['자치구명', '건물면적(㎡)', '건축년도', '층', '물건금액(만원)']].dropna().copy()

# 4. 숫자로 바꾸기

# 3) 인코딩: 자치구 이름 -> 숫자	//컴퓨터는 숫자만 계산하니 자치구 이름을 숫자로 변경
gu_map = {g: i for i, g in enumerate(data['자치구명'].unique())}
data['gu_num'] = data['자치구명'].map(gu_map)

# 4) 정규화: 0~1로 줄이기		//면적, 건축년도, 층을 0~1 범위로 맞춤. 큰 숫자가 학습을 흔들지 않게.
for col in ['건물면적(㎡)', '건축년도', '층']:
    data[col + '_norm'] = (data[col] - data[col].min()) / (data[col].max() - data[col].min())

# 5) 정답(y)은 억 단위로 줄이기
data['price_억'] = data['물건금액(만원)'] / 10000

print(data.shape)
print(gu_map)
print(data.head())

# 5. 첫 번째 모델 (번호 인코딩)

import numpy as np
import tensorflow as tf
from sklearn.model_selection import train_test_split

# 1) 자치구 번호도 0~1로 줄이기
data['gu_norm'] = data['gu_num'] / data['gu_num'].max()

# 2) 입력(X)과 정답(y) 나누기
features = ['gu_norm', '건물면적(㎡)_norm', '건축년도_norm', '층_norm']
X = data[features].values
y = data['price_억'].values

# 3) 학습용 80% / 시험용 20%
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 4) 모델 정의
model = tf.keras.Sequential([
    tf.keras.Input(shape=(4,)),
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.Dense(32, activation='relu'),
    tf.keras.layers.Dense(1)
])

# 5) 컴파일
model.compile(optimizer='adam', loss='mse', metrics=['mae'])

# 6) 학습
history = model.fit(X_train, y_train, epochs=30, batch_size=64,
                    validation_data=(X_test, y_test), verbose=1)

# 7) 평가
loss, mae = model.evaluate(X_test, y_test, verbose=0)
print('평균 오차(억):', mae)
#결과 : 평균 오차 3.71억

# 6. 두 번째 모델 : 자치구를 0/1 칸으로 (one-hot, 개선)

# 1) 자치구를 원-핫으로 (자치구마다 0/1 칸 만들기) -> "번호가 크면 비싸다"는 오해가 사라짐.
gu_dummies = pd.get_dummies(data['자치구명']).astype(int)		# 강남구 아파트면 "강남구 칸"만 1이고 나머지 24칸은 0.

"""
 번호 인코딩은 강남구=14, 서초구=23, 노원구=9, 그런데 모델은 숫자를 크기로 받아들여서"번호가 크면 비싸다"는 오해. 
 원-핫은 자치구마다 칸이 따로라서 이런 순서 문제가 없음. 각 자치구가 자기 칸의 가중치(w)를 따로 가지므로,
 "강남구는 비싸다", "노원구는 상대적으로 싸다"를 따로 학습할 수 있음.
"""

# 2) 입력(X) = 정규화한 숫자 3개 + 자치구 0/1 칸 25개 -> 4개에서 28개
X2 = pd.concat([data[['건물면적(㎡)_norm', '건축년도_norm', '층_norm']], gu_dummies], axis=1)
feature_cols = X2.columns.tolist()     # 나중에 저장할 입력 순서
X2 = X2.values.astype('float32')
y = data['price_억'].values

# 3) 학습용/시험용 분리
X_train, X_test, y_train, y_test = train_test_split(X2, y, test_size=0.2, random_state=42)

# 4) 모델 (입력 개수만 바뀜)
model2 = tf.keras.Sequential([
    tf.keras.Input(shape=(X2.shape[1],)),
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.Dense(32, activation='relu'),
    tf.keras.layers.Dense(1)
])
model2.compile(optimizer='adam', loss='mse', metrics=['mae'])

# 5) 학습과 평가
history2 = model2.fit(X_train, y_train, epochs=30, batch_size=64,
                      validation_data=(X_test, y_test), verbose=1)
loss, mae = model2.evaluate(X_test, y_test, verbose=0)
print('원-핫 적용 후 평균 오차(억):', mae)
#결과 : 평균 오차 2.50억

# 7. 저장

import json

# 1) 모델 저장
model2.save('/content/apartment_model.keras')

# 2) 전처리 정보 저장 (예측할 때 똑같은 규칙을 쓰기 위함)
prep = {
    'area_min': float(data['건물면적(㎡)'].min()),
    'area_max': float(data['건물면적(㎡)'].max()),
    'year_min': int(data['건축년도'].min()),
    'year_max': int(data['건축년도'].max()),
    'floor_min': float(data['층'].min()),
    'floor_max': float(data['층'].max()),
    'gu_list': sorted(data['자치구명'].unique().tolist()),
    'features': feature_cols
}
with open('/content/preprocess.json', 'w', encoding='utf-8') as f:
    json.dump(prep, f, ensure_ascii=False, indent=2)

# 3) 정리한 데이터셋도 저장 (제출물 dataset.csv)
data.to_csv('/content/dataset.csv', index=False, encoding='utf-8-sig')

print('저장 완료')

# 8. 그래프와 예측 테스트

import matplotlib.pyplot as plt

# 1) loss 그래프
plt.plot(history2.history['loss'], label='train loss')
plt.plot(history2.history['val_loss'], label='val loss')
plt.xlabel('epoch')
plt.ylabel('loss')
plt.legend()
plt.show()

# 2) 예측 함수 (저장한 전처리 정보 사용)
with open('/content/preprocess.json', encoding='utf-8') as f:
    prep = json.load(f)

def predict_price(gu, area, year, floor):
    row = {
        '건물면적(㎡)_norm': (area - prep['area_min']) / (prep['area_max'] - prep['area_min']),
        '건축년도_norm': (year - prep['year_min']) / (prep['year_max'] - prep['year_min']),
        '층_norm': (floor - prep['floor_min']) / (prep['floor_max'] - prep['floor_min']),
    }
    for g in prep['gu_list']:
        row[g] = 1 if g == gu else 0
    x = np.array([[row[c] for c in prep['features']]], dtype='float32')
    return model2.predict(x, verbose=0)[0][0]

print('강남구 84㎡ 2015년 10층:', round(float(predict_price('강남구', 84, 2015, 10)), 2), '억')
print('노원구 59㎡ 1995년 5층:', round(float(predict_price('노원구', 59, 1995, 5)), 2), '억')
print('마포구 84㎡ 2010년 15층:', round(float(predict_price('마포구', 84, 2010, 15)), 2), '억')
