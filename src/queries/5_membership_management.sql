.open "C:/Users/Ellio/REPO_CLONES/dat1-26-02-shf-assignment-1-ElliotGibGit/src/fittrackpro.db"
.mode column

-- 5.1 
SELECT m.member_id,m.first_name,m.last_name,ms.type as membership_type,m.join_date
FROM MEMBERS m
JOIN memberships ms ON m.member_id = ms.member_id
WHERE ms.status='Active';


-- 5.2 
SELECT ms.type AS membership_type,
ROUND(AVG((strftime('%s', a.check_out_time) - strftime('%s', a.check_in_time)) / 60.0), 2) AS avg_visit_duration_minutes
FROM attendance a
JOIN memberships ms ON a.member_id = ms.member_id
GROUP BY ms.type;


-- 5.3 
SELECT m.member_id,m.first_name,m.last_name,m.email,ms.end_date
FROM MEMBERS m
JOIN memberships ms ON m.member_id = ms.member_id
WHERE ms.end_date BETWEEN '2025-01-01' AND '2025-12-31';
