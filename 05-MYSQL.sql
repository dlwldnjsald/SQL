-- 0509
-- MySQL은 사용자와 Database를 구분하는 DBMS 이다
-- 현재 내가 접근할수 있는 database가 어떤게 있는지 확인
SHOW DATABASES;
-- 사용하고자 하는 특정 DATABASE 사용위해 선언 필요
USE sakila;
-- 데이터베이스 내 어떤 테이블이 있는지 확인
SHOW TABLES;
-- 테이블 구조 확인 
DESCRIBE actor;

-- 간단한 쿼리 실행 해보기
SELECT VERSION(), CURRENT_DATE;
SELECT VERSION(), CURRENT_DATE FROM dual; 
-- VERSION() 함수는 현재 MySQL 서버의 버전을 반환
-- CURRENT_DATE 함수는 현재 날짜를 반환
-- 위 두 쿼리 중 선택해서 출력 가능 
-- from dual은 있어도되고 없어도 됨 시스템정보를 나타내는 가상 테이블  

-- 특정 테이블의 데이터 조회
SELECT * FROM actor;
-- -----------------------------------

-- 데이터베이스 생성/삭제>>
-- webdb 데이터베이스 생성 
CREATE DATABASE webdb;
-- 생성 잘 되었는가 확인
SHOW DATABASES;
-- 시스템 설정에 좌우되는 경우 많다 적절한 옵션 선택이 중요함

-- 데이터베이스 삭제
DROP DATABASE webdb;

-- 문자셋, 정렬 방식을 명시적으로 지정하는것이 좋다
-- webdb라는 데이터베이스 생성하고, 문자셋 utf8mb4, 정렬 방식 utf8mb4_unicode_ci로 명시적 지정
CREATE DATABASE webdb CHARSET utf8mb4
	COLLATE utf8mb4_unicode_ci;
SHOW DATABASES;
-- -----------------------------------

-- 사용자 관리>>
-- 사용자 만들기 
--  'dev'사용자를 'localhost'에서 만들고, 비밀번호 'dev'로 설정. 
-- 그러나 아직 이 사용자에게 권한이 부여되지 않아서 생성후 권한부여 필수
CREATE USER 'dev'@'localhost' IDENTIFIED BY 'dev';
-- 사용자 비번 변경 
-- ALTER USER 'dev'@'localhost' IDENTIFIED BY 'new_password'; 하면 됨
-- 사용자 삭제 
-- DROP USER 'dev'@'localhost'; 하면 됨
-- ---------------------------------
-- 권한>>
-- 권한의 부여
-- GRANT 권한목록 ON 객체 TO '계정'@'접속호스트';
-- 권환 회수
-- REVOKE 권한 목록 ON 객체 FROM '계정'@'접속호스트';
-- 'dev'@'localhost'에게 /webdb 데이터베이스의 모든 객체에 대한 /모든 권한 허용
GRANT ALL PRIVILEGES ON webdb.* TO 'dev'@'localhost'; 
-- 권한 회수시
-- REVOKE ALL PRIVILEGES ON webdb.* TO 'dev'@'localhost'; 하면 됨
-- ----------------------------------

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
    title VARCHAR(100) NOT NULL, 	-- > pk, not null 등 컬럼에 대한 제약사항 표기해준것 
    pubs VARCHAR(100),
    pub_date DATETIME DEFAULT now(), -- DEFAULT now(): 데이터 삽입시 현재시간으로 자동 설정 //current_timestamp
    author_id int,
    CONSTRAINT fk_book FOREIGN KEY (author_id) -- > constraint,reference 이하문은 테이블 제약사항 표기
    REFERENCES author(author_id)
); 
SHOW TABLES;
DESC book;
-- ---------------------------------------------

-- INSERT UPDATE DELETE >> 
-- INSERT :새로운 레코드 삽입
-- 방법1)묵시적 방법 : 컬럼 목록 제공하지 않음-> 선언된 컬럼의 순서대로 삽입됨
INSERT INTO author VALUES(1, '박경리', '토지 작가');
-- 방법2)명시적 방법 : 컬럼 목록 제공, 컬럼 목록의  숫자, 순서, 타입이 
-- 값 목록의 숫자, 순서, 타입과 일치해야 함
INSERT INTO author (author_id, author_name) -- author_desc는 널 허용한다고 지정해줬기때문에 빼도됨
VALUES (2, '김영하');
SELECT * FROM author; -- 목록확인

