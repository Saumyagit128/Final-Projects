# Project - 1
# 📊 Telecom Customer Churn Analysis Project

## 📌 Project Overview

This project focuses on analyzing customer churn in a telecom company. It aims to understand key customer behaviors, identify drivers of churn, and predict future churners using machine learning. The project integrates **SQL** for data exploration and ETL processes, **Python** for predictive modeling with **Random Forest**, and **Power BI** for interactive visualization and dashboarding.

## 💼 Business Problem

Customer retention is a critical challenge in the telecom sector. High churn rates lead to significant revenue losses. The objective is to:

1. Identify demographic, geographic, and service-related patterns contributing to customer churn.
2. Build a machine learning model to predict customers likely to churn.
3. Provide actionable insights and strategic recommendations for customer retention.

## 🛠️ Tools & Technologies Used

`MySQL`, `python`, `power BI`

Libraries - `seaborn`, `pandas`, `numpy`, `matplotlib`, `sqlalchemy`, `sklearn`

## 🔄 Process Flow Summary

### 🔍 1. Data Exploration in SQL

Performed exploratory data analysis (EDA) across:

- **Demographics**: Gender, Age, Marital Status  
- **Geographics**: State-wise customer distribution  
- **Account Info**: Tenure, Contracts, Payment Methods  
- **Revenue Metrics**: Total Revenue by customer segments  
- **Churn Metrics**: Churn rate by category, reason, gender, services  

Created SQL views for:
- `vw_ChurnData` – For model training  
- `vw_JoinData` – For predicting churn among new joiners  

---

### ⚙️ 2. Data Preprocessing & Feature Engineering (Python)

Steps taken:

- Removed unnecessary columns (`Customer_ID`, `Churn_Category`, `Churn_Reason`)  
- Label-encoded categorical variables  
- Split data into training and testing sets (80:20)  
- Encoded target: `Customer_Status` → 0 = Stayed, 1 = Churned  

---

### 🌲 3. Machine Learning: Churn Prediction with Random Forest

- Algorithm: `RandomForestClassifier`  
- Model Evaluation:  
  - Confusion Matrix  
  - Classification Report  
  - Feature Importance Plot  

Top important features:
- Contract type  
- Online Security  
- Monthly Charges  
- Payment Method  
- Streaming services usage  

Predicted churners from "Joined" customers and stored in `churn_prediction` table for dashboard use.

### 📈 4. Power BI Dashboard & Data Transformations

#### Data Model Enhancements:

- **Churn Status**: 1 for churned, 0 otherwise  
- **Monthly Charge Range**: `<20`, `20–50`, `50–100`, `>100`  
- **Age Group**: `<20`, `20–35`, `36–50`, `>50`  
- **Tenure Group**: `<6M`, `6–12M`, `12–18M`, `18–24M`, `>24M`  
- **Services**: Unpivoted for churn distribution analysis  

---

## 📊 Dashboards

### 📋 Page 1: Churn Summary Dashboard

**Key KPIs:**
- **Total Customers**: 6,418  
- **New Joiners**: 411  
- **Total Churn**: 1,732  
- **Churn Rate**: 27%  

#### Insights:

- **Gender**: 64% of churned customers are female  
- **Age**: Churn rate highest (36.14%) among customers over 60  
- **Contract**: Month-to-month contracts → 46.53% churn  
- **Payment Method**: Mailed check → 37.82% churn  
- **Internet Type**: Fiber Optic users → 41.10% churn  
- **Geography**: Jammu & Kashmir leads with 57.19% churn  
- **Services Not Taken**:
  - Internet service:   93.71% churn  
  - Phone Service: 90.59%  
- 

#### Churn Categories:

- **Competitor**: 761 churns  
- Followed by **Attitude** and **Dissatisfaction**--

### 🔍 Page 2: Predicted Churner Profile

**Predicted churners**: 381

#### Profile Breakdown:

- **Gender**: 246 Female, 135 Male  
- **Age Group**: Most churners in 40–60 age range  
- **Marital Status**: Almost evenly split  
- **Tenure**: High churn from >24 months customers  
- **Contract**: 356 out of 381 on month-to-month  
- **Payment Method**: Mostly Credit Card and Bank Withdrawal  
- **Top States**:
  - Uttar Pradesh: 45  
  - Maharashtra: 39  
  - Tamil Nadu: 37  

