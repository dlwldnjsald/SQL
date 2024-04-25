----------------------------------------
--practice 01.
----------------------------------------
-- 1.문제
-- 정렬-> 입사일의 올림차순으로 가장 선임부터 출력이 되도록  
-- 문제에서 말하는 선임은 입사일 기준으로 선임으로 지정한다고 보면 되고 (오름차순으로 날짜정렬)

-- 나중에 보스를 찾는 과정은 조인으로 해결하면 됨 (이후에 다룰 예정)
-- 매니저 아이디가 100부터 오름차순으로 예상해볼수 있다. 
-- 매니저 아이디를 오름차순으로 정렬해주면 됨.

-- 이름, 월급, 전번, 입사일 순서로 출력하고 
-- 이름, 월급, 전화번호, 입사일로 컬럼이름 대체
SELECT first_name || ' ' || last_name 직원명, 
        TO_CHAR((salary + salary * NVL(commission_pct,0)), '$999,999.99') "월급($)", --(커미션O)
        phone_number 전화번호, hire_date 입사일
        -- NVL(commission_pct,0)해당데이터가 널일경우 0으로대체해서 연산하겠다는 위의 코드 
        -- 헷갈림 주의 전체에다 nvl()하지말고 해당컬럼만 해주면됨
FROM employees
ORDER BY 입사일 ;



-- 2. 문제
-- 업무(jobs)별로 업무이름(job_title)과 최고월급(max_salary)을 월급의 내림차순(DESC)로 정렬
SELECT * 
FROM JOBS
ORDER BY min_salary DESC, max_salary DESC ; -- 컬럼명 하고 차순지정해서 해도 괜찮음 EX) 최고월급 DESC; 
-- 오류이유 :이때 SUBSTR(job_id,1,2)의 오름차순을 구하고 싶은 거지 -> JOB_ID ASC하면 오류뜸 주의하기 구분해줄것..



-- 3. 문제
-- 담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 
-- 직원의 이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
SELECT first_name || ' ' || last_name 직원명, 
        manager_id 매니저아이디, 
        commission_pct "커미션%",
        TO_CHAR((salary + salary * NVL(commission_pct,0)), '$999,999.99') "월급($)"
FROM employees
WHERE manager_id IS NOT NULL
        AND commission_pct is NULL 
        AND SALARY > 3000
ORDER BY "월급($)";



-- 4. 문제 
-- 최고월급(max_salary)이 10000 이상인 업무의 이름(job_title)과 
-- 최고월급(max_salary)을 최고월급의(max_salary) 내림차순(DESC)로 정렬하여 출력하세요.
SELECT *
FROM JOBS
WHERE MAX_SALARY >= 10000 
ORDER BY max_salary DESC;



-- 5. 문제
-- 월급이 14000 미만 10000 이상인 직원의 이름(first_name), 월급, 커미션퍼센트 를 
-- 월급순(내림차순) 출력하세오. 
-- 조건) 단 커미션퍼센트 가 null 이면 0 으로 나타내시오 nvl(commission_pct,0)
SELECT first_name || ' ' || last_name 직원명,
        TO_CHAR((salary + salary * NVL(commission_pct,0)), '$999,999.99') "월급($)" ,
        nvl(commission_pct,0) "커미션%"
FROM employees
WHERE salary >= 10000 AND salary < 14000 
ORDER BY "월급($)" DESC,"커미션%" DESC ;



-- 6. 문제
-- 부서번호가 10, 90, 100 인 직원의 이름, 월급, 입사일, 부서번호를 나타내시오
-- 조건) 입사일은 1977-12 와 같이 표시하시오
SELECT first_name || ' ' || last_name 직원명, 
        TO_CHAR((salary + salary * NVL(commission_pct,0)), '$999,999.99') "월급($)", 
        TO_CHAR(hire_date,'YYYY-MM') 입사일, 
        department_id 부서번호
FROM employees
WHERE department_id IN(10, 90, 100)
ORDER BY 입사일, 부서번호;



-- 7. 문제 
-- 이름(first_name)에 S 또는 s 가 들어가는 직원의 이름, 월급을 나타내시오.
SELECT first_name || ' ' || last_name 직원명, 
        TO_CHAR((salary + salary * NVL(commission_pct,0)), '$999,999.99') "월급($)"
FROM employees                      --주의)LIKE문은 이 절이 아닌 WHERE문옆에 해줘야함
-- 방법1)
WHERE UPPER(first_name) LIKE '%S%'                     -- 대문자로 정렬후 s를 추출 
-- 또는 WHERE LOWER(first_name) LIKE '%s%'; 이렇게 해도 정상출력됨
-- first_name을 UPPER 또는 LOWER로 감싸고 LIKE문옆에 '%S%' 또는 '%s%' 를 출력하면 편함
-- 방법2) WHERE first_name LIKE '%S%' OR first_name LIKE '%s%';
-- 오류 원인: WHERE first_name LIKE '%s%'; 이렇게만 출력하는 경우 소문자만 출력되서 오류뜸
ORDER BY "월급($)" DESC ;


-- 8. 문제
-- 전체 부서를 출력하려고 합니다. 
-- 순서는 부서이름이 긴 순서대로 출력해 보세오.
SELECT * FROM departments
ORDER BY LENGTH(department_name) DESC;



-- 9. 문제??
-- 정확하지 않지만, 지사가 있을 것으로 예상되는 나라들을 나라이름을 대문자로 출력하고
-- 올림차순(ASC)으로 정렬해 보세오.
SELECT UPPER(city), UPPER(country_id), 
        location_id,postal_code,state_province,street_address
FROM LOCATIONS
WHERE state_province IS NOT NULL 
ORDER BY city, country_id;




-- 10. 문제
-- 입사일이 03/12/31 일 이전 입사한 직원의 이름, 월급, 전화 번호, 입사일을 출력하세요
-- 전화번호는 545-343-3433 과 같은 형태로 출력하시오.
SELECT first_name || ' ' || last_name 직원명, 
        TO_CHAR((salary + salary * NVL(commission_pct,0)), '$999,999.99') "월급($)",
        TO_CHAR(phone_number,'XXX-XXX-XXXX') 전화번호,
        hire_date 입사일
FROM employees
WHERE hire_date >= 03/12/31; 
        


--------------------------------------