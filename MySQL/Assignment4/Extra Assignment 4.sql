Create database Assignment_4;
use Assignment_4;

CREATE TABLE Department (
    department_number INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(20)
);

insert into Department(department_number, department_name) values (1, 'D001'),
																	(2, 'D002'),
                                                                    (3, 'D003'),
                                                                    (4, 'D004'),
                                                                    (5, 'D005'),
                                                                    (6, 'D006'),
                                                                    (7, 'D007'),
                                                                    (8, 'D008'),
                                                                    (9, 'D009'),
                                                                    (10, 'D010'),
                                                                    (11, 'D011');
                                                                    
SELECT 
    *
FROM
    Department;
 
CREATE TABLE Employee (
    employee_number INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    employee_name NVARCHAR(50),
    department_number INT UNSIGNED REFERENCES Department (department_number)
);

insert into Employee(employee_number, employee_name, department_number ) values (1,n'Nguyễn Huy Phong', 1),
																				(2,n'Nguyễn Minh Hiếu', 1),
                                                                                (3,n'Nguyễn Đức Minh', 2),
                                                                                (4,n'Hoàng Ngọc Huy', 2),
                                                                                (5,n'Ngô Đức Độ', 2),
                                                                                (6,n'Ngô Đức Hiệp', 2),
                                                                                (7,n'Trần Hữu Hoàng', 1),
                                                                                (8,n'Lê Tuấn Minh', 4),
                                                                                (9,n'Phạm Đức Anh', 5),
                                                                                (10,n'Nguyễn Thanh Tùng', 6),
                                                                                (11,n'Nguyễn Đức Phúc', 6),
                                                                                (12,n'Ngô Quang Huy', 7);

select * from Employee;
delete from Employee;
CREATE TABLE Employee_Skill_Table (
    employee_number INT UNSIGNED REFERENCES Employee (employee_number),
    skill_Code VARCHAR(20),
    date_registered DATETIME DEFAULT NOW()
);

insert into Employee_Skill_Table(employee_number, skill_Code) values (1,'Java'),
																	(2,'Object-C'),
                                                                    (3,'Java'),
                                                                    (4,'C#'),
                                                                    (5,'Java'),
                                                                    (6,'C#'),
                                                                    (7,'Java'),
                                                                    (8,'Object-C'),
                                                                    (9,'Java'),
                                                                    (10,'Object-C'),
                                                                    (11,'Object-C'),
                                                                    (12,'Java'),
                                                                    (1,'PHP'),
                                                                    (3,'C#'),
                                                                    (1,'Javascript'),
                                                                    (2,'C++');
delete from Employee_Skill_Table;
select * from Employee_Skill_Table;

-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java

SELECT 
    e.employee_name, esk.skill_code
FROM
    Employee_Skill_Table esk
JOIN
	Employee e
ON e.employee_number = esk.employee_number
WHERE esk.skill_code = 'Java'
;

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên

SELECT 
    d.department_name as 'Phòng ban' , COUNT(e.department_number) as 'Số nhân viên'
FROM
    Employee e
        JOIN
    Department d ON d.department_number = e.department_number
GROUP BY e.department_number
HAVING COUNT(e.department_number) >= 3;

-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban.

SELECT 
    e.employee_name AS ' Tên nhân viên',
    d.department_name AS 'Phòng ban'
FROM
    Employee e
        JOIN
    Department d ON e.department_number = d.department_number
GROUP BY e.employee_name
ORDER BY e.employee_number ASC;

-- Viết lệnh để lấy ra danh sách nhân viên có > 1 skills.

SELECT 
    e.employee_name, COUNT(esk.employee_number)
FROM
    Employee_Skill_Table esk
        JOIN
    Employee e ON e.employee_number = esk.employee_number
GROUP BY esk.employee_number
HAVING COUNT(esk.employee_number) > 1;