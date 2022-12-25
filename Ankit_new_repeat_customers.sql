 --  Other efficient solution
 SELECT order_date, 
SUM(CASE WHEN rn=1 THEN 1 ELSE 0 END) as new_customers, 
SUM(CASE WHEN rn>1 THEN 1 ELSE 0 END) as repeat_customers
FROM
(SELECT customer_id, order_date,
ROW_NUMBER() OVER (PARTITION BY customer_id order BY order_date) as rn
FROM customer_orders) A
GROUP BY order_date ORDER BY order_date;

-- My solution
with cte as(
select order_date  ,customer_id,
row_number() over(partition by customer_id order by order_date) rn
from customer_orders
),
cte2 as(
select * , count(customer_id) as new_customer from cte where rn=1 
group by order_date
)
select cte2.order_date,cte2.new_customer,(x.total_customer-cte2.new_customer) as Repeating_customers
from cte2 join (select order_date,count(customer_id) as total_customer from customer_orders group by order_date) x
on cte2.order_date=x.order_date
;
