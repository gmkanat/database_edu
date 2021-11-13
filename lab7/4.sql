create type new_type as (a char(5));
alter table accounts alter column currency type new_type using currency::new_type;