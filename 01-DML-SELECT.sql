--0423 강의문
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


-- 0424강의문-------------------------------------------------------------------
-- NULL 
-- 이름,급여, 커미션 비율을 출력
SELECT first_name, salary, commission_pct FROM employees;

-- 이름, 커미션 까지 포함한 급여를 출력할 경우 
-- 널이 포함된 연산식의 결과는 null이다
SELECT first_name, salary, commission_pct, salary + salary * commission_pct FROM employees;
-- null을 처리하기 위한 함수 NVL이 필요
-- NVL(표현식1, 표현식1일이 널일 경우의 대체값)으로 표현해준다
SELECT first_name, salary, commission_pct, salary+salary * NVL(commission_pct,0) FROM employees;

-- NULL은 0이나 "" 와 다르게 빈 값이다.
-- NULL은 산술연산 결과, 통계 결과를 왜곡,-> NULL에 대한 처리는 철저하게!


-- 별칭 Alias
-- projection 단계에서 출력용으로 표시되는 임시 컬럼 제목

-- 컬럼명 뒤에 별칭
-- 컬럼명 뒤에 as 별칭
-- 표시명에 특수문자나 공백이 포함된 경우 "" 쌍따옴표로 묶어서 부여

-- 1.employees에 있는 컬럼값 확인
-- 2.직원 아이디, 이름, 급여 출력
-- 3.직원 아이디는 empNo, 이름은 f-name, 급여는 월 급으로 표시
desc employees;
SELECT employee_id, first_name, salary FROM employees;
SELECT employee_id empNo, first_name as "f-name", salary "월 급" FROM employees;

-- 4. 직원이름(first_name last_name을 합쳐서) name으로 출력,
-- 급여 (커미션이 포함된 급여), 급여*12 연봉 별칭으로 표기할 경우
SELECT first_name + last_name, salary + salary* nvl(commission_pct,0),salary*12 FROM employees;
SELECT first_name || ' ' || last_name, salary + salary* nvl(commission_pct,0),salary*12 FROM employees;
SELECT 
    first_name || ' ' || last_name "Full Name",       --문자열 합치기는 || 사용
    salary + salary* nvl(commission_pct,0)"급여(커미션포함)",
    salary*12 연봉 
FROM employees;

--PROJECTION기능 위해 사용된 SELECT문
-- 연습 : Alias 붙이기( employees 테이블)
-- 이름: first_name last_name
-- 입사일: hire_date
-- 전화번호: phone_number
-- 급여: salary
-- 연봉: salary* 12

SELECT 
    first_name|| ' ' || last_name 이름, 
    hire_date 입사일, 
    phone_number as 전화번호, 
    salary 급여, 
    salary*12 연봉 
FROM employees;


-- SELECTION기능을 위한 WHERE문 사용
-- 특정 조건을 기준으로 레코드를 선택한다(SELECTION)
-- salary>10000조건을 포함한 출력방법 
-- 키워드들의 순서가 중요하다
SELECT * FROM employees;             -- 출력 ALL, FROM employees
SELECT first_name 이름, salary 월급   -- first_name, salary만 셀렉트
FROM employees                       -- employees 테이블 내에서 출력
WHERE salary>10000;                  -- 조건문 where이하 사용

-- 비교 연산: =, <>, >, >=, <, <= 연습하기
-- 사원들 중, 급여가 15000 이상인 직원의 이름과 급여 출력
SELECT first_name, salary 
FROM employees
WHERE salary>15000;

-- 입사일이 17/01/01 이후인 직원들의 이름과 입사일 출력
SELECT first_name, hire_date 
FROM employees
WHERE hire_date >= '17/01/01';

-- 급여가 4000 이하이거나 17000 이상인 사원의 이름과 급여 출력
SELECT first_name, salary 
FROM employees
WHERE salary <= 4000 OR salary >=17000;    --OR 논리합 둘중 하나가 참이면 참이다

-- 급여가 14000 이상이고 ,17000 미만인 사원의 이름과 급여 출력
SELECT first_name, salary 
FROM employees
WHERE salary >= 14000 AND salary < 17000;   --AND 논리곱 연산자 사용

-- 급여가 14000 이상이고 ,17000 이하인 사원의 이름과 급여 출력
-- BETWEEEN 연산자: 범위 비교할 경우//--이상 --이하 
SELECT first_name, salary 
FROM employees
WHERE salary BETWEEN 14000 AND 17000;    
 
 
-- NULL 체크 =, <> 사용하면 안됨
--IS NULL, IS NOT NULL 

-- commission을 받지 않는 사람들 데이터가 비어있는(null)인 사람들 출력
SELECT first_name,commission_pct
FROM employees
WHERE commission_pct IS NULL;  --NULL CHECK

-- commission을 받는 사람들 데이터가 (null)이 아닌 사람들 출력
SELECT first_name,commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;  -- NOTNULL CHECK
 
 
-- IN연산자: 특정 집합의 요소와 비교
-- 사원들 중 10,20,40 번 부서에서 근무하는 직원들의 이름과 부서아이디
-- 위의 3개의 조건 중 하나만 만족하면 되는것으로 출력이 될것임 10이거나 20이거나 40이거나 ..
SELECT first_name,department_id
FROM employees
--WHERE department_id =10 OR department_id =20 OR department_id =40; 이렇게 대신 아래처럼도 가능
WHERE department_id IN(10,20,40);


-- LIKE연산
-- 와일드카드(%, _)를 이용한 부분 문자열 매핑
-- % : 0개 이상의 정해지지 않은 문자열
-- _ : 1개의 정해지지 않은 문자열

-- 이름에 am을 포함하고 있는 사원의 이름과 급여 출력
SELECT first_name,salary
FROM employees
WHERE LOWER(first_name) LIKE '%am%';    --소문자로 다 변경후 am 앞뒤로 뭐가 오든 상관없이 출력

-- 이름의 두번째 글자가 a인 사원의 이름과 급여 출력
SELECT first_name,salary
FROM employees
WHERE LOWER(first_name)
LIKE '_a%';                --두번째 글자를 _언더바 사용해서 입력세팅후 그뒤로 뭐가 오든 상관없이 출력

-- 이름의 4번째 글자가 a인 사원의 이름과 급여 
SELECT first_name,salary
FROM employees
WHERE LOWER(first_name)
LIKE '___a%';    

-- 이름이 네글자인 사원들 중에서 두번째 글자가 a인 사원의 이름과 급여
SELECT first_name,salary
FROM employees 
WHERE first_name LIKE '_a__';

-- 부서 id가 90인 사원 중, 급여가 20000이상인 사원 출력
SELECT first_name , department_id , salary
FROM employees
WHERE department_id = 90 AND salary >= 20000; --2개의 조건을 동시 만족하기위해 AND

-- 입사일이 11/01/01 ~ 17/12/31 구간에 있는 사원의 목록
--1. 비교조합
SELECT first_name, hire_date
FROM employees
WHERE hire_date >='11/01/01' AND hire_date <='17/12/31';
--2. BETWEEN 연산자 이용
SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '11/01/01' AND '17/12/31';

-- manager_id  가 100,120,147인 사원의 명단
--1. 비교연산자+논리연산자의 조합
SELECT first_name, manager_id
FROM employees
WHERE manager_id = 100 OR manager_id = 120 OR manager_id = 147;
--2. In 연산자 이용
SELECT first_name, manager_id
FROM employees
WHERE manager_id IN(100,120,147);
-- 두 쿼리 비교하자