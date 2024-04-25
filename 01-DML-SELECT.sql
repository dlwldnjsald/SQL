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



-- ORDER BY 
-- 특정 컬럼명, 연산식, 별칭, 혹은 컬럼 순서를 기준으로 레코드 정렬
-- ASC (오름차순:DEFAULT), DESC(내림차순)
-- 여러개의 컬럼에 적용할 수 있고 ,로 구분한다
-- 정렬기준을 어떻게 세우느냐에 따라 성능, 출력결과에 영향을 미칠 수 있다

-- 부서 번호의 오름차순으로 정렬, 부서번호와 급여, 이름을 출력
SELECT department_id, salary, first_name
FROM employees
ORDER BY department_id; 
--asc 디폴트값이라 생략가능

-- 급여가 10000 이상인 직원 대상, 급여의 내림차순으로 출력, 이름, 급여
SELECT first_name, salary
FROM employees
WHERE salary >= 10000
ORDER BY salary DESC;

-- 부서 번호, 급여, 이름순으로 출력하고 정렬기준은 부서번호 오름차순, 급여 내림차순
SELECT department_id "부서 번호", salary 급여, first_name 이름
FROM employees
ORDER BY department_id ,salary DESC;

----------------------------------------
--practice 01.
----------------------------------------
-- 1.문제
-- 정렬-> 입사일의 올림차순으로 가장 선임부터 출력이 되도록 
-- 이름, 월급, 전번, 입사일 순서로 출력하고 
-- 이름, 월급, 전화번호, 입사일로 컬럼이름 대체
SELECT first_name 이름, salary 월급, phone_number 전화번호, hire_date 입사일
FROM employees
ORDER BY hire_date;

-- 2. 문제
-- 업무(jobs)별로 업무이름(job_title)과 최고월급(max_salary)을 월급의 내림차순(DESC)로 정렬
SELECT job_id job_title, salary max_salary
FROM employees
ORDER BY job_id,salary DESC;

-- 3. 문제
-- 담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 
-- 직원의 이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
SELECT first_name, manager_id, commission_pct, salary
FROM employees
WHERE manager_id IS NOT NULL 
AND commission_pct is NULL 
AND salary > 3000;

-- 4. 문제 
-- 최고월급(max_salary)이 10000 이상인 업무의 이름(job_title)과 
-- 최고월급(max_salary)을 최고월급의(max_salary) 내림차순(DESC)로 정렬하여 출력하세요.
SELECT job_id "job_title", salary "max_salary"
FROM employees
WHERE salary > 10000
ORDER BY salary DESC;

-- 5. 문제
-- 월급이 14000 미만 10000 이상인 직원의 이름(first_name), 월급, 커미션퍼센트 를 
-- 월급순(내림차순) 출력하세오. 단 커미션퍼센트 가 null 이면 0 으로 나타내시오 nvl(commission_pct,0)
SELECT first_name, salary , nvl(commission_pct,0)
FROM employees
where salary <14000 OR salary>=10000 
ORDER BY salary DESC;




--------------------------------------

-- 0425 강의문------------------------------------------------------------------
-- 단일행 함수 SINGLE-ROW FUNCTION 
-- 단일 레코드를 기준으로 특정 컬럼에 값에 적용되는 함수


-- 문자열 단일행 함수의 여러가지 방법
SELECT first_name, last_name,
    CONCAT(first_name, CONCAT(' ', last_name)),     -- CONCAT 문자열연결함수
    first_name || ' ' || last_name,                 -- || 문자열 연결 연산자
    INITCAP(first_name || ' ' || last_name)         -- 각 단어의 첫글자 대문자
FROM employees;

SELECT first_name, last_name,
    LOWER(first_name),          --모두 소문자
    UPPER(first_name),          --모두 대문자
    LPAD(first_name, 20, '*'),  -- 왼쪽 빈자리 채움
    RPAD(first_name, 20, '*')   -- 오른쪽 빈자리 채움
FROM employees;
    
SELECT '    Oracle    ',
        '*****Database*****',
        LTRIM('    Oracle    '), -- 왼쪽의 빈공간 삭제
        RTRIM('    Oracle    '), -- 오른쪽의 빈공간 삭제
        TRIM('*' FROM '*****Database*****'),    -- 앞뒤의 잡음 문자 제거
        SUBSTR('Oracle Database', 8, 4),         -- 부분 문자열
        SUBSTR('Oracle Database', -8, 4),        -- 역인덱스 이용 부분 문자열
        LENGTH('Oracle Database')                -- 문자열 길이
FROM dual;


