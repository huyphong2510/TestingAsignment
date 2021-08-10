use Testing_system_assignment;
SET GLOBAL log_bin_trust_function_creators = 1;

-- Ví dụ Stored Procedured
drop procedure get_department_name;

delimiter $$
create procedure get_department_name (IN deptID TINYINT, OUT deptName varchar(50))
	begin 
		SELECT 
    department_name
INTO deptName FROM
    Department
WHERE
    department_id = deptID;
	end $$
delimiter ;

set @dpN = '';
call testing_system_assignment.get_department_name(1, @deptName);
SELECT @dpN;
SELECT 
    *
FROM
    Department
WHERE
    department_name = @dpN;
    
    
    DROP FUNCTION IF EXISTS get_department_info;
    
    DELIMITER $$
CREATE FUNCTION get_department_info (accountID INT) RETURNS VARCHAR(50)
BEGIN 
	DECLARE deptName varchar(50);
    DECLARE deptID tinyint;
    
    SELECT department_id INTO deptID  FROM `Account` WHERE account_id = accountID;
	SELECT department_name INTO deptName  FROM Department WHERE department_id = deptID;
    
    RETURN deptName;
    
    END $$
    
	DELIMITER ;
    
SELECT get_department_info(1);


-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
drop procedure Department_info;

delimiter $$
CREATE PROCEDURE Department_info (IN deptName VARCHAR(50))
	BEGIN 
		SELECT 
    d.department_id as 'Mã phòng ban' , a.full_name as 'Họ tên'
  FROM
    Department d
JOIN `Account` a ON d.department_id = a.department_id
WHERE d.department_name = deptName;

	END $$
delimiter ;

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE Account_amount;

DELIMITER $$
CREATE PROCEDURE Account_amount (IN deptID TINYINT(50))
	BEGIN 
        
		SELECT d.department_name as' Tên phòng ban' ,Count(a.department_id) as 'Số lượng'  
        FROM `Account` a 
        JOIN Department d
        ON a.department_id = d.department_id
        GROUP BY a.department_id;
        
	END $$
DELIMITER ;

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE Type_question_current_month;

    DELIMITER $$
CREATE PROCEDURE Type_question_current_month (IN typeQuestion ENUM('Essay', 'Multiple-Choice') ) 
BEGIN 
    
    Select q.content as 'Nội dung',tq.type_name as 'Kiểu câu hỏi' ,q.create_date as 'Ngày tạo'
    FROM Question q 
	JOIN type_question tq 
	ON tq.type_id = q.type_id
	WHERE tq.type_name = typeQuestion
    AND MONTH(q.create_date)  = MONTH(CURRENT_DATE()) 
	AND YEAR(q.create_date) = YEAR(CURRENT_DATE());
    
    
    END $$
    
	DELIMITER ;

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question

    CREATE VIEW maxQuestion AS
    SELECT 
        COUNT(q.type_id) AS Max, tq.type_name
    FROM
        Question q
            JOIN
        Type_question tq ON q.type_id = tq.type_id
    GROUP BY q.type_id
    LIMIT 1;
    
    
-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào

DROP PROCEDURE Account_info;

DELIMITER $$
CREATE PROCEDURE Account_info (IN userName varchar(50))
BEGIN
	SELECT 
    d.department_name, a.full_name, a.user_name
FROM
    `Account` a
        LEFT JOIN
    Department d ON d.department_id = a.department_id
    WHERE a.user_name = userName
ORDER BY a.department_id ASC;


END $$

DELIMITER ;

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi positionID: sẽ có default là developer departmentID: sẽ được cho vào 1 phòng chờ
DROP PROCEDURE InsertAccount;

DELIMITER $$
CREATE PROCEDURE InsertAccount (IN fullName varchar(50),IN userName varchar(50), IN emailAddress VARCHAR(50))
BEGIN
	INSERT INTO `Account` (user_name, full_name, email) values (userName,fullName, emailAddress );
END $$

DELIMITER ;



-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

DROP PROCEDURE LoongestContent;

DELIMITER $$
CREATE PROCEDURE LoongestContent (IN typeName varchar(50))
BEGIN
SELECT 
    MAX(LENGTH(q.content))as 'Độ dài ', q.content as 'Nội dung', tq.type_name as 'Kiểu câu hỏi'
FROM
    Question q
        JOIN
    Type_question tq ON q.type_id = tq.type_id
    WHERE tq.type_name = typeName
GROUP BY q.content
ORDER BY MAX(LENGTH(q.content)) desc
LIMIT 1;
END $$
DELIMITER ;

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID

DELIMITER $$
CREATE PROCEDURE DeleteAccount (IN accountID int)
BEGIN
	Delete from `Account` WHERE account_id = accountID;
END $$

DELIMITER ;


-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa) Sau đó in số lượng record đã remove 
-- từ các table liên quan trong khi removing
DROP PROCEDURE Delete_Old_Exam;
DELIMITER $$
CREATE PROCEDURE Delete_Old_Exam ()
BEGIN
	Delete from Exam WHERE YEAR(create_date) <= YEAR(CURRENT_DATE()) - 3 ;
    Select * from Exam;
END $$

DELIMITER ;

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc

DELIMITER $$
CREATE PROCEDURE Update_department (IN deptID int, IN accID int)
BEGIN
UPDATE `Account` SET department_id = 4 WHERE account_id = accID AND department_id = deptID;
END $$
DELIMITER ;

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay

DELIMITER $$
CREATE PROCEDURE Question_In_YEAR ()
BEGIN
	SELECT * from Exam WHERE YEAR(create_date) <= YEAR(CURRENT_DATE());
    Select * from Exam;
END $$

DELIMITER ;

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")


DELIMITER $$
CREATE PROCEDURE Near_Question(IN typeName ENUM('Essay', 'Multiple-Choice'), OUT content varchar(255))
BEGIN

SELECT 
    q.content_id
FROM
    Question q
        JOIN
    Type_question tq ON q.type_id = tq.type_id
WHERE tq.type_name = typeName AND
    MONTH(q.create_date) <= MONTH(CURRENT_DATE()) - 6;

    IF (content IS NULL) THEN
            SET content  = 'không có câu hỏi nào trong tháng';
END IF;
END $$
DELIMITER ;

DROP PROCEDURE Near_Question;

