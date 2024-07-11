-- users 테이블 생성
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255),
    user_email VARCHAR(255),
    user_password VARCHAR(255),
    user_authority VARCHAR(20) DEFAULT "user",
    user_position VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- tasks 테이블 생성
CREATE TABLE tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    project_id INT,
    task_title VARCHAR(255),
    task_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    task_status VARCHAR(10) DEFAULT "none"
);
insert into tasks( user_id,project_id, task_title, task_description, task_status)
values (123, 456, 'testTiele', 'testDesc', 'testStat')


insert into tasks( user_id,project_id, task_title, task_description, task_status)
values (789, 1111, 'testTieleaaaa', 'testDescaaaa', 'aaaaa')

		SELECT * 
		  FROM TASKS
-- projects 테이블 생성
CREATE TABLE projects (
		project_id INT AUTO_INCREMENT PRIMARY KEY,
		user_id INT,
		project_title VARCHAR(255),
		project_description TEXT,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    project_status VARCHAR(10) DEFAULT "none"
		
);
