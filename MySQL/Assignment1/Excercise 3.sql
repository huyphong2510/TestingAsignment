CREATE TABLE Excercise3 (
    id MEDIUMINT UNSIGNED PRIMARY KEY,
    `name` VARCHAR(40),
    birth_date DATE,
    gender ENUM('male', 'female', 'unknown'),
    is_Delete_Flag ENUM('0', '1')
);


SELECT 
    *
FROM
    Excercise3;


