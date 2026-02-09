# Day 3: SQL 심폐소생술 (2) - 실전 DML 정복 (SELECT 특강)

## 🎯 학습 목표
- 관계형 데이터베이스의 꽃, `SELECT` 문을 자유자재로 다룬다.
- `JOIN`의 종류(Inner, Left Outer)를 이해하고 상황에 맞춰 사용한다.
- 데이터를 그룹핑(`GROUP BY`)하고 집계(`COUNT`, `SUM`)하여 통계 데이터를 추출해본다.
- 서브쿼리(Subquery)를 활용해 복잡한 조건의 데이터를 조회한다.
- (제외 항목: 윈도우 함수, 프로시저, 트리거, 인덱스 등 심화/운영 토픽은 과감히 배제).

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day3` 브랜치 상태*
1. **dml.sql**: 샘플 데이터 INSERT 구문이 준비되어 있어야 합니다. (라이브에서 타이핑하면 시간 낭비).
   - 회원 5명 (`user1` ~ `user5`).
   - 게시물 20개 (작성자 섞어서, 개수 다르게).
   - 팔로우 관계 몇 개.

---

## ⏱️ 2시간 라이브 코딩 타임테이블 (Minute-by-Minute)

### 00:00 ~ 00:15 (15분) - Part 1: 데이터 준비 (INSERT)
*파일: `src/main/resources/sql/dml.sql`*
- **(0~5분) 오프닝**: "데이터가 있어야 조회도 할 수 있습니다." 오늘 배울 내용(조회, 조인, 집계) 요약.
- **(5~15분) 샘플 데이터 붓기**:
    - 준비된 `INSERT` 문 실행 (H2 Console).
    - **[Live Coding]**: 
      ```sql
      -- 유령 회원(게시물 없는 사람) 하나 만들기
      INSERT INTO members (email, nickname) VALUES ('ghost@test.com', '유령회원');
      ```
    - 데이터가 잘 들어갔는지 `SELECT * FROM members;` 로 확인.

### 00:15 ~ 00:40 (25분) - Part 2: SELECT, WHERE, ORDER BY
*파일: `dml.sql` (쿼리 작성 및 실행)*
- **(15~25분) 기본 조회와 필터링**:
    - "닉네임이 '철수'인 사람만 뽑아보자." -> `WHERE`.
    - "이메일이 'google.com'으로 끝나는 사람?" -> `LIKE '%@google.com'`.
- **(25~40분) 정렬과 페이징**:
    - "최신 게시물 순서대로 보자." -> `ORDER BY created_at DESC`.
    - "한 페이지에 5개씩만 보여준다면?" -> `LIMIT 5 OFFSET 0`.
    - **[설명]**: 게시판 만들 때 필수인 SQL 3대장 (`WHERE`, `ORDER BY`, `LIMIT`) 강조.

### 00:40 ~ 01:00 (20분) - Part 3: The Power of JOIN (교집합과 합집합)
*파일: `dml.sql`*
- **(40~50분) INNER JOIN (교집합)**:
    - 상황: "게시물 제목과 작성자 닉네임을 같이 보고 싶다."
    - **[Live Coding]**:
      ```sql
      SELECT p.title, m.nickname
      FROM posts p
      INNER JOIN members m ON p.member_id = m.id;
      ```
    - **[설명]**: `p.member_id`와 `m.id`가 같은 것만 연결한다. 탈퇴한 회원의 글은? (참조 무결성이 있다면 글도 삭제됐겠지만, 없다면 INNER JOIN시 누락됨).   
- **(50~60분) LEFT OUTER JOIN (합집합)**:
    - 상황: "게시물을 쓰지 않은 회원도 모두 보고 싶다. 글이 없으면 NULL로 표시해라."
    - **[Live Coding]**:
      ```sql
      SELECT m.nickname, p.title
      FROM members m
      LEFT JOIN posts p ON m.id = p.member_id;
      ```
    - 유령 회원이 리스트에 포함되는지 확인.
    - **[핵심]**: "누구가 주인공인가?" (Members 기준이면 LEFT JOIN).

### 01:00 ~ 01:10 (10분) - 휴식 (Break)
- 질의응답: "Right Join은 안 쓰나요?" (거의 안 씀. Left로 통일하는 게 가독성에 좋음).

### 01:10 ~ 01:40 (30분) - Part 4: Aggregation (집계와 그룹핑)
*파일: `dml.sql`*
- **(70~80분) 단순 집계 (COUNT, SUM, AVG)**:
    - "전체 회원 수는?" -> `COUNT(*)`.
    - "전체 게시물 조회수 합은?" -> `SUM(view_count)`.
- **(80~90분) GROUP BY**:
    - 상황: "회원별로 게시물을 몇 개 썼는지 통계를 내보자."
    - **[Live Coding]**:
      ```sql
      SELECT m.nickname, COUNT(p.id) as post_count
      FROM members m
      LEFT JOIN posts p ON m.id = p.member_id
      GROUP BY m.nickname;
      ```
    - **[주의점]**: `GROUP BY`에 참여하지 않은 컬럼을 `SELECT` 하면 에러(MySQL 5.7+ default) 혹은 랜덤값(오라클 등) 나옴 설명.
- **(90~100분) HAVING**:
    - 상황: "게시물을 3개 이상 쓴 '헤비 유저'만 뽑아보자."
    - **[Live Coding]**:
      ```sql
      ...
      GROUP BY m.nickname
      HAVING COUNT(p.id) >= 3;
      ```
    - `WHERE` vs `HAVING` 차이점 (집계 전 필터링 vs 집계 후 필터링).

### 01:40 ~ 01:55 (15분) - Part 5: Subquery (쿼리 안의 쿼리)
*파일: `dml.sql`*
- **(100~110분) WHERE 절 서브쿼리**:
    - 상황: "가장 조회수가 높은 게시물의 제목을 알고 싶다."
    - **[Live Coding]**:
      ```sql
      SELECT title 
      FROM posts 
      WHERE view_count = (SELECT MAX(view_count) FROM posts);
      ```
- **(110~115분) FROM 절 서브쿼리 (Inline View) (간단히)**:
    - "가상의 테이블처럼 쿼리 결과를 다시 쿼리하기." (복잡해서 맛만 보여줌).

### 01:55 ~ 02:00 (5분) - 마무리 및 과제 안내
- **오늘의 요약**: 
    - 조회는 `SELECT`, 조건은 `WHERE`, 정렬은 `ORDER BY`.
    - 테이블 연결은 `JOIN`, 통계는 `GROUP BY`.
- **내일 예고**: "이 귀찮은 SQL을 자바 코드로 대신 짜주는 도구(JPA)를 배웁니다."
- **과제**: "자기가 설계한 댓글 테이블에 더미 데이터 5개 넣고, 특정 게시물의 모든 댓글을 작성자 이름과 함께 조회하는 쿼리 짜오기."

---

## 💡 강사 팁 (Instructor Tips)
- `JOIN` 설명할 때 벤 다이어그램을 칠판에 그리면 이해가 빠릅니다.
- 쿼리 실행 순서(`FROM` -> `JOIN` -> `WHERE` -> `GROUP BY` -> `HAVING` -> `SELECT` -> `ORDER BY`)를 한 번 짚어주면 아주 좋습니다. (왜 별칭(Alias)을 WHERE절에서 못 쓰는지 이해시킬 수 있음).
- "실무에서 이렇게 긴 SQL 짜나요?" -> "JPA 써도 결국 이 쿼리가 나갑니다. 알아야 튜닝합니다."
