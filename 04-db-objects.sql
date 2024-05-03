
--0503 강의문 
--------------------------
-- DB OBJECTS
--------------------------


-- SYSTEM 계정으로 진행 >>
-- VIEW생성 위한 SYSTEM 권한
GRANT create view TO himedia; --Grant을(를) 성공했습니다.

GRANT select ON HR.employees TO himedia; --Grant을(를) 성공했습니다. 
-- hr의 employees테이블의 select권한을 하이미디어에 줘겟다
GRANT select ON HR.departments TO himedia; --Grant을(를) 성공했습니다.




-- himedia 계정으로 다시 진행>>
---- simple view 
-- 단일 테이블 혹은 단일 뷰를 베이스로한 함수, 연산식을 포함하지 않은 뷰

-- emp123테이블 만들어둔것에 뷰를 만들어보고 
-- dml을 이용해 데이터를 변경하는 작업 연습해보기
-- emp123 table 만든것 확인
DESC emp123;
-- 10,20,30 번 부서들 중 10번부서만 볼수있는 뷰를 만들어보기 (subquery이용하기)
CREATE or REPLACE VIEW emp10 AS SELECT employee_id, first_name, last_name, salary 
                                    FROM emp123 WHERE department_id = 10;
                                    --"View EMP10이(가) 생성되었습니다."
--                                    
-- 실제 테이블이 생성된것은 아니지만                                
SELECT * FROM tabs;
--
-- 일반 테이블처럼 활용할 수 있음
DESC emp10;
--
SELECT * FROM emp10;
SELECT first_name || ' ' || last_name, salary FROM emp10;
--
-- simple view는 제약 사항에 걸리지 않는다면 insert, delete, update 가능
UPDATE emp10 SET salary = salary * 2; -- "1 행 이(가) 업데이트되었습니다."
SELECT * FROM emp10;
--반영취소
ROLLBACK;           --"롤백 완료. 
SELECT * FROM emp10;       
--
-- 가급적 VIEW는 조회용으로만 활용하자
-- WITH READ ONLY : 읽기 전용 뷰
CREATE OR REPLACE VIEW emp10 AS SELECT employee_id, first_name, last_name, salary
                                FROM emp123 WHERE department_id = 10
                                WITH READ ONLY; --"View EMP10이(가) 생성되었습니다."
-- 읽기 전용 뷰에서는 DML작업 수행 불가                                
UPDATE emp10 SET salary = salary* 2;  --"읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다."라고 뜸   




---- COMPLEX VIEW
-- 한개 혹은 여러개의 테이블 혹은 뷰에 JOIN, 함수, 연산식 등을 활용한 VIEW
-- 특별한 경우가 아니면 INSERT, UPDATE, DELETE 작업 수행 불가
CREATE OR REPLACE VIEW emp_detail 
                    (employee_id, employee_name, manager_name, department_name)
                    AS SELECT 
                            emp.employee_id, 
                            emp.first_name ||' '|| emp.last_name,
                            man.first_name ||' '|| man.last_name,
                            department_name 
                       FROM HR.employees emp 
                            JOIN HR.employees man ON emp.manager_id = man.employee_id
                             JOIN HR.departments dept ON emp.department_id = dept.department_id;
                             --"View EMP_DETAIL이(가) 생성되었습니다."
-- view 확인
 DESC emp_detail;                            
-- 세부 데이터들 확인
SELECT * FROM emp_detail;

-- VIEW를 위한 딕셔너리 :VIEWS
SELECT * FROM USER_VIEWS;
--
-- USER_OBJECTS 중에 STATUS 현재 사용 가능한가 VALID인지 보기
-- VIEW를 포함한 모든 DB 객체들의 정보 확인 가능
SELECT * FROM USER_OBJECTS;
--
-- VIEW 삭제 : DROP VIEW
-- view를 삭제해도 기반 테이블 데이터는 삭제되지 않음 
DROP VIEW emp_detail; --"View EMP_DETAIL이(가) 삭제되었습니다.
SELECT * FROM EMP_DETAIL; --"테이블 또는 뷰가 존재하지 않습니다





























