# pj_publish 개념 노트 (2026-10-07)

> 사내 규정 CSV를 근거로 질문에 답하는 **RAG 챗봇** 프로젝트.
> 초보자 기준으로, 코드에서 쓰이는 개념을 순서대로 정리한다.

---

## 1. 폴더 구조

```
pj_publish/
├─ .env                      # OpenAI API 키 보관 (절대 공개/커밋 금지)
└─ rag/
   ├─ app.py                 # 터미널(CLI) 버전
   ├─ app_web.py             # 웹(Streamlit) 버전
   ├─ app_web_regen.py       # 웹 버전 + "캐시 삭제/재생성" 버튼
   ├─ requirements.txt       # 필요한 라이브러리 목록
   ├─ origin/
   │   └─ company_manual01.csv   # 원본 규정 데이터 (category, content)
   └─ embedding/
       ├─ em01.csv           # 원본 복사본 (캐시)
       └─ em01.npy           # 문장별 임베딩 벡터 (캐시)
```

- `origin/` = 사람이 관리하는 **원본**
- `embedding/` = 프로그램이 만든 **캐시**(지워도 원본으로 다시 만들 수 있음)

---

## 2. RAG란?

**R**etrieval-**A**ugmented **G**eneration = **검색(Retrieval)으로 근거를 찾아 → 그 근거를 LLM에 붙여서 → 답변을 생성(Generation)** 하는 방식.

### 왜 필요한가?
- LLM(gpt-4o-mini)은 **우리 회사 규정을 모른다.**
- 그냥 물어보면 그럴듯하게 지어낸다(= 환각, hallucination).
- 그래서 규정 문장을 먼저 찾아서 "이 내용만 보고 답해"라고 알려준다.

### 이 프로젝트의 흐름

```
[준비 단계 - 최초 1회]
 company_manual01.csv ─(문장마다 임베딩)→ em01.npy 저장

[질문할 때마다]
 질문 ─(임베딩)→ 질문 벡터
        │
        ▼
 문서 벡터들과 코사인 유사도 계산 → 가장 비슷한 Top-K 문장 선택
        │
        ▼
 프롬프트 = "이 규정만 근거로 답해" + Top-K 문장 + 질문
        │
        ▼
 LLM(gpt-4o-mini) → 답변 출력
```

---

## 3. 핵심 개념 상세

### 3-1. 임베딩 (Embedding)
- 문장을 **숫자 목록(벡터)** 으로 바꾸는 것.
- 모델: `text-embedding-3-small` → 문장 하나가 **1536개 숫자**가 된다.
- 의미가 비슷한 문장은 벡터도 비슷한 방향을 가진다.
  - "연차를 반차로 쓸 수 있어?" ↔ "연차는 1시간 단위로 분할 사용이 가능하다."
  - 단어는 달라도 **의미**가 가까워서 찾아진다. (키워드 검색과의 차이점)

코드: `get_embedding(text)`

```python
resp = client.embeddings.create(model=EMBED_MODEL, input=text)
return np.array(resp.data[0].embedding, dtype=np.float32)
```

### 3-2. 코사인 유사도 (Cosine Similarity)
- 두 벡터가 **얼마나 같은 방향을 보는지** 재는 값 (-1 ~ 1, 1에 가까울수록 비슷).
- 공식: `(A·B) / (|A| × |B|)`
- 코드 `cosine_similarity_matrix`는 문서 N개 전체를 **한 번에** 계산한다.
  - `emb_matrix @ q_vec` → 내적(행렬 곱)으로 N개 점수가 한꺼번에 나옴
  - `+ 1e-12` → 0으로 나누는 오류 방지용 아주 작은 값

### 3-3. Top-K 검색
- 유사도 점수를 내림차순 정렬해서 **상위 K개**만 가져온다.
- `result.sort_values("similarity", ascending=False).head(top_k)`
- K가 너무 작으면 근거 부족, 너무 크면 관련 없는 문장이 섞인다. (기본값 3, 웹에서는 슬라이더 1~5)

### 3-4. 캐시 (Cache) — 임베딩을 파일로 저장해 재사용
- 문서 임베딩은 **API 호출 = 돈 + 시간**이 든다.
- 그래서 최초 1회만 만들고 `em01.csv` + `em01.npy`로 저장한다.
- 다음 실행부터는 파일만 읽는다. (`load_or_create_index()`)

