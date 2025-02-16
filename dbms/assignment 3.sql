create table course(
	course_id int primary key,
	course_name varchar(255),
	instructor_id int,
	department varchar(255),
	semester varchar(255),
	building varchar(255),
	room_no int ,
	total_credits int,
	foreign key (instructor_id)  references instructors(instructor_id)		
)
create table instructors(
	instructor_id int primary key,
	instructor_name varchar(255),
	salary int
)
create table students(
	student_id int primary key,
	student_name varchar(255)
)


create table enrollments(
	enrollment_id int primary key,
	course_id int,
	student_id int ,
	semester varchar(255),
	grade varchar(1),
	foreign key (course_id) references course(course_id),
	foreign key (student_id) references students(student_id)
)
select count(course_id) , department from course
group by department;

select * from course;
select count(course_id) , course_name from course 
group by course_name
having count(course_id)>2;

select * from enrollments;
select c.course_name , c.course_id from course c
left join enrollments e
on e.course_id = c.course_id
where e.grade = 'A';

select * from course;
select instructor_name from instructors i
inner join course c
on c.instructor_id = i.instructor_id
group by i.instructor_id 
having  count( distinct c.department) > 1;

select avg(salary) , department from instructors i
left join course c
on c.instructor_id = i.instructor_id
group by c.department
having count(i.instructor_id) >= 2;


select count(s.student_id),semester from students s
left join enrollments e
on e.student_id = s.student_id
group by semester;


select department  from course 
group by department
having avg(total_credits) > 3;

select c1.department from course c1
join course c2
on c1.instructor_id = c2.instructor_id
group by c1.course_id , c2.course_id
having count( distinct c1.course_id) > 1 and c1.instructor_id = c2.instructor_id;


select s.student_id , s.student_name from students s
left join enrollments e
on e.student_id = s.student_id
left join course c
on c.course_id = e.course_id
group by s.student_id , s.student_name
having count(distinct c.semester) = (select count(semester) from course);

select department , salary from course c
left join enrollments e
on e.course_id = c.course_id
left join students s
on s.student_id = e.student_id
left join instructors i
on i.instructor_id = c.instructor_id
group by c.department , i.salary
order by max(i.salary) desc
limit 1;



select s.student_name from students s 
left join enrollments e
on e.student_id = s.student_id
group by e.course_id , s.student_name
having count(distinct course_id) = (select count(distinct course_id) from course)


select c.course_id , course_name , e.semester from course c
left join enrollments e
on e.course_id = c.course_id
group by e.semester , c.course_id , e.grade
having e.grade = (select max(grade) from enrollments);
