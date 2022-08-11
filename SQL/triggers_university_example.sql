--
--  Triggers to maintain Branch assets as
--    sum of Account balances at that branch
--
-- function to fix Branch assets when new account added
--
create or replace function
   include_new_customer_assets() returns trigger
as $$
begin
   update Branches
   set    assets = assets + new.balance
   where  location = new.branch;
   return new;
end;
$$ language plpgsql;

--
-- set trigger to invoke function when new Account tuple inserted
--
create trigger new_assets
after insert on Accounts
for each row execute
procedure include_new_customer_assets();


-- function to adjust Branch assets for cases:
-- * customer deposits funds into account
-- * customer withdraws funds from account

create or replace function
   update_customer_assets() returns trigger
as $$
begin
   update Branches
   set    assets = assets - old.balance
   where  location = old.branch;
   
   update Branches
   set    assets = assets + new.balance
   where  location = new.branch;
   return new;
end;
$$ language plpgsql;

--
-- set trigger to invoke function when Account tuple updated
--
create trigger changed_assets
after update on Accounts
for each row execute
procedure update_customer_assets();


-- Populate Accounts table

insert into Accounts values ('Adam',   'Coogee',   1000.00);
insert into Accounts values ('Adam',   'UNSW',     2000.00);
insert into Accounts values ('Bob',    'UNSW',      500.00);
insert into Accounts values ('Chuck',  'Clovelly',  660.00);
insert into Accounts values ('David',  'Randwick', 1500.00);
insert into Accounts values ('George', 'Maroubra', 2000.00);
insert into Accounts values ('Graham', 'Maroubra',  400.00);
insert into Accounts values ('Greg',   'Randwick', 9000.00);
insert into Accounts values ('Ian',    'Clovelly', 5500.00);
insert into Accounts values ('Jack',   'Coogee',    500.00);
insert into Accounts values ('James',  'Clovelly', 2700.00);
insert into Accounts values ('Jane',   'Maroubra',  350.00);
insert into Accounts values ('Jenny',  'Coogee',   4250.00);
insert into Accounts values ('Jill',   'UNSW',     5000.00);
insert into Accounts values ('Jim',    'UNSW',     2500.00);
insert into Accounts values ('Joe',    'UNSW',      900.00);
insert into Accounts values ('John',   'UNSW',     5000.00);
insert into Accounts values ('Keith',  'UNSW',      880.00);
insert into Accounts values ('Steve',  'UNSW',     1500.00);
insert into Accounts values ('Tony',   'Coogee',   2500.00);
insert into Accounts values ('Victor', 'UNSW',      250.00);


update Accounts set balance = 50 where holder = 'Adam' and branch = 'UNSW';
update Accounts set balance = 250000 where holder = 'Greg' and branch = 'Randwick';
update Accounts set balance = 0 where holder = 'Chuck' and branch = 'Clovelly';


