# Day 19: OAuth2 Social Login - 구글/페이스북 로그인

## 🎯 학습 목표
- OAuth2 프로토콜의 복잡한 흐름(인가 코드 -> 토큰 -> 유저 정보)을 이해합니다.
- Spring Security OAuth2 Client 라이브러리를 사용해 간편하게 구현해봅니다.
- 소셜 로그인한 회원을 우리 DB에 어떻게 저장(매핑)할지 고민합니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day19` 브랜치 상태*
1. **Google Console**: OAuth 클라이언트 ID와 Secret을 발급받아 `application-oauth.yml` (gitignore 대상)에 넣어둡니다.
2. **Dependency**: `spring-boot-starter-oauth2-client` 추가.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: OAuth2 설정
- **Task**: `application.yml`에 Provider(Google) 정보와 Redirect URI를 등록합니다.

### 2️⃣ Commit 2: DefaultOAuth2UserService 상속 구현
- **Task**: `CustomOAuth2UserService`를 만들고 `loadUser()` 메소드를 오버라이딩합니다.
- **설명**: 구글에서 준 사용자 정보(Attributes)를 내 입맛에 맞게 가공하는 곳.

### 3️⃣ Commit 3: 회원가입/로그인 처리 로직
- **Task**: 이메일을 기준으로 "이미 가입된 회원이면 정보 업데이트, 없으면 신규 가입" 시키는 로직을 작성합니다.

### 4️⃣ Commit 4: JWT 연동
- **Task**: OAuth2 로그인 성공 후(SuccessHandler), 우리 서버 전용 JWT를 발급해서 리다이렉트 시켜줍니다.
- **설명**: 소셜 로그인은 "입장권"일 뿐, 우리 집(서버)에서는 우리 규칙(JWT)을 따른다.

## 💡 핵심 설명 포인트
- **Scope**: 사용자의 권한 범위를 명시(이메일, 프로필 등).
- **Callback URL**: 인증 후 돌아올 주소 설정의 중요성.
