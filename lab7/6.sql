do $$
declare
    src varchar = 'DK12000';
    dst varchar = 'NT10204';
    src_balance integer = (select balance from accounts where account_id = src);
    src_limit integer = (select accounts.limit from accounts where account_id = src);
    tr_id integer = (select max(id) from transactions)+1;
    amount integer = 100;
begin
    insert into transactions values (tr_id, current_timestamp, src, dst, amount, 'init');
    update accounts set balance = balance + amount where account_id = dst;
    update accounts set balance =balance - amount where account_id = src;
    if src_balance - amount < src_limit then
        rollback; -- delete all previous code
        insert into transactions values (tr_id, current_timestamp, src, dst, amount, 'rollback');
    else
        update transactions set status = 'commit' where id = tr_id;
    end if;
    commit;
end $$