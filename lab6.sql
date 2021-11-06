--- task 1

select * from
dealer cross join client;

select dealer.name, c.name, c.location, c.priority, sell.id, sell.date, sell.amount from
dealer inner join client c on dealer.id = c.dealer_id
inner join sell on dealer.id = sell.dealer_id and c.id = sell.client_id

select dealer.id, c.id, dealer.name, c.name, c.city from
dealer inner join client c on c.city = dealer.location;

select sell.id, sell.amount, c.name, dealer.location from
dealer inner join client c on dealer.id = c.dealer_id
inner join sell on dealer.id = sell.dealer_id and c.id = sell.client_id
WHERE sell.amount >= 100.0 and sell.amount <= 500.0;

select id, name from dealer;

select c.name, c.city, dealer.name, dealer.charge * sell.amount as comission from
dealer inner join client c on dealer.id = c.dealer_id
inner join sell on dealer.id = sell.dealer_id and c.id = sell.client_id;

select c.name, c.city, dealer.name, dealer.charge * sell.amount as comission from
dealer inner join client c on dealer.id = c.dealer_id
inner join sell on dealer.id = sell.dealer_id and c.id = sell.client_id
WHERE dealer.charge > 0.12;

select c.name, c.city, sell.date, sell.amount, dealer.name, dealer.charge * sell.amount as comission from
dealer inner join client c on dealer.id = c.dealer_id
inner join sell on dealer.id = sell.dealer_id and c.id = sell.client_id;

select c.name, c.priority, dealer.name, sell.id, sell.amount as temp from
dealer inner join client c on dealer.id = c.dealer_id
inner join sell on dealer.id = sell.dealer_id and c.id = sell.client_id
WHERE sell.amount < 2000 OR (sell.amount > 2000 and c.priority is not NULL);


--- task 2
-- drop view v1;
create view v1 as
select sell.date, count(c.name), avg(sell.amount), sum(sell.amount) from
sell inner join client c on c.id = sell.client_id
group by (sell.date)
order by sell.date
;
select * from v1;

create view v2 as
select sell.date, count(c.name), avg(sell.amount), sum(sell.amount) from
sell inner join client c on c.id = sell.client_id
group by (sell.date)
order by sum(-sell.amount)
;
select * from v2 limit 5;

create view v3 as
select d.id, count(sell.id), sum(sell.amount), avg(sell.amount) from
sell inner join dealer d on d.id = sell.dealer_id
group by d.id;
select * from v3;

drop view v4;
create view v4 as
select count(sell.dealer_id), sum(sell.amount), avg(sell.amount), sum(sell.amount * d.charge) as total from
sell inner join dealer d on d.id = sell.dealer_id
group by d.location;
select * from v4;

create view v5 as
select count(sell.id), sum(sell.amount), avg(sell.amount) from
sell inner join dealer d on d.id = sell.dealer_id
group by d.location;
select * from v5;
drop view v5;

create view v6 as
select c.city, count(sell.id), avg(sell.amount), sum(sell.amount) from
sell inner join client c on c.id = sell.client_id
group by (c.city);
-- order by sum(-sell.amount)
select * from v6;
drop view v6;


-- drop view v5, v6;
create view v5 as
select d.location, count(sell.id), sum(sell.amount) as plus, avg(sell.amount) from
sell inner join dealer d on d.id = sell.dealer_id
group by d.location;
-- select * from v5;
-- drop view v5;

create view v6 as
select c.city, count(sell.id), avg(sell.amount), sum(sell.amount) as minus from
sell inner join client c on c.id = sell.client_id
group by (c.city);


select * from
v5 right join v6 v on v5.location = v.city
where v5.plus < v.minus or (v5.location is null and v.city is not null);


