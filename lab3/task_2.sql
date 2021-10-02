--#2

select * from instructor;
select dept_name, avg(salary) from instructor group by dept_name order by avg(salary) asc; --2.1

select * from course;
select dept_name, count(course_id) from course group by dept_name order by count(course_id) limit 1; --2.2

select * from section;
select building, count(course_id) from section group by building order by -count(course_id) limit 1; --2.3

select * from takes;
select id, count(course_id) from takes where course_id like 'CS%' group by id having count(course_id) > 3; --2.4

select * from instructor;
select * from instructor where dept_name ='Biology' or dept_name ='Music' or dept_name ='Philosophy'; --2.5

select * from teaches;
select instructor.id, instructor.name from instructor, teaches where instructor.id = teaches.id and teaches.year = 2018 and instructor.id not in (
    select instructor.id from instructor, teaches where instructor.id = teaches.id and teaches.year = 2017
    );  --2.6
