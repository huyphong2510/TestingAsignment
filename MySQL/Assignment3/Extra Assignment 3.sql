SELECT 
    *
FROM
    Trainee;
DELETE FROM Trainee;
insert into Trainee (trainee_id, full_name, birth_date, gender, et_iq, et_gmath, et_english, training_class, evaluation_notes, vti_account) values
					(1, n'Nguyễn Huy Phong','2000-10-25', 'male', 18, 18, 38, '1', 'Good', 'huyphong@vti.edu.vn'),
					(2, n'Lê Thị Thanh Hương','2001-1-2', 'Female', 14, 20, 38, '2', 'Good', 'thanhhuong@vti.edu.vn'),	
                    (3, n'Nguyễn Phúc Nguyên','2000-12-12', 'Male', 15, 18, 40, '3', 'Good', 'phucnguyen@vti.edu.vn'),
                    (4, n'Bùi Thanh Yến','2000-10-24', 'Female', 17, 17, 45, '4', 'Good', 'thanhyen@vti.edu.vn'),
                    (5, n'Phạm Văn Tình','2000-7-15', 'Male', 5, 11, 23, '1', 'Bad', 'vantinh@vti.edu.vn'),
                    (6, n'Phạm Thị Thu Trang','2000-6-17', 'Female', 15, 16, 42, '2', 'Good', 'thutrang@vti.edu.vn'),
                    (7, n'Ngô Đức Hiệp','2000-5-27', 'Male', 20, 15, 44, '3', 'Good', 'duchiep@vti.edu.vn'),
                    (8, n'Nguyễn Chí Thanh','2000-4-29', 'Male', 17, 14, 39, '3', 'Good', 'chithanh@vti.edu.vn'),
                    (9, n'Trương Tiến Thành','2000-3-8', 'Male', 9, 9, 17, '1', 'Bad', 'tienthanh@vti.edu.vn'),
                    (10, n'Nguyễn Minh Tuấn','2000-10-9', 'Male', 20, 18, 41, '4', 'Good', 'minhtuan@vti.edu.vn'),
                    (11, n'Nguyễn Đức Toàn','2000-11-19', 'Male', 9, 10, 19, '1', 'Bad', 'ductoan@vti.edu.vn');

-- Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào, nhóm chúng thành các tháng sinh khác nhau

SELECT 
    *
FROM
    Trainee
WHERE
    evaluation_notes = 'Good'
GROUP BY birth_date;

-- Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau: tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)

Select * from Trainee where LENGTH(full_name) = (SELECT 
            MAX(LENGTH(full_name))
        FROM
            Trainee);
            
--  Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là những người đã vượt qua bài test đầu vào và thỏa mãn số điểm 

Select * from Trainee where (et_iq + et_gmath) >= 20 and et_iq >=8 and et_gmath >=8 and et_english >= 18; 

-- xóa thực tập sinh có TraineeID = 3    

Delete from Trainee where trainee_id = 3; 

-- Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". Hãy cập nhật thông tin vào database

update Trainee set training_class = 2 where trainee_id = 5;