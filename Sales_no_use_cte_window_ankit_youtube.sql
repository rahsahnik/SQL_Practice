
-- select * from sales;
-- We can use any of the last two, as 1st one is general query and wont work on other database.

select `order`,order_date,cust_id,sale_id,max(amount)
from (select * from sales
 order by amount desc ) sub
group by sale_id;

select a.* from sales a
join sales b  on a.sale_id = b.sale_id
group by a.order,a.order_date,a.cust_id,a.sale_id,a.amount
having a.amount>=max(b.amount) ;

select * from (
select *,
row_number() over(partition by sale_id order by amount desc) rnum
from sales ) sub
where rnum=1;
