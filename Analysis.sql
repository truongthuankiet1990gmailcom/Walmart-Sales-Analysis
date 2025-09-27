-- 1. Calculate Total Sales and Profit by Category for Each Year
select Category, Year, sum(Sales) as 'Total Sum', sum(Profit) as 'Total Profit'
from dbo.Global_Superstore
group by Category, Year

-- 2. Get the Top 5 Customers by Sales
select top 5 Customer_Name, Customer_ID, SUM(Sales) as "TotalSales"
from dbo.Global_Superstore
group by Customer_Name, Customer_ID
order by "TotalSales" desc

-- 3. Calculate Monthly Sales Trend for Each Year
select year(Order_Date) as "Year", month(Order_Date) as "Month", SUM(Sales) as Monthly_Sales
from dbo.Global_Superstore
group by year(Order_Date), month(Order_Date)
order by year(Order_Date), month(Order_Date)

-- 4. Identify the Most Profitable Region and Segment
select top 1 Market2, Segment, sum(Profit) as Total_Profit
from dbo.Global_Superstore
group by Market2, Segment
order by Total_Profit desc

-- 5. Calculate Year-over-Year Growth in Sales for Each Category
with sales_per_yer as(
	select Category, Year,  sum(Sales) as Total_Sales
	from dbo.Global_Superstore
	group by Category, Year 
)
select a.Category, 
    a.Year as Current_Year, 
    a.Total_Sales as Current_Year_Sales, 
    b.Year as Previous_Year, 
    b.Total_Sales as Previous_Year_Sales, 
    ((a.Total_Sales - b.Total_Sales) * 1.0 / b.Total_Sales) * 100 AS YoY_Growth_Percentage
from sales_per_yer a
join sales_per_yer b 
on a.Category = b.Category and a.Year = b.Year + 1
order by a.Category, a.Year

-- 7. Find the Product Subcategories with Negative Profit
select 
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
from 
    dbo.Global_Superstore
group by
    "Sub_Category"
having 
    SUM(Profit) < 0
order by
    Total_Profit;
