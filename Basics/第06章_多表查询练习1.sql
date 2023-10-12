# 第06章_多表查询练习1

#【题目】
# 1.显示所有员工的姓名，部门号和部门名称。
SELECT e.last_name,e.department_id,d.department_name
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;
# 2.查询90号部门员工的job_id和90号部门的location_id
SELECT job_id,location_id
FROM employees e,departments d
WHERE e.department_id = d.department_id
AND e.department_id = 90;
# 3.选择所有有奖金的员工的 last_name , department_name , location_id , city
SELECT e.last_name,d.department_name,d.location_id,l.city
from employees e 
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
LEFT OUTER JOIN locations l
ON d.location_id = l.location_id
WHERE e.commission_pct IS NOT NULL;
# 4.选择city在Toronto工作的员工的 last_name , job_id , department_id , department_name
SELECT last_name,job_id,d.department_id,department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE l.city = 'Toronto';
# 5.查询员工所在的部门名称、部门地址、姓名、工作、工资，其中员工所在部门的部门名称为’Executive’
SELECT last_name,department_name,street_address,job_id,salary
FROM employees e,departments d,locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND d.department_name = 'Executive';

SELECT department_name, street_address, last_name, job_id, salary
FROM employees e JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.`location_id` = l.`location_id`
WHERE department_name = 'Executive'
# 6.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
/*
employees Emp# manager Mgr#
kochhar 101 king 100
*/

SELECT t1.last_name employees,t1.employee_id "Emp#",t2.last_name manager,t2.employee_id "Mgr#"
FROM employees t1
LEFT OUTER JOIN employees t2
ON t1.manager_id = t2.employee_id;

# 7.查询哪些部门没有员工
SELECT d.department_id,department_name
FROM employees e
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IS NULL;

SELECT d.department_id
FROM departments d LEFT JOIN employees e
ON e.department_id = d.`department_id`
WHERE e.department_id IS NULL;
# 8. 查询哪个城市没有部门
SELECT city
FROM departments d
RIGHT JOIN locations l
ON d.location_id = l.location_id
WHERE d.location_id IS NULL;
# 9. 查询部门名为 Sales 或 IT 的员工信息
SELECT employee_id,last_name,department_name
FROM employees e,departments d
WHERE e.department_id = d.`department_id`
AND d.`department_name` IN ('Sales','IT');