# Day 7: Project 1 회고 및 문서화

## 🎯 학습 목표
- 개발한 API를 문서화(README or Swagger)하여 클라이언트(프론트엔드)와 소통하는 법을 배웁니다.
- KPT(Keep, Problem, Try) 회고를 통해 프로젝트를 정리합니다.
- 코드를 리팩토링하며 "Clean Code" 맛보기를 합니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day7` 브랜치 상태*

1. **불필요한 코드**: 사용하지 않는 import문, `System.out.println` 디버깅 로그 등을 남겨둡니다.
2. **README**: 기본 템플릿만 있고 내용은 비워둡니다.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: Code Clean-up
- **Task**: IDE의 정렬 기능(Reformat Code)을 사용하고, 미사용 Import 제거, `System.out.println`을 Logger로 변경합니다.
- **설명**: "깨진 유리창 이론". 코드가 깔끔해야 버그도 잘 보입니다.

### 2️⃣ Commit 2: README.md 작성
- **Task**: 프로젝트 개요, 실행 방법, API 명세 테이블(Method, URI, Parameter, Response)을 작성합니다.
- **설명**: "문서가 없으면 코드는 쓰레기다". 내가 짠 코드를 남이 실행할 수 있게 친절하게 설명합니다.

### 3️⃣ Commit 3: 단순 리팩토링 (메소드 추출)
- **Task**: 하나의 메소드가 너무 길어진 부분(예: 복잡한 검증 로직)을 `private` 메소드로 추출(Extract Method)합니다.
- **설명**: 메소드 이름만으로 로직이 설명되게 하라.

## 💡 핵심 설명 포인트
- **회고(Retrospective)**: 지난 7일간 자바/SQL/MVC를 배우며 느낀 점 공유.
- **협업의 기본**: 코드는 글이다. 읽기 쉬워야 한다.
- Swagger 같은 자동화 도구는 2학기(혹은 심화과정) 때 도입한다고 언급하며, 지금은 수동 문서화의 고통(?)과 중요성을 느껴봅니다.
