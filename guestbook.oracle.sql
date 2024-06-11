
drop table guestbook;


CREATE TABLE guestbook (
  no        NUMBER,
  name      VARCHAR2(80),
  password  VARCHAR2(20),
  content   VARCHAR2(2000),
  reg_date  DATE default sysdate,
  PRIMARY KEY(no)
);

CREATE SEQUENCE seq_guestbook_no
INCREMENT BY 1 
START WITH 1 ;

INSERT INTO guestbook
VALUES (
    seq_guestbook_no.nextval,
    '홍길동',
    '홍길동',
    '첫번째글입니다', 
    '2018-01-15');
    

INSERT INTO guestbook
VALUES (
    seq_guestbook_no.nextval,
    '장길산',
    '장길산',
    '두번째글입니다', 
    '2018-01-15');    


select * from guestbook;
commit;

    
DELETE FROM Guestbook 
WHERE no=2;    

