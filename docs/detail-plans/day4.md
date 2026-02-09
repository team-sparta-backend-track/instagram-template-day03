# Day 4: JPA 매핑과 기본 CRUD - SQL 없이 DB 다루기

## 🎯 학습 목표
- 관계형 데이터베이스(RDB) 테이블을 자바 객체(Entity)로 매핑하는 방법을 익힙니다.
- `JpaRepository`가 제공하는 강력한 CRUD 메소드(`save`, `findById`, `delete`)를 사용해봅니다.
- **영속성 컨텍스트(Persistence Context)**의 핵심 개념인 '변경 감지(Dirty Checking)'를 코드로 직접 체험합니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day4` 브랜치 상태*
1. **POJO 상태**: `Member.java`와 `Post.java`는 어떠한 JPA 애노테이션도 없는 순수 자바 클래스 상태여야 합니다.
2. **Repository 초기화**: `MemberRepository` 등의 인터페이스가 빈 상태 혹은 존재하지 않는 상태.
3. **H2 Console**: 브라우저에서 H2 콘솔에 접속할 수 있는지 확인.

---

## ⏱️ 2시간 라이브 코딩 타임테이블 (Minute-by-Minute)

### 00:00 ~ 00:20 (20분) - Part 1: Member Entity 매핑
*파일: `Member.java`*
- **(0~5분) 오프닝**: "어제 짠 SQL(CREATE TABLE...) 기억나시죠? 그걸 자바가 알아서 하게 만듭니다."
- **(5~15분) 기본 어노테이션 매핑**:
    - `@Entity`: "이 클래스는 DB 테이블 대용입니다."
    - `@Id`, `@GeneratedValue(strategy = IDENTITY)`: "PK는 자동 증가합니다."
    - `@Column`: "필드명과 컬럼명이 다르거나, 제약조건(nullable=false, unique)을 걸 때 씁니다."
    - **[Live Coding]**:
      ```java
      @Entity
      @Table(name = "members") // 테이블명 복수형 룰
      @NoArgsConstructor(access = Protected) // JPA 필수
      public class Member {
          @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
          private Long id;
          
          @Column(nullable = false, unique = true)
          private String email;
          // ...
      }
      ```
- **(15~20분) 생성자 정의**: 불변성을 위해 Setter를 지양하고, 의미 있는 생성자(`@Builder`)를 만드는 패턴 설명.

### 00:20 ~ 00:40 (20분) - Part 2: Repository와 Create (INSERT)
*파일: `MemberRepository.java`, `TestController.java`(혹은 테스트코드)*
- **(20~25분) JpaRepository 상속**:
    - "DAO를 만들고 SQLMap을 짜던 시절은 갔습니다."
    - `interface MemberRepository extends JpaRepository<Member, Long> {}` 한 줄의 위엄 설명.
- **(25~40분) INSERT 실행**:
    - 임시 컨트롤러나 `@PostConstruct` 등을 이용해 `repository.save(new Member(...))` 실행.
    - **[확인]**: 콘솔에 찍힌 `insert into members ...` 쿼리 확인 + H2 Console에서 데이터 조회.

### 00:40 ~ 00:50 (10분) - 휴식 (Break)
- 질의응답: "Setter 없이 어떻게 수정하나요?" (Dirty Checking 예고).

### 00:50 ~ 01:20 (30분) - Part 3: Post Entity와 연관관계 (N:1)
*파일: `Post.java`*
- **(50~60분) Post 매핑**: 
    - `content`, `created_at` 등 기본 필드 매핑.
- **(60~70분) @ManyToOne의 마법**:
    - "DB에서는 `member_id`인데, 자바에서는 `Member member` 객체를 가집니다."
    - **[Live Coding]**:
      ```java
      @Entity
      public class Post {
          // ...
          @ManyToOne(fetch = FetchType.LAZY) // 실무 국룰 LAZY
          @JoinColumn(name = "member_id")
          private Member member;
      }
      ```
- **(70~80분) 외래키 저장 실습**:
    - `Post` 객체 생성 시 `post.setMember(member)` 처럼 객체를 넣어주면, DB엔 ID가 들어감을 확인.

### 01:20 ~ 01:50 (30분) - Part 4: 영속성 컨텍스트 맛보기 (Update/Delete)
*파일: `MainRunner`(가칭) or Service*
- **(80~90분) Dirty Checking (변경 감지)**:
    - 상황: "닉네임을 바꾸고 싶다."
    - **[Code]**:
      ```java
      Member member = repository.findById(1L).get();
      member.changeNickname("new_nick"); // repository.save() 호출 안 함!
      ```
    - 트랜잭션 종료 시점에 `UPDATE` 쿼리가 나가는 것을 목격. "JPA가 객체를 감시하고 있다."
- **(90~100분) Select & Delete**:
    - `findById`는 영속성 컨텍스트(1차 캐시)를 먼저 뒤진다. (쿼리가 안 나가는 경우 시연).
    - `repository.delete(member)` 호출 시 `DELETE` 쿼리 확인.

### 01:50 ~ 02:00 (10분) - 마무리 및 과제 안내
- **(110~115분) 오늘 요약**:
    - SQL을 안 짜도 된다 (하지만 짜는 법은 알아야 한다).
    - 객체와 테이블의 패러다임 불일치를 JPA가 해결해준다.
    - `save` 없이도 수정되는 마법(Dirty Checking).
- **(115~120분) 과제**:
    - "자신이 설계한 `Comment` 테이블도 Entity로 매핑하고, 댓글을 달고 수정하는 테스트 코드(혹은 실행 코드) 짜오기."

---

## 💡 강사 팁 (Instructor Tips)
- `@ManyToOne(fetch = LAZY)`는 오늘은 깊게 설명하지 말고 "일단 이렇게 쓴다"고 하고 넘어가세요. (Day 9에 지옥을 맛보며 배울 예정).
- "왜 엔티티에 `@Data`를 안 쓰나요?" -> `toString()` 무한 루프나 `equals/hashCode` 문제 언급.
- H2 Console 접속 URL이 `jdbc:h2:mem:testdb`가 맞는지 꼭 확인하세요 (application.yml 설정).
