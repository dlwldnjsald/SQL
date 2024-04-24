--SQL 문장의 주석
-- 마지막에 세미콜론(;)으로 끝난다
-- 키워드들은 대소문자 구분하지 않는다
-- 실제 데이터의 경우 대소문자를 구분


--테이블 구조 확인 (DESCRIBE) 
DESCRIBE employees; 
--describe EMPLOYEES; 
Describe Departments;
Describe Locations;


-- DML (Data Manipulation Language) 연습 
-- SELECT 연습
--* : 테이블 내의 모든 컬럼 projection, 테이블 설계시에 정의한 순서대로 출력될수 있다
SELECT * FROM employees;

-- 특정 컬럼만 projection 하고자 하면 열 목록을 명시해준다
--employees 테이블의 first_name, phone_number, hire_date, salary 만 뽑고 싶을경우,
SELECT first_name, phone_number, hire_date, salary From employees;

-- (practice) 사원의 이름, 성, 급여, 전화번호, 입사일 정보 출력 원할시
SELECT first_name, last_name, salary, phone_number, hire_date From employees;
-- (practice) 사원 정보로부터 사번, 이름, 성 정보 출력 원할시
SELECT employee_id, first_name, last_name From employees;


-- 산술연산: 기본적인 산술연산을 수행할 수 있다.
-- dual은 특정 테이블의 값이 아닌 시스템으로부터 데이터를 받아오고자 할때 쓸수있는 가상테이블
--아래 코드는 특정 테이블 소속의 데이터가 아닌 단순 연산 데이터 불러오기위한 산술식을 작성한것
SELECT 3.14159 * 10 * 10 FROM dual; 
--특정 컬럼의 값(ex. salary*12 부분)을 산술 연산에 포함시키고자 할 경우,
SELECT first_name, salary, salary*12 FROM employees;

--아래에서 오류가 나는 원인: job_id는 문자열 데이터(VARCHAR2)이기 때문에 산술연산 불가함
SELECT first_name, job_ id, job_id * 12 FROM employees;
DESC employees;

--0424강의문
--NULL 
--이름,급여, 커미션 비율을 출력
SELECT first_name, salary, commission_pct FROM employees;

--이름, 커미션 까지 포함한 급여를 출력할 경우 
--널이 포함된 연산식의 결과는 null이다
--null을 처리하기 위한 함수 NVL이 필요
SELECT first_name, salary, commission_pct, salary + salary * commission_pct FROM employees;
--NVL(표현식1, 표현식1일이 널일 경우의 대체값)으로 표현해준다
SELECT first_name, salary, commission_pct, salary+salary * NVL(commission_pct,0) FROM employees;

--NULL은 0이나 "" 와 다르게 빈 값이다.
--NULL은 산술연산 결과, 통계 결과를 왜곡,-> NULL에 대한 처리는 철저하게!