---
<img width="1475" height="824" alt="image" src="https://github.com/user-attachments/assets/26ee55dd-ff36-4efa-b336-711b60a23acf" />

<img width="1474" height="823" alt="image" src="https://github.com/user-attachments/assets/a3969aa7-83d1-4dc9-b46e-f7f9f94e9c94" />


## 🔎 Key Insights Summary

- **Who churns the most**:
  - Female customers  
  - Older age groups (>60)  
  - Month-to-month contracts  
  - Mailed check payments  
  - Customers lacking value-added services
 
# Project - 2
# Retail Business Performance & Profitability Analysis

## Project Overview
This project addresses critical inventory and sales management challenges in the retail/wholesale industry by analyzing  transaction records to optimize vendor relationships and profitability. Through an automated ETL pipeline that processes sales, purchases, and inventory data into a SQLite database, the analysis solves complex business problems. The solution includes Python-based data processing, exploratory data analysis, correlation analysis, confidence interval estimation, hypothesis testing, and an interactive Power BI dashboard with DAX calculations for real-time monitoring, enabling data-driven decisions for vendor diversification, pricing optimization, and inventory management strategies.

## Business Problem

Effective inventory and sales management are critical for optimizing profitability in the retail and wholesale industry. Companies need to ensure that they are not incurring losses due to inefficient pricing, poor inventory turnover, or vendor dependency. The goal of this analysis is to:
- Identify underperforming brands that require promotional or pricing adjustments.
- Determine top vendors contributing to sales and gross profit.
- Analyze the impact of bulk purchasing on unit costs.
- Assess inventory turnover to reduce holding costs and improve efficiency.
- Investigate the profitability variance between high-performing and low-performing vendors


##  Tools & Technologies

`Python`
`SQL`
`Power BI`

Libraries - `SQLite`, `SQLALchemy`, `Pandas`, `numpy`, `matplotlib`, `seaborn`, `scipy.stats`

## Database Ingestion Pipeline: Real-Time Processing of Large-Scale Inventory Data

file : `ingestion_db.py`

This Python script implements an automated data pipeline designed to handle the ingestion of large-scale inventory management dataset into a SQLite database. The system processes multiple CSV files containing millions of records related to inventory tracking, sales transactions, and vendor management, while maintaining detailed logs of all operations for monitoring and debugging purposes.

The script creates a centralized SQLite database (inventory.db) that serves as a unified repository for all inventory-related data. Using SQLAlchemy's engine, it establishes a robust connection that can handle concurrent operations and large data volumes efficiently.

**Data Sources**:
The pipeline processes six critical business datasets:

- begin_inventory.csv: Opening inventory positions for all products across stores
- end_inventory.csv: Closing inventory positions to track stock movements
- sales.csv: Detailed transaction records of all customer purchases
- purchases.csv: Vendor purchase orders and procurement data
purchase_prices.csv: Wholesale pricing information from suppliers
- vendor_invoices.csv: Invoice details for financial reconciliation

The script implements chunk-based processing (chunksize=1000) to handle extremely large files without overwhelming system memory. This approach allows the system to process files that might be several gigabytes in size by breaking them into manageable pieces.

**Comprehensive Logging System:**
The logging mechanism captures-

- Timestamp of each operation for precise tracking
Operation status (INFO, DEBUG, ERROR) for different severity levels
- File-specific ingestion progress to monitor which datasets are being processed
- Performance metrics including total execution time in minutes
- Logs are stored in **`logs/ingestion_db.log`** with append mode, creating a permanent audit trail of all database operations.

The script tracks execution time using Python's  **time** module, calculating the total duration of the ingestion process.

This automated pipeline eliminates manual data loading, reduces human error, and provides real-time visibility into data processing operations. It enables:

- Rapid data availability for business intelligence and analytics
- Scalable architecture that grows with business needs
- Audit compliance through comprehensive logging
- Operational efficiency by automating repetitive tasks

## Initial Analysis to understand the data 

file - `Exploratory Data Analysis.ipynb`

This analysis is performed to understand the dataset to explore how the data is present in the database and if there is a need of creating some aggregated columns that can help with

- Vendor selection for profitability
- Product Pricing Optimization

