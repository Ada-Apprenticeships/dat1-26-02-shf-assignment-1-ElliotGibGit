.open "C:/Users/Ellio/REPO_CLONES/dat1-26-02-shf-assignment-1-ElliotGibGit/src/fittrackpro.db"
.mode column

-- 8.1 

SELECT 
    pts.session_id,
    m.first_name || ' ' || m.last_name AS member_name,
    pts.session_date,
    pts.start_time,
    pts.end_time
FROM personal_training_sessions as pts
JOIN staff as s ON pts.staff_id = s.staff_id
JOIN members as m ON pts.member_id = m.member_id
WHERE s.first_name = 'Ivy' AND s.last_name = 'Irwin';