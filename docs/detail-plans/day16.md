# Day 16: Security & JWT - 무상태 인증

## 🎯 학습 목표
- Spring Security의 거대한 필터 체인(Filter Chain) 구조를 파악합니다.
- JWT(Json Web Token)의 구조(Header, Payload, Signature)를 이해하고 발급/검증 로직을 구현합니다.
- "서버가 사용자를 기억하지 않아도 되는" Stateless 인증 혁명을 경험합니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day16` 브랜치 상태*
1. **Dependency**: `spring-boot-starter-security`, `jjwt` 관련 라이브러리 추가.
2. **SecurityConfig**: 모든 요청을 `permitAll()`로 열어둔 상태.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: Token Provider 구현
- **Task**: `Jwts.builder()`를 사용하여 Access Token을 생성하는 메소드와, 토큰을 파싱(검증)하는 메소드를 구현합니다.
- **설명**: 서명 키(Secret Key) 관리의 중요성.

### 2️⃣ Commit 2: Security Filter Chain 설정
- **Task**: `SecurityConfig`에서 `csrf().disable()`, `sessionManagement().sessionCreationPolicy(STATELESS)` 등을 설정합니다.

### 3️⃣ Commit 3: JwtAuthenticationFilter 구현
- **Task**: `OncePerRequestFilter`를 상속받아, 요청 헤더에서 "Bearer 토큰"을 꺼내 검증하고 `SecurityContext`에 인증 객체를 넣는 필터를 만듭니다.
- **설명**: 문지기(Filter)가 하는 일. 통과되면 컨트롤러는 "누구인지" 이미 알고 있다.

### 4️⃣ Commit 4: 인증 테스트
- **Task**: Postman으로 로그인 후 받은 토큰을 헤더에 넣고, 보호된 API(내 프로필 조회)를 찔러봅니다.

## 💡 핵심 설명 포인트
- **인증(Authentication) vs 인가(Authorization)**.
- **JWT의 장단점**: DB 조회 없이 검증 가능(장점) vs 강제 로그아웃 시키기 어려움(단점 - Blacklist 필요).
