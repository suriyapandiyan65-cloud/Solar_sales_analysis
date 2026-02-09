--Q1 Find total sales for each product category.
select product_category, sum(total_sales)as Total_sales
from sales_data
group by product_category
order by Total_sales desc

--Q2 Find Year-over-Year(YoY) sales growth for each year.
select year, sum(total_sales)as Total_sales
from sales_data
group by year
order by year

--Q3 Find the top 5 best-selling products(by total revenue)
select top 5 product_category, sum(total_sales)as Total_revenue
from sales_data
group by product_category
order by Total_revenue desc

--Q4 Find monthly sales trends for the last 3 years
select DATENAME(month,date_formatted) as Month_name,month(date_formatted)as month_number,
		sum(total_sales)as Total_sales, year
from sales_data
group by DATENAME(month,date_formatted),month(date_formatted),year
order by year,month_number

select month(date_formatted)as monthly_sales, sum(total_sales)as Total_sales, year
from sales_data
group by month(date_formatted),year
order by monthly_sales, year

select format(date,'MMM yyyy') as Month_year,sum(total_sales)as Total_sales
from sales_data
group by format(date,'MMM yyyy'),month(date_formatted)
order by month(date_formatted),format(date,'MMM yyyy'),Total_sales desc

--Q5 which region generated the highest revenue?
select top 1 region,sum(total_sales)as Total_sales
from sales_data
group by region
order by Total_sales desc

--Q6 Identify the top 3 products in each region?
with item_counts as(
select region,product_category,
count(units_sold) as total_sales,
row_number() over(
		partition by region
		order by count(units_sold) desc) as item_rank
from sales_data
group by region,product_category
)
select item_rank,region,product_category,total_sales
from item_counts
where item_rank<=3

--Q7 Find underperforming product categories(sales below average)
select product_category,sum(total_sales) as Total_sales
from sales_data
group by product_category
having sum(total_sales)<(
		select avg(category_sales)
		from(
		   select sum(total_sales) as category_sales
		   from sales_data
           group by product_category) as t
		   )

--Q8 Find seasonal sales pattern(Quarter-wise performance)
select year,datepart(quarter,date_formatted) as Quarter,sum(total_sales) as Total_sales
from sales_data
group by datepart(quarter,date_formatted),year
order by year,Quarter
--Q1=Jan-Mar  Q2=Apr-June  Q3=July-Sep  Q4=Oct-Dec

--Q9 Find total units sold per year for forecasting trend
select year, sum(total_sales) as Total_units_sold
from sales_data
group by year
order by year 

--Q10 Identify days where sales crossed $1,00,000
select date,sum(total_sales) as Total_sales
from sales_data
group by date
having sum(total_sales)>100000
order by date 







