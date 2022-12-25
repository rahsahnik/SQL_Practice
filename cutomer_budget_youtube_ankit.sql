
select * from products;
select * from customer_budget;

with cte as(
select * ,
sum(cost) over(order by cost asc) run_cost
from products)
select customer_id,budget,count(1) as no_of_products,group_concat(product_id) as List_of_products
from customer_budget c
join cte ct on ct.run_cost< c.budget
group by customer_id
order by customer_id,budget;