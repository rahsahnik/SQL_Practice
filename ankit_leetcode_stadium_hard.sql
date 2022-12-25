with 
cte as(
select id,visit_date,no_of_people,
lag(no_of_people) over(order by visit_date) as previous_day,
lead(no_of_people) over (order by visit_date) as next_day
from stadium 
),
cte2 as
(select id from cte
where no_of_people>100 and previous_day>100 and next_day>100)

select  
id,visit_date,no_of_people from stadium
where id in(
select id from cte2
union
select id-1 from cte2
union
select id+1 from cte2
);


-- select id-1 from cte
-- where no_of_people>100 and previous_day>100 and next_day>100
-- union
-- select id from cte
-- where no_of_people>100 and previous_day>100 and next_day>100
-- union
-- select id+1 from cte
-- where no_of_people>100 and previous_day>100 and next_day>100  