-- other person soution
-- WITH CTE AS
-- (
-- SELECT *,left(seat,1) as Row_No, SUBSTRING(seat,2,2) as Seat_int FROM movie 
-- )
-- , CTE1 AS( 
-- SELECT * , ROW_NUMBER() OVER(PARTITION BY Row_No ORDER BY Seat_int ) as rn1,
-- Seat_int - ROW_NUMBER() OVER(PARTITION BY Row_No ORDER BY Seat_int ) as rn FROM CTE WHERE occupancy = 0
-- )
-- , 
-- CTE2 AS (
-- SELECT *, COUNT(*) OVER(PARTITION BY rn,row_no ORDER BY rn) as cnt FROM CTE1 
--   )
--   SELECT * FROM CTE2  WHERE Cnt >= 4
  
  -- Ankit solution
  WITH cte1 AS
(
SELECT *,left(seat,1) as row_id, SUBSTRING(seat,2,2) as Seat_id FROM movie 
),
 cte2 as
(
select *,
max(occupancy) over (partition by row_id  rows between current row and 3 following) as is_4_rows_empty,
count(occupancy) over (partition by row_id  rows between current row and 3 following) as cnt
from cte1
),
cte3 as
(
select * from cte2 where is_4_rows_empty=0 and cnt=4 )

select cte2.* from cte2 
join cte3 on cte2.row_id=cte3.row_id  and cte2.seat_id between cte3.seat_id and cte3.seat_id+3;