--------------------------
-- DCL and DDL
--------------------------

-- 사용자 생성
-- CREATE USER 권한이 있어야 함
-- SYSTEM 계정으로 수행해야 함

-- himedia 라는 이름의 계정을 만들고 비밀번호 himedia로 설정 
CREATE USER himedia IDENTIFIED BY himedia;         
-- orale 18 version 부터 container database 개념이 도입됨
-- 한대의 데이터 베이스에 다 몰아넣으면 무리가 생겨서 
-- 사용자 스키마 자체를 분산 데이터로 분산저장하기 시작

-- 계정 생성 방법1, 
-- 사용자 계정 C## 붙여서 생성  : CREATE USER
CREATE USER C##HIMEDIA IDENTIFIED BY himedia;
-- 비밀번호 변경 : ALTER USER
ALTER USER C##HIMEDIA IDENTIFIED BY new_password;
-- 계정 삭제 : DROP USER
DROP USER C##HIMEDIA CASCADE;           
--CASCADE : 폭포수 혹은 연결된 것이라는 의미-- 이 USER와 연결된 모든 것들을 삭제하겠다는 의미 

-- 계정 생성 방법 2. CD 기능 무력화
-- 연습상태이기에 방법 2를 사용해서 사용자를 생성해볼예정
-- 하지만 이것은 추천하지 않음 ..
ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER himedia IDENTIFIED BY himedia;



-- 아직 접속 불가
-- 데이터 베이스 접속, 테이블 생성 데이터베이스 객체 작업을 수행
--> CONNECT, RESOURCE ROLE(역할) 부여
GRANT CONNECT, RESOURCE TO HIMEDIA;
-- CMD ; SQLPLUS HIMEDIA/HIMEDIA
-- CREATE TABLE test(a NUMBER); TEST란 테이블을 만들건데 A라는 컬럼안의 NUMBER타입의 데이터를 집어넣을것 명령
-- DESC TEST; -- 테이블 test의 구조 보기

-->himedia 스키마로 사용자로 진행해야 함 
--> himedia 생성해주고 system-> himedia로 변경해주기 스키마
-- 데이터 추가 
DESCRIBE test;
INSERT INTO test VALUES (2024);   --테스트란 테이블 안쪽에다가 정의된 값 2024를 집어넣어라--> 여기서 실행 안됨 
--> 오류나는 이유 USERS 테이블 스페이스에 대한 권한이 없다 --권한이 불충분합니다
-- 19이상 

--> 다시 시스템 계정으로 변경후 실행
ALTER USER himedia DEFAULT TABLESPACE USERS
        QUOTA unlimited on USERS; 
        -- "User HIMEDIA이(가) 변경되었습니다." 로 출력됨
        -- QUOTA (용량)
        -- TABLESPACE 권한 부여함
        
--> 다시 himedia 계정으로 변경후 실행
INSERT INTO test VALUES (2024);  --1 행 이(가) 삽입되었습니다." 가 출력될것
SELECT * FROM test;


SELECT * FROM USER_USERS; -- 현재 로그인한 사용자 정보(나)
SELECT * FROM ALL_USERS;  -- 모든 사용자 정보
-- DBA 전용 (sysdba로 로그인해야 확인 가능 실제 계정은 아닌데 역할이라고 보면 됨)
--cmd : sqlplus system/manager --> ㄴsysdba로 접속 가능
SELECT * FROM DBA_USERS;



---- 만일 시나리오: HR스키마의 EMPLOYEES 테이블 조회 권환을 HIMEDIA에게 부여하고자 한다면
-- HR 스키마의 오너(주인)은 HR -> HR로 접속후 수행해보기 
GRANT SELECT ON employees TO himedia; --Grant을(를) 성공했습니다.로 출력됨

--> 다시 himedia 계정으로 변경후  실행 // (스키마->사용자)
SELECT * FROM HR.employees; 
-- HR 스키마 안쪽의 EMPLOYEES TABLE의 셀렉트 권한을 HIMEDIA 에게 부여한 값
SELECT * FROM HR.DEPARTMENTS; --테이블 또는 뷰가 존재하지 않습니다 로 뜨게됨
-- HR.EMPLOYEES 에 SELECT 할수있는 권한만 부여받은것이기 때문 



--------------------------
-- DDL
--------------------------
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

-- hr.employees 테이블에서 job_id가 it 관련된 직원의 목록으로 새 테이블 생성을 원할경우,
SELECT * FROM HR.employees WHERE job_id LIKE 'IT_%';                          -->먼저 뽑아내기
CREATE TABLE emp_it AS 
            (SELECT * FROM HR.employees WHERE job_id LIKE 'IT_%'); --Table EMP_IT이(가) 생성되었습니다-

--> NOT NULL 제약조건만 물려받는다는것을 확인할 수 있음             
SELECT * FROM tabs;
DESC EMP_IT;


---- 테이블 삭제 
DROP TABLE emp_it; --Table EMP_IT이(가) 삭제되었습니다.
SELECT * FROM tabs; --> 삭제된것 확인 가능


DESC BOOK;



