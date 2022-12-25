-- select * from sachin_batting_scores;

with cte as(
select Match_no,Innings,Runs,
sum(Runs) over(order by Match_no ) as Running_Sum
from sachin_batting_scores),
cte2 as (
select min(case when Running_Sum >=1000 AND  Running_Sum <5000 then Running_Sum end ) as Milestone_score from cte
union all
select min(case when Running_Sum >=5000 AND  Running_Sum <10000 then Running_Sum end ) as Milestone_score from cte
union all
select min(case when Running_Sum >=10000 AND  Running_Sum <15000 then Running_Sum end ) as Milestone_score from cte
union all
select min(case when Running_Sum >=15000 AND  Running_Sum <20000 then Running_Sum end ) as Milestone_score from cte)

select cte.Match_no,cte.Innings,cte2.Milestone_score as Runs_Scored ,
floor((cte2.Milestone_score/1000))*1000 as Milestone_score 
from cte
join cte2 on cte.Running_Sum=cte2.Milestone_score
;

--  Other person Query

WITH CTE AS(
SELECT Match_no,Innings,runs,
floor(SUM(runs)OVER(ORDER BY Match_no)/1000.0)*1000 AS milestone_runs
FROM  Sachin_batting_Scores)

SELECT ROW_NUMBER()OVER(ORDER BY milestone_runs) AS milestone_number,
min(Match_no)AS milestone_match,min(Innings) AS milestone_innings,milestone_runs
FROM CTE
WHERE milestone_runs IN(1000,5000,10000)
GROUP BY milestone_runs;

-- OTHER QUERY 

WITH t1 AS(
SELECT *,SUM(runs) OVER (ORDER BY match_no) as milestone
FROM sachin_batting_scores),
cte2 as (
SELECT match_no,innings,milestone as runs,
CASE WHEN milestone>=1000  AND milestone<=4999  THEN "First"
WHEN milestone>=5000 AND milestone<=9999 THEN "SECOND"
WHEN milestone>=10000 AND milestone<=14999 THEN "Third"
WHEN milestone>=15000 AND milestone<=19999 THEN "Fourth"
ELSE "Zero" END AS milestone_name
FROM t1)
select *,floor(runs/1000)*1000 as Milestone_number from cte2
WHERE milestone_name!="Zero"
GROUP BY milestone_name
ORDER BY runs;
