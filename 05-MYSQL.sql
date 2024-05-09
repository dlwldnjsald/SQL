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

-- 데이터베이스 생성/삭제>>
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

-- 사용자 관리>>
-- 사용자 만들기 
CREATE USER 'dev'@'localhost' IDENTIFIED BY 'dev';
-- 사용자 비번 변경 
-- ALTER USER 'dev'@'localhost' IDENTIFIED BY 'new_password';
-- 사용자 삭제 
-- DROP USER 'dev'@'localhost';

-- 권한>>
-- 권한의 부여
-- GRANT 권한목록 ON 객체 TO '계정'@'접속호스트';
-- 권환 회수
-- REVOKE 권한 목록 ON 객체 FROM '계정'@'접속호스트';

-- 'dev'@'localhost'에게 /webdb 데이터베이스의 모든 객체에 대한 /모든 권한 허용
GRANT ALL PRIVILEGES ON webdb.* TO 'dev'@'localhost'; 
-- 권한 회수시
-- REVOKE ALL PRIVILEGES ON webdb.* TO 'dev'@'localhost'; 하면 됨

-- 테이블 관리>> 
-- 데이터 베이스 확인
SHOW DATABASES;
-- 사용할 데이터 베이스 선언
USE webdb;

-- author 테이블 생성
CREATE TABLE author (
	author_id int PRIMARY KEY,
    author_name VARCHAR(50) NOT NULL,
    author_desc VARCHAR(500) 
);
SHOW TABLES;
DESC author;
-- 테이블 생성 정보 확인
SHOW CREATE TABLE author;

-- book 테이블 생성
CREATE TABLE book (
	book_id int PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    pubs VARCHAR(100),
    pub_date DATETIME DEFAULT now(),
    author_id int,
    CONSTRAINT fk_book FOREIGN KEY (author_id)
    REFERENCES author(author_id)
); 
SHOW TABLES;
DESC book;

-- INSERT UPDATE DELETE >> 
-- INSERT :새로운 레코드 삽입
-- 방법1)묵시적 방법 : 컬럼 목록 제공하지 않음-> 선언된 컬럼의 순서대로 삽입됨
INSERT INTO author VALUES(1, '박경리', '토지 작가');
-- 방법2)명시적 방법 : 컬럼 목록 제공, 컬럼 목록의  숫자, 순서, 타입이 
-- 값 목록의 숫자, 순서, 타입과 일치해야 함
INSERT INTO author (author_id, author_name) -- author_desc는 널 허용한다하니 빼도됨
VALUES (2, '김영하');
SELECT * FROM author; -- 목록확인

-- MySQL은 기본적으로 자동 커밋이 활성화
-- autocommit을 비활성화 하기 위해선 autocommit 옵션을 0으로 설정해줘야 한다
SET autocommit = 0;

-- MySQL은 명시적 트랜잭션을 수행한다
START transaction;
SELECT * FROM author;

-- UPDATE author
-- SET author_desc = '알쓸신잡 출연'; -- where절이 없을경우 전체 레코드 변경됨 
-- 위의 경우 where절 안쓰면 안되도록 막아버림

UPDATE author
SET author_desc = '알쓸신잡 출연'
WHERE author_id = 2;  -- where절 써줘야 함 
SELECT * FROM author; -- 확인
-- ROLLBACK; -- 위의 커리 반영 취소할 경우,
COMMIT; -- 변경 사항 영구 반영 



