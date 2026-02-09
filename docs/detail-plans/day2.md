# Day 2: SQL 심폐소생술 (1) - DDL과 데이터베이스 모델링

## 🎯 학습 목표
- 관계형 데이터베이스(RDB)의 핵심 개념(Entity, Attribute, Key, Relationship)을 이해한다.
- 정규화(Normalization)의 필요성("왜 데이터를 쪼개야 하는가?")을 깨닫는다.
- SQL DDL(`CREATE`)을 사용하여 테이블을 설계하고 제약조건(Constraint)을 걸 수 있다.
- 1:N, M:N 관계를 이해하고 외래키(FK)로 구현할 수 있다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day2` 브랜치 상태*
1. **ddl.sql 초기화**: `src/main/resources/sql/ddl.sql` 파일을 생성하되, 내용을 비워둡니다.
2. **ERD 도구 준비**: 칠판이나 draw.io, 혹은 IntelliJ의 Database Diagram 도구를 띄울 준비를 합니다.

---

## ⏱️ 2시간 라이브 코딩 타임테이블 (Minute-by-Minute)

### 00:00 ~ 00:30 (30분) - Part 1: 데이터베이스 기초 이론 (이론 중심)
*파일: 칠판 or 메모장*
- **(0~10분) RDB의 구성 요소**:
    - **Entity (개체)**: "회원", "게시물" 같은 덩어리 -> **Table**로 구현됨.
    - **Attribute (속성)**: 회원의 "이름", "나이" -> **Column**으로 구현됨.
    - **Key (키)**: 
        - 식별자(PK): 주민등록번호처럼 나를 유일하게 구분하는 것.
        - 외래키(FK): 다른 테이블의 PK를 가리키는 손가락.
- **(10~20분) 정규화(Normalization) 이야기**:
    - "왜 엑셀 시트 하나에 다 때려박으면 안 되나요?"
    - 중복 데이터의 문제점(Update Anomaly) 설명.
    - **제1정규형**: 컬럼 하나엔 하나의 값만. (취미 컬럼에 "축구,농구" 넣지 마라).
    - **제2/3정규형**: "함수 종속성" 같은 어려운 말 빼고, **"주제에 안 맞는 컬럼은 테이블로 쪼개라"** 로 설명.
- **(20~30분) 관계 차수 (Cardinality)**:
    - **1:1**: 남편 - 아내 (법적).
    - **1:N**: 부서 - 직원, 게시물 - 댓글. (가장 흔함).
    - **M:N**: 학생 - 수업. (그대로 구현 불가, 중간 테이블 필요).

### 00:30 ~ 00:50 (20분) - Part 2: Member 테이블 설계 (DDL)
*파일: `src/main/resources/sql/ddl.sql`*
- **(30~40분) CREATE TABLE**:
    - `ddl.sql` 파일에 `members` 테이블 생성문 작성.
    - **Data Types**: 
        - `INT` vs `BIGINT` (ID는 21억 넘을 수 있으니 BIGINT).
        - `VARCHAR` (짧은 글) vs `TEXT` (긴 글).
    - **[Live Coding]**:
      ```sql
      CREATE TABLE members (
          id BIGINT AUTO_INCREMENT,
          email VARCHAR(255),
          nickname VARCHAR(50),
          password VARCHAR(100),
          created_at DATETIME,
          PRIMARY KEY (id)
      );
      ```
- **(40~50분) 제약조건(Constraint) 추가**:
    - **NOT NULL**: "이메일 없는 회원이 존재할 수 있나?" -> 필수 값 지정.
    - **UNIQUE**: "이메일이 중복되면 로그인 할 때 누굴 찾아야 함?" -> 중복 방지.
    - 완성된 쿼리를 H2 Console 등에서 실행하여 테이블 생성 확인.

### 00:50 ~ 01:00 (10분) - 휴식 (Break)
- 질의응답: "저는 PK를 UUID로 하고 싶은데요?" (장단점 간략 언급).

### 01:00 ~ 01:30 (30분) - Part 3: 1:N 관계 - Post 테이블
*파일: `src/main/resources/sql/ddl.sql`*
- **(60~70분) 게시물 테이블 설계**:
    - 필요한 컬럼 나열: `title`, `content`, `view_count` 등.
    - "작성자는 어떻게 저장하죠?" -> `writer_name` (X), `member_id` (O).
- **(70~80분) Foreign Key 설정**:
    - **[Live Coding]**:
      ```sql
      CREATE TABLE posts (
          id BIGINT AUTO_INCREMENT PRIMARY KEY,
          member_id BIGINT NOT NULL,
          contents TEXT,
          created_at DATETIME,
          FOREIGN KEY (member_id) REFERENCES members(id)
      );
      ```
- **(80~90분) 참조 무결성 (Referential Integrity)**:
    - 없는 회원 ID(999번)로 게시물 insert 시도 -> 에러 발생 확인.
    - "부모(회원)가 없는데 자식(게시물)이 태어날 수 없다."
    - (심화) `ON DELETE CASCADE` 등은 JPA에서 다룰지 DB 레벨에서 다룰지 고민 포인트 던지기.

### 01:30 ~ 01:50 (20분) - Part 4: M:N 관계의 해소 - Follow 테이블
*파일: `src/main/resources/sql/ddl.sql`*
- **(90~100분) 팔로우 기능의 논리적 설계**:
    - "철수가 영희를 팔로우한다".
    - `Member` 테이블에 `following_list` 컬럼? -> 정규화 위반(1정규형).
    - `Follow`라는 **행위** 자체가 엔터티(테이블)가 되어야 함.
- **(100~110분) 중간 테이블 구현**:
    - 누가(`from_member_id`) 누구를(`to_member_id`).
    - **[Live Coding]**:
      ```sql
      CREATE TABLE follows (
          id BIGINT AUTO_INCREMENT PRIMARY KEY, -- 대리키
          from_member_id BIGINT NOT NULL,
          to_member_id BIGINT NOT NULL,
          created_at DATETIME,
          FOREIGN KEY (from_member_id) REFERENCES members(id),
          FOREIGN KEY (to_member_id) REFERENCES members(id),
          UNIQUE (from_member_id, to_member_id) -- 중복 팔로우 방지
      );
      ```

### 01:50 ~ 02:00 (10분) - 마무리 및 과제 안내
- **(110~115분) 오늘 요약**:
    - 테이블 = 엑셀 시트인데 규칙이 엄격함.
    - PK는 주민번호, FK는 부모님 주민번호.
    - M:N은 중간 테이블로 푼다.
- **(115~120분) 과제 안내**:
    - "댓글(Comment) 테이블 설계해오기".
    - 힌트: 댓글은 게시물(Post)에도 속하고, 작성자(Member)에게도 속함. 1:N 이 두 개.

---

## 💡 강사 팁 (Instructor Tips)
- 인덱스(Index)는 오늘 다루지 않습니다. (학생들 머리 터짐 방지). "책의 맨 뒤에 있는 색인" 정도로만 비유하고 넘어가세요.
- DDL 작성 시 `AUTO_INCREMENT`는 DB마다 문법이 다를 수 있음(MySQL 기준 설명, Oracle은 Sequence). 우리는 H2(MySQL 모드)를 씁니다.
- **가장 중요한 질문**: "이거 외워야 하나요?" -> "아니요, 저도 구글링해서 씁니다. 하지만 **구조**는 머릿속에 있어야 합니다."
