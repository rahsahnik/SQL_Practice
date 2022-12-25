use practice;
select * from sales;

 SELECT a.order,sum(b.amount)
   FROM   sales a
    join  sales b
    on a.order>= b.order
	GROUP BY a.order
    ORDER BY a.order;
    
    select `order`,
    sum(amount) over(order by `order`)sm
    from sales;
    
-- set @rnum=0 ;
set @count:=0;
select @count:=@count+1, @rnum:=(select cname from client limit 0,1) as r_count  from client;