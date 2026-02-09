# Day 14: Integration Testing & Transaction - 통합 테스트

## 🎯 학습 목표
- `@SpringBootTest`를 사용하여 실제 스프링 컨텍스트와 DB를 띄우고 테스트합니다.
- 테스트 환경에서의 `@Transactional` 동작(자동 롤백)을 이해합니다.
- H2 Database를 활용해 테스트 격리성을 확보합니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day14` 브랜치 상태*
1. **Test DB 설정**: `src/test/resources/application.yml`에 H2 인메모리 DB 설정이 되어 있어야 합니다.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: 통합 테스트 환경 구축
- **Task**: `PostIntegrationTest`를 만들고 `@SpringBootTest`와 `@Transactional`을 붙입니다.
- **설명**: 스프링 부트가 실제로 뜬다 = 무겁다. 하지만 실제 환경과 가장 유사하다.

### 2️⃣ Commit 2: 전체 흐름 검증
- **Task**: 회원 가입 -> 로그인 -> 글 작성 -> 조회 까지 이어지는 시나리오를 하나의 테스트 메소드로 작성합니다.
- **설명**: 컨트롤러부터 DB까지 데이터가 잘 흐르는지 확인.

### 3️⃣ Commit 3: 롤백 테스트
- **Task**: `@Transactional`을 붙였을 때 테스트가 끝나면 DB가 초기화되는지(`count` 체크) 확인합니다.
- **설명**: 테스트끼리 데이터 간섭을 없애기 위해 필수.

### 4️⃣ Commit 4: 트랜잭션 전파(Propagation) 맛보기 (심화/선택)
- **Task**: 서비스 내에서 예외가 터졌을 때 DB에 데이터가 남는지 안 남는지 확인합니다.
- **설명**: 원자성(Atomicity). "다 되거나, 아예 안 되거나".

## 💡 핵심 설명 포인트
- **언제 통합 테스트를 하나요?**: 외부 라이브러리 연동, SQL 쿼리 매핑 검증, 트랜잭션 동작 확인 시.
- **테스트 피라미드**: 단위 테스트를 많이, 통합 테스트는 적절히.