-- AUTOCOMMIT 꺼주기>>----------------
-- MySQL은 기본적으로 자동 커밋 모드가 활성화 -> 각각 쿼리문이 자동커밋되어 db에 즉시반영된단의미
-- MySQL은 기본적으로 자동 커밋 모드로 설정되어 있으므로 트랜잭션이 활성화되어 있지 않다  
-- MySQL은 명시적 트랜잭션을 수행한다
-- 만약 자동 커밋 모드를 비활성화하면 MySQL은 자동으로 커밋하지 않고 트랜잭션을 수동으로 관리해야 함 
-- 트랜잭션을 명시적으로 시작한 후에는 해당 트랜잭션 범위 내에서 모든 작업이 커밋되거나 롤백되도록 해야 함

SET autocommit = 0; -- autocommit을 비활성화 하기 위해선 autocommit 옵션을 0으로 설정
START transaction; -- 명시적으로 트랜잭션 시작
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
-- ----------------------------------------------------

-- AUTO_INCREMENT 속성>>
-- 연속된 순차정보, MySQL이 해당 열에 대해 자동으로 값을 증가, 
-- 주로 일련 번호나 고유한 식별자를 생성하는 데 사용 (주로 PK속성에 사용된다)

-- author 테이블의 PK에 auto_increment 속성부여------
ALTER TABLE author MODIFY author_id INT AUTO_INCREMENT PRIMARY KEY;
-- 위의 코드가 MULTIPLE PRIMARY KEY DEFINED로 오류뜸 (중복있다는 소리) 
-- 위의 오류 해결방법은 아래
-- 1. FK 정보 확인
SELECT * FROM information_schema.KEY_COLUMN_USAGE;
SELECT constraint_name FROM information_schema.KEY_COLUMN_USAGE 
WHERE table_name = 'book'; -- book 테이블 내의 fk 값 찾아보기
-- 2. FK 삭제 : book 테이블의 FK(fk_book)삭제하기
ALTER TABLE book DROP FOREIGN KEY fk_book;
-- 3. author 테이블의 pk에 auto_increment 속성 붙이기 
-- 기존 PK 삭제
ALTER TABLE author DROP PRIMARY KEY;
-- AUTO_INCREMENT 속성이 부여된 새로운 PK 생성
ALTER TABLE author MODIFY author_id INT AUTO_INCREMENT PRIMARY KEY;
-- 4. 삭제했던 FK-> 다시 book의 author_id에 FK 재연결 
ALTER TABLE book 
ADD CONSTRAINT fk_book FOREIGN KEY (author_id) 
REFERENCES author(author_id);

-- AUTO_COMMIT 을 다시 켜주기 -------------------
SET autocommit = 1;
-- 다시 자동으로 트랜잭션이 수행될것

-- AUTO_INCREMENT -----------------------------
-- AUTHOR TABLE 확인
SELECT * FROM author;
-- 1. 새로운 AUTO_INCREMENT 값 부여하기위해 PK 최댓값 구하기
SELECT MAX(author_id) FROM author; -- 2 로 나옴
-- 새로 생성되는 uteo_increment 시작값을 변경
ALTER TABLE author AUTO_INCREMENT = 3; -- 3번부터 시작해야 함 
-- 테이블 구조 확인
DESC author;

SELECT * FROM author;
-- 작가 2명 데이터 더 추가 
INSERT INTO author (author_name) VALUES ('스티븐 킹'); -- authordesc 는 굳이 입력 안해도 null값으로 나옴
INSERT INTO author (author_name, author_desc) VALUES ('류츠신', '삼체 작가');
SELECT * FROM author; 
-- -------------------------------------------

-- 2. 테이블 생성시 AUTO_INCREMENT 속성을 부여하는 방법 
DROP TABLE book CASCADE; -- 기존의 book 테이블 삭제후 다시 생성해보기

-- book 테이블 생성 (AUTO_INCREMENT 속성 부여)
CREATE TABLE book ( 
	book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    pubs VARCHAR(100),
    pub_date DATETIME DEFAULT now(),
    author_id int,
    CONSTRAINT fk_book FOREIGN KEY (author_id)
    REFERENCES author(author_id)
);
DESC book; 

-- 데이터 입력해주기 
INSERT INTO book (title, pub_date, author_id) VALUES ('토지', '1994-03-04', 1);
INSERT INTO book (title, author_id) VALUES ('살인자의 기억법', 2);
INSERT INTO book (title, author_id) VALUES ('쇼생크 탈출', 3);
INSERT INTO book (title, author_id) VALUES ('삼체', 4);
SELECT * FROM book;
-- ------------------------------------------
desc author;
desc book;
-- JOIN >>
SELECT title 제목,  
		pub_date 출판일, -- > book 테이블 내
		author_name 저자명,
        author_desc '저자 상세' -- > author 테이블 내
FROM book b JOIN author a -- join
ON b.author_id = a.author_id; 















