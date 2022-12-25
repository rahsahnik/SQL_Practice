
with cte as 
(
select b.Time as buy_time,b.Qty as buy_qty,s.Qty as sell_qty, 
sum(b.Qty) over(order by b.time) as BUY_QTY_RUN_TOTAL,
coalesce(sum(b.Qty) over(order by b.time rows between unbounded preceding and 1 preceding),0) as BUY_QTY_RUN_TOTAL_PREV -- we can use isnull also 
from buy b
join sell s on b.Date=s.Date and  b.Time<s.Time
)
select buy_time,
case when sell_qty>=BUY_QTY_RUN_TOTAL then buy_qty
else sell_qty-BUY_QTY_RUN_TOTAL_PREV end as buy_qty ,
case when sell_qty>=BUY_QTY_RUN_TOTAL then buy_qty
else sell_qty-BUY_QTY_RUN_TOTAL_PREV end as sell_qty
from cte
union all
select buy_time,BUY_QTY_RUN_TOTAL-sell_qty as buy_qty,
null as sell_qty
from cte where sell_qty<BUY_QTY_RUN_TOTAL ;