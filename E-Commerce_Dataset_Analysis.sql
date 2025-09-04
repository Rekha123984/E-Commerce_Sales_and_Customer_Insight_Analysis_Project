-- Checked Null

select * from Customers
where Customer_Id is null
    or Customer_Name is null
	or Gender is null
	or Age is null
	or Location is null
	or Customer_Join_Date is null
	or Customer_Join_Year is null
	or Loyalty_Status is null;

select * from Order_Details
where Order_Detail_Id is null
    or Order_Id is null
	or Product_Id is null
	or Quantity is null
	or Unit_Price is null
	or Discount is null
	or Discount_Status is null
	or Total_Amount is null;

select * from Orders
where Order_Id is null
    or Customer_Id is null
	or Order_Date is null
	or Order_Week is null
	or Order_Month is null
	or Order_Year is null
	or Order_Status is null
	or Payment_Id is null;

select * from Payments
where Payment_Id is null
    or Order_Id is null
	or Payment_Method is null
	or Payment_Status is null
	or Payment_Date is null
	or Amount_Paid is null;

select * from Products
where Product_Id is null
    or Product_Name is null
	or Category is null
	or Sub_Category is null
	or Brand is null
	or Price is null
	or Stock_Quantity is null;
	
/*
Finding & Observation
Checked all tables and columns, no NULL values found.  
Data is complete and reliable for further analysis. 
*/


-- Checked Duplicates

select Customer_Id, count(*) as Duplicate_Values from Customers
    group by Customer_Id having count(*)>1;

select Order_Detail_Id, count(*) as Duplicate_Values from Order_Details
    group by Order_Detail_Id having count(*)>1;

select Order_Id, count(*) as Duplicate_Values from Orders
    group by Order_Id having count(*)>1;

select Payment_Id, count(*) as Duplicate_Values from Payments
    group by Payment_Id having count(*)>1;

select Product_Id, count(*) as Duplicate_Values from Products
    group by Product_Id having count(*)>1;

	
/*
Finding & Observation
-Checked all tables and columns, no Duplicate values found.  
-Data is complete and reliable for further analysis. 
*/


-- Adding Foreign Key

alter table Order_Details add constraint fk_order_details_order foreign key (Order_Id)
    references Orders (Order_Id);

alter table Order_Details add constraint fk_order_details_product foreign key (Product_Id)
    references Products (Product_Id);

alter table Orders add constraint fk_orders_customer foreign key (Customer_Id)
    references Customers (Customer_Id);

alter table Orders add constraint fk_orders_payment foreign key (Payment_Id)
    references Payments (Payment_Id);

alter table Payments add constraint fk_payments_order foreign key (Order_Id)
    references Orders (Order_Id);

/*
Finding & Observation
-Added Foreign Key to the tables 
*/


-- Total Customer

select count(*) as Total_Customer from Customers;

/*
Finding & Observation
-Total Customer is 20000
*/


-- Total Orders

select count(*) as Total_Order from Orders;

/*
Finding & Observation
-Total Order is 100000
*/


--Customer Gender Distribution

select Gender, count(*) as Customers from Customers group by Gender order by Customers desc;

/*
Finding & Observation
-Male customers (10,070) slightly outnumber Female customers (9,930).  
-The distribution is nearly balanced, indicating no major gender dominance.  
-Marketing strategies can be designed to target both genders equally.  
*/


-- Frequently using Payment Method

select Payment_Method, count(*) as Total_Orders from Payments
    group by Payment_Method order by Total_Orders desc;

/*
Findings & Observations
-Credit Card is the most frequently used payment method with 25,215 orders.  
-UPI (25,007), COD (24,968), and PayPal (24,810) follow closely, showing 
that all four payment methods are almost equally preferred by customers.
*/

 
-- Total Billed Amount

select sum(Total_Amount) as Total_Billed_Amount from  Order_Details;

/*
Finding & Observation
-The total billed order amount is 115,285,572.81
*/


-- Total Revenue

select sum(p.Amount_Paid) as Total_Revenue from Payments p
    join Orders o on p.Order_Id=o.Order_Id
	where p.Payment_Status = 'Successful';


/*
Finding & Observation
-The Total Revenue is 42,674,414.60
-The total billed order amount is 115,285,572.81,
whereas the actual revenue collected is 42,674,414.60.
-This indicates a significant gap (~63% uncollected), suggesting issues such as cancellations,
returns, or unpaid invoices.
*/


