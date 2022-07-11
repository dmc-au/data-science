-- The Q5 view must have attributes called (team,reds,yellows)

drop view if exists CardsFor;
create view CardsFor
as
select t.country as team, c.cardtype, count(c.cardtype) as cards
from   Players p
		join Teams t on (p.memberof = t.id)
		join Cards c on (c.givento = p.id)
group  by t.country, c.cardtype
;

drop view if exists RedCardsFor;
create view RedCardsFor
as
select t.country as team, c.cardtype, count(c.cardtype) as cards
from   Players p
		join Teams t on (p.memberof = t.id)
		join Cards c on (c.givento = p.id)
where  c.cardtype='red'
group  by t.country, c.cardtype
;

drop view if exists RedCards;
create view RedCards
as
select t.country as team, coalesce(c.cards,0) as cards
from   Teams t left outer join RedCardsFor c on (t.country=c.team)
;

drop view if exists YellowCardsFor;
create view YellowCardsFor
as
select t.country as team, c.cardtype, count(c.cardtype) as cards
from   Players p
        join Teams t on (p.memberof = t.id)
        join Cards c on (c.givento = p.id) 
where  c.cardtype='yellow'
group  by t.country, c.cardtype
;

drop view if exists YellowCards;
create view YellowCards
as
select t.country as team, coalesce(c.cards,0) as cards
from   Teams t left outer join YellowCardsFor c on (t.country=c.team)
;

select r.team as team, r.cards as reds, y.cards as yellows
from   RedCards r join YellowCards y on (r.team=y.team);
