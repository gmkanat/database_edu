--a
    create role accountant;
    create role administrator;
    create role support;
    create role boss createrole;
    grant insert, update on accounts, transactions to accountant;
    grant insert, update on customers to administrator;
    grant select on accounts, customers, transactions to support, administrator, accountant;

--b
    create user steve_jobs;
    grant administrator to steve_jobs;
    create user elon_musk;
    grant support to elon_musk;
    create user bill_gates;
    grant accountant to bill_gates;
--c
    create user magjan;
    grant boss to magjan;
--d
    revoke update on transactions from bill_gates;
    revoke select on customers from elon_musk;