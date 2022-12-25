-- select * from tasks;
with cte as 
(
select *,
sum(case when (state ='success' and prev_state='fail') or (state ='fail' and prev_state='success')  then 1 else 0 end) over (order by date_value) gk
from(
select date_value,state,lag(state,1,state) over() prev_state
from tasks )sub
)
select min(date_value) as start_time,max(date_value) as end_time , state
from cte
group by gk;