`load_or_create_index()`의 판단 순서:
1. 캐시 파일 둘 다 있다 → 로드 (+ 검증)
2. 없다 → 원본 CSV 읽기 → 임베딩 생성 → 캐시 저장

**검증 2가지** (캐시가 깨졌는지 확인):
- `content` 컬럼이 있는가
- `em01.npy`의 행 수 == `em01.csv`의 문장 수 인가
  → 둘이 어긋나면 "엉뚱한 문장에 엉뚱한 벡터"가 붙기 때문

> 주의: 원본 CSV를 수정해도 캐시는 **자동으로 갱신되지 않는다.**
> → `embedding/` 폴더를 지우거나, `app_web_regen.py`의 재생성 버튼을 쓴다.

### 3-5. 프롬프트 설계 (`ask_llm`)
프롬프트의 구성 요소:
| 부분 | 역할 |
|---|---|
| 역할 부여 ("인사/총무 담당자") | 말투와 관점 고정 |
| `[회사 규정]` | 검색된 Top-K 문장 (= 근거) |
| "근거만 사용" | 환각 억제 |
| "없으면 '규정에 명시되어 있지 않습니다.'" | 모르는 건 모른다고 답하게 함 |
| `[답변 형식]` 결론 + 근거 | 출력 형태 통일 |

- 추천 질문 중 "명예퇴직시 퇴직금 정산 방법은?"은 CSV에 관련 규정이 없다.
  → "규정에 명시되어 있지 않습니다."가 나오는지 **확인용 질문**으로 좋다.

### 3-6. `.env`와 API 키
- `python-dotenv`의 `load_dotenv()`가 `.env` 파일 내용을 환경변수로 읽어온다.
- `os.getenv("OPENAI_API_KEY")`로 꺼내서 `OpenAI(api_key=...)`에 전달.
- 코드에 키를 직접 쓰지 않는 이유: Git에 올라가면 **키가 유출**되기 때문.
- `.env`는 반드시 `.gitignore`에 넣을 것.

### 3-7. 경로 계산 방식
```python
APP_DIR     = os.path.dirname(os.path.abspath(__file__))  # ...\rag
PROJECT_DIR = os.path.dirname(APP_DIR)                    # ...\pj_publish
ENV_PATH    = os.path.join(PROJECT_DIR, ".env")
```
- `__file__` = 지금 실행 중인 파이썬 파일 위치
- 이렇게 **파일 기준 상대 위치**로 계산하면, 어디서 실행해도 경로가 안 틀어진다.

---

## 4. 세 파일의 차이

| 구분 | app.py | app_web.py | app_web_regen.py |
|---|---|---|---|
| 화면 | 터미널 `input()` | Streamlit 웹 | Streamlit 웹 |
| 실행 | `python app.py` | `streamlit run app_web.py` | `streamlit run app_web_regen.py` |
| 반복 질문 | `while True` 루프 | 버튼 클릭 | 버튼 클릭 |
| 인덱스 재사용 | 프로그램 시작 시 1회 로드 | `st.cache_resource` | `st.session_state` |
| 캐시 재생성 | 폴더 직접 삭제 | 폴더 직접 삭제 | **사이드바 버튼** + 진행률 표시 |

- 검색/임베딩/LLM 호출 함수는 **세 파일이 거의 동일**하다. (UI만 다름)
- 종료: CLI에서는 `exit` / `quit` / `나가기` 입력.

---

## 5. Streamlit 개념

### 5-1. 리런(rerun) 구조
- Streamlit은 **버튼을 누르거나 입력이 바뀔 때마다 파이썬 파일을 처음부터 다시 실행**한다.
- 그래서 아무 대책이 없으면 매번 CSV/npy를 다시 읽게 된다.

### 5-2. `st.cache_resource` (app_web.py)
- 무거운 객체(인덱스)를 **한 번만 만들어 놓고 재사용**하게 하는 데코레이터.
- `get_index_cached()`가 리런마다 호출돼도 실제 로드는 처음 1번만.

### 5-3. `st.session_state` (app_web_regen.py)
- 리런이 돼도 **값이 유지되는 사용자별 저장소(딕셔너리)**.
- 사용하는 키:
  - `docs_df`, `doc_emb` : 문서와 임베딩
  - `ready` : 인덱스 준비 완료 여부
  - `is_building` : 재생성 진행 중 여부 → 이 동안 버튼 비활성화(`disabled=`)로 **중복 클릭 방지**

