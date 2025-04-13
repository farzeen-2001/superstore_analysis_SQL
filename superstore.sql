
rename table `sample - superstore`
to `sample_superstore`;

select * from sample_superstore;

ALTER TABLE sample_superstore
ADD COLUMN order_date_parsed DATE;

UPDATE sample_superstore
SET order_date_parsed = 
  CASE
    WHEN `Order Date` LIKE '%/%' THEN STR_TO_DATE(`Order Date`, '%m/%d/%Y')
    WHEN `Order Date` LIKE '%-%' THEN STR_TO_DATE(`Order Date`, '%m-%d-%Y')
    ELSE NULL
  END;
  
ALTER TABLE sample_superstore DROP COLUMN `Order Date`;
ALTER TABLE sample_superstore CHANGE order_date_parsed `Order Date` DATE;


ALTER TABLE sample_superstore
ADD COLUMN ship_date_parsed DATE;

UPDATE sample_superstore
SET ship_date_parsed = 
  CASE
    WHEN `Ship Date` LIKE '%/%' THEN STR_TO_DATE(`Ship Date`, '%m/%d/%Y')
    WHEN `Ship Date` LIKE '%-%' THEN STR_TO_DATE(`Ship Date`, '%m-%d-%Y')
    ELSE NULL
  END;
  
ALTER TABLE sample_superstore DROP COLUMN `Ship Date`;
ALTER TABLE sample_superstore CHANGE ship_date_parsed `Ship Date` DATE;



-- Total Sales,proft,quantity,discount,profit margin 
select round(sum(Sales)) as Total_Sales,
round(sum(Profit)) as Total_profit,
round(sum(quantity)) as Total_quantity,
round(avg((Discount))*100) as Average_discount,
round((sum(profit)/sum(sales))*100) as Profit_margin
from sample_superstore;

-- Sales by region
select region , round(sum(Sales)) as Sales_by_region
from sample_superstore
group by region;

-- Top 5 sub categories by sales
select sub_category,round(sum(Sales)) as Sales_by_subcategory
from sample_superstore
group by Sub_Category
order by sales_by_subcategory desc 
limit 5;
 
-- segment by sales and profit
select segment,
round(sum(sales)) as Segment_wise_sales
from sample_superstore
group by Segment;

-- state wise profit
select State,
round(sum(profit)) as State_wise_profit
from sample_superstore
group by State
order by State_wise_profit desc
limit 5;

-- category giving sales
select Category,
round(sum(sales)) as category_wise_sales
from sample_superstore
group by Category
order by category_wise_sales desc;

-- least performing city
select city,Segment,
round(sum(sales)) as city_wise_sales
from sample_superstore
group by City,segment
order by city_wise_sales asc
limit 5;


-- number of orders
select `Ship Mode`, count(distinct(`Order ID`)) as No_of_orders
from sample_superstore
group by `Ship Mode`;

-- avg delivery time
select round(avg(datediff(`Ship Date`,`Order Date`)),2) as Avg_delivery_time
from sample_superstore; 

-- product by sales and profit
select `Product Name`,
round(sum(Sales)) as Total_Sales,
round(sum(Profit)) as Total_profit
from sample_superstore
group by `Product Name`
order by Total_Profit desc
;
 
-- unique customer id by region
select region,count(distinct(`Customer ID`)) as Customer_by_region
from sample_superstore
group by Region
order by Customer_by_region desc; 
