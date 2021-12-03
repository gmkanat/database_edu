-- 1a
create or replace function increment(a numeric)returns numeric as
    $$
    begin
        a := a + 1;
        return a;
    end;
    $$
language plpgsql;

select increment(123);
-- 1b
create or replace function get_sum(a numeric, b numeric) returns numeric as
    $$
    begin
        return a + b;
    end;
    $$
language plpgsql;

select get_sum(322, 20);

-- 1c
create or replace function isdivisible(a numeric) returns bool as
    $$
    begin
        return 1 - a%2;
    end;
    $$
language plpgsql;
select isdivisible(12);

-- 1d
create or replace function isvalid(a varchar) returns bool as
    $$
        begin
            if length(a) > 7 then
                return true;
            else
                return false;
            end if;
        end;
    $$
language plpgsql;
select isvalid('qwerty12');

-- 1e
create or replace function square_and_cube(a numeric, out b numeric, c out numeric) as
    $$
    begin
        b := a*a;
        c := a*a*a;
    end;
    $$
language plpgsql;
select * from square_and_cube(3);


-- Trigger
-- 2a
drop table timelife;
create table timelife(
    id int unique,
    date date,
    age int,
    price int,
    last_date timestamp,
    primary key (id)
);
create or replace function timetrigger() returns trigger as $time_trigger$
    begin
        new.last_date := current_timestamp;
        return new;
    end;
    $time_trigger$
language plpgsql;

create trigger time_trigger before insert or update on timelife
    for each row execute function timetrigger();
insert into timelife(id, date, age, price) values(2, '2002-12-12', 15, 2000);

select * from timelife;
drop trigger time_trigger on timelife;

-- 2b
create table timelife2 (
   id int unique,
   date_of_birth date,
   age integer,
   primary key(id)
);

create or replace function ages() returns trigger as
    $$
        begin
            new.age = extract(years from age(current_date, new.date_of_birth ));
        return new;
    end;
    $$
language plpgsql;

create trigger compute_age before insert on
    timelife2 for each row execute procedure ages();

insert into timelife2 (id, date_of_birth)values (1, '2000-10-05');
select * from timelife2;

-- 2c

drop table timelife3;
drop function tax_calc();
create table timelife3 (
  price int not null,
  tax double precision
);

create function tax_calc() returns trigger as
    $$
        begin
            new.tax = new.price * 0.12;
            return new;
        end;
    $$
language plpgsql;

create trigger set_tax before insert on timelife3
for each row execute procedure tax_calc();
insert into timelife3(price) values (10);
select * from timelife3;

-- 2d

-- d
create table timelife4 (
   id int,
   name varchar not null,
   date_of_birth date,
   age integer,
   primary key(id)
);

create function del() returns trigger as
    $$
        begin
            return null;
        end;
    $$
language plpgsql;
drop trigger del_trigger on timelife4;
create trigger del_trigger before delete on timelife4
for each row execute procedure del();
insert into timelife4(id, name) values(1, 'Kanat');
delete from timelife4 where name= 'Kanat';
select * from timelife4;

-- 2e
drop table timelife5;
create table timelife5 (
   id int,
   a int,
   akvadrat int,
   acube int,
   password varchar,
   checkpp bool,
   primary key(id)
);
drop function checkpass();
create function checkpass() returns trigger as
    $$
        begin
            new.akvadrat = new.a*new.a;
            new.acube = new.a*new.a*new.a;
           if length(new.password) > 7 then
                        new.checkpp := true;
                        return new;
                    else
                        new.checkpp := false;
                        return new;
                end if;
        end;
    $$
language plpgsql;
drop trigger passtrigger on timelife5;
create trigger passtrigger before insert on timelife5
for each row execute procedure checkpass();
insert into timelife5(id, a, password) values (1, 3, 'holi');
insert into timelife5(id, a, password) values (32, 4, 'fddafdsafdsafsaa');
insert into timelife5(id, a,  password) values (31, 5,'fdasf');

select * from timelife5;
drop table timelife5;
drop function checkpass();
drop trigger passtrigger on timelife5;


-- 3
-- What is the difference between procedure and function
-- Function is used to calculate something from a given input.
-- While procedure is the set of commands, which are executed in a order.

-- 4a
create table timelife44(
    id int unique,
    name varchar,
    date_of_birth date,
    age int,
    salary int,
    workexperience int,
    discount int
);
create or replace procedure increase()as
    $$
        begin
            update timelife44
            set salary = salary * (workexperience/2)*1.1,
            discount = 10
            where workexperience >= 2;

            update timelife44
            set discount = discount + (workexperience / 5)
            where workexperience >= 5;
            commit ;
        end;
    $$
language plpgsql;

call increase();
insert into timelife44 values (1,'Kana', '2003-11-15', 20, 50000,16, 0);
select * from timelife44;

-- 4d
create or replace procedure increase40() as
    $$
        begin
            update timelife44
            set salary = salary * 1.15
            where age >= 40;

            update timelife44 set
            salary = salary * 1.15,
            discount = 20
            where age >= 40 and workexperience >= 8;
            commit ;
        end;
    $$
language plpgsql;
call increase40();

insert into timelife44 values ( 2, 'Kanat', '1965-08-03', 51, 40000, 20,0);
select * from timelife44;

-- 5


