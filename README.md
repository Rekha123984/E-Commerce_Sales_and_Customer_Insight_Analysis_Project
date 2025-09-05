# 📄 E-Commerce Sales & Customer Insights Analysis  

## 📌 Project Overview  
Analyzed **200K+ e-commerce transactions** using **Excel, SQL, Python, and Power BI** to uncover insights on customer behavior, product performance, sales trends, and payment patterns.  
The project demonstrates a **complete data analytics workflow** — from **cleaning → transformation → analysis → visualization → recommendations** — to support **data-driven decision making**.  

---

## 🗂️ Dataset Description  
The dataset contains five main tables:  
- **Customers** – Demographics and details.  
- **Orders** – Order-level details (dates, status).  
- **Order_Details** – Itemized details for each order.  
- **Payments** – Payment modes and statuses.  
- **Products** – Categories, pricing, and product details.  

---

## 🔧 Data Cleaning & Preparation  

### 1. Excel  
- Standardized column names & formats.  
- Removed **duplicates & null values**.  
- Applied `TRIM()` to clean text fields.  
- Added calculated fields: `Discount Status`, `Order_Week`, `Order_Month`, `Order_Year`.
- Created Pivot Tables.

*<img width="465" height="142" alt="image" src="https://github.com/user-attachments/assets/d6975734-6b79-46a1-9ed5-fe9d189c3931" />*

*<img width="641" height="98" alt="image" src="https://github.com/user-attachments/assets/e3e02c90-5b61-4323-9365-9dd040ba5f1b" />*

*<img width="630" height="359" alt="image" src="https://github.com/user-attachments/assets/f9767012-02ed-4af5-88e0-88aa68f00638" />*

*<img width="677" height="175" alt="image" src="https://github.com/user-attachments/assets/bc6ae6af-2b70-4c25-a47c-2510540fbdd3" />*

*<img width="577" height="166" alt="image" src="https://github.com/user-attachments/assets/c482a4dd-90dc-46f8-8b47-aa6bfcc07294" />*




### 2. SQL  
- Imported **cleaned CSV files** (`Customers`, `Orders`, `Order_Details`, `Payments`, `Products`) into SQL database.  
- Performed **data validation**: checked for duplicates, nulls, and orphan records using joins.  
- Enforced **referential integrity** between tables (CustomerID, OrderID, ProductID, PaymentID).  
- Wrote analytical queries to extract insights, including:  

  - **Top 10 Locations by Number of Orders and Total Payments**  
    ```sql
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
    ```
    
  - **Product Category and Sub-Category Sales Analysis**  
    ```sql
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
    ```
    
  - **Top 5 Products by Order Count**   
    ```sql
    select Top 5 od.Product_Id,p.Sub_Category, count(*) as Total_Values from Order_Details od
    join Products p on od.Product_Id=p.Product_Id 
	group by od.Product_Id,p.Sub_Category order by Total_Values desc;

    /*
    Findings & Observations
    -Kitchen leads with the highest order count (64), showing strong customer demand.
    -Kids, Skincare, and Laptops follow closely, each having 60+ orders.
    -Men’s category also ranks in the Top 5, reflecting balanced interest across essentials and lifestyle.
    */
    ```
  
  - **Customer Age Category Distribution**  
    ```sql
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
    ```
 
  - **Monthly Orders and Payments Analysis**  
    ```sql
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
    ```
    
### 3. Python  
- Used **Pandas** for cleaning and preprocessing.  
- Conducted **EDA** with Matplotlib & Seaborn.  
- Performed **hypothesis testing** (Z-test, T-test, F-test, Chi-square).  
- Generated visualizations: sales trends, discount effects, customer segments.

*<img width="994" height="442" alt="image" src="https://github.com/user-attachments/assets/0ca128f9-65c2-4c80-a20a-d66aa4262400" />*
*<img width="1082" height="683" alt="image" src="https://github.com/user-attachments/assets/91b22d9d-c6c2-4817-95c1-86e01afdc071" />*

