# Day 9: N+1 문제와 성능 최적화

## 🎯 학습 목표
- JPA(Hibernate) 사용 시 가장 빈번하게 발생하는 성능 이슈인 N+1 문제를 이해합니다.
- 쿼리 로그를 보며 "내가 의도하지 않은 쿼리"가 나가는 현상을 목격합니다.
- `Fetch Join`을 통해 이를 해결하는 방법을 배웁니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day9` 브랜치 상태*
1. **데이터 준비**: `dml.sql` 등을 활용해 회원이 10명, 각 회원이 게시물을 5개씩 작성한 상태를 만들어 N+1이 확연히 드러나도록 합니다.
2. **로깅 설정**: `application.yml`에 `hibernate.SQL` 옵션을 켜서 콘솔에 쿼리가 찍히게 해둡니다.
3. **지연 로딩 설정**: 모든 `@ManyToOne`을 `FetchType.LAZY`로 설정해둡니다(권장사항이지만 N+1 발생 확인용).

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: N+1 문제 재현
- **Task**: 모든 게시물을 조회(`findAll`)하고, 루프를 돌며 작성자의 닉네임을 출력하는 테스트 코드(혹은 API)를 실행합니다.
- **관찰**: `SELECT * FROM Post` 1번 + `SELECT * FROM Member` N번 발생 확인.
- **설명**: "지연 로딩(Lazy Loading)이라도 루프 돌며 접근하면 결국 쿼리가 나갑니다."

### 2️⃣ Commit 2: Fetch Join 적용 (JPQL)
- **Task**: `PostRepository`에 `@Query("select p from Post p join fetch p.member")`를 작성합니다.
- **설명**: "가져올 때 한방 쿼리(Join)로 다 가져오자". 즉시 로딩(EAGER)과는 다르게 내가 원할 때만 조인한다.

### 3️⃣ Commit 3: EntityGraph 활용 (선택)
- **Task**: JPQL 대신 `@EntityGraph` 애노테이션으로 해결하는 방법도 간단히 보여줍니다.
- **설명**: 간단한 경우엔 좋지만 복잡해지면 JPQL이 낫다.

### 4️⃣ Commit 4: 컬렉션 조회 최적화 (Batch Size)
- **Task**: 게시물 조회 시 댓글(`List<Comment>`)까지 가져올 때 뻥튀기되는 문제를 `default_batch_fetch_size` 설정으로 해결해봅니다.

## 💡 핵심 설명 포인트
- **즉시 로딩(EAGER)은 독이다**: 무조건 지연 로딩(LAZY)을 쓰고, 필요할 때만 Fetch Join.
- **쿼리 카운트**: "API 호출 한 번에 쿼리가 100개 나가면 서버 터집니다."
