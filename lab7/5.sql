--a
create unique index account_index on accounts(customer_id, currency);
--b
create index currency_balance_index on accounts(currency, balance);