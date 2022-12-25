-- select * from event_status;

with cte as (
select  *,
sum(case when status = 'on' and  prev_status ='off' then 1 else 0 end) over(order by event_time) as group_key
from (
select  event_time,status ,
lag(status,1,status) over() prev_status
from event_status) sub
)
select min(event_time) as login,max(event_time) as logout , count(*)-1 as Count_of_status
from cte
group by group_key
  ;
  
 