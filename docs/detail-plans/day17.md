# Day 17: 팀 프로젝트 3 시작 (Chat) - 웹소켓 맛보기

## 🎯 학습 목표
- HTTP의 한계(Request가 있어야 Response가 있다)를 넘어서는 실시간 통신을 기획합니다.
- 1:1 채팅, 그룹 채팅 등 요구사항에 따른 DB 모델링을 진행합니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day17` 브랜치 상태*
1. **기획 가이드**: 채팅방, 메시지, 읽음 처리, 알림 등의 요구사항 명세.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: Chat 도메인 설계
- **Task**: `ChatRoom`, `ChatMessage` 엔티티 설계. 특히 NoSQL(MongoDB)을 쓰면 좋지만 RDB로 구현할 때의 스키마 제약 사항 논의.

### 2️⃣ Commit 2: 실시간 데이터 흐름 그려보기
- **Task**: 사용자 A가 메시지 전송 -> 서버 수신 -> 사용자 B에게(혹은 구독자들에게) 전송 하는 STOMP 흐름도를 그립니다.

### 3️⃣ Commit 3: API 명세
- **Task**: "채팅방 생성", "이전 대화 내역 조회" API 등을 정의합니다.

## 💡 핵심 설명 포인트
- **Polling vs Push**: 계속 물어볼 것인가(Polling), 서버가 알려줄 것인가(WebSocket).
- HTTP Handshake 후 프로토콜이 업그레이드 된다.
