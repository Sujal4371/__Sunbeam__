
create database sunbeam;
use sunbeam;
create table users(email varchar(50) primary key , password varchar(20) , role enum ('admin', 'student'));  
create table courses(course_id int primary key , course_name varchar(20) , description varchar(100) , fees int , start_date date , end_date date , video_expiry_days int );
create table students(reg_no int primary key , name varchar(20) , email varchar(20) , course_id int , mobile_no int , profile_pic blob,  foreign key (email) references users(email) on delete cascade on update cascade, foreign key (course_id) references courses(course_id) on update cascade on delete cascade );
create table videos(video_id int primary key , course_id int , title varchar(20) , description varchar(100) , youtube_url varchar(100) , added_at timestamp , foreign key(course_id) references courses(course_id) on update cascade on delete cascade );


INSERT INTO users (email, password, role) VALUES
('admin@sunbeam.com', 'admin123', 'admin'),
('rahul@gmail.com', 'rahul@123', 'student'),
('priya@gmail.com', 'priya@123', 'student'),
('amit@gmail.com', 'amit@123', 'student');

INSERT INTO courses
(course_id, course_name, description, fees, start_date, end_date, video_expiry_days)
VALUES
(101, 'Java',   'Core Java and Advanced Java', 25000, '2025-12-20', '2026-01-20', 180),
(102, 'Python', 'Python for Data Science',     30000, '2025-12-24', '2026-01-24', 180),
(103, 'WebDev', 'HTML CSS JavaScript',         20000, '2025-12-24', '2026-01-24', 120);


INSERT INTO students
(reg_no, name, email, course_id, mobile_no, profile_pic)
VALUES
(1, 'Rahul', 'rahul@gmail.com', 101, 98765, NULL),
(2, 'Priya', 'priya@gmail.com', 102, 98765, NULL),
(3, 'Amit', 'amit@gmail.com', 103, 91234, NULL);

INSERT INTO videos (video_id, course_id, title, description, youtube_url, added_at)
VALUES
(201, 101, 'Java Intro', 'Introduction to Java', 'https://youtu.be/java01', '2025-11-26 23:36:18'),
(202, 101, 'OOP Concepts', 'Java OOP Basics', 'https://youtu.be/java02', '2025-11-26 23:52:13'),

(203, 102, 'Python Intro', 'Getting started with Python', 'https://youtu.be/py01', '2025-11-26 23:36:18'),
(204, 102, 'Pandas', 'Data analysis using Pandas', 'https://youtu.be/py02', '2025-11-26 23:52:13'),

(205, 103, 'HTML Basics', 'HTML Introduction', 'https://youtu.be/web01', '2025-11-26 23:36:18'),
(206, 103, 'CSS Basics', 'Styling with CSS', 'https://youtu.be/web02', '2025-11-26 23:52:13');


select * from users;
select * from students;
select * from courses;
select * from videos;


select * 
from courses where start_date > curdate();

select s.reg_no , s.name , s.email , s.mobile_no , c.course_id , c.course_name 
from students s natural join courses c;

select * 
from students natural join courses;

SELECT
  c.course_id, c.course_name, c.start_date, c.end_date, c.video_expiry_days, v.video_id, v.title, v.added_at
FROM students s
JOIN courses c ON s.course_id = c.course_id
JOIN videos  v ON v.course_id = c.course_id
WHERE s.email = 'rahul@gmail.com'
  AND (v.added_at + INTERVAL c.video_expiry_days DAY) >= CURDATE();
 



