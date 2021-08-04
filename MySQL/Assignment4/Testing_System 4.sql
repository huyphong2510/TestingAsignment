-- Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ

SELECT 
    *
FROM
    `Account`
        JOIN
    Department ON `Account`.department_id = Department.department_id
ORDER BY Department.department_id;

-- Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010

SELECT 
    a.account_id, a.email, a.user_name, a.full_name, a.create_date, d.department_name
FROM
    `Account` a
        JOIN
    Department d ON a.department_id = d.department_id
WHERE
    a.create_date > '2010-12-20'
ORDER BY a.account_id;

--  lấy ra tất cả các developer

SELECT 
    *
FROM
    `Account` a
        JOIN
    Position p ON a.position_id = p.position_id
WHERE
    p.department_name = 'Dev';
-- Lấy ra group không có account nào

SELECT 
    g.group_name
FROM
    `Group` g
         JOIN
    Group_account ga ON g.group_id = ga.group_id
WHERE
    ga.account_id IS NULL;
    
-- Lấy ra account không nằm trong Group nào

SELECT 
    ga.account_id
FROM
    `Group` g
        RIGHT JOIN
    Group_account ga ON g.group_id = ga.group_id
WHERE
    ga.group_id IS NULL;
    
--     Lấy ra question không có answer nào

SELECT 
    *
FROM
    Question q
        LEFT JOIN
    Answer a ON q.question_id = a.question_id
WHERE
    a.question_id IS NULL
;

-- Lấy ra tên account và group đã tham gia

SELECT 
    a.full_name
FROM
    Group_account ga
        JOIN
    `Group` g ON ga.group_id = g.group_id
        JOIN
    `Account` a ON ga.account_id = a.account_id
WHERE
    ga.account_id IS NOT NULL;
    
-- Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên

SELECT 
    COUNT(a.department_id) as "Mã Phòng Ban", d.department_name as 'Tên phòng ban'
FROM
    `Account` a
        JOIN
    Department d ON a.department_id = d.department_id
GROUP BY a.department_id
HAVING COUNT(a.department_id) >= 3;

-- Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất

select * from Answer;

SELECT 
    a.content,Count(a.question_id)
FROM
    Question q
        JOIN
    Answer a ON q.question_id = a.question_id
GROUP BY a.question_id
HAVING Count(a.question_id) limit 1;

-- Question 17:
SELECT distinct
    *
FROM
    Group_account ga
        JOIN
    `Group` g ON ga.group_id = g.group_id
where ga.group_id = 1 
UNION SELECT 
    *
FROM
    Group_account ga
        JOIN
    `Group` g ON ga.group_id = g.group_id
where ga.group_id = 2;

	
    -- Question 18
    select * from Group_account;
SELECT 
    *
FROM
    `Group` g
        JOIN
    `group_account` ga ON ga.group_id = g.group_id
HAVING COUNT(ga.account_id) > 4;

SELECT 
    *, COUNT(ga.account_id)
FROM
    group_account ga
        JOIN
    `Group` g ON g.group_id = ga.group_id
GROUP BY ga.account_id
HAVING COUNT(ga.account_id) >= 5;

SELECT 
     g.group_name,COUNT(ga.group_id) from Group_account ga join `Group` g on g.group_id = ga.group_id  GROUP BY g.group_id HAVING count(ga.group_id) >= 5
UNION
SELECT 
     g.group_name,COUNT(ga.group_id) from Group_account ga join `Group` g on g.group_id = ga.group_id  GROUP BY g.group_id HAVING count(ga.group_id) < 7  ;

-- 6 den 13


-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question

SELECT 
    c.category_name, COUNT(e.category_id)
FROM
    Exam e
        JOIN
    Category_question c ON e.category_id = c.category_id
GROUP BY e.category_id
HAVING COUNT(e.category_id);

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam

SELECT 
    q.content as 'Câu hỏi', COUNT(eq.question_id) AS 'Số lần sử dụng'
FROM
    ExamQuestion eq
        JOIN
    Question q ON q.question_id = eq.question_id
GROUP BY eq.question_id;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất

SELECT 
    q.content as 'Câu hỏi' , COUNT(*) question_count  
FROM
    Answer a
        JOIN
    Question q ON a.question_id = q.question_id
GROUP BY a.question_id
ORDER BY question_count  DESC
LIMIT 1;

-- Question 9: Thống kê số lượng account trong mỗi group

SELECT 
    g.group_name as `Tên nhóm`, COUNT(account_id) as `Số lượng`
FROM
    Group_account ga join `Group` g on g.group_id = ga.group_id
GROUP BY ga.group_id;

-- Question 10: Tìm chức vụ có ít người nhất

SELECT 
    p.department_name, MIN(a.position_id)
FROM
    `Account` a
        JOIN
    position p ON p.position_id = a.position_id
GROUP BY a.position_id
ORDER BY a.position_id DESC
LIMIT 1;

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM

SELECT 
    d.department_name as `Phòng ban` ,p.position_name ` Vị trí`, COUNT(a.position_id) as ` Số lượng `
FROM
    `Account` a
        JOIN
    Department d ON d.department_id = a.department_id
    JOIN
    `Position` p ON p.position_id = a.position_id
GROUP BY a.position_id;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...

SELECT 
    q.content, q.type_id, q.create_date, ac.full_name, a.content
FROM
    Question q
        JOIN
    Answer a ON a.question_id = q.question_id
        JOIN
    `Account` ac ON ac.account_id = q.creator_id
	
		;

