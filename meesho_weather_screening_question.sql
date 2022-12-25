select * from country;
select * from state;
select * from weather_stats ;

select s.name as State,c.name as Country,
avg(w.humidity) as Average_humidity,
case
	when avg(w.temperature)<15 then 'COLD'
    when avg(w.temperature)<30 then 'WARM'
    when avg(w.temperature)>=30 then 'HOT'
end as  Average_temperature
from country c join state s on c.id=s.country_id
join weather_stats w on s.id=w.state_id
where record_date between '2018-10-01' AND '2018-10-31'
group by s.name
order by 3 desc, 1 asc;