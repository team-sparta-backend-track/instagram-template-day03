# Instagram Clone Curriculum: Branch & Task Plan

This document outlines the codebase state and tasks for each branch (`day1` to `day27`), corresponding to the 27-session curriculum.
The goal is to prepare "Fill-in-the-Blanks" style branches where students can implement the core logic during live coding sessions.

## 📝 General Strategy
- **Base Branch (master/main)**: Contains the full, completed implementation (Reference).
- **Session Branches (`dayX`)**: usage logic
    - `dayX` branch should be the **starting point** for Session X.
    - Code unrelated to the current session should be either pre-implemented (if past topic) or hidden/mocked (if future topic).
    - **TODO Comments**: Critical logic to be taught in the session should be replaced with `// TODO: [Instruction]`.

---

## 🗓️ Phase 1: JPA & Persistence (Sessions 1-7)

### Day 1: MVC & API Identity
**Goal**: Understand Controller responsibility and API design.
**Branch**: `day1`
- **Files to Modify**:
    - `PostController.java`, `MemberController.java`
        - **Keep**: Class structure, `@RestController`, `@GetMapping` definitions.
        - **Remove**: Method bodies.
        - **TODO**: Implement method logic to return simple DTOs (mock data).
    - `Service/Repository` layers:
        - Should likely not exist or be empty shells to avoid confusion.
- **Tasks**:
    - Clean up all Controller bodies.
    - Remove Service/Repository logic dependencies for now (or mock them).

### Day 2: DDL SQL Analysis
**Goal**: DB Table Design.
**Branch**: `day2`
- **Focus**: `src/main/resources/sql/ddl.sql` (Create this file if missing).
- **Tasks**:
    - Create an empty `ddl.sql`.
    - **TODO**: Write `CREATE TABLE` statements for `Member` and `Post`.

### Day 3: SQL JOIN
**Goal**: Complex Queries.
**Branch**: `day3`
- **Focus**: `src/main/resources/sql/dml.sql` (Data manipulation/query practice).
- **Tasks**:
    - Provide sample data insert scripts.
    - **TODO**: Write `SELECT JOIN` queries to fetch Feed data.

### Day 4: JPA Mapping & CRUD
**Goal**: Converting SQL to JPA Entities.
**Branch**: `day4`
- **Files to Modify**:
    - `Member.java`, `Post.java`
        - **Remove**: `@Entity`, `@Id`, `@Column`, `@ManyToOne` annotations.
        - **TODO**: Map fields to DB tables using JPA annotations.
    - `MemberRepository.java`, `PostRepository.java`
        - **Remove**: `JpaRepository` inheritance.
        - **TODO**: Define the repository interface.

### Day 5: Team Project 1 (Git Flow)
**Branch**: `day5`
- **Focus**: Git configuration, `.gitignore`.
- **Tasks**: No code changes. Focus on branching strategy explanation.

### Day 6: Layered Architecture
**Goal**: Refactoring Controller Logic to Service.
**Branch**: `day6`
- **Files to Modify**:
    - `PostController.java`: Put "fat controller" logic here (business logic mixed in controller).
    - `PostService.java`: Empty or non-existent.
    - **TODO**: Extract logic from Controller to `PostService`.

### Day 7: Project 1 Review
**Branch**: `day7`
- **Tasks**: Cleanup and documentation (`README.md`).

---

## 🏗️ Phase 2: Architecture & Stability (Sessions 8-14)

### Day 8: JPA Deep Dive (Associations)
**Goal**: Advanced Mappings (1:N, N:M).
**Branch**: `day8`
- **Files to Modify**:
    - `Comment.java`, `Follow.java`
        - **Remove**: Entity definitions.
    - `Member.java`, `Post.java`
        - **Remove**: Association fields (`@OneToMany` lists).
    - **TODO**: Implement `Comment` and `Follow` entities and map relationships.

### Day 9: N+1 Problem & Optimization
**Goal**: Fetch Join.
**Branch**: `day9`
- **Files to Modify**:
    - `PostRepository.java`
        - **State**: Contains basic `findAll()`.
    - **TODO**: Add `@Query` with `JOIN FETCH` to optimize feed retrieval.
- **Setup**: Ensure the default implementation triggers N+1 logs.

