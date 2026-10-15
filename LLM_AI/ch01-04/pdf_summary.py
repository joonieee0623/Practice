from openai import OpenAI
from dotenv import load_dotenv
import os
import pymupdf

load_dotenv()
api_key = os.getenv('OPENAI_API_KEY')

def pdf_to_txt(pdf_file_path: str):
    doc = pymupdf.open(pdf_file_path)


    header_height = 80
    footer_height = 80

    full_text = ''

    for page in doc:
        rect = page.rect        # 페이지 크기 가져오기

        header = page.get_text(clip= (0, 0, rect.width, header_height))
        footer = page.get_text(clip=(0, rect.height - footer_height, rect.width, rect.height))
        text = page.get_text(clip=(0, header_height, rect.width, rect.height - footer_height))

        full_text += text + '\n------------------------\n'


    # 파일명만 추출
    pdf_file_name = os.path.basename(pdf_file_path)
    pdf_file_name = os.path.splitext(pdf_file_name)[0]         # 확장자 제거

    txt_file_path = f'output/{pdf_file_name}_with_preprocessing.txt'

    with open(txt_file_path, 'w', encoding='utf-8') as f:
        f.write(full_text)

    return txt_file_path

def summarize_txt(file_path: str):

    from summary import summarize_txt as _summarize
    return _summarize(file_path)

def summarize_pdf(pdf_file_path: str, output_file_path: str):
    txt_file_path = pdf_to_txt(pdf_file_path)
    summary = summarize_txt(txt_file_path)

    with open(output_file_path, 'w', encoding='utf-8') as f:
        f.write(summary)

if __name__ == '__main__':
    pdf_file_path = "data/2024 통계로 보는 우리나라 노동시장의 모습(PDF).pdf"
    summarize_pdf(pdf_file_path, 'output/labor_market_summary2.txt')