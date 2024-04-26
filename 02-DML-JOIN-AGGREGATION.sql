--------------
--JOIN
--------------
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
-------------------------------
-- Simple Join or Equi-Join
-------------------------------
SELECT first_name, 
        department_id,--> 중복이 있어서 열의 정의가 애매하다고 뜸 
        department_name
FROM employees,departments
WHERE employees.department_id = departments.department_id;


SELECT first_name, 
        employees.department_id,
        departments.department_id,
        department_name
FROM employees,departments
WHERE employees.department_id = departments.department_id; 
-->code가 길어져서 별칭달예정


SELECT first_name, 
        emp.department_id,
        dept.department_id,
        department_name
FROM employees emp , departments dept
WHERE emp.department_id = dept.department_id; --106명, department_id가 null인 직원은 join에서 배제됨

-- 이때 널값 확인해보기 ------------------------
SELECT * 
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL; -- 레코드1개 출력되는것을 확인할수 있음 178 KIMBERLY
---------------------------------------------
SELECT emp.first_name, 
        dept.department_name,
FROM employees emp JOIN departments dept USING (department_id);


