
-- project _cal db --
show databases;
SHOW TABLES;


-- users 테이블 생성
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255),
    user_email VARCHAR(255),
    user_password VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from users;

-- events 테이블 생성
CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    event_title VARCHAR(255),
    event_description TEXT,
    event_start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    event_end_time TIMESTAMP,
    event_repeat_type VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    event_status VARCHAR(10),
    event_authority INT DEFAULT 0
);


select * from events;

-- files 테이블 생성
CREATE TABLE files (
    file_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    file_name VARCHAR(255),
    file_path VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from files;

-- event_comments 테이블 생성 -> drop
CREATE TABLE event_comments (
    event_comment_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    user_id INT,
    event_comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from event_comments;


-- event_attendees 테이블 생성 -> drop
CREATE TABLE event_attendees (
    event_attendee_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    user_id INT,
    event_attendee_status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from event_attendees;

