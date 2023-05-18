-- sales data analysis 
select * from sales_data;

-- checking unique values

select distinct status from sales_data;
select distinct year_id from sales_data;
select distinct productline from sales_data;
select distinct country from sales_data;
select distinct territory from sales_data;

-- analyzing the data
-- grouping sales by productline
select productline, round(sum(sales)) as total_sales from sales_data
group by productline
order by sum(sales) desc;

-- grouping by year_id
select year_id , round(sum(sales)) as total_sales_by_year
from sales_data
group by year_id
order by sum(sales) desc;

-- grouping by dealsize
select dealsize, round(sum(sales)) as total_sales_by_dealsize
from sales_data
group by dealsize
order by sum(sales) desc;

-- the best month for sales in a specific year, How much was earned that month
select month_id, round(sum(sales)) as total_sales, count(ordernumber) as no_of_orders
from sales_data
where year_id  = 2004
group by month_id
order by sum(sales) desc;

-- The highest sale happened in the month of november,what product do they sell in november 
select month_id, productline, round(sum(sales)) as total_sales, count(ordernumber)
from sales_data
where year_id = 2004 and month_id = 11
group by month_id, productline
order by sum(sales) desc;

-- the best product in United States

select country,year_id, productline as top_products,round(sum(sales)) as revenue
from sales_data
where country = 'usa'
group by country,year_id, productline
order by sum(sales) desc;

select * from sales_data;

-- top 5 country that made  highest_sale
select country, max(sales) as highest_sale
from sales_data
group by country
order by max(sales)
limit 5;




