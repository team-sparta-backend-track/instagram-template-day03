

-- ryan이 작성한 피드게시물을 조회
-- 비연관 서브쿼리: 서브쿼리 독자적 실행 가능, 안쪽먼저 실행 -> 바깥쪽 실행
SELECT *
FROM POSTS
WHERE user_id = (
    SELECT user_id
    FROM USERS
    WHERE username = 'ryan'
)
;

SELECT *
FROM POSTS
WHERE user_id = (
    SELECT user_id
    FROM USERS
    WHERE username LIKE 'p%'
)
;


SELECT P.content, U.username, U.email
FROM POSTS P
JOIN USERS U
ON P.user_id = U.user_id
WHERE P.user_id = (
    SELECT user_id
    FROM USERS
    WHERE username = 'ryan'
)
;


-- =========== 연관 서브쿼리 ===========
-- 연관 서브쿼리는 단독실행이 안됨,
-- 바깥쪽이 먼저 실행되고 그다음 서브쿼리가 실행됨
-- 메인쿼리 1번실행당 서브쿼리도 1번씩 반복실행됨

SELECT
    u.username,
    (
     SELECT COUNT(*)
     FROM POSTS p
     WHERE p.user_id = u.user_id
     ) AS "작성 게시물 수" -- 1. 바깥 쿼리의 u.user_id를 참조
FROM
    USERS u
;


SELECT U.username, U.user_id
FROM USERS U

;

SELECT P.user_id, P.content
FROM POSTS P
WHERE P.user_id = 24
;

SELECT count(*)
FROM POSTS P
WHERE P.user_id = 24
;

SELECT u.username, COUNT(P.user_id)
FROM USERS U
LEFT JOIN POSTS P
ON U.user_id = P.user_id
GROUP BY P.user_id
;

SELECT
    p.post_id,
    p.content,
    (SELECT COUNT(*) FROM LIKES l WHERE l.post_id = p.post_id) AS "좋아요 수",
    (SELECT COUNT(*) FROM COMMENTS c WHERE c.post_id = p.post_id) AS "댓글 수"
FROM
    POSTS p
;

SELECT
    p.post_id,
    p.content,
    COALESCE(lc.like_count, 0) AS "좋아요 수",
    COALESCE(cc.comment_count, 0) AS "댓글 수"
FROM
    POSTS p
        LEFT JOIN
    (SELECT post_id, COUNT(*) AS like_count FROM LIKES GROUP BY post_id) lc
    ON p.post_id = lc.post_id -- '좋아요 수' 요약 테이블을 조인
        LEFT JOIN
    (SELECT post_id, COUNT(*) AS comment_count FROM COMMENTS GROUP BY post_id) cc
    ON p.post_id = cc.post_id -- '댓글 수' 요약 테이블을 조인
;