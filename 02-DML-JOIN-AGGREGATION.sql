-----------------------
--JOIN
-----------------------
DESC EMPLOYEES;
DESC DEPARTMENTS;

SELECT * 
FROM employees; --107 개의 행
SELECT *    
FROM departments; -- 27 개의 행

SELECT * 
FROM employees,departments;
--카티젼 프로덕트

SELECT * 
FROM employees,departments
WHERE employees.department_id = departments.department_id; --106
-- INNER JOIN, EQUE-JOIN


-- alias를 이용한 원하는 필드의 projection
------------------------
-- Simple Join or Equi-Join
------------------------
/*
SELECT first_name, 
        department_id,--> 중복이 있어서 열의 정의가 애매하다고 뜸 
        department_name
FROM employees,departments
WHERE employees.department_id = departments.department_id;
*/

/*
SELECT first_name, 
        employees.department_id,
        departments.department_id,
        department_name
FROM employees,departments
WHERE employees.department_id = departments.department_id; 
-->code가 길어져서 별칭달예정
*/

SELECT first_name, 
        emp.department_id,
        dept.department_id,
        department_name
FROM employees emp , departments dept
WHERE emp.department_id = dept.department_id; 
--106명, department_id가 null인 직원은 join에서 배제됨

-- 이때 널값 확인해보기 ------------------------
SELECT * 
FROM EMPLOYEES
WHERE department_id IS NULL; -- 레코드1개 출력되는것을 확인할수 있음( 178 KIMBERLY)
---------------------------------------------

SELECT emp.first_name, 
        dept.department_name    
FROM employees emp JOIN departments dept USING (department_id)
ORDER BY FIRST_NAME;
--KIMBERLY 출력 안된것 확인 가능

------------------------
-- Theta Join
------------------------
-- join 조건이 = 아닌 다른 조건들

-- 급여가 직군 평균 급여보다 낮은 직원들 목록
-- jobs 테이블의 평균급여 = (min_salary + max_salary) /2  와 employees table을 join 예정
select * from jobs;
select * from employees order by last_name;
SELECT 
    emp.employee_id,
    emp.first_name,
    emp.salary,
    emp.job_id 직원T,
    j.job_id 직업T,
    j.job_title
FROM 
    employees emp JOIN jobs j 
        ON emp.job_id = j.job_id -->여기서 ON절은 JOIN절의 WHERE절과 같다고보면됨 )
WHERE emp.salary < = (j.min_salary + j.max_salary) / 2;


-------------------------------------------
-- Outer Join
-------------------------------------------
-- 조건을 만족하는 짝이 없는 튜플도 NULL을 포함해서 결과 출력을 참여시키는 방법
-- 모든 결과를 표현한 테이블이 어느쪽에 위치하는가에 따라 LEFT, RIGHT, FULL OUTER로 구분됨
-- 오라클SQL의 경우 NULL이 출력되는 쪽에 (+)를 붙여 표시해준다.

------------------------
--(LEFT OUTER JOIN)
------------------------
---- ORACLE SQL 
-- NULL할 (포함된)테이블쪽에 (+)사인을 표기
-- DEPT의 널값이 포함되어 왼쪽 테이블 EMP가 출력됨
--> 왼쪽 EMP TABLE 레코드 전부를 출력에 참여하려는 목적
SELECT emp.first_name,
        emp.department_id 직원,
         dept.department_id 부서,
          department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id (+); 

---- ANSI SQL (LEFT OUTER JOIN) 
--명시적으로 JOIN방법을 정한다
--자동으로 DEPT의 널값이 포함되어 왼쪽 테이블 EMP가 출력됨
SELECT first_name,
    
    emp.department_id 직원,
    dept.department_id 부서,
    department_name
FROM employees emp LEFT OUTER JOIN departments dept  
    ON emp.department_id = dept.department_id;


--(널값 확인작업)
SELECT * FROM employees WHERE DEPARTMENT_ID IS NULL; 
--위 결과를 통해 결국 KIMBERLY 사원은 부서에 소속되지 않음을 알수 있음 

-------------------------
--RIGHT OUTER JOIN) 
-------------------------
---- ORACLE SQL 
-- EMP의 널값이 포함되어 오른쪽 테이블 DEPT가 출력됨
--(+)사인은 널이 출력될수 있는 곳 위치에 입력해주면 됨 
--> 오른쪽 DEPT TABLE 레코드 전부를 출력에 참여하려는 목적
SELECT first_name,
        emp.department_id 직원,
        dept.department_id 부서,
        department_name
FROM employees emp, departments dept
WHERE emp.department_id (+) = dept.department_id; 

