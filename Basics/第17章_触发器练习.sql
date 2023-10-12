# 第17章_触发器练习

# 练习1

#0. 准备工作
CREATE DATABASE test17_tri;

USE test17_tri;

CREATE TABLE emps
AS
SELECT employee_id,last_name,salary
FROM atguigudb.`employees`;
#1. 复制一张emps表的空表emps_back，只有表结构，不包含任何数据
CREATE TABLE IF NOT EXISTS emps_back
AS
SELECT *
FROM emps
WHERE 1 = 2;
#2. 查询emps_back表中的数据
SELECT * FROM emps_back;
#3. 创建触发器emps_insert_trigger，每当向emps表中添加一条记录时，同步将这条记录添加到emps_back表中
DELIMITER //
CREATE TRIGGER emps_insert_trigger
AFTER INSERT ON emps
FOR EACH ROW
BEGIN
		INSERT INTO emps_back(employee_id,last_name,salary)
		VALUES(NEW.employee_id,NEW.last_name,NEW.salary);
END //
DELIMITER ;
#4. 验证触发器是否起作用
INSERT INTO emps
VALUES(300,'Tom',5600);

SELECT * FROM emps_back;

# 练习2

#0. 准备工作：使用练习1中的emps表
USE test17_tri;
#1. 复制一张emps表的空表emps_back1，只有表结构，不包含任何数据
CREATE TABLE IF NOT EXISTS emps_back1
AS
SELECT *
FROM emps
WHERE 1 = 2;
#2. 查询emps_back1表中的数据
SELECT * FROM emps_back1;
#3. 创建触发器emps_del_trigger，每当向emps表中删除一条记录时，同步将删除的这条记录添加到emps_back1表中
DELIMITER //
CREATE TRIGGER emps_del_trigger
AFTER DELETE ON emps
FOR EACH ROW
BEGIN
		INSERT INTO emps_back1(employee_id,last_name,salary)
		VALUES(OLD.employee_id,OLD.last_name,OLD.salary);
END //
DELIMITER ;
#4. 验证触发器是否起作用
#测试1
DELETE FROM emps
WHERE employee_id = 100;
SELECT * FROM emps_back1;
#测试2
DELETE FROM emps;
SELECT * FROM emps_back1;