select s.name from student s
left join attend a on s.id=a.id
where s.id not in (
select a.id from lecture l
join attend a
on l.lecid=a.lecid
where l.name='joseph'
)
and  
a.lecid in (select lecid from lecture where name='john' )
group by s.name 
having count(s.id)= (select count(lecid) from lecture where name='john');

-- select * from student;
-- select * from lecture;
-- select * from attend;

-- select name from student where
-- id not in (
-- select a.id from lecture l
-- join attend a
-- on l.lecid=a.lecid
-- where l.name='joseph') 
-- group by name
-- having count(id)=(select count(lecid) from lecture where name='john');







