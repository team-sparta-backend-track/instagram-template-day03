# Day 1: MVC와 API의 정체

## 🎯 학습 목표
- REST API의 기본개념을 이해한다.
- Spring MVC의 핵심 컴포넌트(`@Controller`, `@RestController`)의 역할을 이해한다.
- 클라이언트(브라우저/Postman)의 요청을 받아 응답을 반환하는 기본적인 흐름을 구현한다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day1` 브랜치 상태*
1. **Controller 초기화**: `PostController.java`와 `MemberController.java`의 메소드 내용을 모두 비웁니다.
3. **TODO 주석**: 학생들을 위한 가이드 주석이 적재적소에 배치되어 있어야 합니다.

---

## ⏱️ 2시간 라이브 코딩 타임테이블 (Minute-by-Minute)

### 00:00 ~ 00:15 (15분) - 오프닝 및 프로젝트 세팅
- **(0~5분) 인사 및 아이스브레이킹**: 
    - "스탠다드반에 오신 것을 환영합니다."
    - 오늘 목표: 브라우저 주소창에 주소를 쳤을 때, 내 서버가 대답하게 만들기.
- **(5~10분) 프로젝트 구조 훑어보기**:
    - `src/main/java` 패키지 구조 설명 (Controller, Domain, Config).
    - `docs/requirement.md` 짧게 리마인드.
- **(10~15분) 실습 준비**:
    - 강사/학생 모두 `day1` 브랜치 체크아웃.
    - `InstagramCloneApplication` 실행하여 서버 띄우기 (에러 없는지 확인).

### 00:15 ~ 00:40 (25분) - Session 1: 컨트롤러의 탄생
*파일: `MemberController.java`*
- **(15~20분) @Controller vs @RestController**:
    - `MemberController.java` 파일 열기.
    - 클래스 위에 `@Controller`를 붙이고 `ping` 메소드 작성.
    - 브라우저 접속 시 404 혹은 뷰 리졸버 에러 확인 -> `@ResponseBody` 추가 -> `@RestController`로 변경하는 흐름 시연.
- **(20~30분) Mapping의 이해**:
    - `@GetMapping("/api/members/ping")` 작성.
    - **[Live Coding]**:
      ```java
      @RestController
      @RequestMapping("/api/members")
      public class MemberController {
          @GetMapping("/ping")
          public String ping() {
              return "pong";
          }
      }
      ```
    - 서버 재시작 후 `localhost:8080/api/members/ping` 접속 확인.
- **(30~40분) HTTP Method 설명**:
    - GET(조회) vs POST(등록) 의 차이점 설명.
    - Postman 켜서 요청 보내보기.

### 00:40 ~ 00:50 (10분) - 휴식 (Break)
- 질의응답 및 다음 시간 예고 ("이제 단순 문자열 말고, 진짜 회원 정보를 줘볼까요?").

### 00:50 ~ 01:20 (30분) - Session 2: JSON과 DTO
*파일: `MemberResponse.java`, `MemberController.java`*
- **(50~60분) 객체 반환 시도**:
    - `ping()` 처럼 문자열이 아니라, `Member` 객체(혹은 DTO)를 반환하면 어떻게 될까?
    - **[Live Coding]**: `getMyProfile()` 메소드 작성.
      ```java
      @GetMapping("/me")
      public MemberResponse getMyProfile() {
          return new MemberResponse(1L, "user1", "홍길동");
      }
      ```
- **(60~70분) MemberResponse DTO 작성**:
    - `domain/member/dto/response/MemberResponse.java` 파일 열기.
    - 필드(id, username, name) 작성 및 생성자/Getter 생성.
    - **설명**: Getter가 없으면 Jackson 라이브러리가 JSON을 못 만든다는 점 강조.
- **(70~80분) 확인 및 구조 설명**:
    - Postman으로 `/me` 호출 -> JSON 결과 확인.
    - **핵심 이론**: `User` -> `Controller` -> `MessageConverter(Jackson)` -> `JSON` 흐름 도식화 설명.

### 01:20 ~ 01:50 (30분) - Session 3: 동적 데이터 처리 (PathVariable, RequestParam)
*파일: `MemberController.java`*
- **(80~95분) PathVariable (경로 변수)**:
    - 상황: "내 정보 말고, ID가 1번인 친구, 2번인 친구 정보를 보고 싶다면?"
    - **[Live Coding]**:
      ```java
      @GetMapping("/{memberId}")
      public MemberResponse getMember(@PathVariable Long memberId) {
          // DB 연동 전이므로 Mock 데이터 반환
          return new MemberResponse(memberId, "user" + memberId, "친구" + memberId);
      }
      ```
    - `@PathVariable(name=...)` 생략 조건 설명.
- **(95~110분) RequestParam (쿼리 파라미터)**:
    - 상황: "이름으로 회원을 검색하고 싶다면?" -> `?name=홍길동`
    - **[Live Coding]**:
      ```java
      @GetMapping("/search")
      public MemberSearchResponse searchMember(@RequestParam String name) {
          return new MemberSearchResponse(List.of(
              new MemberResponse(1L, "user1", name),
              new MemberResponse(2L, "user2", name)
          ));
      }
      ```
    - `MemberSearchResponse` (List 감싸는 DTO) 빠르게 생성. 필요한 이유(확장성) 설명.

### 01:50 ~ 02:00 (10분) - 마무리 및 과제 안내
- **(110~115분) 오늘 배운 것 요약**:
    - `@RestController`, `@GetMapping`
    - DTO와 JSON 변환
    - `@PathVariable` vs `@RequestParam`
- **(115~120분) 내일 예고 및 과제**:
    - **과제**: `PostController`에도 동일하게 조회/검색 API 껍데기 만들어오기.
    - **내일**: "가짜 데이터 말고 진짜 DB 테이블을 만들어봅시다" (SQL/DDL).

---

## 💡 강사 팁 (Instructor Tips)
- 1교시(`ping`)에서 에러(404, 500)를 일부러 발생시켜 보여주세요. 학생들은 에러 화면을 보면 당황합니다.
- DTO 작성 시 `Lombok`(`@Data` or `@Getter`) 사용 여부를 결정해서 통일해주세요 (스탠다드반은 명시적 Getter 작성을 추천하다가 나중에 롬복 도입하는 것도 방법).
- "DB 연결은 안 하나요?"라는 질문이 100% 나옵니다. -> "내일 합니다. 오늘은 통신 규약(API)부터 잡는 날입니다"라고 방어하세요.
