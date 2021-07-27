create database Testing_system_assignment;
use Testing_system_assignment;

CREATE TABLE Department (
    department_id INT AUTO_INCREMENT,
    department_name VARCHAR(50),
    PRIMARY KEY (department_id)
);

CREATE TABLE `Position` (
    position_id INT AUTO_INCREMENT,
    department_name VARCHAR(50),
    PRIMARY KEY (position_id)
);

CREATE TABLE `Account` (
    account_id INT AUTO_INCREMENT,
    email VARCHAR(50),
    user_name VARCHAR(50),
    full_name VARCHAR(50),
    department_id INT,
    position_id INT,
    create_date DATE,
    PRIMARY KEY (account_id)
);

CREATE TABLE `Group` (
    group_id INT AUTO_INCREMENT,
    group_name VARCHAR(50),
    creator_id INT,
    create_date DATE,
    PRIMARY KEY (group_id)
);

CREATE TABLE Group_account (
    group_id INT,
    account_id INT,
    join_date DATE
);

CREATE TABLE Type_question (
    type_id INT AUTO_INCREMENT,
    type_name VARCHAR(50),
    PRIMARY KEY (type_id)
);

CREATE TABLE Category_question (
    category_id INT AUTO_INCREMENT,
    category_name VARCHAR(50),
    PRIMARY KEY (category_id)
);

CREATE TABLE Question (
    question_id INT AUTO_INCREMENT,
    content VARCHAR(50),
    content_id INT,
    type_id INT,
    creator_id INT,
    create_date DATE,
    PRIMARY KEY (question_id)
);

CREATE TABLE Answer (
    answer_id INT AUTO_INCREMENT,
    content VARCHAR(50),
    question_id INT,
    isCorrect BOOLEAN,
    PRIMARY KEY (answer_id)
);

CREATE TABLE Exam (
    exam_id INT AUTO_INCREMENT,
    `code` VARCHAR(50),
    title VARCHAR(50),
    category_id INT,
    duration int,
    creator_id INT,
    create_date DATE,
    PRIMARY KEY (exam_id)
);

CREATE TABLE ExamQuestion (
    exam_id INT,
    question_id INT
);
