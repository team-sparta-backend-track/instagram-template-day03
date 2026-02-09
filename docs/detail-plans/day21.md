# Day 21: Redis Performance (Ranking) - 실시간 랭킹

## 🎯 학습 목표
- 인메모리 DB인 Redis의 특징(Key-Value, 고성능)을 이해합니다.
- Redis의 자료구조 중 `Sorted Set (ZSET)`을 활용해 실시간 랭킹 시스템을 구현합니다.
- Spring Data Redis 설정 및 활용법을 익힙니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day21` 브랜치 상태*
1. **Docker**: Redis 컨테이너를 로컬에 띄워둡니다.
2. **Dependency**: `spring-boot-starter-data-redis` 추가.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: RedisConfig 설정
- **Task**: `RedisTemplate<String, String>` 빈을 등록합니다. 호스트와 포트를 `application.yml`에서 가져오도록 설정합니다.

### 2️⃣ Commit 2: ZSET 연산 실습
- **Task**: `redisTemplate.opsForZSet()`을 사용하여 데이터를 넣고(`add`), 점수를 올리고(`incrementScore`), 순위를 조회(`reverseRange`) 하는 테스트 코드를 작성합니다.

### 3️⃣ Commit 3: 인기 해시태그 랭킹 구현
- **Task**: 게시물 작성/검색 시 해당 해시태그의 점수를 +1 하는 로직을 추가합니다.
- **설명**: DB로 하려면 `GROUP BY` + `COUNT`로 매번 쿼리해야 하는데, Redis는 O(logN)으로 끝난다.

### 4️⃣ Commit 4: 랭킹 API 노출
- **Task**: `GET /api/hashtags/rank` API를 만들어 Top 10 해시태그를 반환합니다.

## 💡 핵심 설명 포인트
- **Cache vs Storage**: 레디스를 캐시로 쓸 것인가(날아가도 됨), 저장소로 쓸 것인가(영속성 필요).
- **In-memory**: 빠르지만 비싸다. 아껴 써야 한다.