INSERT INTO members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) VALUES
(0, 'GUEST', 'GUEST', 'GUEST', 0, '(000) 000-0000', NULL, '2012-07-01 00:00:00'),
(1, 'Smith', 'Darren', '8 Bloomsbury Close, Boston', 4321, '555-555-5555', NULL, '2012-07-02 12:02:05'),
(2, 'Smith', 'Tracy', '8 Bloomsbury Close, New York', 4321, '555-555-5555', NULL, '2012-07-02 12:08:23'),
(3, 'Rownam', 'Tim', '23 Highway Way, Boston', 23423, '(844) 693-0723', NULL, '2012-07-03 09:32:15'),
(4, 'Joplette', 'Janice', '20 Crossing Road, New York', 234, '(833) 942-4710', 1, '2012-07-03 10:25:05'),
(5, 'Butters', 'Gerald', '1065 Huntingdon Avenue, Boston', 56754, '(844) 078-4130', 1, '2012-07-09 10:44:09'),
(6, 'Tracy', 'Burton', '3 Tunisia Drive, Boston', 45678, '(822) 354-9973', NULL, '2012-07-15 08:52:55'),
(7, 'Dare', 'Nancy', '6 Hunting Lodge Way, Boston', 10383, '(833) 776-4001', 4, '2012-07-25 08:59:12'),
(8, 'Boothe', 'Tim', '3 Bloomsbury Close, Reading, 00234', 234, '(811) 433-2547', 3, '2012-07-25 16:02:35'),
(9, 'Stibbons', 'Ponder', '5 Dragons Way, Winchester', 87630, '(833) 160-3900', 6, '2012-07-25 17:09:05'),
(10, 'Owen', 'Charles', '52 Cheshire Grove, Winchester, 28563', 28563, '(855) 542-5251', 1, '2012-08-03 19:42:37'),
(11, 'Jones', 'David', '976 Gnats Close, Reading', 33862, '(844) 536-8036', 4, '2012-08-06 16:32:55'),
(12, 'Baker', 'Anne', '55 Powdery Street, Boston', 80743, '844-076-5141', 9, '2012-08-10 14:23:22'),
(13, 'Farrell', 'Jemima', '103 Firth Avenue, North Reading', 57392, '(855) 016-0163', NULL, '2012-08-10 14:28:01'),
(14, 'Smith', 'Jack', '252 Binkington Way, Boston', 69302, '(822) 163-3254', 1, '2012-08-10 16:22:05'),
(15, 'Bader', 'Florence', '264 Ursula Drive, Westford', 84923, '(833) 499-3527', 9, '2012-08-10 17:52:03'),
(16, 'Baker', 'Timothy', '329 James Street, Reading', 58393, '833-941-0824', 13, '2012-08-15 10:34:25'),
(17, 'Pinker', 'David', '5 Impreza Road, Boston', 65332, '811 409-6734', 13, '2012-08-16 11:32:47'),
(20, 'Genting', 'Matthew', '4 Nunnington Place, Wingfield, Boston', 52365, '(811) 972-1377', 5, '2012-08-19 14:55:55'),
(21, 'Mackenzie', 'Anna', '64 Perkington Lane, Reading', 64577, '(822) 661-2898', 1, '2012-08-26 09:32:05'),
(22, 'Coplin', 'Joan', '85 Bard Street, Bloomington, Boston', 43533, '(822) 499-2232', 16, '2012-08-29 08:32:41'),
(24, 'Sarwin', 'Ramnaresh', '12 Bullington Lane, Boston', 65464, '(822) 413-1470', 15, '2012-09-01 08:44:42'),
(26, 'Jones', 'Douglas', '976 Gnats Close, Reading', 11986, '844 536-8036', 11, '2012-09-02 18:43:05'),
(27, 'Rumney', 'Henrietta', '3 Burkington Plaza, Boston', 78533, '(822) 989-8876', 20, '2012-09-05 08:42:35'),
(28, 'Farrell', 'David', '437 Granite Farm Road, Westford', 43532, '(855) 755-9876', NULL, '2012-09-15 08:22:05'),
(29, 'Worthington-Smyth', 'Henry', '55 Jagbi Way, North Reading', 97676, '(855) 894-3758', 2, '2012-09-17 12:27:15'),
(30, 'Purview', 'Millicent', '641 Drudgery Close, Burnington, Boston', 34232, '(855) 941-9786', 2, '2012-09-18 19:04:01'),
(33, 'Tupperware', 'Hyacinth', '33 Cheerful Plaza, Drake Road, Westford', 68666, '(822) 665-5327', NULL, '2012-09-18 19:32:05'),
(35, 'Hunt', 'John', '5 Bullington Lane, Boston', 54333, '(899) 720-6978', 30, '2012-09-19 11:32:45'),
(36, 'Crumpet', 'Erica', 'Crimson Road, North Reading', 75655, '(811) 732-4816', 2, '2012-09-22 08:36:38'),
(37, 'Smith', 'Darren', '3 Funktown, Denzington, Boston', 66796, '(822) 577-3541', NULL, '2012-09-26 18:08:45');
create table members(
    memid integer,
    surname character varying(200),
    firstname character varying(200),
    address character varying(300),
    zipcode integer,
    telephone character varying(20),
    recommendedby integer,
    joindate timestamp
);

create table cd.bookings(
    facid integer,
    memid integer,
    starttime timestamp,
    slots integer
);

create table cd.facilities (
    facid integer,
    name character varying(100),
    memercost numeric,
    guestcost numeric,
    initialoutlay numeric,
    monthlymaintenance numeric
);


with recursive recommenders(recommender, member) as (
	select recommendedby, memid
		from members
	union all
	select mems.recommendedby, recs.member
		from recommenders recs
		inner join members mems
			on mems.memid = recs.recommender
)
select recs.member member, recs.recommender, mems.firstname, mems.surname
	from recommenders recs
	inner join members mems
		on recs.recommender = mems.memid
	where recs.member = 22 or recs.member = 12
order by recs.member asc, recs.recommender desc