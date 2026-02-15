.open "C:/Users/Ellio/REPO_CLONES/dat1-26-02-shf-assignment-1-ElliotGibGit/src/fittrackpro.db"
.mode column

-- 1.1
SELECT member_id, first_name, last_name, email, join_date 
FROM members;


-- 1.2
UPDATE members
SET phone_number='07000 100005', email='emily.jones.updated@email.com'
WHERE member_id = 5;


-- 1.3
SELECT count(member_id) as amount_of_members
FROM members;

-- 1.4
SELECT m.member_id,m.first_name,m.last_name,
    count(*) as registration_count
FROM members as m
JOIN class_attendance as ca
    ON m.member_id = ca.member_id
GROUP BY m.member_id
ORDER BY registration_count DESC
LIMIT 1;

-- 1.5

SELECT m.member_id,m.first_name,m.last_name,
    count(*) as registration_count
FROM members as m
JOIN class_attendance as ca
    ON m.member_id = ca.member_id
GROUP BY m.member_id
ORDER BY registration_count ASC
LIMIT 1;

-- 1.6
SELECT count(DISTINCT m.member_id) AS total_members_over_2
FROM members as m
JOIN class_attendance as ca
    ON m.member_id = ca.member_id
WHERE ca.attendance_status = 'Attended'
GROUP BY m.member_id
HAVING count(ca.class_attendance_id) >= 2;
