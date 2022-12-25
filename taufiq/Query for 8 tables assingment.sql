-- Calculate the average rating given by students to each teacher for each session created. 
-- Also, provide the batch name for which session was conducted.

select b.id as Batch_ID,a.session_id as Session_ID ,round(avg(a.rating),2) as Rating 
from batches b 
left join sessions s     on b.id=s.batch_id
left join  attendances a on s.id=a.session_id
group by 2,1
order by 1,3 desc ;

