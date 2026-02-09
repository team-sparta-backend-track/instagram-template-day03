# Day 12: Elegant Exception Handling - 전역 예외 처리

## 🎯 학습 목표
- `try-catch` 지옥에서 벗어나 `@RestControllerAdvice`를 활용해 예외를 중앙에서 관리합니다.
- 표준화된 에러 응답 포맷(ErrorResponse)을 설계하고 적용합니다.
- Custom Exception을 만들어 비즈니스 로직의 의도를 명확히 합니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day12` 브랜치 상태*
1. **지저분한 코드**: Service 곳곳에 `throw new RuntimeException("회원 없음")` 등이 하드코딩 되어 있고, Controller에서 이를 `try-catch`로 잡고 있는 모습을 둡니다.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: ErrorCode Enum 정의
- **Task**: 에러 코드와 메시지를 관리하는 `ErrorCode` Enum을 만듭니다. (예: `USER_NOT_FOUND(404, "U001", "사용자를 찾을 수 없습니다")`).
- **설명**: 매직 스트링 제거 및 에러 코드 체계화.

### 2️⃣ Commit 2: Custom Exception 생성
- **Task**: `RuntimeException`을 상속받는 `BusinessException`을 만들고, 구체적인 예외(`UserNotFoundException` 등)들이 이를 상속받게 합니다.

### 3️⃣ Commit 3: GlobalExceptionHandler 구현
- **Task**: `@RestControllerAdvice` 클래스를 만들고 `@ExceptionHandler` 메소드에서 `ErrorResponse`를 반환하도록 작성합니다.
- **설명**: 예외가 터지면 스프링이 이쪽으로 납치해온다(AOP).

### 4️⃣ Commit 4: 비즈니스 로직 리팩토링
- **Task**: Service 코드에서 `throw new UserNotFoundException(...)` 형식으로 변경하고, Controller의 `try-catch`를 모두 제거합니다.
- **설명**: 코드가 훨씬 깔끔해지고 핵심 로직만 남게 됨.

## 💡 핵심 설명 포인트
- **Unchecked Exception**: 비즈니스 로직에서는 주로 런타임 예외를 사용하여 트랜잭션 롤백을 유도한다.
- **클라이언트 친화적 응답**: 프론트엔드가 처리가능하도록 약속된 JSON 포맷을 내려주는 것이 중요.
