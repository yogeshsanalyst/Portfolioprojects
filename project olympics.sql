use olympics;
select * from olympic_events;
select * from olympic_regions;
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. How many olympics games have been held?
select count(distinct games)as no_of_games_held 
from olympic_events;
--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. List down all Olympics games held so far.
select distinct year,sport,season,city 
from olympic_events
order by year;
---------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Mention the total no of nations who participated in each olympics game?

select games, count(distinct region) as no_of_nations
from olympic_events oe
join olympic_regions os
on oe.noc = os.noc
group by games
order by games;
---------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Which nation has participated in all of the olympic games?

with t1 as (Select count(distinct games) as total_games
			from olympic_events),
	 t2 as (SELECT games, rg.region as country
			from olympic_events oh
			join olympic_regions rg
			on rg.noc = oh.noc
			group by games, rg.region
		order by games),
	 t3 as (select country, count(1) as total_participated_games
		    from t2
		    group by country)
Select t3.* 
from t3
join t1 on t1.total_games = t3.total_participated_games
order by 1;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Identify the sport which was played in all summer olympics.

With t1 as (select count(distinct games) as total_summer_games
			from olympic_events
			where season = 'Summer'),
	 t2 as (Select distinct sport, games
			from olympic_events
			where season = 'Summer'
			order by games),
	 t3 as (select sport, count(games) as no_of_games
		    from t2
		    group by sport)
Select *
from t3
join t1
on t1.total_summer_games = t3.no_of_games;

------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 6. Which Sports were just played only once in the olympics?

with t1 as (select distinct games, sport 
from olympic_events),
t2 as (select sport, count(games) as no_of_games
from t1 group by sport)
select t2.*,t1.games
from t2
join t1
on t2.sport = t1.sport
where t2.no_of_games =1
order by t1.games;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 7. Fetch the total no of sports played in each olympic games.
select distinct games, count(distinct sport) as no_of_sports
from olympic_events
group by games
order by count(distinct sport) desc;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- 8. Fetch oldest athletes to win a gold medal.
 with t1 as(select name,sex,age,team,games,sport,event,medal
 from olympic_events
 where medal = 'gold'),
 
 t2 as (select *, rank() over(order by age desc) as rnk
 from t1)

select * from t2
where rnk =1;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 9. Write SQL query to fetch the top 5 athletes who have won the most gold medals.

With t1 as (Select distinct name, team, count(medal) as no_of_medals
			from olympic_events
			where medal = 'Gold'
			group by name, team
			order by no_of_medals desc),
	 t2 as (Select *,
			dense_rank() over(order by no_of_medals desc) as rnk
			from t1)
select name, team, no_of_medals
from t2
where rnk <= 5;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 12. Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.

select rg.region as country, count(medal) as total_medals_won
from olympic_events oh
join olympic_regions rg
on rg.noc = oh.noc
where medal <> 'NA'
group by country
order by 2 desc
limit 5;



