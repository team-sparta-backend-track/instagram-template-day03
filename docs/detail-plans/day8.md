# Day 8: JPA Deep Dive (Associations) - 연관관계 매핑

## 🎯 학습 목표
- 객체의 참조와 테이블의 외래키를 매핑하는 JPA 연관관계(`@ManyToOne`, `@OneToMany`)를 이해합니다.
- `Comment`(댓글), `Follow`(팔로우) 테이블을 추가하고 기존 `Post`, `Member`와 연결합니다.
- 양방향 매핑 시 발생할 수 있는 무한 루프 문제(StackOverflow)를 직관적으로 확인하고 해결합니다.

## 🛠️ 브랜치 준비 작업 (Pre-work)
*`day8` 브랜치 상태*

1. **Entity 백지화**: `Comment`와 `Follow` 클래스는 삭제되어 있거나 빈 껍데기만 있어야 합니다.
2. **기존 Entity 정리**: `Member`와 `Post`에 양방향 매핑 코드가 있다면 모두 제거합니다.

## 👨‍💻 라이브 세션 커밋 가이드 (Live Session Plan)

### 1️⃣ Commit 1: Comment Entity와 N:1 매핑
- **Task**: `Comment` 엔티티를 만들고, 하나의 게시물(`Post`)에 여러 댓글이 달리는 구조(`@ManyToOne POST`)를 매핑합니다.
- **설명**: "댓글은 게시물에 종속적이다". 연관관계의 주인(Owner)은 외래키를 가진 쪽.

### 2️⃣ Commit 2: Follow Entity와 Self-Join (N:M 해소)
- **Task**: `Follow` 엔티티를 만듭니다. `fromMember`와 `toMember`로 Member 테이블과 두 번 연결되는 Self Many-To-One 관계를 맺습니다.
- **설명**: M:N 관계를 직접 매핑(`@ManyToMany`)하지 않고 연결 테이블(`Follow`)을 엔티티로 승격시키는 실무적 기법.

### 3️⃣ Commit 3: 양방향 매핑과 편의 메소드
- **Task**: `Member` 엔티티에 `List<Post> posts`를 추가(`mappedBy`)하고, 게시물 작성 시 리스트에도 자동으로 추가되도록 `addPost()` 편의 메소드를 작성합니다.
- **설명**: "DB에는 영향이 없지만, 객체 상태의 정합성을 위해 양쪽에 값을 넣어줘야 한다".

### 4️⃣ Commit 4: 무한 루프 이슈 확인 (JsonBackReference)
- **Task**: 양방향 매핑 후 API 호출 시 `Member -> Post -> Member -> ...` 로 JSON 직렬화가 무한 반복되는 에러를 터뜨려보고, `@JsonIgnore`나 DTO 반환으로 해결합니다.

## 💡 핵심 설명 포인트
- **연관관계의 주인**: `mappedBy`가 없는 쪽이 주인. 외래키 관리는 주인만 할 수 있다.
- **N:M은 악이다**: 연결 엔티티(`Follow`)를 명시적으로 만드는 것이 유지보수에 유리하다.