The purchases table contains actual purchase data, including the date of purchase, products (brands) purchased by vendors, the amount paid (in dollars), and the quantity purchased.
- The purchase price column is derived from the purchase_prices table, which provides product-wise actual and purchase prices. The combination of vendor and brand is unique in this table.
- The vendor_invoice table aggregates data from the purchases table, summarizing quantity and dollar amounts, along with an additional column for freight. This table maintains uniqueness based on vendor and PO number.
- The sales table captures actual sales transactions, detailing the brands purchased by vendors, the quantity sold, the selling price, and the revenue earned.

As the data that we need for analysis is distributed in different tables, we need to create a summary table containing:
- purchase transactions made by vendors
-  sales transaction data
- freight costs for each vendor
- actual product prices from vendors

## Vendor_sales_summary table Pipeline

file - `get_vendor_summary.py`

This script transforms millions of raw transaction records into a focused vendor performance summary table, reducing data volume by 99%+ while extracting critical business insights. It converts complex multi-table relationships into a single, analytics-ready dataset of ~10,000 rows.

**Data Aggregation**

Combines data from 4 source tables using SQL CTEs (Common Table Expressions):
- Freight costs from vendor invoices
- Purchase data including quantities and pricing
- Sales performance with revenue and tax information
- Product details with descriptions and volumes

**Data Transformation**

- Aggregates millions of transactions by vendor and product
- Joins purchase and sales data to create complete vendor view
- Filters only products with valid purchase prices
- Sorts by purchase volume to identify key vendors

**Data Enhancement**

- Cleans vendor names and product descriptions
- Converts data types for accurate calculations
- Creates 4 new analytical metrics:
    -  Gross Profit
    - Profit Margin
    - Sales-to-Purchase Ratio
    - Stock Turnover

The pipeline transforms big data into actionable insights, making vendor performance analysis accessible to business users through simplified, pre-calculated metrics.

## Exploratory Data Analysis Insights

file: `Vendor Performance Analysis.ipynb`

### Summary Statistics

