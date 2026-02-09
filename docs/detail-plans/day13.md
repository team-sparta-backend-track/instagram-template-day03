# Day 13: Unit Testing & Mocking - 단위 테스트

## 🎯 학습 목표
- JUnit5와 Mockito를 사용하여 "외부 환경(DB, Network)과 격리된" 순수 비즈니스 로직 테스트를 작성합니다.
- TDD(Test Driven Development)의 리듬을 짧게나마 경험해봅니다 (Red-Green-Refactor).

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day13` 브랜치 상태*
1. **테스트 없음**: `src/test` 디렉토리가 텅 비어있거나 생성만 되어 있습니다.
2. **Service 로직**: 테스트 대상인 `MemberService`에 회원가입 등의 로직이 구현되어 있어야 합니다.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: 테스트 환경 설정 및 Mocking
- **Task**: `MemberServiceTest` 클래스를 생성하고 `@ExtendWith(MockitoExtension.class)`를 붙입니다. `MemberRepository`를 `@Mock`으로 선언합니다.
- **설명**: "가짜 DB를 만든다". 진짜 DB 연결 없이 로직만 검증하기 위함.

### 2️⃣ Commit 2: 성공 케이스 테스트 (Stubbing)
- **Task**: "회원가입 성공" 테스트를 작성합니다. `given(repository.save(any())).willReturn(member)` 로 가짜 행동을 정의합니다.
- **설명**: Given-When-Then 패턴.

### 3️⃣ Commit 3: 실패 케이스 테스트 (예외 검증)
- **Task**: "중복 회원 가입 시 예외 발생" 테스트를 작성합니다. `assertThrows`를 사용하여 예외가 터지는지 확인합니다.
- **설명**: 테스트는 성공보다 실패 케이스가 더 중요하다.

### 4️⃣ Commit 4: Refactoring
- **Task**: 테스트 코드의 중복을 `@BeforeEach`로 빼거나, 가독성을 높이는 작업을 합니다.

## 💡 핵심 설명 포인트
- **단위 테스트 vs 통합 테스트**: 속도 차이와 격리성.
- **Mockito**: 남의 코드(DB)는 믿고(Mock 처리), 내 코드(Service)만 검증한다.
