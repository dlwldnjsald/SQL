-- table PHONE_BOOK 만들기 
CREATE TABLE PHONE_BOOK (
    id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(10),
    hp VARCHAR2(20),
    tel VARCHAR2(20)
); 
DESC PHONE_BOOK;

--  table PHONE_BOOK 에 컬럼 및 데이터 삽입
INSERT INTO PHONE_BOOK (id, name, hp, tel) VALUES (1, '고길동', '010-8788-8881', '032-8890-2974');
INSERT INTO PHONE_BOOK (id, name, hp, tel) VALUES (2, '둘리', '010-1212-3434', '02-5678-8765');
INSERT INTO PHONE_BOOK (id, name, hp, tel) VALUES (3, '마이콜', '010-7102-6327', '02-9192-5069');
INSERT INTO PHONE_BOOK (id, name, hp, tel) VALUES (4, '또치', '010-6514-5113', '02-7976-9368');
INSERT INTO PHONE_BOOK (id, name, hp, tel) VALUES (5, '홍길동', '010-7777-7777', '02-3333-3333');

--  table PHONE_BOOK의 컬럼 및 데이터 확인
SELECT * FROM PHONE_BOOK;

-- sql --> java에다 입력할 sql)
SELECT id, name, hp, tel 
FROM PHONE_BOOK
ORDER BY id;

COMMIT;

-- 2.등록 문항에 추가 등록을 위한 시퀀스 작성 
CREATE SEQUENCE seq_phonebook_id 
        START WITH 6 INCREMENT BY 1 MAXVALUE 1000000;
---- 시퀀스를 위한 딕셔너리
SELECT * FROM USER_SEQUENCES;
--drop 원할경우
DROP SEQUENCE seq_phonebook_id;

        
