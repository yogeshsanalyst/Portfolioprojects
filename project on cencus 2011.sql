select * from growth;
select * from population;

-- number of rows in thde datasets
select count(*) from growth;
select count(*) from population;     -- (both the datasets contains 640 rows each)

-- Total population in india
select sum(population) from population;

--  avg growth by state comapared to previous cencus
select state,avg(growth) as avg_growth_in_population from growth
group by state;

-- avg of sex ratio
select state,round(avg(sex_ratio),2) as avg_sex_ratio from growth
group by state
order by avg(sex_ratio);

select state,round(avg(literacy),2) as avg_lit_rate 
from growth
group by state
order by avg(literacy) desc;  -- (it seems to be kerala has the highest average literacy rate)

-- top 3 state showing highest avg growth ratio
select state, round(avg(growth),2) as top_3_growth_ratio 
from growth
group by state 
order by max(growth) desc
limit 3;

-- below 3 states showing least sex ratio
select state, round(avg(sex_ratio),2) as lowest_sex_ratio
from growth
group by state 
order by avg(sex_ratio) desc
limit 3;

-- top and bottom 3 states in literacy
create table topstates (
 state varchar(255),
  topstate float
);

-- union operator
select * from
(select state,round(avg(literacy),2) as top_3_literacy
from growth
group by state
order by avg(literacy) desc
limit 3) a

union

select * from
(select state,round(avg(literacy),2) as least_3_literacy
from growth
group by state
order by avg(literacy) asc
limit 3) b;

-- joning both the tables
select g.district, g.state, p.population
from growth g 
join population p on g.district = p.district;

-- window function 
 -- top 3 districts from each state with highest literacy rate
 select g.*from
 (select district, state, literacy, rank() over (partition by state order by literacy desc) as top_3 from growth) g
 where g.top_3 in (1,2,3)
 order by state;
