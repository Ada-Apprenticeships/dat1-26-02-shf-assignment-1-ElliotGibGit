.open "C:/Users/Ellio/REPO_CLONES/dat1-26-02-shf-assignment-1-ElliotGibGit/src/fittrackpro.db"
.mode column

-- 6.1 
INSERT INTO attendance (member_id, location_id, check_in_time)
VALUES (7, 1, '2025-02-14 16:30:00');

-- 6.2 
SELECT 
    DATE(check_in_time) AS visit_date,check_in_time,check_out_time
FROM attendance
WHERE member_id = 5;

-- 6.3 
SELECT 
    CASE CAST(strftime('%w', check_in_time) AS INTEGER)
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS day_of_week,
    COUNT(*) AS visit_count
FROM attendance
GROUP BY strftime('%w', check_in_time)
ORDER BY visit_count DESC;

-- 6.4 
SELECT
    l.name AS location_name,
    ROUND(COUNT(a.attendance_id) * 1.0 / 7, 2) AS avg_daily_attendance
FROM locations as l
LEFT JOIN attendance a ON l.location_id = a.location_id
GROUP BY l.location_id, l.name;