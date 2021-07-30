create database Testing_system_assignment;
use Testing_system_assignment;

--  drop database Testing_system_assignment;

CREATE TABLE Department (
    department_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL
);

insert into Department(department_id, department_name) values (1, 'Sale'),
															(2, 'Marketing'),
															(3, 'Audit'),
															(4, 'Accounting'),
                                                            (5, 'Accounting');

insert into Department(department_id, department_name) values (6, 'IT');


Select * from Department;


CREATE TABLE `Position` (
    position_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    department_name ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL
);

insert into `Position`(position_id, department_name) values (1, 'Dev'),
															(2, 'Test'),
															(3,'Scrum Master'),
															(4, 'PM'),
															(5, 'Dev');

Select * from `Position`;
 
 
CREATE TABLE `Account` (
    account_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) UNIQUE NOT NULL,
    user_name VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    department_id TINYINT UNSIGNED REFERENCES Department (department_id),
    position_id TINYINT NOT NULL REFERENCES Department (position_id),
    create_date DATETIME default now()
);

insert into `Account`(account_id, email, user_name, full_name, department_id, position_id) values (1, 'abcxffdgfg123@gmail.com', 'abcdxyz', 'Nguyen Van A', 1, 1  );
insert into `Account`(account_id, email, user_name, full_name, department_id, position_id) values (2, 'abcxffdgfg456@gmail.com', 'qwerrt', 'Nguyen Van B', 2, 2  );
insert into `Account`(account_id, email, user_name, full_name, department_id, position_id) values (3, 'abcxffdgfg789@gmail.com', 'zxcvbn', 'Nguyen Van C', 3, 3  );
insert into `Account`(account_id, email, user_name, full_name, department_id, position_id) values (4, 'abcxffdgfg10@gmail.com', 'ghjkl', 'Nguyen Van D', 4, 4  );
insert into `Account`(account_id, email, user_name, full_name, department_id, position_id) values (5, 'abcxffdgfg11@gmail.com', 'qwdfh123', 'Nguyen Van E', 5, 5  );
 insert into `Account`(account_id, email, user_name, full_name, department_id, position_id) values (6, 'abcxffqdgfg11@gmail.com', 'qwdfqh123', 'Nguyen Van F', 6, 5  );
select * from `Account`;
 
CREATE TABLE `Group` (
    group_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(50) UNIQUE,
    creator_id INT UNSIGNED REFERENCES Account (account_id),
    create_date DATETIME default now()
);

insert into `Group`(group_id, group_name, creator_id) values (1, 'ABCD', 1);
insert into `Group`(group_id, group_name, creator_id) values (2, 'ACD', 2);
insert into `Group`(group_id, group_name, creator_id) values (3, 'ABD', 3);
insert into `Group`(group_id, group_name, creator_id) values (4, 'BCD', 4);
insert into `Group`(group_id, group_name, creator_id) values (5, 'AACD', 5);

select * from `Group`;

CREATE TABLE Group_account (
    group_id TINYINT UNSIGNED REFERENCES `Group` (group_id),
    account_id INT UNSIGNED REFERENCES `Account` (account_id),
    join_date DATE
);

insert into Group_account(group_id, account_id, join_date) values (1, 1, '2021-07-29');
insert into Group_account(group_id, account_id, join_date) values (2, 2, '2021-07-29');
insert into Group_account(group_id, account_id, join_date) values (3, 3, '2021-07-29');
insert into Group_account(group_id, account_id, join_date) values (4, 4, '2021-07-29');
insert into Group_account(group_id, account_id, join_date) values (5, 5, '2021-07-29');

select * from Group_account;


CREATE TABLE Type_question (
    type_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    type_name ENUM('Essay', 'Multiple-Choice') NOT NULL
);

INSERT INTO Type_question(type_id, type_name) values (1, 'Essay');
INSERT INTO Type_question(type_id, type_name) values (2, 'Multiple-Choice');

select * from Type_question;

CREATE TABLE Category_question (
    category_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

insert into Category_question(category_id, category_name) values (1, 'Java'),
									(2, 'C#'),
                                    (3, 'PHP'),
                                    (4, 'Javascript'),
                                    (5, 'Swift');
                                    
CREATE TABLE Question (
    question_id INT UNSIGNED,
    content VARCHAR(50) NOT NULL,
    content_id INT UNSIGNED,
    type_id TINYINT UNSIGNED REFERENCES Type_question (type_id),
    creator_id SMALLINT UNSIGNED REFERENCES `Account` (account_id),
    create_date DATETIME DEFAULT NOW(),
    PRIMARY KEY (question_id , content_id)
);

insert into Question(question_id, content, content_id, type_id,creator_id) values (1, 'Java',1, 1,6  ),
														(2, 'C#',1, 2,6 ),
                                                        (3 ,'PHP',1, 2,6 ),
                                                        (4, 'Javascript',1, 1,6 ),
                                                        (5, 'Swift',1, 2,6 );
                                                        
select * from Question;
CREATE TABLE Answer (
    answer_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    content NVARCHAR(150) NOT NULL,
    question_id INT UNSIGNED REFERENCES Question (question_id),
    isCorrect TINYINT
);
drop table Answer;
insert into Answer(answer_id, content, question_id, isCorrect) values (1,n'Bạn hãy cho biết sự khác nhau giữa JDK và JRE',1,0),
																		(2,n'Thế nào là attribute trong C#?',2,0),
                                                                        (3,n'Phân biệt $_POST và $_GET trong PHP?',3,0),
                                                                        (4,n'Vòng lặp sử dụng var hoặc let trong Javascript có gì khác nhau?',4,0),
                                                                        (5,n'Các tính năng chính của Swift?',5,0);
select * from Answer;

select * from Answer a join Question q on a.question_id = q.question_id;

CREATE TABLE Exam (
    exam_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `code` VARCHAR(50) UNIQUE KEY NOT NULL,
    title VARCHAR(50),
    category_id INT UNSIGNED REFERENCES Category_question (category_id),
    duration TINYINT NOT NULL,
    creator_id INT UNSIGNED REFERENCES `Account` (account_id),
    create_date datetime default now()
);

insert into Exam(exam_id, `code`, title, category_id, duration, creator_id) values (1,'A01',n'Final Exam',1, 60,6 ),
																					(2,'A02',n'Final Exam',2, 60,6 ),
                                                                                    (3,'A03',n'Final Exam',3, 60,6 ),
                                                                                    (4,'A04',n'Final Exam',4, 60,6 ),
                                                                                    (5,'A05',n'Final Exam',5, 60,6 ),
                                                                                    (6,'A06',n'Final Exam',6, 60,6 );
                                                                                    
select * from Exam;

CREATE TABLE ExamQuestion (
    exam_id INT UNSIGNED REFERENCES Exam (exam_id),
    question_id INT UNSIGNED REFERENCES Question (question_id)
);