-- Total Customer per Customer Join Year

select Customer_Join_Year, count(*) as Total_Customer from Customers
    group by Customer_Join_Year order by Total_Customer desc;

/*
Finding & Observation
-Between 2018 and 2020, customer acquisition was strong, 
with annual customer counts ranging from 3,659 (2018) 
to 3,692 (2020).
-In contrast, the number of new customers dropped 
significantly in 2023, reaching only 723 customers.
-This represents a sharp decline compared to previous years, 
which may indicate a change in business strategy, market 
conditions, or customer engagement.
*/


-- Weekly Order Distribution

select Order_Week, count(*) as Total_Orders from Orders
    group by Order_Week order by Total_Orders desc;

/*
Findings & Observations:  
-The First Week recorded the highest orders (23,516), followed by Weeks 4, 2, and 3 with 
nearly equal volumes (22.9K each).  
-The Fifth Week shows a sharp drop (7,816), likely due to shorter duration or lower activity.  
=Overall, orders are fairly consistent across the first four weeks, with Week 1 slightly leading.  
*/


-- Top 10 Locations by Number of Orders and Total Payments

select Top 10 Customers.Location, count(Orders.Order_Id) as Orders, Sum(Payments.Amount_Paid) as Payment
    from Customers
    join Orders on Customers.Customer_Id = Orders.Customer_Id
	join Payments on Orders.Payment_Id = Payments.Payment_Id
	group by Customers.Location order by Orders desc, Payment desc ;

/*
Findings & Observations
-Lake Michael has the highest number of orders (108) and the highest payments (56,875.58),
making it the top-performing location.
-East Michael (99 orders, 49,447.10 payments) and North James (92 orders, 51,261.14 payments)
follow closely, showing strong sales and revenue.
-The top 10 locations contribute significantly, with payments ranging between 34,663.17 and 56,875.58,
indicating a relatively balanced distribution across locations.
*/


--Payment Status vs Order Status Analysis 

select Payments.Payment_Status, sum(Amount_Paid) as Amount_Value,
    Orders.Order_Status,count(distinct Orders.Order_Id) as Number_of_Order from Payments
	join Orders on Payments.Order_Id=Orders.Order_Id
	group by Payments.Payment_Status,Orders.Order_Status
	order by Payments.Payment_Status desc, Amount_Value desc;

/*
Findings & Observations
- Out of total billed orders, only ~29.88M is marked as Successful & Completed 
(59,352 orders), which represents the true realized revenue. 
-A large share of "Successful" payments (~12.8M) are linked to Returned, 
Cancelled, or Pending orders — this indicates revenue leakage or unsettled transactions.    
-Refunded payments total ~2.5M across ~5,000 orders, reducing net revenue further.  
-Failed transactions account for ~5.5M across ~10,000+ orders, showing 
significant payment failures that need to be addressed.  
*/


-- Monthly Orders and Payments Analysis

select o.Order_Month, count(o.Order_Id) as Orders, sum(p.Amount_Paid) as Payments from Orders o
    join Payments p on o.Payment_Id=p.Payment_Id
	group by o.Order_Month order by Orders desc,Payments desc;

/*
Findings & Observations
-January recorded the highest orders and payments,
while months like June and September were relatively lower.  
-Overall, order volume and revenue are fairly consistent across months with seasonal peaks
in Jan and Dec.
*/


--Product Category and Sub-Category Sales Analysis

select p.Category, p.Sub_Category, count(od.Product_Id) as Total_Product_Sold,
    sum(py.Amount_Paid) as Payments from Products p
	join Order_Details od on p.Product_Id=od.Product_Id
	join Payments py on od.Order_Id=py.Order_Id
	group by Category,Sub_Category
	order by Category asc, Payments desc;

/*
Findings & Observations
-Home (Kitchen) and Clothing (Women) recorded the highest payments and product sales.  
-Beauty sub-categories (Makeup, Haircare, Skincare) show consistently strong performance.  
-Electronics and Sports also contribute significantly, highlighting diverse revenue streams.  
*/


-- Product Category and Sub-Category Stock Analysis

select Category,Sub_Category, sum(Stock_Quantity) as Total_Stock from Products
    group by Category, Sub_Category order by Category asc,Total_Stock desc;

