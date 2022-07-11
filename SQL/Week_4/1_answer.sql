
create or replace function
   LowestPriceAt(_bar text) returns float
as $$
   select min(price) from Sells where bar = _bar;
$$ language sql;

select * from Sells where price = LowestPriceAt('Marble Bar');



