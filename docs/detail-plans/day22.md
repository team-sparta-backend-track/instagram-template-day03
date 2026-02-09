# Day 22: Async & Kafka - 이벤트 기반 아키텍처

## 🎯 학습 목표
- 강한 결합을 끊어내는 이벤트 기반(Event-Driven) 설계의 장점을 이해합니다.
- 메시지 큐(Message Queue)인 Kafka의 기본 개념(Topic, Producer, Consumer)을 익힙니다.
- "좋아요"를 눌렀을 때 알림이 발송되는 과정을 비동기로 처리해봅니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day22` 브랜치 상태*
1. **Infrastructure**: `docker-compose.yml`에 Zookeeper와 Kafka를 추가해둡니다.
2. **Dependency**: `spring-kafka` 추가.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: Spring Event (ApplicationEventPublisher) - 1단계
- **Task**: Kafka 도입 전, 스프링 내부 이벤트를 사용해 로직을 분리해봅니다. `PostLikedEvent` 발행 -> `NotificationEventListener` 수신.
- **설명**: 이것만으로도 소스 코드 의존성은 끊기지만, 같은 트랜잭션/JVM 안에 있다.

### 2️⃣ Commit 2: Kafka Producer 구현
- **Task**: 좋아요 로직에서 이벤트를 발행하는 대신 KafkaTemplate으로 `notification-topic`에 메시지를 쏘도록 변경합니다.

### 3️⃣ Commit 3: Kafka Consumer 구현
- **Task**: `@KafkaListener`를 사용하여 토픽에서 메시지를 꺼내오고, (가상의) 알림 발송 로직을 수행합니다.

### 4️⃣ Commit 4: 비동기 처리 확인
- **Task**: 알림 발송에 `Thread.sleep(3000)`을 걸어두고, 좋아요 API 응답 속도에는 영향이 없음을 확인합니다.

## 💡 핵심 설명 포인트
- **Decoupling**: 알림 서버가 죽어도 좋아요 기능은 멈추지 않는다.
- **Eventual Consistency**: "언젠가는 맞춰진다".
