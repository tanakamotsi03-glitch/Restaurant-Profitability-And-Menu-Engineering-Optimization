-- PHASE 2: Exploratory Data Analysis

select * from
pos_sales_clean_Data;

SELECT DISTINCT restaurant_location
FROM pos_sales_clean_Data;

/* Business Operation Period*/
SELECT
MIN(`timestamp`) AS Start_Date,
MAX(`timestamp`) AS End_Date
FROM pos_sales_clean_Data;

/*Highest and Lowest item Price*/
Select
max(unit_price) as Highest_Price,
min(unit_price) as Minimum_Price
from pos_sales_clean_Data;

/*Revenue By Location*/
Select restaurant_location, round(sum(total_amount),2)
from pos_sales_clean_data
group by  restaurant_location
order by 2 desc
;

/*Top 10 Selling Items*/
Select item_name, sum(quantity) Quantity_Sold
from pos_sales_clean_data
group by item_name
order by 2 desc
limit 10
;
/*Top Revenue Items*/
Select item_name, round(sum(total_amount),2) Total_Revenue
from pos_sales_clean_data
group by item_name
order by 2 desc
;

/*Revenue By Month*/
With monthly_Revenue as (
Select 
month(`timestamp`) month_number, monthname(`timestamp`) `Month`, `timestamp`, total_amount
from pos_sales_clean_data
), 
Revenue_By_Month as (
select month_number, `Month`,
round(sum(total_amount),2) Total_Revenue
from monthly_Revenue
group by month_number, `Month`
order by 1 
), 

/*Percentage Monthly Increase*/
previous_revenue as (
Select *,
lag(Total_Revenue,1,0) over() as Previous_Month_Revenue
from Revenue_By_Month
)
select *,
(round(
	((Total_Revenue - Previous_Month_Revenue)/Previous_Month_Revenue)*100
,2)) as Growth_Increase
from 
previous_revenue;

/*Percentage Growth Increase (Orders)*/
With monthly_Orders as (
Select 
month(`timestamp`) month_number, monthname(`timestamp`) `Month`, `timestamp`, order_id
from pos_sales_clean_data
)
select month_number, `Month`,
count(order_id) orders
from monthly_Orders
group by month_number, `Month`
order by 1 
;

/* Total Orders, Menu Items, Items Sold and Total Revenue and Average Order Value */
With Operations as (

select 
count(distinct order_id) as Total_Orders,
count(distinct item_name) Menu_Items,
sum(quantity) AS Total_Items_Sold,
round(sum(total_amount),2) as Total_Revenue_$
from pos_sales_clean_Data
)
select *,
Round(Total_Revenue_$/Total_Orders,2) as AOV,
Round(Total_Items_Sold/Total_Orders,2) as Items_Per_Order,
Round(Total_Revenue_$/Total_Items_Sold,2) as Average_Item_Price_$
from Operations
;
