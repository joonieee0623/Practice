import pymupdf
import os

pdf_file_path = "data/2024 통계로 보는 우리나라 노동시장의 모습(PDF).pdf"
doc = pymupdf.open(pdf_file_path)

full_text = ''

for page in doc:                # 문서 페이지 반복
    text = page.get_text()      # 페이지 텍스트 추출
    full_text += text

pdf_file_name = os.path.basename(pdf_file_path)
pdf_file_name = os.path.splitext(pdf_file_name)[0]  # 확장자 제거

txt_file_path = f"output/{pdf_file_name}.txt"
with open(txt_file_path, 'w', encoding='utf-8') as f:
    f.write(full_text)