---- ANSI SQL (RIGHT OUTER JOIN) 
--명시적으로 JOIN방법을 정한다
--자동으로 DEPT의 널값이 포함되어 왼쪽 테이블 EMP가 출력됨
SELECT first_name,
        emp.department_id 직원,
        dept.department_id 부서,
        department_name
FROM employees emp RIGHT OUTER JOIN departments dept  
    ON emp.department_id = dept.department_id;


--------------------------
-- FULL OUTER JOIN
--------------------------

-- JOIN에 참여한 모든 테이블의 모든 레코드를 출력에 참여시킴
-- 짝이 없는 레코드들은 NULL 포함해서 출력에 참여시킴 (LEFT AND RIGHT 의 모든 널값 출력됨 확인가능)

---- ANSI SQL (RIGHT OUTER JOIN)
SELECT first_name,
        emp.department_id 직원,
        dept.department_id 부서,
        department_name
FROM employees emp FULL OUTER JOIN departments dept  
    ON emp.department_id = dept.department_id;
    

--------------------------
-- NATURAL JOIN VS. JOIN?
--------------------------
-- JOIN할 TABLE에 중복된 이름의 컬럼이 있을 경우 해당 컬럼을 기준으로 JOIN
SELECT * FROM employees emp NATURAL JOIN departments dept; --32개 컬럼 확인가능
-- 어떤 컬럼이 일치하는지에 대한 데이터를 명확하게 확인해야 함 아래의 작업 참고..
-- 즉 실제 본인이 JOIN할 조건과 일치하는지를 확인해야

SELECT * FROM employees emp JOIN departments dept  
ON emp.department_id = dept.department_id; --106(A)

SELECT * FROM employees emp JOIN departments dept 
ON emp.manager_id = dept.manager_id; --44(B)

SELECT * FROM employees emp JOIN departments dept 
ON emp.manager_id = dept.manager_id AND emp.department_id = dept.department_id; --32
-- NATURAL 쓰면 우리가 명시하지 않은데도 앞전의 (A)AND(B)로 출력됨을 알수 있음


--------------------------
-- SELF JOIN
--------------------------
-- 자기 자신과 JOIN
-- 자신을 두번 호출하기때문-> 별칭ALIAS 반드시 부여해야할 필요 있는 JOIN

-- 담당 매니저가 있는지 확인해보고자 한다면
SELECT * FROM EMPLOYEES; --107개의 행
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IS NULL; 
--> 간단히 NULL값 1명 확인 가능 

--> 하지만 NULL값이 여러명인 경우? 또는 더 확실한 코드로
SELECT emp.employee_id 직원아이디, emp.first_name 직원명, 
        emp.manager_id 담당매니저아이디, man.first_name 담당매니저명
-------        
--FROM employees emp JOIN employees man   --EMPLOYEES의 중복 테이블 MAN별칭붙여 생성
--ON emp.manager_id = man.employee_id;    
------아래처럼도 가능
FROM employees emp, employees man        
WHERE emp.manager_id = man.employee_id; --106개 행이 출력된것 확인할 수 있음



--=========================================================================
--------------------------
-- Group Aggregation
--------------------------
-- 집계: 여러 행으로부터 데이터를 수집, 하나의 행으로 반환

---- COUNT: 갯수 세기 함수
-- employees 테이블의 총 레코드 갯수?
SELECT COUNT(*) FROM employees; -- 107
-- *로 카운트하면 모든 행의 수를 반환
-- 특정 컬럼 내에 null값이 포함되어있는지의 여부는 중요하지 않음

SELECT COUNT(commission_pct) FROM employees;
-- commission_pct 가 null인 경우를 제외하고 싶을 경우
-- commission_pct을 받는 직원의 수를 알고 싶을 경우
-- 컬럼 내에 포함된 널 데이터를 카운트하지 않음
-- 위 커리는 아래 커리와 같음
SELECT COUNT(*) FROM employees
WHERE commission_pct IS NOT NULL;



---- SUM: 합계 함수
-- 모든 사원의 급여의 함계?
SELECT SUM(salary) FROM employees;



---- AVG: 평균 함수
-- 사원들의 평균 급여?
SELECT AVG(salary) FROM employees;

-- 사원들이 받는 커미션 비율의 평균은 얼마인가?
SELECT AVG(commission_pct) FROM employees; --22%

SELECT AVG(NVL(commission_pct,0))FROM employees;
-- null 값을 집계 결과에 포함시킬지의 여부는 정책으로 결정하고 수행해야 한다
-- AVG 함수는 NULL값이 포함되어있을 경우 그 값을 집계 수치에서 제외한다



