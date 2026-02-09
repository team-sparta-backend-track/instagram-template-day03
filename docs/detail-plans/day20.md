# Day 20: WebSocket & STOMP - 실시간 DM

## 🎯 학습 목표
- 웹소켓(WebSocket) 프로토콜을 설정하고 STOMP(Simple Text Oriented Messaging Protocol)의 Pub/Sub 모델을 이해합니다.
- 실시간으로 메시지를 주고받는 채팅 기능을 구현합니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day20` 브랜치 상태*
1. **Dependency**: `spring-boot-starter-websocket` 추가.
2. **Skeleton**: `ChatController`, `WebSocketConfig` 파일 생성 (내용은 비움).

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: WebSocketConfig 설정
- **Task**: `@EnableWebSocketMessageBroker` 설정과 엔드포인트(`/ws-stomp`), 메시지 브로커 prefix(`/sub`, `/pub`)를 설정합니다.
- **설명**: 우체국(Broker)을 세우는 과정.

### 2️⃣ Commit 2: ChatController (Message Handling)
- **Task**: `@MessageMapping("/chat/send")`으로 메시지를 받아 `@SendTo`로 구독자들에게 뿌려주는 메소드를 작성합니다.
- **설명**: HTTP Controller와 비슷하지만 목적지가 다르다.

### 3️⃣ Commit 3: 메시지 영속화 (DB 저장)
- **Task**: 메시지를 중개함과 동시에 RDB(혹은 MongoDB)에 저장하는 로직을 추가합니다.
- **설명**: 나중에 들어온 사람도 지난 대화를 봐야 하니까.

### 4️⃣ Commit 4: 클라이언트 연동 테스트 (w/ APIC or JS)
- **Task**: 크롬 확장 프로그램이나 간단한 JS 클라이언트로 메시지가 실시간으로 오가는 것을 확인합니다.

## 💡 핵심 설명 포인트
- **Session 관리**: 웹소켓 연결도 세션이다. 서버 부하 고려 필요.
- **STOMP**: 날것의 소켓 데이터에 "규격(Header 등)"을 입혀 다루기 쉽게 만든 것.
