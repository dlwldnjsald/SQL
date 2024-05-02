-- DBMS 의 3대 기능 : 조작, 제어, 정의기능
--DML DATA MANIPULATION LANGUAGE (조작)
    -- 생성 CREATE --> "INSERT"문
    -- 조회 RETRIEVE OR READ --> "SELECT"문
    -- 갱신 UPDATE --> "UPDATE"문
    -- 삭제 DELETE --> "DELETE"문
--DCL DATA CONTROL LANGUAGE (제어)
--DDL DATA DEFINITION LANGUAGE (정의)

--DATABASE USER사용자
-- DATABASE USER -> 데이터베이스에 접속하여 데이터를 이용하기 위해 접근하는 모든 사람
-- 이용 목적에 따라 데이터베이스 관리자(DBA), 최종사용자(일반사용자), 응용프로그래머 로 구분


--------------------------------------
-- DCL (DATA CONTROL LANGUAGE) 
-- and DDL(DATA DEFINITION LANGUAGE)
--------------------------------------

-- 사용자 생성
-- CREATE USER 권한이 있어야 함
-- SYSTEM 계정으로 수행해야 함

-- SYSTEM 계정으로 수행>>
CREATE USER himedia IDENTIFIED BY himedia;  
-- himedia 라는 이름의 계정을 (schema)만들고 
-- 비밀번호 himedia로 설정 한 코드
-- orale 18 version 부터 container database 개념이 도입됨
-- 한대의 데이터 베이스에 다 몰아넣으면 무리가 생겨서 
-- 사용자 스키마 자체를 분산 데이터로 분산 저장하기 시작

-- SYSTEM 계정으로 수행>>
-- 1)사용자 계정 생성 ->사용자 계정명 앞에 C## 붙여서 생성  : CREATE USER
CREATE USER C##HIMEDIA IDENTIFIED BY himedia;
-- 2)비밀번호 변경 : ALTER USER
ALTER USER C##HIMEDIA IDENTIFIED BY new_password;
-- 3)계정 삭제 : DROP USER
DROP USER C##HIMEDIA CASCADE;           
--CASCADE : 폭포수 혹은 연결된 것이라는 의미
-- 이 USER와 연결된 모든 것들을 삭제하겠다는 의미 

-- SYSTEM 계정으로 수행>>
-- 계정 생성 방법 2. -> CD 기능 무력화
ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER himedia IDENTIFIED BY himedia;
-- 연습상태이기에 방법 2를 사용해서 사용자를 생성해볼예정
-- 하지만 이것은 추천하지 않음 ..
--
-- 아직 접속 불가
-- 데이터 베이스 접속, 테이블 생성 데이터베이스 객체 작업을 수행
--> CONNECT, RESOURCE ROLE(역할) 부여
GRANT CONNECT, RESOURCE TO HIMEDIA;
-- CMD 컴맨드라인에 : SQLPLUS HIMEDIA/HIMEDIA 
-- CREATE TABLE test(A NUMBER); TEST란 테이블을 만들건데 
-- A라는 컬럼안의 NUMBER타입의 데이터를 집어넣을것 명령해줌 
-- DESC TEST; -- 테이블 test의 구조 보기
-- HIMEDIA계정 안에 >TEST테이블안에 >>A컬럼이 생성된것을 확인할수 있음
--
-->himedia 스키마로 사용자로 진행>>
--> himedia 생성해주고 system-> himedia로 변경해주기 스키마
-- 데이터 추가 
DESCRIBE test;
INSERT INTO test VALUES (2024); 
-- 테스트란 테이블 안쪽에다가 정의된 값 2024를 집어넣어라--> 여기서 실행 안됨 
--> 오류나는 이유 USERS 테이블 스페이스에 대한 권한이 없다 
-- 권한이 불충분합니다로 출력됨.
-- 19이상 
--
--> 다시 SYSTEM 시스템 계정으로 변경후 실행>>
ALTER USER himedia DEFAULT TABLESPACE USERS
        QUOTA unlimited on USERS; 
        -- "User HIMEDIA이(가) 변경되었습니다." 로 출력됨
        -- QUOTA (용량)
        -- TABLESPACE 권한 부여함
--
--> 다시 himedia 계정으로 변경후 실행>>
INSERT INTO test VALUES (2024);  --1 행 이(가) 삽입되었습니다." 가 출력될것
SELECT * FROM test;
--
SELECT * FROM USER_USERS; -- 현재 로그인한 사용자 정보(나)
SELECT * FROM ALL_USERS;  -- 모든 사용자 정보
-- DBA 전용 (sysdba로 로그인해야 확인 가능 실제 계정은 아닌데 역할이라고 보면 됨)
--cmd : sqlplus system/manager --> ㄴsysdba로 접속 가능
SELECT * FROM DBA_USERS;



