select * from business_city;
use practice;

insert into business_city
values(cast('2022-01-02' as date),7);
-- Ankit solution

select left(a.business_date,4) as Year ,count(case when b.business_date is null then a.city_id end  )new_city_count 
from business_city a
left join business_city b
on a.city_id=b.city_id  and a.business_date>b.business_date
group by 1;

-- My soln

with cte as 
(
select business_date,city_id,
row_number() over(partition by city_id order by left(business_date,4)) as rnum
from business_city )

select  left(business_date,4) as Year ,count(rnum) as no_of_new_city from cte
where rnum=1
group by 1
order by 1;