/*
Findings & Observations
-Clothing (Women) has the highest stock availability (202K), followed by Home (Kitchen) and 
Beauty (Makeup).  
-Beauty and Electronics sub-categories show consistently high stock levels across Makeup, 
Skincare, Laptops, and Accessories.  
-Balanced stock distribution is seen across all categories, ensuring steady product availability.  
*/


--Top 5 Products by Order Count 

select Top 5 od.Product_Id,p.Sub_Category, count(*) as Total_Values from Order_Details od
    join Products p on od.Product_Id=p.Product_Id 
	group by od.Product_Id,p.Sub_Category order by Total_Values desc;

/*
Findings & Observations
-Kitchen leads with the highest order count (64), showing strong customer demand.
-Kids, Skincare, and Laptops follow closely, each having 60+ orders.
-Men’s category also ranks in the Top 5, reflecting balanced interest across essentials and lifestyle.
*/


--Customer Age Category Distribution 

select
    case
	    when Age between 1 and 17 then 'Minor'
		when Age between 18 and 25 then 'Major'
		when Age between 26 and 59 then 'Adult'
		else 'Senior' end as Age_Category,
		count(*) as Total_Customer from Customers
		group by case
		when Age between 1 and 17 then 'Minor'
		when Age between 18 and 25 then 'Major'
		when Age between 26 and 59 then 'Adult'
		else 'Senior' end
		order by Total_Customer desc;

/*
Findings & Observations
-The majority of customers fall into the "Adult" category (12,731), showing the main target group.  
-"Senior" customers (4,201) form a significant secondary segment, requiring tailored engagement.  		
-"Major" group (3,068) is smaller, while "Minor" count is negligible, indicating limited 
presence of younger customers.
*/


--Loyalty Status vs Discount Status vs Order Status

select c.Loyalty_Status,od.Discount_Status,o.Order_Status, count(*) as Total_Customers from Customers c
    join Orders o on c.Customer_Id=o.Customer_Id
	join Order_Details od on o.Order_Id=od.Order_Id
	group by c.Loyalty_Status,od.Discount_Status,o.Order_Status
	order by Loyalty_Status asc,Order_Status asc,Total_Customers desc;

/*
Findings & Observations
-Across all Loyalty tiers (Bronze, Silver, Gold), "Discounted + Completed" orders dominate (~37K each),
showing discounts drive successful conversions.  
-Cancelled, Pending, and Returned orders are significantly higher in Discounted cases compared 
to Not Discounted, indicating possible post-purchase issues linked to discounts.  
-The distribution is fairly consistent across Loyalty levels, 
suggesting that customer loyalty status does not heavily alter order outcomes compared to discounting.
*/


--Profit by Product Category (Assuming 30% Cost) 

select pr.Category,
       sum(od.Total_Amount - (od.Quantity * pr.Price * 0.7)) as Profit  -- assuming 30% cost
from Order_Details od
join Products pr on od.Product_Id = pr.Product_Id
group by pr.Category
order by Profit desc;

/*
Findings & Observations
-Beauty leads with the highest profit (5.24M), closely followed by Sports (5.22M) 
and Electronics (5.20M).  
-Home (5.05M) and Clothing (4.88M) also contribute significantly, showing balanced 
profitability across categories.  
-Profit margins are relatively close across all categories, indicating consistent performance 
without extreme outliers.  
*/


-- Comprehensive Customer, Order, Order Detail, Product, and Payment Details
select c.Customer_Id,c.Gender,c.Age,c.Location,o.Order_Id,o.Order_Week,o.Order_Month,o.Order_Year,
    o.Order_Status,od.Order_Detail_Id,od.Quantity,od.Unit_Price,od.Discount_Status,od.Total_Amount,
	py.Payment_Id,py.Payment_Method,py.Payment_Status,py.Amount_Paid,p.Product_Id,p.Category,p.Sub_Category,
	p.Price,p.Stock_Quantity from Customers c
	join Orders o on c.Customer_Id=o.Customer_Id
	join Order_Details od on o.Order_Id=od.Order_Id
	join Products p on od.Product_Id=p.Product_Id
	join Payments py on o.Order_Id=py.Order_Id;

/*
Findings & Observations
-Retrieves complete info on customers, their orders, order details, products, and payments.
-Only customers with orders and corresponding payments are included.
-Useful for analyzing sales, payment status, popular products, and customer demographics.
-Can help identify revenue trends, discount impact, and inventory status.
*/







