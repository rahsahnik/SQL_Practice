-- select * from emp order by dep_id, salary desc;
with cte as(
select emp_id,emp_name,salary,dep_id,dep_name,
row_number() over(partition by dep_id order by salary desc) rnk,
count(*) over (partition by dep_id) cnt
from emp 
)
select emp_id,emp_name,salary,dep_id,dep_name from cte where rnk=3 or (cnt <3 and rnk=cnt);
