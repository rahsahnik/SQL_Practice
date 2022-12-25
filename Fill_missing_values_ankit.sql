select * from brands;
-- with cte as(
-- select *,
-- row_number() over(order by (select null)) as rnum
--  from brands),
--  cte2 as (
--  select *,
--  lead(rnum,1) over(order by rnum) as next_rn
--  from cte where category is not null ) 
--  select cte2.category,cte.brand_name from cte
-- inner join cte2 on cte.rnum>=cte2.rnum and (cte.rnum<=cte2.next_rn-1  or cte2.next_rn is null) ;

with cte as (select *,row_number() over() as rowed from brands),
cte2 as (
select *
,sum(case when category is not null then 1 else 0 end) over(order by rowed) as grouped
from cte)
select max(category) over (partition by grouped),brand_name 
from cte2;








 






 
