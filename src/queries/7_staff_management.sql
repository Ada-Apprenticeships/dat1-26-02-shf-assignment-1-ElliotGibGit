.open "C:/Users/Ellio/REPO_CLONES/dat1-26-02-shf-assignment-1-ElliotGibGit/src/fittrackpro.db"
.mode column

-- 7.1 
SELECT staff_id,first_name,last_name,position AS role
FROM staff
ORDER BY position;

-- 7.2 
SELECT 
    s.staff_id AS trainer_id,
    s.first_name || ' ' || s.last_name AS trainer_name,
    COUNT(pts.session_id) AS session_count
FROM staff as s
JOIN personal_training_sessions as pts ON s.staff_id = pts.staff_id
WHERE s.position = 'Trainer'
AND pts.session_date BETWEEN date('2025-01-20') AND date('2025-02-19')
GROUP BY s.staff_id, s.first_name, s.last_name
HAVING COUNT(pts.session_id) >= 1;