-- 수치형 단일행 함수
SELECT 3.14159,
    ABS(-3.14),         -- 절대값 함수
    CEIL(3.14),         -- 올림 함수
    FLOOR(3.14),        -- 버림 함수   
    ROUND(3.5),         -- 반올림 함수    
    ROUND(3.14159,3),   -- 반올림 함수,소수점3째 자리까지 반올림 (실제 4째자리에서 반올림)
    TRUNC(3.5),         -- 버림 함수
    TRUNC(3.14159, 3),  -- 버림 함수, 소수점4째 자리에서 버림
    SIGN(-3.14159),     -- 부호 함수(-1: 음수, 0:0, 1:양수)
    MOD(7,3),          -- 7을 3으로 나눈 나머지
    POWER(2,4)         -- 2의 4제곱
FROM dual;


---------------------------
--DATE FORMAT
---------------------------
-- 현재 세션 정보 확인
SELECT * FROM nls_session_parameters;

-- 현재 날짜 포맷이 어떻게 되는가 확인작업 하기 
-- system으로 위에 바꾸고 딕셔너리를 확인하기
-- SESSION->현재 접속된 사용자의 환경 정보를 뜻함
SELECT value FROM nls_session_parameters    --환경변수를 담고있는 세션 환경에 관련된 값들 중에서
WHERE parameter = 'NLS_DATE_FORMAT';        --파라미터명이 '' 이것인 값을 확인해본것 
-- DATE FORMAT확인시-> RR TYPE으로 되있는것알수있음

---------------------------
-- 현재 날짜 : SYSDATE
SELECT sysdate 
FROM dual;           -- 가상 테이블 dual로부터 받아오므로 1개의 레코드 존재

SELECT sysdate 
FROM employees;      -- employees테이블로부터 받아오므로 employees 테이블 레코드의 갯수만큼 출력

-- 날짜 관련 단일행 함수
SELECT sysdate,
    ADD_MONTHS(sysdate, 2),                 -- 2개월 지난후의 날짜
    LAST_DAY(sysdate),                      -- 현재 달의 마지막 날짜
    MONTHS_BETWEEN('12/09/24', sysdate),    -- 두 날짜 사이에 개월 차
    NEXT_DAY(sysdate,'금'),                  -- 현시점 이후 금요일의 요일 출력
    NEXT_DAY(sysdate,6),                    -- 1:SUN-7:SAT/현재시점이후 해당요일의 날짜 출력
    ROUND(sysdate, 'MONTH'),                -- MONTH를 기준으로 반올림
    TRUNC(sysdate, 'MONTH')                 -- MONTH를 기준으로 버림
FROM dual;

SELECT first_name, hire_date, 
    ROUND(MONTHS_BETWEEN(sysdate, hire_date)) as 근속월수
FROM employees;


-- 변환 함수
-- 1,TO NUMBER(s, fmt) : 문자열 -> 숫자
-- 2,TO_DATE(s, fmt) : 문자열 -> 날짜
-- 3,TO_CHAR(0, fmt) : 숫자, 날짜 -> 문자열

--------------------------------
-- TO_CHAR : 숫자, 날짜 -> 문자열
-- 입사일을 yy-mm-dd형식으로 출력
SELECT first_name, 
        TO_CHAR(hire_date, 'YYYY-MM-DD') -- yy-mm-dd
FROM employees;

-- 현재 시간을 년-월-일 시:분:초로 출력
SELECT SYSDATE,
        TO_CHAR(sysdate, 'YYYY-MM-DD HH:MI:SS')
FROM DUAL;

-- 숫자를 화폐단위로 출력
SELECT  
        TO_CHAR(3000000, 'L999,999,999.99') -- L은 화폐단위 콤마표시로 구분 .00(달러표시의 .)
FROM DUAL;

-- 모든 직원의 이름, 월급, 연봉 정보(숫자->문자열 달러표시해서) 출력해보기
SELECT first_name, salary, commission_pct,
        TO_CHAR((salary + salary * nvl(commission_pct,0))*12, '$999,999.99') 연봉    
        --nvl(commission_pct,0):cpct가 널이면 0으로 해준단뜻
        --TO_CHAR 함수를 사용해서 숫자->문자열 달러표시로 변환해주는 함수 사용됨
FROM employees;

-----------------------------------
-- TO NUMBER(s, fmt) : 문자열 -> 숫자
SELECT '$57,600',
    TO_NUMBER('$57,600', '$999,999') "TO_NUMBER",
    TO_NUMBER('$57,600', '$999,999') / 12 월급
FROM DUAL;

-- TO NUMBER(s, fmt) :문자열 -> 날짜
SELECT '2012-09-24 13:48:00',
    TO_DATE('2012-09-24 13:48:00', 'YYYY-MM-DD HH24:MI:SS') TO_DATE
FROM DUAL;