### 5-4. "해결책 A" — 재생성 직후 바로 반영
- 캐시를 지우고 다시 만든 뒤, 결과를 `session_state`에 **즉시 넣는다.**
- 덕분에 `streamlit run`을 다시 하지 않아도 같은 화면에서 바로 질문 가능.
- `st.cache_data.clear()`, `st.cache_resource.clear()`로 이전 캐시도 비워서 옛 데이터가 남지 않게 한다.

### 5-5. 자주 쓰는 UI 요소
| 코드 | 설명 |
|---|---|
| `st.sidebar` | 왼쪽 설정 패널 |
| `st.slider` | Top-K 선택 |
| `st.toggle` | 유사도 표시 on/off |
| `st.text_input` / `st.button` | 질문 입력 / 실행 |
| `st.columns([1,1])` | 화면 2분할 (왼쪽 답변, 오른쪽 참조 규정) |
| `st.spinner` | "처리 중..." 표시 |
| `st.progress` | 진행률 바 (임베딩 i/N) |
| `st.dataframe` | 표 출력 |
| `st.stop()` | 오류 시 아래 코드 실행 중단 |

---

## 6. 사용한 라이브러리 (requirements.txt)

| 라이브러리 | 용도 |
|---|---|
| `openai` | 임베딩/챗 API 호출 |
| `python-dotenv` | `.env` 읽기 |
| `pandas` | CSV를 표(DataFrame)로 다루기 |
| `numpy` | 벡터·행렬 계산, `.npy` 저장 |
| `streamlit` | 웹 UI |

설치: `pip install -r requirements.txt`

---

## 7. 데이터 형식 (company_manual01.csv)

```
category,content
출장비 규정,국내 출장은 1일 최대 10만원까지 식비를 지원한다.
휴가 규정,연차는 1시간 단위로 분할 사용이 가능하다.
...
```
- 필수 컬럼: **`content`** (임베딩 대상). 없으면 오류.
- `category`는 선택. 있으면 웹 화면의 "참조 규정" 표에 함께 표시.
- 현재 9문장 (출장비 3, 근무 2, 휴가 2, 보안 2).
- **한 줄 = 한 개의 규정 문장**으로 쪼개 두는 게 검색 정확도에 유리하다(청킹의 가장 단순한 형태).

---

## 8. 실행 방법

```powershell
cd C:\SOO\AiPublish\pj_publish\rag
pip install -r requirements.txt

python app.py                          # CLI
streamlit run app_web.py               # 웹
streamlit run app_web_regen.py         # 웹 + 캐시 재생성 버튼
```

---

## 9. 에러 & 주의점

- **429 insufficient_quota** : OpenAI 결제/쿼터 문제. 코드 버그가 아님.
- **`.env`에 OPENAI_API_KEY 없음** : 시작 시 `ValueError` 발생. `.env` 위치(= `pj_publish/`)와 변수명 확인.
- **em01.npy 행 수 불일치** : 캐시 폴더를 지우고 재생성.
- **CSV 수정했는데 답이 안 바뀜** : 캐시가 옛 데이터. 재생성 필요.
- `app_web_regen.py`의 변수명 `PROJECTS_DIR` / 에러 메시지의 "Projects 폴더"는 옛 이름이 남은 것.
  실제로는 `rag`의 상위 폴더(= `pj_publish`)를 가리키므로 동작에는 문제 없다.
- 질문마다 **질문 임베딩 API 1회 + LLM API 1회**가 호출된다. (문서 임베딩은 캐시라 호출 없음)

---

## 10. 한계와 개선 아이디어 (다음 학습 거리)

- 문서가 많아지면 NumPy 전체 비교가 느려짐 → **벡터 DB** (FAISS, Chroma 등)
- 문서 임베딩을 한 문장씩 호출 → **배치 호출**로 속도·비용 개선
- 유사도가 너무 낮은 문장은 걸러내는 **임계값(threshold)** 추가
- PDF/긴 문서 지원 → **청킹(chunking)** 전략 필요
- 대화 맥락 유지(이전 질문 기억) 기능 없음
