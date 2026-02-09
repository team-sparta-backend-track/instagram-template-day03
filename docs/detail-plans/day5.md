# Day 5: 팀 프로젝트 1 시작 - 협업의 기술 (Git flow)

## 🎯 학습 목표
- **부트캠프 입과 2달 만의 첫 팀 프로젝트!** 혼자 코딩하는 것이 아니라 "함께" 제품을 만드는 법을 배웁니다.
- GitHub Organization을 생성하고 팀원들을 Collaborator로 초대하여 협업 공간을 구축합니다.
- **Feature Branch Workflow**를 익히고, PR(Pull Request) -> Code Review -> Merge Cycle을 경험합니다.
- 필연적으로 발생하는 **충돌(Conflict)**을 두려워하지 않고 해결하는 능력을 기릅니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day5` 브랜치 상태*
1. **팀 구성 완료**: 4~5인 1조로 팀이 배정되어 있어야 합니다.
2. **팀장 선출**: 각 팀에서 레포지토리를 생성하고 초기 세팅을 담당할 팀장이 정해져 있어야 합니다. (라이브 때는 강사가 시범을 보이고 학생들이 따라하는 형식이 좋습니다).

---

## ⏱️ 2시간 라이브 코딩 타임테이블 (Minute-by-Minute)

### 00:00 ~ 00:20 (20분) - Part 1: 협업 마인드셋 & 워크플로우 이론
*파일: 장표 혹은 그림 설명*
- **(0~5분) 오프닝**: "개발자의 실력은 코딩이 50, 소통이 50입니다." 첫 팀 프로젝트의 의미 강조.
- **(5~15분) Feature Branch Workflow 설명**:
    - **Main 브랜치**: 언제나 배포 가능한 깨끗한 상태 (신성불가침).
    - **Feature 브랜치**: 기능을 개발하는 작업대. (`feature/login`, `feature/signup`).
    - **PR(Pull Request)**: "제 코드를 메인에 합쳐도 될까요?" 라고 묻는 과정.
- **(15~20분) Organization vs Fork**:
    - 오늘은 우리끼리 믿고 가는 팀이니까 **Organization + Collaborator** 방식을 쓴다고 설명 (권한 관리 용이성).

### 00:20 ~ 00:50 (30분) - Part 2: 초기 세팅 (팀장 주도)
*파일: GitHub 웹사이트*
- **(20~30분) Organization 생성 및 멤버 초대**:
    1. 팀장이 GitHub Organization 생성 (`Team-Name-Project`).
    2. Repository 생성 (`instagram-clone`).
    3. `Settings` -> `Collaborators`에서 팀원들 초대.
    4. 팀원들은 메일함 확인 후 수락.
- **(30~40분) 초기 코드 Push 및 Clone**:
    1. 팀장: 로컬 프로젝트를 Remote에 연결하여 Push.
       - `.gitignore` 확인 (매우 중요! `.idea`, `build/` 반드시 제외).
    2. 팀원: `git clone [Repo-URL]` 받아서 로컬에서 실행 확인.
- **(40~50분) Issue 등록 및 역할 분담**:
    - GitHub Issues 탭에 "회원가입 구현", "로그인 구현" 등 티켓을 만들고 Assignee(담당자)를 지정하는 실습.

### 00:50 ~ 01:00 (10분) - 휴식 (Break)
- 질의응답: "권한 에러(403)가 떠요" -> 초대 수락 안 했거나 주소 오타 체크.

### 01:00 ~ 01:30 (30분) - Part 3: Feature 개발 시뮬레이션
*파일: 터미널, 소스코드*
- **(60~65분) 브랜치 생성**:
    - `git switch -c feature/setup` (혹은 본인 담당 기능명).
- **(65~75분) 코드 수정 및 커밋**:
    - `README.md`에 팀원 이름 한 줄 추가하거나, 간단한 주석 추가.
    - `git add .`, `git commit -m "docs: 팀원 명단 추가"`.
- **(75~80분) Push & PR**:
    - `git push origin feature/setup`.
    - GitHub 웹에서 "Compare & pull request" 버튼 클릭.
    - PR 본문 작성 ("이러이러한 기능을 추가했습니다").
- **(80~90분) 코드 리뷰 & Merge**:
    - 옆 짝꿍이 승인(Approve) 눌러주기.
    - 팀장이 `Squash and merge` (혹은 `Merge commit`) 버튼 클릭.
    - 로컬에서 `git checkout main` -> `git pull`로 동기화 확인.

### 01:30 ~ 01:50 (20분) - Part 4: 공포의 Merge Conflict 해결
*파일: `MainController` 등 동일 파일*
- **(90~100분) 충돌 상황 연출**:
    - 팀원 A와 B가 **같은 파일의 같은 라인**을 수정하고 각자 브랜치에서 커밋/푸시.
    - A가 먼저 Merge 함.
    - B가 PR을 올리면 "Can’t automatically merge" 뜸.
- **(100~110분) 해결 가이드**:
    1. 로컬 main 업데이트: `git checkout main` -> `git pull`.
    2. 내 브랜치로 이동: `git checkout feature/B`.
    3. main을 내 브랜치로 합침: `git merge main`.
    4. **충돌 발생! (`CONFLICT`)**.
    5. IDE(IntelliJ)의 `Resolve Conflicts` 창을 띄워서 3-way Merge (내꺼 남길지, 쟤꺼 남길지, 둘 다 남길지) 수행.
    6. 해결 후 Commit & Push -> PR 초록불 확인.

### 01:50 ~ 02:00 (10분) - 마무리 및 과제 안내
- **(110~115분) 오늘 요약**:
    - `add` - `commit` - `push` - `PR` - `Merge` - `Pull` 사이클 무한 반복.
    - 충돌나면 당황하지 말고 "팀원과 대화"해라 (코드로 싸우지 말고 말로 풀어라).
- **(115~120분) 과제**:
    - "오늘 만든 Organization 레포지토리에 각자 맡은 기능(회원가입, 게시물 목록 등)의 API 껍데기(Controller)를 만들어서 PR 날리고 머지까지 해오기."

---

## 💡 강사 팁 (Instructor Tips)
- **.gitignore 실수**: 첫날 가장 많이 하는 실수가 DB 비번이 든 `application.yml`이나 `.idea` 폴더를 올리는 것입니다. 팀장이 push하기 전에 `.gitignore`가 제대로 되어있는지 라이브로 꼭 확인시켜주세요. (https://www.toptal.com/developers/gitignore 활용 추천).
- **Commit Message Convention**: `feat:`, `fix:`, `docs:` 등 컨벤션을 간단히 정해주면 학생들이 전문가가 된 기분을 느낍니다.
- **Branch Strategy**: 너무 복잡한 Git-flow(release, hotfix 등)보다는 `main` - `feature` 단순 구조가 초심자에게 적합합니다.
