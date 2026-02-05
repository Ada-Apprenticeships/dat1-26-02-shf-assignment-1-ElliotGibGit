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
name VARCHAR(255) NOT NULL,
address VARCHAR(255),
phone_number VARCHAR(20),--Home Phone num used
email VARCHAR(255) 
    CHECK (email GLOB '*@*.*'),
opening_hours VARCHAR(11) 
    CHECK (opening_hours GLOB '[0-2][0-9]:[0-5][0-9]-[0-2][0-9]:[0-5][0-9]')
);
CREATE TABLE members (
member_id INTEGER PRIMARY KEY,
first_name TEXT NOT NULL,
last_name TEXT NOT NULL,
email VARCHAR(255) NOT NULL
    CHECK (email GLOB '*@*.*'),
phone_number VARCHAR(12)
    CHECK (phone_number GLOB '[0-9][0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9][0-9][0-9]'),
date_of_birth VARCHAR(10)
    CHECK (date_of_birth GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
join_date VARCHAR(10)
    CHECK (join_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
emergency_contact_name TEXT,
emergency_contact_phone VARCHAR(12)
    CHECK (emergency_contact_phone GLOB '[0-9][0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9][0-9][0-9]')
);
CREATE TABLE staff (
staff_id INTEGER PRIMARY KEY, --PK
first_name TEXT NOT NULL,
last_name TEXT NOT NULL, 
email VARCHAR(255) NOT NULL,
phone_number VARCHAR(12) 
    CHECK (phone_number GLOB '[0-9][0-9][0-9][0-9][0-9] [0-9][0-9][0-9][0-9][0-9][0-9]'),
position TEXT
    CHECK (position IN ('Trainer', 'Manager','Receptionist','Maintenance')),
hire_date VARCHAR(10)
    CHECK (hire_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
location_id INTEGER,
FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE SET NULL
);
CREATE TABLE equipment (
equipment_id INTEGER PRIMARY KEY, --PK
name VARCHAR(255),
type TEXT
    CHECK (type IN ('Cardio', 'Strength')),
purchase_date VARCHAR(10) CHECK (purchase_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
last_maintenance_date VARCHAR(10) CHECK (last_maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
next_maintenance_date VARCHAR(10) CHECK (next_maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
location_id INTEGER, --FK,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
CREATE TABLE classes (
class_id INTEGER PRIMARY KEY, --PK
name VARCHAR(255) NOT NULL,
description VARCHAR(255),
capacity INTEGER,
duration INTEGER,
location_id INTEGER,--FK,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
CREATE TABLE class_schedule (
schedule_id INTEGER PRIMARY KEY, --PK
class_id INTEGER, --FK
staff_id INTEGER, --FK
start_time VARCHAR(19)
    CHECK (start_time GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
end_time VARCHAR(19)
    CHECK (end_time GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE SET NULL
);
CREATE TABLE memberships (
membership_id INTEGER PRIMARY KEY,-- PK
member_id INTEGER,--FK
type VARCHAR(50)
    CHECK (type IN ('Standard','Premium','Day pass')),
start_date VARCHAR(10) 
    CHECK (start_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
end_date VARCHAR(10)
    CHECK (end_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
status TEXT
    CHECK (status IN ('Active','Inactive')),
FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);
CREATE TABLE attendance (
attendance_id INTEGER PRIMARY KEY,--PK
member_id INTEGER, --FK
location_id INTEGER, --FK
check_in_time VARCHAR(19)
    CHECK (check_in_time GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
check_out_time VARCHAR(19)
    CHECK (check_out_time GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
CREATE TABLE class_attendance (
class_attendance_id INTEGER PRIMARY KEY, --PK
schedule_id INTEGER, --FK
member_id INTEGER, --FK
attendance_status
    CHECK (attendance_status IN ('Registered', 'Attended', 'Unattended')),
FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id) ON DELETE CASCADE,
FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);
CREATE TABLE payments(
payment_id INTEGER PRIMARY KEY, --PK
member_id INTEGER, --FK
amount DECIMAL,
payment_date 
    CHECK (payment_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
payment_method VARCHAR(50)
    CHECK (payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal','Cash'))
    CHECK (amount >= 0),
payment_type TEXT,
    CHECK(payment_type IN ('Monthly membership fee', 'Day pass')),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);
CREATE TABLE personal_training_sessions(
session_id INTEGER PRIMARY KEY, --PK
member_id INTEGER, --FK
staff_id INTEGER, --FK
session_date VARCHAR(10)
    CHECK (session_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
start_time VARCHAR(8)
    CHECK (start_time GLOB '[0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
end_time VARCHAR(8)
    CHECK (end_time GLOB '[0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),

notes VARCHAR(255),
FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE SET NULL
);
CREATE TABLE member_health_metrics(
metric_id INTEGER PRIMARY KEY, --PK
member_id INTEGER, --FK
measurement_date VARCHAR(10) 
    CHECK (measurement_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
weight DECIMAL
    CHECK (weight > 0),
body_fat_percentage DECIMAL
    CHECK (body_fat_percentage >= 0 AND body_fat_percentage <= 100),
muscle_mass DECIMAL
    CHECK (muscle_mass >= 0),
bmi DECIMAL
    CHECK (bmi > 0),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);
CREATE TABLE equipment_maintenance_log(
log_id INTEGER PRIMARY KEY , --PK
equipment_id INTEGER, --FK
maintenance_date 
    CHECK (maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
description TEXT,
staff_id INTEGER, --FK
FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);