---- 만일 시나리오: HR스키마의 EMPLOYEES 테이블 조회 권환을 HIMEDIA에게 부여하고자 한다면
-- HR 스키마의 오너(주인)은 HR -> HR로 접속후 수행해보기 
GRANT SELECT ON employees TO himedia; --Grant을(를) 성공했습니다.로 출력됨
--
--> 다시 himedia 계정으로 변경후  실행 >> (스키마->사용자)
SELECT * FROM HR.employees; 
-- HR 스키마 안쪽의 EMPLOYEES TABLE의 셀렉트 권한을 HIMEDIA 에게 부여한 값
SELECT * FROM HR.DEPARTMENTS; --테이블 또는 뷰가 존재하지 않습니다 로 뜨게됨
-- HR.EMPLOYEES 에 SELECT 할수있는 권한만 부여받은것이기 때문 


        
--> himedia 계정으로 실행>>
---- 현재 사용자에게 부여된 ROLE의 확인
SELECT * FROM USER_ROLE_PRIVS;   
--> CONNECT 와 RESOURCE ROLE 확인 가능
--
-- 위 두개의 역할(CONNECT 와 RESOURCE ROLE)은 어떤 권한(privilege)으로 구성되어 있는가 확인하고자 할때
-- SYSDBA로 진행해야 함 -->CMD 켜기 
-- 1) sqlplus sys/oracle as sysdba 입력하기 (접속)
-- 2) desc role_sys_privs;    입력하기
-- 3) CONNECT 롤에는 어떤 권한(privilege)이 포함되어 있는가?
--    SELECT privilege FROM role_sys_privs WHERE role='CONNECT';   입력하기
-- 4) RESOURCE 롤에는 어떤 권한(privilege)이 포함되어 있는가?
--    SELECT privilege FROM role_sys_privs WHERE role='RESOURCE';  입력하기



------------------------------------------
-- DDL  -DATA DEFINITION LANGUAGE(정의 기능)
------------------------------------------
--> himedia 계정으로 실행 >>
-- 스키마 내의 모든 테이블을 확인
SELECT * FROM tabs; --tabs : table 정보 dictionary

---- 1번째 방법을 통한 테이블 생성
-- 테이블 생성 : CREATE TABLE --> BOOK 테이블 생성하기 --Table BOOK이(가) 생성되었습니다.
CREATE TABLE book (book_id NUMBER(5), 
                    title VARCHAR2(50), 
                    author VARCHAR2(10), 
                    pub_date DATE DEFAULT SYSDATE);
                    --> 아직 여기다 제약조건은 안넣음 나중에 할 예정..
-- 테이블 정보확인 
DESC book;


---- 2번째 방법을 통한 테이블 생성 : SUBQUERY를 이용한 테이블 생성
SELECT * FROM HR.employees;
--
-- hr.employees 테이블에서 job_id가 it 관련된 직원의 목록으로 새 테이블 생성을 원할경우,
SELECT * FROM HR.employees WHERE job_id LIKE 'IT_%';                          -->먼저 뽑아내기
CREATE TABLE emp_it AS 
            (SELECT * FROM HR.employees WHERE job_id LIKE 'IT_%'); --Table EMP_IT이(가) 생성되었습니다-
--
--> NOT NULL 제약조건만 물려받는다는것을 확인할 수 있음             
SELECT * FROM tabs;
DESC EMP_IT;


---- 테이블 삭제 
DROP TABLE emp_it; --Table EMP_IT이(가) 삭제되었습니다.
SELECT * FROM tabs; --> 삭제된것 확인 가능

DESC BOOK;

--==============================================================================
-- 0502
-- DDL 이어서 공부 시작 >>

----실습문제
-- himedia 계정으로 실행>>
-- 1)AUTHOR 테이블 생성하기 
CREATE TABLE author ( author_id NUMBER(10), --> 여기서 PRIMARY KEY로 잡아도 되지만 
                      author_name VARCHAR2(100) NOT NULL, -- not null은 컬럼 제약조건으로만 활용 가능
                      author_desc VARCHAR2(500),
                      PRIMARY KEY (author_id) --> 여기서 이렇게 PRIMARY KEY 로 명시해줘도 된다.
                      --> 복합키의 경우 이 방법으로 해야할수 밖에 없음
                      );  -->Table AUTHOR이(가) 생성되었습니다.
--                      
--author table 잘 생성되었는지 확인
DESC author; 
--
-- 2)book 테이블의 author 컬럼 삭제하기
-- 나중에 author_id 컬럼 추가 --> author. author_id 와 참조 연결할 예정
--
ALTER TABLE book DROP COLUMN author; -- Table BOOK이(가) 변경되었습니다.
-- author 컬럼 삭제된것 확인
DESC book; 
--
-- 3)book 테이블에 author_id 컬럼 추가
-- author.author_id 를 참조하는 컬럼이기에 author.author_id 컬럼과 같은 형태여야 한다.
ALTER TABLE book ADD (author_id NUMBER(10));  --Table BOOK이(가) 변경되었습니다.
-- author_id 컬럼 추가된것 확인
DESC book; 
--
--


---- PK-FK 연결작업 하기 
-- 두개의 테이블 내에서 author_id 컬럼 중복된것 확인  
DESC book; --여기에 author_id(FK) 해주기
DESC author;
--
-- book 테이블의 book_id도 author 테이블의 PK와 같은 데이터타입 (NUMBER(10))로 변경
ALTER TABLE book MODIFY (book_id NUMBER(10)); --Table BOOK이(가) 변경되었습니다.
DESC book; -->book_id가 (NUMBER(10))로 변경된것 확인
--
-- book 테이블의 book_id 컬럼에 primary key (PK)제약조건을 부여
ALTER TABLE book ADD CONSTRAINT pk_book_id PRIMARY KEY (book_id); --Table BOOK이(가) 변경되었습니다.//PK설정함
DESC book; 
--
-- book 테이블의 author_id 컬럼과 author 테이블의 author_id를 FK로 연결
ALTER TABLE book ADD CONSTRAINT fk_author_id FOREIGN KEY (author_id) 
                    REFERENCES author(author_id); --author 테이블의 author_id와 연결
                    --Table BOOK이(가) 변경되었습니다.









