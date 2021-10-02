--#1
select * from course where credits > 3; -- 1.1
select * from classroom where building  = 'Watson' or building = 'Packard'; --1.2
select * from department where dept_name='Comp. Sci.'; --1.3
select * from section, course where section.course_id = course.course_id and section.semester = 'Fall'; --1.4
select * from student where tot_cred > 45 and tot_cred < 90; --1.5
select * from student where name like '%a' or name like '%e' or name like '%y' or name like '%u' or name like '%i' or name like '%o'; --1.5
select * from prereq, course where prereq.course_id = course.course_id and prereq_id = 'CS-101'; --1.6





