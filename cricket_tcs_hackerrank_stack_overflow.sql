-- select * from cricket;
select Team_name, count(1) as Played,sum(Matches_flag) as Won ,
count(1)-(sum(Matches_flag) + sum(if (Matches_flag = 'draw',1,0) )) as Lost
 ,sum(if (Matches_flag = 'draw',1,0) )as Draw 
from
(
(select Team_a as Team_name ,
case when Team_a =Winner then 1 
when Winner = 'draw' then 'draw' else 0 end as Matches_flag
from cricket)
union all
(select Team_b as Team_name ,
case when Team_b=Winner then 1 
when Winner = 'draw' then 'draw'else 0 end  as Matches_flag
from cricket) 
)x
group by Team_name;

-- set SQL_SAFE_UPDATES=0;
-- update cricket set Team_a ='india'  where Match_no =2;
-- set SQL_SAFE_UPDATES=1;

