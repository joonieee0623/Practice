import json
import numpy as np
import tensorflow as tf

# 저장한 모델과 전처리 정보 불러오기
model = tf.keras.models.load_model('/content/apartment_model.keras')
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
    return float(model.predict(x, verbose=0)[0][0])

print('=== 서울 아파트 가격 예측 ===')
print('자치구 목록:', ', '.join(prep['gu_list']))

gu = input('자치구 (예: 강남구): ')
if gu not in prep['gu_list']:
    print('없는 자치구입니다.')
else:
    area = float(input('전용면적 ㎡ (예: 84): '))
    year = int(input('건축년도 (예: 2015): '))
    floor = int(input('층 (예: 10): '))
    price = predict_price(gu, area, year, floor)
    print(f'\n예상 가격: 약 {price:.2f}억 원')
