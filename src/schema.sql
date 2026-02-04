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
name VARCHAR(255),
address VARCHAR(255),
phone_number VARCHAR(12),
email VARCHAR(255),
opening_hours TEXT 
    check (opening_hours GLOB '[0-1][0-9]:[0-5][0-9]-[0-1][0-9]:[0-5][0-9]')
);
CREATE TABLE members (
member_id INTEGER PRIMARY KEY,
first_name TEXT,
last_name TEXT,
email VARCHAR(255),
phone_number VARCHAR(12),
date_of_birth VARCHAR(6) 
    check (date_of_birth GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'), 
join_date,
emergency_contact_name,
emergency_contact_phone
);
CREATE TABLE staff (
staff_id PRIMARY KEY, --PK
first_name,
last_name,
email,
phone_number,
position,
hire_date,
location_id,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
CREATE TABLE equipment (
equipment_id PRIMARY KEY, --PK
name,
type,
purchase_date,
last_maintenance_date,
next_maintenance_date,
location_id, --FK,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
CREATE TABLE classes (
class_id PRIMARY KEY, --PK
name,
description,
capacity,
duration,
location_id,--FK,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
CREATE TABLE class_schedule (
schedule_id PRIMARY KEY, --PK
class_id, --FK
staff_id, --FK
start_time,
end_time,
FOREIGN KEY (class_id) REFERENCES classes(class_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);
CREATE TABLE memberships (
membership_id PRIMARY KEY,-- PK
member_id ,--FK
type,
start_date,
end_date,
status,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);
CREATE TABLE attendance (
attendance_id PRIMARY KEY,--PK
member_id, --FK
location_id, --FK
check_in_time,
check_out_time,
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
CREATE TABLE class_attendance (
class_attendance_id PRIMARY KEY, --PK
schedule_id, --FK
member_id, --FK
attendance_status,
FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id)
FOREIGN KEY (member_id) REFERENCES members(member_id)
);
CREATE TABLE payments(
payment_id PRIMARY KEY, --PK
member_id, --FK
amount,
payment_date,
payment_method,
description,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);
CREATE TABLE personal_training_sessions(
session_id PRIMARY KEY, --PK
member_id, --FK
staff_id, --FK
session_date,
start_time,
end_time,
notes,
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);
CREATE TABLE member_health_metrics(
metric_id PRIMARY KEY, --PK
member_id, --FK
measurement_date,
weight,
body_fat_percentage,
muscle_mass,
bmi,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);
CREATE TABLE equipment_maintenance_log(
log_id PRIMARY KEY, --PK
equipment_id, --FK
maintenance_date,
description,
staff_id, --FK
FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);