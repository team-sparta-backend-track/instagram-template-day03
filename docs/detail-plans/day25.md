# Day 25: Technical Decision Making - 기술적 의사결정

## 🎯 학습 목표
- 지난 24일간 적용한 기술들을 되돌아보며 "왜?"라는 질문에 답하는 시간을 갖습니다.
- 면접이나 포트폴리오에서 사용할 수 있는 "기술적 의사결정 문서(Architecture Decision Record - ADR)"를 작성해봅니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day25` 브랜치 상태*
- 코드 변경 없음. 문서 작업 위주.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: Architecture Decision Record (ADR) 템플릿 작성
- **Task**: `docs/adr/001-why-redis.md` 파일을 생성합니다.
- **내용**: Context(배경), Decision(결정), Consequences(결과).

### 2️⃣ Commit 2: 주요 의사결정 복기
- **Task**:
    1. 왜 Session 대신 JWT를 썼는가?
    2. 왜 N:M 매핑 대신 연결 테이블(Follow)을 엔티티로 승격했는가?
    3. 왜 알림에 Kafka를 썼는가? (DB Polling으로 하면 안 됐나?)
    위 주제 중 하나를 골라 상세히 기술합니다.

### 3️⃣ Commit 3: 아키텍처 다이어그램 업데이트
- **Task**: 최종 아키텍처(LB -> Web Server -> App Server -> DB/Redis/Kafka)를 그림(Mermaid or Image)으로 `README.md`에 추가합니다.

## 💡 핵심 설명 포인트
- "정답은 없다". 모든 선택엔 트레이드오프가 있다.
- 시니어 개발자는 기술의 장점뿐만 아니라 단점과 비용을 아는 사람이다.
