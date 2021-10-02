--#3
select * from takes;
select * from student;
select student.id, student.name from student, takes where takes.id = student.id and course_id like 'CS%'
    and (takes.grade = 'A' or takes.grade = 'A-') order by name; --3.1

select instructor.name, instructor.dept_name, student.name, student.id, takes.course_id, takes.grade from instructor, advisor, student, takes
    where instructor.id = advisor.i_id and student.id = advisor.s_id and takes.id = student.id and takes.grade > 'B+'; --3.2

select distinct department.dept_name from department, student, takes where student.id = takes.id and department.dept_name = student.dept_name
    and department.dept_name not in(select department.dept_name from student, takes, department
    where student.id = takes.id and department.dept_name = student.dept_name and (takes.grade = 'F' or takes.grade = 'C')); --3.3

select instructor.name, takes.course_id, takes.grade, takes.id from instructor, course, takes, advisor
where instructor.id = advisor.i_id and advisor.s_id = takes.id and course.course_id = takes.course_id and instructor.name not in (
    select instructor.name from instructor, course, takes, advisor
    where instructor.id = advisor.i_id and advisor.s_id = takes.id and course.course_id = takes.course_id and takes.grade in ('A')); --3.4

select course.title, time_slot.day, time_slot.start_hr, time_slot.start_min, time_slot.end_hr, time_slot.end_min
    from course, time_slot, section
    where time_slot.time_slot_id = section.time_slot_id and course.course_id = section.course_id and
    ((time_slot.end_hr <= 12 and time_slot.end_min <= 59) or (time_slot.end_hr = 13 and time_slot.end_min = 0))
    order by end_hr;  --3.5