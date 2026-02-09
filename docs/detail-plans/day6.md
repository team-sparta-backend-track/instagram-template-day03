# Day 6: Layered Architecture - 서비스(Service)의 미학

## 🎯 학습 목표
- **"Fat Controller"의 문제점**을 인식하고, **Service Layer**를 도입해야 하는 이유를 납득합니다.
- **DTO(Data Transfer Object)**의 진정한 용도를 깨닫습니다.
  - Request: 입력값 검증(Validation)의 책임을 짐.
  - Response: 클라이언트가 필요로 하는 데이터만 선별해서 제공(정보 은닉).
- **트랜잭션(`@Transactional`)**과 **예외 처리**가 왜 Controller가 아닌 Service에 위치해야 하는지 이해합니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day6` 브랜치 상태*
1. **나쁜 코드 준비**: `PostController`에 비즈니스 로직(Repository 호출, 엔티티 수정 등)이 잔뜩 들어있는 상태여야 합니다.
2. **PostService**: 클래스 파일이 없거나 비워져 있어야 합니다.

---

## ⏱️ 2시간 라이브 코딩 타임테이블 (Minute-by-Minute)

### 00:00 ~ 00:20 (20분) - Part 1: 문제 인식 (Why Service?)
*파일: `PostController.java`*
- **(0~10분) Fat Controller 해부**:
    - 현재의 컨트롤러 코드를 보며 문제점을 지적합니다.
    - 1. **재사용 불가**: "만약 모바일 앱이 아니라 관리자 페이지에서도 글을 써야 한다면? 이 코드를 복사&붙여넣기 해야 합니다."
    - 2. **트랜잭션 관리 불가**: "글은 써졌는데, 알림 보내다가 에러나면? 글 쓴 건 롤백되어야 하는데 컨트롤러에서는 어렵습니다."
- **(10~20분) Service 레이어의 정의**:
    - "컨트롤러는 **'안내 데스크직원'**이고, 서비스는 **'실무 전문가'**입니다."
    - 트랜잭션의 경계 = Service 메소드의 시작과 끝.

### 00:20 ~ 00:50 (30분) - Part 2: Refactoring to Service
*파일: `PostService.java`, `PostController.java`*
- **(20~30분) PostService 뼈대 생성**:
    - `@Service`, `@RequiredArgsConstructor` 추가.
    - `PostRepository` 주입.
- **(30~45분) 로직 이관 (Cut & Paste)**:
    - 컨트롤러의 `writePost` 로직을 잘라내어 서비스의 `write` 메소드로 옮깁니다.
    - **[Live Coding]**:
      ```java
      @Service
      @RequiredArgsConstructor
      @Transactional // 매우 중요!
      public PostResponse write(PostCreate request) {
          Member writer = memberRepository.findById(request.getMemberId())...
          Post post = Post.builder()...build();
          postRepository.save(post);
          return PostResponse.from(post); // DTO 변환도 여기서!
      }
      ```
- **(45~50분) Transactional의 마법**:
    - "이 애노테이션 하나가 `Connection.setAutoCommit(false)` ... `commit()` 코드를 대신합니다."

### 00:50 ~ 01:00 (10분) - 휴식 (Break)
- 질의응답: "Entity를 반환하면 안 되나요?" -> Part 4에서 다룹니다!

### 01:00 ~ 01:30 (30분) - Part 3: DTO의 역할과 위치 (Argument Refinement)
*파일: `PostCreate.java` (Request), `PostResponse.java` (Response)*
- **(60~70분) Request DTO와 Validation**:
    - "왜 Map<String, Object>로 안 받고 굳이 클래스를 만드나?"
    - **이유**: `@NotBlank`, `@Size` 등으로 유효성 검증 책임을 DTO에 위임하기 위함.
    - **[Live Coding]**: `PostCreate`에 `@NotBlank` 추가하고 `@Valid` 적용.
- **(70~80분) Response DTO와 정보 은닉**:
    - "Entity를 그대로 내리면 비밀번호, 주민번호 다 나갑니다."
    - "프론트 개발자에게 '필요한 것'만 줘야 합니다."
    - `PostResponse`에서 `member` 전체가 아니라 `writerNickname`만 반환하도록 수정.
- **(80~90분) 어디서 변환하나? (Controller vs Service)**:
    - **결론**: **Service**에서 변환해서 내보낸다.
    - **이유**: OSIV(Open Session In View)를 껐을 때 Controller에서 Entity 접근 시 `LazyInitializationException` 발생 가능성 차단. 서비스는 "완벽하게 포장된 결과물"을 내놔야 한다.

### 01:30 ~ 01:50 (20분) - Part 4: 예외 처리와 흐름 제어
*파일: `PostService.java`*
- **(90~100분) 비즈니스 예외 던지기**:
    - `findById` 실패 시 `orElseThrow(() -> new IllegalArgumentException("회원 없음"))`.
    - 서비스는 "문제가 생기면 **던지는(Throw)** 곳"이지 "처리(Try-Catch)하는 곳"이 아님을 강조.
    - 처리는 나중에 `GlobalExceptionHandler`가 일괄 담당 (Day 12 예고).
- **(100~110분) 롤백 시연 (선택)**:
    - 강제로 예외를 발생시켜 DB에 데이터가 안 들어가는지 확인.

### 01:50 ~ 02:00 (10분) - 마무리 및 과제 안내
- **(110~115분) 오늘 요약**:
    - Controller는 요청을 받고 응답을 줄 뿐, 일은 Service가 한다.
    - DTO는 "데이터의 경계(Boundary)"를 지키는 수문장이다.
    - 트랜잭션은 Service 메소드 단위로 묶인다.
- **(115~120분) 과제**:
    - "Day 2, 3에서 짠 `Comment` 관련 로직도 모두 `CommentService` 만들어서 이관하기."
    - "Request/Response DTO 분리해서 적용하기."

---

## 💡 강사 팁 (Instructor Tips)
- 학생들이 가장 많이 묻는 질문: **"코드가 더 길어지고 파일도 많아지는데 왜 이렇게 하나요?"**
    - 답변: "소프트웨어는 **작성하는 시간보다 유지보수하는 시간이 훨씬 깁니다.** 지금의 복잡함이 나중의 변경을 쉽게 만듭니다(격리)."
- DTO 변환 위치 논쟁은 정답이 없지만, 우리 커리큘럼(JPA)에서는 **Transaction 안에서(Service)** 변환하는 것이 지연 로딩 문제로부터 안전하다는 논리로 설득하면 효과적입니다.
