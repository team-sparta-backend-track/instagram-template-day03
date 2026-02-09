SELECT NOW() FROM dual;
SELECT * FROM USERS;

SELECT *
FROM USERS
WHERE username = 'ryan';

SELECT *
FROM POSTS
WHERE user_id = 1
  AND post_type = 'video'
;

-- 가입일(registration_date)이 2022년도인 사용자를 찾습니다.
SELECT username, registration_date
FROM USERS
WHERE registration_date BETWEEN '2022-01-01' AND '2022-12-31';


SELECT username, registration_date
FROM USERS
WHERE registration_date >= '2022-01-01'
    AND registration_date <= '2022-12-31';

-- user_id가 1, 9, 21 중 하나에 해당하는 사용자 정보를 찾습니다.
SELECT *
FROM USERS
WHERE user_id IN (1, 9, 21);

SELECT *
FROM USERS
WHERE user_id = 1
    OR user_id = 9
    OR user_id = 21;

-- 'p'로 시작하는 모든 사용자 검색
SELECT username
FROM USERS
WHERE username LIKE 'p%';

-- manager_id가 NULL인 사용자를 찾습니다.
SELECT *
FROM USERS
WHERE manager_id IS NULL
;




