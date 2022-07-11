-- The Q4 view must have attributes called (team1,team2,matches)

drop view if exists MatchDetails;
create view MatchDetails
as
select m.id as matchid,
        t1.id as team1id, t1.country as team1,
        t2.id as team2id, t2.country as team2,
        m.city, m.playedOn
from   Matches m
        join Involves i1 on (m.id = i1.match)
        join Involves i2 on (m.id = i2.match)
        join Teams t1 on (i1.team = t1.id)
        join Teams t2 on (i2.team = t2.id)
where  t1.country < t2.country
;

drop view if exists TeamVsTeam;
create view TeamVsTeam
as
select team1, team2, count(*) as matches
from   MatchDetails
group  by team1, team2
;

select team1, team2, matches
from   TeamVsTeam
where  matches = (select max(matches) from TeamVsTeam);