### Day 10: IoC/DI & Flexible Design
**Goal**: Interface abstraction.
**Branch**: `day10`
- **Files to Modify**:
    - `PostService.java`: Hardcoded dependency on a specific File Upload implementation (e.g., LocalFileSaver).
    - **TODO**: Refactor to use `FileUploadUtil` interface.

### Day 11: Team Project 2 Start (Payment)
**Branch**: `day11`
- **Focus**: Domain Modeling for Payment (if applicable to clone).

### Day 12: Elegant Exception Handling
**Goal**: Global Exception Handler.
**Branch**: `day12`
- **Files to Modify**:
    - `GlobalExceptionHandler.java`: Remove content or file.
    - `ErrorCode.java`: Remove specific codes.
    - **TODO**: Implement `@RestControllerAdvice` and handle runtime exceptions.

### Day 13: Unit Testing & Mocking
**Goal**: Testing Service Layer.
**Branch**: `day13`
- **Files to Modify**:
    - `MemberServiceTest.java` (Create if missing).
    - **TODO**: Write `@Test` for `join()` method using `Mockito`.

### Day 14: Integration Testing
**Goal**: Full flow testing.
**Branch**: `day14`
- **Files to Modify**:
    - `PostIntegrationTest.java`.
    - **TODO**: Write test verifying @Transactional rollback on failure.

---

## 🌐 Phase 3: Infrastructure & Auth (Sessions 15-19)

### Day 15: Auth Basics (Session/Cookie)
**Branch**: `day15`
- **Files to Modify**:
    - `AuthController.java`: Simple login logic using `HttpSession`.
    - **TODO**: Implement login/logout using session.

### Day 16: Security & JWT
**Goal**: Stateless Authentication.
**Branch**: `day16`
- **Files to Modify**:
    - `JwtTokenProvider.java`: Empty shell.
    - `SecurityConfig.java`: Basic permitAll.
    - **TODO**: Implement Token generation & parsing. Configure filter chain.

### Day 17: Team Project 3 Start (Chat)
**Branch**: `day17`
- **Focus**: Chat domain setup.

### Day 18: AWS & Docker Deployment
**Branch**: `day18`
- **Files to Modify**:
    - `Dockerfile`: Missing or empty.
    - **TODO**: Write Dockerfile for Spring Boot app.

### Day 19: OAuth2 Social Login
**Branch**: `day19`
- **Files to Modify**:
    - `OAuth2UserService.java`.
    - **TODO**: Implement loadUser logic for Google/Facebook.

---

## 🏆 Phase 4: Advanced Traffic Handling (Sessions 20-27)
*Note: These features are not present in the base project and must be implemented from scratch.*

### Day 20: WebSocket & STOMP (Real-time DM)
**Branch**: `day20`
- **Goal**: Real-time messaging.
- **Tasks**:
    - Add `WebSocketConfig`.
    - Implement `ChatController`.
    - **TODO**: Define STOMP endpoints and message handling.

### Day 21: Redis Performance (Ranking)
**Branch**: `day21`
- **Goal**: In-memory sorting.
- **Tasks**:
    - Add `spring-boot-starter-data-redis` dependency.
    - Create `RedisConfig`.
    - **TODO**: Implement ZSET logic in `RankingService`.

### Day 22: Async & Kafka (Notifications)
**Branch**: `day22`
- **Goal**: Event-driven architecture.
- **Tasks**:
    - Add Kafka dependencies.
    - Create `KafkaConfig`.
    - **TODO**: Implement Producer/Consumer interaction for notifications.

### Day 23: Concurrency & Locks
**Branch**: `day23`
- **Goal**: Data integrity.
- **Tasks**:
    - **TODO**: Identify race conditions in `PostLikeService` and apply locking mechanisms.

### Day 24: Load Testing (k6)
**Branch**: `day24`
- **Tasks**: Create and run `k6-script.js`.

### Day 25: Technical Decision Making
**Branch**: `day25`
- **Tasks**: Review architecture and prepare talking points.

### Day 26: Final Report
**Branch**: `day26`
- **Tasks**: Document performance metrics.

### Day 27: Graduation
**Branch**: `day27`
- **Tasks**: Final wrap-up.

