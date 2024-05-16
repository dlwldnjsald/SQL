-- 본인의 이름 주석으로 작성  예)홍길동
-- 여기에 본인의 이름을 작성해 주세요
-- 이지원 




-- 데이터베이스 초기화를 위해 기존의 테이블과 시퀀스를 모두 삭제
-- 초기화를 위해 테이블(2개)과 시퀀스(2개)를 모두 삭제합니다.
SELECT * FROM USER_SEQUENCES;
SELECT * FROM TABS;

DESC AUTHOR;
DESC BOOK;

DROP TABLE AUTHOR;
DROP TABLE BOOK;

DROP SEQUENCE SEQ_AUTHOR_ID;
DROP SEQUENCE SEQ_BOOK_ID;





-- 시퀀스 생성 쿼리문 2개
-- 테이블 t_author와 t_book에서 사용할 PK를 위한 시퀀스 생성
CREATE SEQUENCE seq_author 
        START WITH 1 INCREMENT BY 1 MAXVALUE 1000000;
CREATE SEQUENCE seq_book 
        START WITH 1 INCREMENT BY 1 MAXVALUE 1000000;
SELECT * FROM USER_SEQUENCES;



-- 테이블 생성 쿼리문 2개
/*
컬럼명은 문제 이미지를 참고합니다.
각각의 테이블의 pk 컬럼은 
!!!!시퀀스 객체를 이용하여 입력합니다
author_id 는 pk, fk 관계입니다.
*/
-- 시퀀스 객체를 이용하여  테이블 생성
CREATE TABLE AUTHOR (
    author_id NUMBER(10) DEFAULT seq_author.NEXTVAL,
    author_name VARCHAR(100),
    author_desc VARCHAR(100),
    PRIMARY KEY (author_id)
);

DESC AUTHOR;

-- 시퀀스 객체를 이용하여 테이블 생성
CREATE TABLE BOOK (
    book_id NUMBER(10) DEFAULT seq_book.NEXTVAL,
    title VARCHAR(100),
    pubs VARCHAR(100),
    pub_date DATE,
    author_id NUMBER(10),
    FOREIGN KEY (author_id) REFERENCES AUTHOR(author_id)
);

DESC BOOK;

-- t_author테이블 데이터 입력 쿼리문 6개
-- 문제 이미지의 결과가 나오도록 데이터를 입력합니다.
        
        -- inset into 
        INSERT INTO author(author_id, author_name, author_desc)
        VALUES(seq_author.NEXTVAL, '이문열', '경북 영양');
        INSERT INTO author(author_id, author_name, author_desc)
        VALUES(seq_author.NEXTVAL, '박경리', '경상남도 통영');
        INSERT INTO author(author_id, author_name, author_desc)
        VALUES(seq_author.NEXTVAL, '유시민', '17대 국회의원');
        INSERT INTO author(author_id, author_name, author_desc)
        VALUES(seq_author.NEXTVAL, '강풀', '온라인 만화가 1세대');
        INSERT INTO author(author_id, author_name, author_desc)
        VALUES(seq_author.NEXTVAL, '김영하', '알쓸신잡');
        INSERT INTO author(author_id, author_name, author_desc)
        VALUES(seq_author.NEXTVAL, '류츠신', '휴고상 수상 SF 작가');
        
SELECT * FROM author;     


-- book테이블의 데이터 입력 쿼리문 9개
-- 문제 이미지의 결과가 나오도록 데이터를 입력합니다.

        --insert into 
        INSERT INTO BOOK(book_id, title, pubs, pub_date, author_id)
        VALUES(seq_book.NEXTVAL, '우리들의 일그러진 영웅', '다림', '1998-02-22', '1');
        INSERT INTO BOOK(book_id, title, pubs, pub_date, author_id)
        VALUES(seq_book.NEXTVAL, '삼국지', '민음사', '2002-03-01', '1');
        INSERT INTO BOOK(book_id, title, pubs, pub_date, author_id)
        VALUES(seq_book.NEXTVAL, '토지', '마로니에북스', '2012-08-15', '2');
        INSERT INTO BOOK(book_id, title, pubs, pub_date, author_id)
        VALUES(seq_book.NEXTVAL, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', '3');
        INSERT INTO BOOK(book_id, title, pubs, pub_date, author_id)
        VALUES(seq_book.NEXTVAL, '순정만화', '재미주의', '2011-08-03', '4');
        INSERT INTO BOOK(book_id, title, pubs, pub_date, author_id)
        VALUES(seq_book.NEXTVAL, '오직두사람', '문학동네', '2017-05-04', '5');
        INSERT INTO BOOK(book_id, title, pubs, pub_date, author_id)
        VALUES(seq_book.NEXTVAL, '26년', '재미주의', '2012-02-04', '4');
        INSERT INTO BOOK(book_id, title, pubs, pub_date, author_id)
        VALUES(seq_book.NEXTVAL, '삼체', '자음과모음', '2020-07-06', '6');
        INSERT INTO BOOK(book_id, title, pubs, pub_date, author_id)
        VALUES(seq_book.NEXTVAL, 'AI 시대의 히치하이커', NULL, '2023-09-24', NULL);
        
SELECT * FROM BOOK; 

--0000-00-00 형식으로 pub_date 컬럼의 데이터 재출력 
SELECT book_id, title, pubs, 
        TO_CHAR(pub_date, 'YYYY-MM-DD') AS pub_date, 
        author_id 
FROM BOOK;

-- 현재 작성된 두 개의 테이블에 대한 /SELECT 권한을 /hr에게 부여
-- 현재 작성된 두 개의 테이블을 조회할 수 있도록 권한을 hr 계정에게 부여합니다

-- grant 권한 부여
GRANT SELECT ON AUTHOR TO hr;
GRANT SELECT ON BOOK TO hr;


-- 아래의 조건에 맞는 책목록 리스트 쿼리문 1개
/*
(1)등록된 모든 책이 출력되어야 합니다.(9권)
(2)출판일은 ‘1998년 02월 02일’ 형태로 보여야 합니다.
(3)정렬은 책 제목을 내림차순으로 정렬합니다.
*/

--(1)등록된 모든 책이 출력되어야 합니다.(9권)
SELECT * FROM BOOK;

--(2)출판일은 ‘1998년 02월 02일’ 형태로 보여야 합니다.
-- YYYY년 MM월 DD일 형식으로 pub_date 컬럼의 데이터 재출력 
SELECT book_id, title, pubs, 
        TO_CHAR(pub_date, 'YYYY"년 "MM"월 "DD"일"') AS pub_date, 
        author_id 
FROM BOOK;

--(3)정렬은 책 제목을 내림차순으로 정렬합니다.
SELECT * FROM BOOK ORDER BY title DESC;

-- 최종 출력물 -- I FORGOT LEFT OUTER JOIN,,
SELECT BOOK.book_id, BOOK.title, BOOK.pubs, BOOK.pub_date, BOOK.author_id,
         AUTHOR.author_id, AUTHOR.author_name, AUTHOR.author_desc
FROM BOOK LEFT OUTER JOIN AUTHOR 
        ON BOOK.author_id = AUTHOR.author_id
ORDER BY BOOK.title DESC;

-- [산출물]
/*
- 아래 2개의 산출물을 
이름.zip 파일로 압축해서 제출합니다.
- book_test.sql -- BOOK_TEST 라는 쿼리문 
- book_list.jpg -- 캡쳐화면 
*/

-- 수고하셨습니다
