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

  - **Sales Trends**  
    ```sql
    SELECT Order_Year, Order_Month, SUM(Amount_Paid) AS Monthly_Revenue
    FROM Orders O
    JOIN Order_Details OD ON O.Order_Id = OD.Order_Id
    GROUP BY Order_Year, Order_Month
    ORDER BY Order_Year, Order_Month;
    ```
    ➝ Identified seasonal peaks in November–December.  

  - **Top Product Categories by Revenue**  
    ```sql
    SELECT P.Category, SUM(OD.Amount_Paid) AS Revenue
    FROM Order_Details OD
    JOIN Products P ON OD.Product_Id = P.Product_Id
    GROUP BY P.Category
    ORDER BY Revenue DESC;
    ```
    ➝ Kitchen, Women, and Laptops contributed ~55% revenue.  

  - **Customer Segmentation** (High-value vs. Regular Customers)  
    ```sql
    SELECT C.Customer_Id, C.Customer_Name, SUM(OD.Amount_Paid) AS Total_Spend
    FROM Customers C
    JOIN Orders O ON C.Customer_Id = O.Customer_Id
    JOIN Order_Details OD ON O.Order_Id = OD.Order_Id
    GROUP BY C.Customer_Id, C.Customer_Name
    HAVING SUM(OD.Amount_Paid) > 5000;
    ```
    ➝ Identified top customers driving revenue.  

  - **Discount Impact Analysis**  
    ```sql
    SELECT Discount_Status, COUNT(*) AS Orders, SUM(Amount_Paid) AS Revenue
    FROM Order_Details
    GROUP BY Discount_Status;
    ```
    ➝ Discounted orders had higher count but lower per-unit profitability.  

  - **Payment Mode Analysis**  
    ```sql
    SELECT Payment_Mode, COUNT(*) AS Transactions, SUM(Amount_Paid) AS Revenue
    FROM Payments
    GROUP BY Payment_Mode
    ORDER BY Revenue DESC;
    ```
    ➝ Credit Card transactions dominated (~60%).  

  - **Return/Refund Impact**  
    ```sql
    SELECT Order_Status, COUNT(*) AS Orders, SUM(Amount_Paid) AS Revenue
    FROM Orders O
    JOIN Order_Details OD ON O.Order_Id = OD.Order_Id
    GROUP BY Order_Status;
    ```
    ➝ Returns accounted for ~5% of total revenue loss.  
  

### 3. Python  
- Used **Pandas** for cleaning and preprocessing.  
- Conducted **EDA** with Matplotlib & Seaborn.  
- Performed **hypothesis testing** (Z-test, T-test, F-test, Chi-square).  
- Generated visualizations: sales trends, discount effects, customer segments.  

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


---

## ⚙️ Tech Stack  
- **Excel** → Cleaning, pivot analysis.  
- **SQL** → Structured queries, transformations, aggregations.  
- **Python** → EDA, visualization, hypothesis testing.  
- **Power BI** → Interactive dashboards, KPI tracking, storytelling.  

---

## 📂 Project Files  
- `E-Commerce_Sales_Insights.pbix` → Power BI Dashboard.  
- `E-Commerce_SQL_Analysis.sql` → SQL scripts.  
- `E-Commerce_Python_Analysis.ipynb` → Python notebook.  
- `Cleaned_Data/` → Final CSV & Excel files.  

---

## 🎯 Results / Impact  
- Improved **data reliability** by validating and cleaning 200K+ records.  
- Built dashboards enabling **real-time business monitoring**.  
- Insights support strategies that could **increase retention by 15%** and **optimize seasonal sales planning**.  
