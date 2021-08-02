Create database FresherManage;
use FresherManage;

create table Trainee(
	trainee_id int primary key auto_increment,
    full_name nvarchar(50) not null,
    birth_date date,
    gender enum('male','female','unknown'),
    et_iq tinyint unsigned not null,
    et_gmath tinyint unsigned not null,
    et_english tinyint unsigned not null,
    training_class varchar(20) not null  ,
    evaluation_notes text,
    check (et_iq <= 20),
    check (et_gmath <= 20),
    check (et_english <= 50)
    
);

alter table Trainee

add vti_account varchar(50) not null unique;

drop table Trainee;
SELECT 
    *
FROM
    Trainee;