![Image](https://github.com/user-attachments/assets/d6dea9a5-4ebf-446e-b960-42c1aa0cea83)

![Image](https://github.com/user-attachments/assets/4e9d103d-57c9-44ba-9a25-5275c89212f6)

**Negative & Zero Values:**

- **Gross Profit**: Minimum value is -52,002.78, indicating losses. Some products or transactions may be selling at a loss due to high costs or selling at discounts lower than the purchase price..

**Outliers Indicated by High Standard Deviations:**
- **Purchase & Actual Prices**: The max values (4264.70 & 5,799.99) are significantly higher than the mean (24.39 & 35.64), indicating potential premium products.
- **Freight Cost**: Huge variation, from 0.09 to 257,032.07, suggests logistics inefficiencies or bulk shipments.
- **Stock Turnover**: Ranges from 0 to 274.5, implying some products sell extremely fast while others remain in stock indefinitely. Value more than 1 indicates that Sold quantity for that product is higher than purchased quantity due to either sales are being fulfilled from older stock.

### Data Filtering
To enhance the reliability of the insights, we removed inconsistent data points where:

- Gross Profit ≤ 0 (to exclude transactions leading to losses).
- Profit Margin 0 (to ensure analysis focuses on profitable transactions).
- Total Sales Quantity = 0 (to eliminate inventory that was never sold).

### Correlation Insights

![Image](https://github.com/user-attachments/assets/9b137d64-a991-4287-9623-17033be18df9)

- **Purchase Price vs Total Sales Dollars & Gross Profit:** Weak correlations with TotalSalesDollars (-0.012) and Gross Profit (-0.016), suggesting that price variations do not significantly impact sales revenue or profit.
- **Total purchase quantity and total sales quantity:** Strong correlation (0.999), confirming efficient inventory turnover.
- **Profit margin & Total Sales Price:** Negative correlation(-0.179), suggests that as sales price increases, margins decrease, possibly due to competitive pricing pressures.
- **StockTurnover vs Gross Profit & ProfitMargin:** Weak negative correlations(-0.038,-0.055), indicating that faster turnover does not necessarily result in higher profitability.

## Research Questions & Key Findings

1. **Brands for Promotions or Pricing adjustments**

![Image](https://github.com/user-attachments/assets/84765494-1237-4e24-bfb1-193367948ae5)

198 brands exibhit lower sales but higher Profit margins, which could benifit from targeted marketing, promotions or pricing optimizations to increase volume without compromising profitability.

![Image](https://github.com/user-attachments/assets/b8de5058-9bcc-45df-9eb9-668ab0065371)

2. **Top Vendors by Sales and Purchase Contribution**

The top 10 vendors contribute 65.69% of total purchases, while the remaining vendors contribute only 34.31%. This over reliance on a few vendors may introduce risks such as supply chain disruptions, indicating a need for diversification.

![Image](https://github.com/user-attachments/assets/c58449dc-0005-4daf-aee7-1b37427d3037)

3. **Impact of Bulk Purchasing on Cost Savings**

- Vendors buying in bulk get the lowest unit price ($10.78 per unit), meaning higher margins if they can manage inventory efficiently.
- The price difference between Small and Large orders is substantial (~72% reduction in unit cost)
- This suggests that bulk pricing strategies successfully encourage vendors to purchase in larger volumes, leading to higher overall sales despite lower per-unit revenue.

![Image](https://github.com/user-attachments/assets/51f109c4-bf52-4cdc-bd81-8b34f6dd59f5)

4. **Identifying vendors with Low Inventory Turnover**

Total unsold capital:  2.71M

Slow-moving inventory increases storage costs, reduces cash flow efficiency and, affects overall profitability

Identifying vendors with low inventory turnover enables better stock management, minimizing financial strain

![Image](https://github.com/user-attachments/assets/ec533640-b154-46d8-9d9a-c895ca8126a2)

![Image](https://github.com/user-attachments/assets/1e293a8c-0fe6-4b92-b38b-bf2fb62c8b12)

5. **Profit Margin Comparision: High vs Low performing brands**

Top Vendors 95% CI: (30.74, 31.61), Mean: 31.18
Low Vendors 95% CI: (40.50, 42.64), Mean: 41.57

Low-performing vendors maintain higher profit margins but struggle with sales volumes, indicating pricing inefficiencies or market reach issues. 

Actionable Insights : 

- Top-performing Vendors: Optimize profitability by adjusting pricing, reduce operational costs, or offering bundled promotions.
- Low-performing Vendors: Improve marketing efforts, optimize pricing strategies, and enhance distribution networks.

![Image](https://github.com/user-attachments/assets/9d095e34-2da5-437f-afb9-3e25627df31f)

**6. Statistical Validation of Profit Margin differences**

**Hypothesis Testing:**

H₀ (Null Hypothesis): No significant difference in profit margins between top-performing and low-performing vendors.

H₁ (Alternative Hypothesis): A significant difference exists in profit margins between top-performing and low-performing vendors.

**Result:** The null Hypothesis is rejected, confirming that the two groups operate under distinctly different probability models.

**Implication:** High vendors might benifit from better pricing strategies, while top selling vendors could focus on cost efficiency.

## Final Recommadations

- Re-evaluate pricing of low-sales, high-margin brands to boost sales volmes without sacrificing profitability.
- Diversify vendor partnerships to reduce dependency on a few suppliers and mitigate supply chain risks.
- Leverage bulk purchasing advantages to maintain competitive pricing while optimizing inventory management.
- Optimize slow-moving inventory by adjusting purchase quantities, launching clearance sales, or revising storage strategies.
- Enhance marketing and distribution strategies for low-performing vendors to drive higher sales volumes without compromising profit margins.
- By implementing these recommendations, the company can achieve sustainable profitability, mitigate risks, and enhance overall operational efficiency.

## Power BI Dashboard

file : `Vendor Performance Analysis.pbix `

Created a Power BI dashboard using powerful DAX queries, with visuals from all the important and relavent analysis conducted using python. This dashboard contains minimal visualizations relevant to our buisness problem and research questions. 

![image](https://github.com/user-attachments/assets/475c666a-a048-486e-b45e-d4abd83cf463)

- **Tenure doesn’t guarantee retention**: >24 months still shows ~27.5% churn  
- **States with highest churn**: J&K, Assam, Jharkhand  

---


## ✅ Recommendations & Action Plan

1. **Loyalty Campaigns**: Target >24-month customers with exclusive offers  
2. **Contract Lock-ins**: Offer discounts on 1- or 2-year contracts  
3. **Upselling Services**: Promote internet services, phone sevices, paperless billing  
4. **Payment Preferences**: Encourage digital methods with cashback offers  
5. **Location-Specific Marketing**: Focus on J&K, Assam, and Jharkhand, Uttar Pradesh  
6. **Customer Support for Elderly**: Elderly are seen to churn the most. Launch personalized guidance programs for elderly
