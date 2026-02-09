# Day 23: Concurrency & Locks - 동시성 이슈 정복

## 🎯 학습 목표
- 멀티 스레드 환경에서 공유 자원(좋아요 수, 재고 등)에 동시에 접근할 때 생기는 레이스 컨디션(Race Condition)을 눈으로 확인합니다.
- Java `synchronized`, DB 비관적/낙관적 락, Redis 분산 락의 차이를 이해하고 적용해봅니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day23` 브랜치 상태*
1. **테스트 케이스**: `ExecutorService`를 사용해 동시에 100명이 좋아요를 누르는 테스트 코드를 미리 작성해둡니다 (실패하도록).

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: 동시성 이슈 재현
- **Task**: 준비된 테스트를 실행하여 100명이 눌렀는데 좋아요가 70개만 카운트되는 현상을 목격합니다.
- **설명**: Read-Modify-Write 연산의 원자성 결여.

### 2️⃣ Commit 2: 비관적 락 (Pessimistic Lock)
- **Task**: `Repository` 메소드에 `@Lock(PESSIMISTIC_WRITE)`를 걸어 해결해봅니다.
- **설명**: 확실하지만 데드락 위험과 성능 저하.

### 3️⃣ Commit 3: 낙관적 락 (Optimistic Lock)
- **Task**: 엔티티에 `@Version` 필드를 추가하고 낙관적 락을 적용해봅니다.
- **설명**: 충돌이 적을 때 유리. 충돌 시 재시도 로직 필요.

### 4️⃣ Commit 4: Redis 분산 락 (Lettuce/Redisson)
- **Task**: 분산 환경(서버가 여러 대)일 때를 가정하여 Redis Lock을 적용해봅니다. AOP로 깔끔하게 분리하는 것까지 보여줍니다(시간 되면).

## 💡 핵심 설명 포인트
- **Transaction Isolation**: DB 격리 수준만으로는 해결되지 않는 문제들.
- **Trade-off**: 정합성(락) vs 성능(No Lock).