---- MIN/MAX : 최솟값/최댓값 함수
---- AVG/ MEDIAN : 산술평균/중앙값 함수
SELECT MIN(salary) 최소급여,
        MAX(salary) 최대급여,
        AVG(salary) 평균급여,
        MEDIAN(salary) 급여중앙값
FROM employees;



-- 흔히 범하는 오류
-- 부서별로 평균 급여 구하고자 할 때
--> 아래코드와 같이 사용할수 없음
SELECT department_id, AVG(salary) FROM employees;
SELECT department_id FROM employees; --> 여러개의 레코드값 존재
SELECT AVG(salary) FROM employees;   --> 단일 레코드값존재하기 때문
---- GROUP BY 사용하는 방법
SELECT department_id 부서아이디, ROUND(AVG(salary),2)평균급여 FROM employees
GROUP BY department_id -- 집계를 위해 특정 컬럼을 기준으로 그룹핑
ORDER BY department_id;
-- 부서별 평균 급여에 부서명도 포함하여 출력하기
-- group by 절 이후에는 group by에 참여한 컬럼과 집계함수만 남는다
SELECT EMP.department_id 부서아이디, 
department_name 부서명, 
ROUND(AVG(salary),2) 평균급여
FROM employees EMP JOIN departments DEPT 
ON EMP.department_id = DEPT.department_id
GROUP BY EMP.department_id, DEPT.department_name
ORDER BY EMP.department_id;



-- 평균 급여가 7000 이상인 부서만 출력
SELECT department_id, AVG(salary)
FROM employees
WHERE AVG(salary)> 7000 --> 아직 집계함수 시행되지 않은 상태라 집계함수의 비교 불가
GROUP BY department_id
ORDER BY department_id;
---- 집계 함수 이후의 조건 비교 Having 절 이용
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
    HAVING AVG(salary)> 7000 --> GROUP BY AGGREGATION의 조건 필터링 
ORDER BY department_id;



---- ROLL UP
-- GROUP BY 절과 함께 사용
-- 그룹 지어진 결과에 대한 좀 더 상세한 요약을 제공하는 기능 수행
-- 일종의 ITEM TOTAL
SELECT department_id 부서, job_id, SUM(salary) FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY 부서;



---- CUBE
-- CROSSTAB에 대한 SUMMARY를 함께 추출하는 함수
-- ROLLUP 함수에 의해 출력되는 ITEM TOTAL 값과 함께
-- COLUMN TOTAL 값을 함께 출력
SELECT department_id 부서, job_id, SUM(salary) FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY 부서;


-----------------------------------
---- SUBQUERY (SINGLE -ROW SUBQUERY)
-----------------------------------
-- 모든 직원의 급여의 중앙값보다 많은 급여를 받는 사원?
-- 1)모든 직원의 급여의 중앙값?
-- 2)위의 값보다 많은 급여를 받는 직원의 목록?

-- 1) 직원 급여의 중앙값
SELECT MEDIAN(salary)급여중앙값 FROM employees; --6200 (1)
----------------
SELECT first_name 직원명, salary 급여
FROM Employees
WHERE salary >= 6200; -->  1번의 쿼리를 여기 6200값에 대체 (2)
-----------------
SELECT first_name 직원명, salary "중앙값보다 많은 급여"
FROM Employees
WHERE salary >= (SELECT MEDIAN(salary) FROM employees)
ORDER BY "중앙값보다 많은 급여" DESC;   --(3)


-- SUSAN보다 늦게 입사한 사원의 정보 
-- 1) SUSAN의 입사일 정보
-- 2) 1)보다 늦게 입사한 사원의 목록 정보
-- 3) 위 둘을 융합
SELECT  hire_date FROM employees
WHERE first_name = 'Susan'; -- 12/06/07 (1)
-------------
SELECT first_name 직원명, hire_date 사원목록
FROM employees 
WHERE hire_date > '12/06/07'; -- (2)
--------------
SELECT first_name "수잔보다 늦게 입사한 사원", hire_date 입사일
FROM employees 
WHERE hire_date > (SELECT  hire_date FROM employees
                    WHERE first_name = 'Susan') --(3)
ORDER BY 입사일;
                    
                    
-- (1)급여를 모든 직원 급여의 중앙값보다 많이 받으면서 
-- (2)수잔보다 늦게 입사한 직원의 목록
SELECT first_name "수잔보다 늦게 입사한 사원", 
        salary "중앙값보다 많은 급여", 
        hire_date 입사일
FROM employees
WHERE salary > (SELECT MEDIAN(salary) FROM employees) --(1)
    AND hire_date > (SELECT hire_date FROM employees  --(2)
                        WHERE first_name = 'Susan')
ORDER BY "중앙값보다 많은 급여" DESC, 입사일 ;
