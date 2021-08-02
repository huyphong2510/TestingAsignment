SELECT 
    *
FROM
    Department;
-- Question 3

SELECT 
    department_id
FROM
    Department
WHERE
    department_name = 'Sale';

-- Question 4 (Subquery)
SELECT 
    *
FROM
    `Account`
WHERE
    LENGTH(full_name) = (SELECT 
            MAX(LENGTH(full_name))
        FROM
            `Account`);
            
-- Question 5
SELECT 
    *
FROM
    `Account`
WHERE department_id = 3 AND
    LENGTH(full_name) = (SELECT 
            MAX(LENGTH(full_name))
        FROM
            `Account`);
    

-- Question 6
SELECT 
    group_name
FROM
    `Group`
WHERE
    create_date < '2019-12-20';
    
-- Question 7

SELECT 
    question_id
FROM
    Answer
GROUP BY question_id
HAVING COUNT(question_id) >= 4;

SELECT 
    *
FROM
    Answer;

 -- Question 8
SELECT 
    exam_id
FROM
    Exam
WHERE
    duration >= 60
        AND create_date < '2019-12-20';

-- Question 9

SELECT 
    *
FROM
    `Group`
ORDER BY create_date DESC;


-- Question 10

SELECT 
    COUNT(account_id) AS Total
FROM
    `Account`
WHERE
    department_id = 2;

-- Question 11

SELECT 
    full_name
FROM
    `Account`
WHERE
    full_name LIKE 'D%O';

-- Question 12

DELETE FROM Exam 
WHERE
    create_date < '2019-12-20';
    
SELECT 
    *
FROM
    Exam;

-- Question 13

DELETE FROM Question 
WHERE
    content LIKE 'Câu hỏi%';
   
-- Question 14

update `Account`
set full_name = "Nguyễn Bá Lộc", email = "loc.nguyenba@vti.com.vn" 
where account_id =5;    
select * from `Account` where account_id =5;

-- Question 15

update Group_account
set group_id = 4
where account_id = 5;

