-- MySQL은 사용자와 Database를 구분하는 DBMS 이다
-- 현재 내가 사용할수 있는 database가 어떤게 있는지 확인
SHOW DATABASES;

-- 사용하고자 하는 DATABASE 사용위해 선언
USE sakila;

-- 데이터베이스 내에 어떤 테이블이 있는지 확인
SHOW TABLES;

-- 테이블 구조 확인 
DESCRIBE actor;

-- 간단한 쿼리 실행 
SELECT VERSION(), CURRENT_DATE;
SELECT VERSION(), CURRENT_DATE FROM dual; 
-- 위 두 쿼리 중 선택해서 출력 가능 
-- from dual은 있어도되고 없어도 됨 시스템정보를 나타내는 가상 테이블  

-- 특정 테이블의 데이터 조회
SELECT * FROM actor;

--
-- 데이터베이스 생성 
-- webdb 데이터베이스 생성 
CREATE DATABASE webdb;
-- 생성 잘 되었는가 확인
SHOW DATABASES;
-- 시스템 설정에 좌우되는 경우 많다

-- 데이터베이스 삭제
DROP DATABASE webdb;
-- 문자셋, 정렬 방식을 명시적으로 지정하는것이 좋다
CREATE DATABASE webdb CHARSET utf8mb4
	COLLATE utf8mb4_unicode_ci;
SHOW DATABASES;

--
-- 사용자 만들기 
CREATE USER 'dev'@'localhost' IDENTIFIED BY 'dev';
-- 사용자 비번 변경 
-- ALTER USER 'dev'@'localhost' IDENTIFIED BY 'new_password';
-- 사용자 삭제 
-- DROP USER 'dev'@'localhost';

--
-- 권한의 부여
-- GRANT 권한목록 ON 객체 TO '계정'@'접속호스트';
-- 권환 회수
-- REVOKE 권한 목록 ON 객체 FROM '계정'@'접속호스트';

-- 'dev'@'localhost'에게 /webdb 데이터베이스의 모든 객체에 대한 /모든 권한 허용
GRANT ALL PRIVILEGES ON webdb.* TO 'dev'@'localhost'; 
-- 권한 회수시
-- REVOKE ALL PRIVILEGES ON webdb.* TO 'dev'@'localhost'; 하면 됨


-- 데이터 베이스 확인
SHOW DATABASES;
-- 사용할 데이터 베이스 선언
USE webdb;
-- 테이블 관리>> 
-- 테이블 생성
CREATE TABLE author (
	author_id int PRIMARY KEY,
    author_name VARCHAR(50) NOT NULL,
    author_desc VARCHAR(500) 
);

SHOW TABLES;
DESC author;
-- 테이블 생성 정보 확인
SHOW CREATE TABLE author;

 

-- 테이블 내에 컬럼 추가 
ALTER TABLE book ADD pubs VARCHAR(50)

-- 제약 조건 NOTNULL