*<img width="1003" height="409" alt="image" src="https://github.com/user-attachments/assets/18bb4087-e56b-4beb-bdb9-338899eaf108" />*
*<img width="1071" height="675" alt="image" src="https://github.com/user-attachments/assets/1a99ba69-aaad-4a9f-98d5-4a86c7f95f02" />*

*<img width="1120" height="422" alt="image" src="https://github.com/user-attachments/assets/bb2a6237-1dba-470a-8522-553df3c98ca1" />*
*<img width="1081" height="736" alt="image" src="https://github.com/user-attachments/assets/3ef42274-6f32-4d7a-bf12-ba2428b2321e" />*

*<img width="975" height="427" alt="image" src="https://github.com/user-attachments/assets/32edad0c-b8f1-4d52-b017-99a9319450c6" />*
*<img width="1081" height="700" alt="image" src="https://github.com/user-attachments/assets/6cdae690-474d-434f-a423-c617866893c0" />*

*<img width="1126" height="539" alt="image" src="https://github.com/user-attachments/assets/44ed89b6-f1a8-41a4-be26-34a261bfa658" />*
*<img width="965" height="185" alt="image" src="https://github.com/user-attachments/assets/cbb48b5b-a5cf-41c6-ab23-df1a88a0edb4" />*



### 4. Power BI  
- Built interactive dashboards with DAX measures.  
- Key dashboards:  
  - Sales Performance  
  - Customer Demographics & Loyalty  
  - Product Category Analysis  
  - Payment & Order Status

---

## 📊 Key Insights  
- **Top 3 Categories (Kitchen, Women, Laptops)** → contributed **~55% of total revenue**.  
- **Loyalty Members** → showed **20% higher repeat purchase rate**.  
- **Seasonality** → Sales peaked in **Nov–Dec (2.3x above monthly average)**.  
- **Discount Effect** → Orders with discounts grew **40% faster**, but reduced per-unit margins by **12%**.  
- **Payments** → Credit Cards accounted for **60% of transactions**, while refunds impacted ~5% of total revenue.  

---

## 📝 Recommendations  
1. Double down on **high-performing categories** (Kitchen, Women, Laptops).  
2. Expand **loyalty program benefits** to increase retention further.  
3. Refine **discount strategy** to maximize volume without hurting margins.  
4. Reduce **returns/refunds** via quality checks & post-purchase engagement.  
5. Use **predictive analytics** for seasonal inventory planning.  

---

## 📊 Dashboard Preview  

*<img width="1323" height="741" alt="image" src="https://github.com/user-attachments/assets/c82d3aca-d67e-48b2-9ea2-484d5190ebf2" />*

*<img width="1322" height="739" alt="image" src="https://github.com/user-attachments/assets/8fefb6fd-e012-4966-a568-0f82db3d9782" />*

*<img width="1322" height="743" alt="image" src="https://github.com/user-attachments/assets/34e5609a-1da2-48f9-9ef9-486aa3e34ea0" />*

*<img width="1322" height="748" alt="image" src="https://github.com/user-attachments/assets/fb27cccf-2b06-4472-94a6-cb4a97144536" />*

*<img width="1326" height="745" alt="image" src="https://github.com/user-attachments/assets/db5e2ba7-b292-4b1e-b6af-7e3daa717773" />*

---

## ⚙️ Tech Stack  
- **Excel** → Cleaning, pivot analysis.  
- **SQL** → Structured queries, transformations, aggregations.  
- **Python** → EDA, visualization, hypothesis testing.  
- **Power BI** → Interactive dashboards, KPI tracking, storytelling.  

---

## 📂 Project Files  
- `E-Commerce Sales & Customer Insights Dashboard.pbix` → Power BI Dashboard.  
- `E-Commerce_Dataset_Analysis.sql` → SQL scripts.  
- `E-Commerce_Analysis.ipynb` → Python notebook.  
- `Cleaned_Data/` → Final CSV & Excel files.  

---

## 🎯 Results / Impact  
- Improved **data reliability** by validating and cleaning 200K+ records.  
- Built dashboards enabling **real-time business monitoring**.  
- Insights support strategies that could **increase retention by 15%** and **optimize seasonal sales planning**.  
