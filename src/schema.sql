.open fittrackpro.db
.mode box

DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintenance_log;

PRAGMA foreign_keys = ON;

CREATE TABLE locations (
location_id INTEGER PRIMARY KEY,
name TEXT,
address TEXT,
phone_number VARCHAR(20),
email VARCHAR(255),
opening_hours TEXT GLOB '[0-1][0-9]:[0-5][0-9]-[0-1][0-9]:[0-5][0-9]'
);
CREATE TABLE members (
member_id INTEGER PRIMARY KEY,
first_name TEXT,
last_name TEXT,
email ,
phone_number ,
date_of_birth, 
join_date,
emergency_contact_name,
emergency_contact_phone
);
CREATE TABLE staff (
staff_id, --PK
first_name,
last_name,
email,
phone_number,
position,
hire_date,
location_id --FK
);
CREATE TABLE equipment (
equipment_id, --PK
name,
type,
purchase_date,
last_maintenance_date,
next_maintenance_date,
location_id --FK
);
CREATE TABLE classes (
class_id, --PK
name,
description,
capacity,
duration,
location_id--FK
);
CREATE TABLE class_schedule (
schedule_id, --PK
class_id, --FK
staff_id, --FK
start_time,
end_time
);
CREATE TABLE memberships (
membership_id,-- PK
member_id ,--FK
type,
start_date,
end_date,
status
);
CREATE TABLE attendance (
attendance_id --PK
member_id, --FK
location_id, --FK
check_in_time,
check_out_time
);
CREATE TABLE class_attendance (
class_attendance_id, --PK
schedule_id, --FK
member_id, --FK
attendance_status
);
CREATE TABLE payments(
payment_id, --PK
member_id, --FK
amount,
payment_date,
payment_method,
description
);
CREATE TABLE personal_training_session(
session_id, --PK
member_id, --FK
staff_id, --FK
session_date,
start_time,
end_time,
notes
);
CREATE TABLE member_health_metrics(
metric_id, --PK
member_id, --FK
measurement_date,
weight,
body_fat_percentage,
muscle_mass,
bmi
);
CREATE TABLE
log_id, --PK
equipment_id, --FK
maintenance_date,
description,
staff_id --FK
);