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
--> 오류나는 이유 USERS 테이블 스페이스에 대한 권한이 없다
-- 19이상 

--> 다시 시스템 계정으로 변경후 실행
ALTER USER himedia DEFAULT TABLESPACE USERS
        QUOTA unlimited on USERS; 
        -- "User HIMEDIA이(가) 변경되었습니다." 로 출력됨
        -- QUOTA (용량)
        -- TABLESPACE 권한 부여함
        
--> 다시 himedia 계정으로 변경후 실행
INSERT INTO test VALUES (2024);  "--1 행 이(가) 삽입되었습니다."가 출력될것
SELECT * FROM test;















