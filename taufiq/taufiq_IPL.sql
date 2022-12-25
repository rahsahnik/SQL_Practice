with cte as 
(
select
row_number() over(order by team_name) rnum,
team_name as team from teams 
)
select a.team as team,b.team as opponent from cte a
join cte b on a.rnum<b.rnum
order by 1; 


-- For twice just we can use simple cross join  or seconf approach also 

-- select a.team_name as team, b.team_name as opponent from teams a
-- cross join teams b 
--  where a.team_name<>b.team_name
-- order by 1,2;

WITH matches AS
	(SELECT row_number() over(order by team_name) AS id, t.*
	 FROM teams t)
SELECT team.team_name AS team, opponent.team_name AS opponent
FROM matches team
JOIN matches opponent ON team.id <> opponent.id
ORDER BY team;