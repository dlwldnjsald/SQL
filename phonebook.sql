-- TABLE
CREATE TABLE PHONE_BOOK (
    id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(10),
    hp VARCHAR2(20),
    tel VARCHAR2(20)
);

-- SEQUENCE
CREATE SEQUENCE seq_phone_book
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
    desc Phone_book;
    select * from phone_book;