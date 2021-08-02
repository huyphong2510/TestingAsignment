Create database FresherManage;
use FresherManage;

create table Trainee(
	trainee_id int primary key auto_increment,
    full_name varchar(50) not null,
    birth_date date,
    gender enum('male','female','unknown'),
    et_iq tinyint unsigned check (et_iq < 20)  not null,
    et_gmath tinyint unsigned check (et_iq < 20) not null,
    et_english tinyint unsigned check (et_iq < 50) not null,
    training_class tinyint unsigned not null,
    evaluation_notes text
    
);

alter table Trainee
add vti_account varchar(50) not null unique;

select * from Trainee;