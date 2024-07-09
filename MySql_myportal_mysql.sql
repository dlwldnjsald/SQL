-- 0708 users 
CREATE TABLE users (
no int auto_increment, 
name varchar(20) NOT NULL,
email varchar(128) NOT NULL,
password varchar(20) NOT NULL,
gender char(1) DEFAULT 'M' check (gender in ('M', 'F')),
joindate datetime DEFAULT now(), 
primary key(no)
)

select * from users



-- guestbook
create table guestbook (
	no int auto_increment,
	name varchar(20) NOT NULL,
    password varchar(20) NOT NULL,
    content varchar(255) NOT NULL,
    reg_date datetime DEFAULT now(),
    primary key(no)
    )
    
    select * from guestbook
    
    CREATE TABLE board (
	no int auto_increment,
    title varchar(128) NOT NULL,
    content varchar(255) NOT NULL,
    hit int DEFAULT 0,
    reg_date datetime DEFAULT now(),
    user_no int NOT NULL,
    PRIMARY KEY(no)
)
select * from board