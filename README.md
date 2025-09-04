# 📄 README: E-Commerce_Sales_and_Customer_Insight_Analysis_Project

## 📌 Project Overview  
This project analyzes an **E-Commerce Sales Dataset** using a combination of **Excel, SQL, Python, and Power BI**.  
The goal was to **clean, process, analyze, and visualize** the data to uncover insights into customer behavior,  
sales trends, product performance, and payment patterns, and finally provide actionable recommendations.  

---

## 🗂️ Dataset Description  
The dataset contains five main tables:  
- **Customers** – Customer demographics and details.  
- **Orders** – Order-level details including dates and status.  
- **Order_Details** – Itemized details for each order.  
- **Payments** – Payment modes and statuses.  
- **Products** – Product information including categories and pricing.  

---

## 🔧 Data Cleaning & Preparation  

### 1. Excel  
- Standardized data types and column headers.  
- Applied `TRIM()` to remove unwanted spaces.  
- Checked for **null values** → none found.  
- Checked for **duplicates** → none found.  
- Created calculated columns:  
  - `Discount Status` (in Order_Details).  
  - `Order_Week`, `Order_Year`, `Order_Month` (in Orders).  
- Saved both **Excel files** (for pivot analysis) and **CSV files** (for SQL/Python imports).  

### 2. SQL  
- Imported cleaned CSVs into SQL database.  
- Validated **data consistency** with queries.  
- Further checks on duplicates, missing values, and foreign key relationships.  
- Performed **data transformations & aggregations** for analysis.  
- Example: revenue by category, customer segmentation, order trends.  

### 3. Python  
- Imported cleaned dataset (CSV).  
- Used **Pandas** for advanced data cleaning and preprocessing.  
- Performed **EDA** with Matplotlib & Seaborn.  
- Created **visualizations** for sales trends, product performance, and customer behavior.  
- Conducted **Hypothesis Testing** for statistical validation of insights.  

### 4. Power BI  
- Imported cleaned data into Power BI.  
- Created **new columns and measures** using DAX.  
- Built interactive dashboards:  
  - Sales performance analysis.  
  - Customer behavior insights.  
  - Product category performance.  
  - Payment and order status trends.  
- Highlighted **key insights and recommendations**.  

---

## 📊 Key Insights  
- **Top Product Categories** contributed majority of revenue.  
- **Customer Retention** rate higher among loyalty program members.  
- **Seasonal Trends**: certain months/weeks show peak orders.  
- **Discount Impact**: Orders with discounts showed higher volume but lower per-unit profitability.  
- **Payment Patterns**: Successful transactions dominated, but returns/refunds impact revenue.  

---

## 📝 Recommendations  
1. Focus marketing on **high-performing product categories**.  
2. Strengthen **loyalty programs** to improve customer retention.  
3. Optimize **discount strategies** to balance sales volume and profit margins.  
4. Improve **return handling** to reduce loss from refunds.  
5. Invest in **predictive analytics** to forecast demand by season.  

---

## ⚙️ Tech Stack  
- **Excel** – Initial cleaning, pivot analysis.  
- **SQL** – Data validation, transformation, and structured analysis.  
- **Python** (Pandas, Matplotlib, Seaborn, Scipy) – Advanced cleaning, EDA, hypothesis testing.  
- **Power BI** – Dashboarding, DAX measures, business insights.  

---

## 📂 Project Files  
- `E-Commerce Sales & Customer Insights Dashboard.pbix` → Power BI Dashboard.  
- `E-Commerce_Dataset_Analysis.sql` → SQL scripts for cleaning & analysis.  
- `E-Commerce_Analysis.ipynb` → Python notebook for EDA, visualization, hypothesis testing.  
- `Cleaned_Data/` → Cleaned CSV & Excel files for each table.  

---

## 🚀 Conclusion  
This end-to-end project showcases a **complete data analytics workflow**:  
**Excel for cleaning → SQL for structured queries → Python for EDA & stats → Power BI for visualization.**  

The findings provide valuable insights for **data-driven decision making** in e-commerce
