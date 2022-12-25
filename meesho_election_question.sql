SELECT PARTY,COUNT(1)
FROM CANDIDATES
WHERE ID IN
(
WITH CTE AS     (
	SELECT *,
    ROW_NUMBER() OVER(PARTITION BY CONSTITUENCY_ID ) AS RNUM
    FROM RESULTS )
      SELECT CANDIDATE_ID FROM CTE
      WHERE RNUM=1
)
GROUP BY 1
ORDER BY 2 DESC;