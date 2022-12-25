with cte as (
select s.id as sid,s.name as sname,t.id as tid,t.name as tname from source s
left join target t
on s.id=t.id
union 
select * from source s
right join target t
on s.id=t.id )
select sid as id, 'New in source' as comment from cte where tid is null
union
select tid,'New in target' as comment from cte where sid is null
union
select sid ,'Mismatch' as comment from cte where sid=tid and sname <> tname 
order by 1
;


