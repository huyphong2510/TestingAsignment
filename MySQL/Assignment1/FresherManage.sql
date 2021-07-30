Create database FresherManage;
use FresherManage;

create table Trainee(
	trainee_id int primary key auto_increment,
    full_name varchar(50) not null,
    birth_date date,
    gender enum('male','female','unknown'),
    et_iq tinyint(20) unsigned not null,
    et_gmath tinyint(20) unsigned not null,
    et_english tinyint(50) unsigned not null,
    training_class tinyint unsigned not null,
    evaluation_notes text
    
);

alter table Trainee
add vti_account varchar(50) not null unique;

select * from Trainee;