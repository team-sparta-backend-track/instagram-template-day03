# Day 18: AWS & Docker Deployment with GitHub Actions

## 🎯 학습 목표
- "내 컴퓨터에서만 되는" 코드를 "어디서든 돌아가는" 컨테이너(Docker)로 만듭니다.
- CI/CD(지속적 통합/배포) 파이프라인의 개념을 익히고, GitHub Actions로 자동화를 구축합니다.
- AWS EC2에 내 서버를 띄워 세상에 공개합니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day18` 브랜치 상태*
1. **AWS 계정**: 프리티어 EC2 인스턴스를 미리 생성해두고(Key Pair 준비), 보안 그룹(8080 포트)을 열어둡니다.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: Dockerfile 작성
- **Task**: `FROM openjdk:17`, `COPY build/libs/*.jar app.jar`, `ENTRYPOINT ...` 등을 포함한 Dockerfile을 작성합니다.
- **설명**: 이미지를 굽는(Build) 과정 설명.

### 2️⃣ Commit 2: 로컬 Docker 실행
- **Task**: `docker build` 및 `docker run` 명령어로 로컬에서 컨테이너를 띄워보고 `localhost:8080` 접속을 확인합니다.

### 3️⃣ Commit 3: GitHub Actions Workflow 작성 (CD)
- **Task**: `.github/workflows/deploy.yml`을 만들고, 코드가 push되면 자동으로 빌드 후 Docker Hub에 이미지를 올리고, EC2에 명령을 내려 pull & run 하는 스크립트를 짭니다.
- **설명**: "자고 일어나도 배포가 되어 있어야 한다".

## 💡 핵심 설명 포인트
- **Infrastructure as Code (IaC)**: 인프라 구성을 코드로 관리.
- **불변 인프라(Immutable Infrastructure)**: 서버를 고쳐 쓰지 않고, 새 컨테이너로 갈아끼운다.
