
DROP TABLE IF EXISTS EMPLOYEES;
DROP TABLE IF EXISTS DEPARTMENTS;

-- 1. 부서 테이블 (DEPARTMENTS) 생성
CREATE TABLE DEPARTMENTS (
                             id BIGINT PRIMARY KEY,
                             name VARCHAR(50) NOT NULL
);

-- 2. 사원 테이블 (EMPLOYEES) 생성
CREATE TABLE EMPLOYEES (
                           id BIGINT PRIMARY KEY,
                           name VARCHAR(50) NOT NULL,
                           dept_id BIGINT -- DEPARTMENTS 테이블의 id를 참조
);

-- 3. 각 테이블에 예시 데이터 삽입
-- 부서 테이블에는 3개의 부서를 넣어봅시다.
INSERT INTO DEPARTMENTS (id, name) VALUES (10, '기획팀');
INSERT INTO DEPARTMENTS (id, name) VALUES (20, '개발팀');
INSERT INTO DEPARTMENTS (id, name) VALUES (30, '디자인팀');


-- 사원 테이블에는 4명의 사원을 넣어봅시다.
INSERT INTO EMPLOYEES (id, name, dept_id) VALUES (101, '김철수', 10);  -- 기획팀
INSERT INTO EMPLOYEES (id, name, dept_id) VALUES (102, '박영희', 20);  -- 기획팀
INSERT INTO EMPLOYEES (id, name, dept_id) VALUES (103, '이지은', 20);  -- 기획팀
INSERT INTO EMPLOYEES (id, name, dept_id) VALUES (104, '최민준', 30);  -- 기획팀

COMMIT;


SELECT E.id, E.name, D.name
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.dept_id = D.id
;


-- user_id가 1인 유저가 쓴 피드의
-- 작성자명, 피드내용, 피드작성일을 조회
SELECT U.username, P.content, P.creation_date
FROM POSTS P
JOIN USERS U
ON P.user_id = U.user_id
WHERE P.user_id = 1
;

SELECT U.username, C.comment_text, P.content
FROM COMMENTS C
JOIN USERS U
ON C.user_id = U.user_id
JOIN POSTS P
ON P.post_id = C.post_id
;

-- ============== OUTER JOIN ============

SELECT U.user_id, U.username, UP.bio
FROM USERS U
LEFT JOIN USER_PROFILES UP
ON U.user_id = UP.user_id
ORDER BY U.user_id
;

SELECT U.user_id, U.username, UP.bio
FROM USERS U
         LEFT OUTER JOIN USER_PROFILES UP
                         ON U.user_id = UP.user_id
WHERE UP.bio IS NULL
ORDER BY U.user_id
;


SELECT U.*, UP.*
FROM USERS U
         LEFT JOIN USER_PROFILES UP
                   ON U.user_id = UP.user_id
ORDER BY U.user_id
;

-- ======================================
-- ==   self join====================================

SELECT U.user_id, U.username, U.manager_id, M.username
FROM USERS U
JOIN USERS M
ON U.manager_id = M.user_id
;

--









