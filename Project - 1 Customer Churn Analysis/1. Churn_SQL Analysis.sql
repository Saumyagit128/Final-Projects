-- DATA EXPLORATION

/*--------------------------------------------------------------------------------------------------------------------------------------------
	Personal Information of Customers
--------------------------------------------------------------------------------------------------------------------------------------------*/

-- Exploring Gender
select Gender, count(Gender) as TotalCount,
count(gender)/(select count(*) from cust)*100
from cust
group by Gender;


-- Youngest and oldest customers
select min(Age) as youngest_customer, max(Age) as oldest_customer
from cust;


-- No. of customers by state
SELECT State, Count(State) as TotalCount,
round(Count(State) / (Select Count(*) from cust)*100, 2)  as Percentage
from cust
Group by State
Order by Percentage desc;


-- Marital Status
SELECT Married, Count(Married) as TotalCount,
round(Count(Married) / (Select Count(*) from cust)*100, 2)  as Percentage
from cust
Group by Married
Order by Percentage desc;

/*--------------------------------------------------------------------------------------------------------------------------------------------
	Account information
--------------------------------------------------------------------------------------------------------------------------------------------*/
-- Exploring Tenure range
select min(Tenure_in_Months) , max(Tenure_in_Months) 
from cust;


-- Contract
SELECT Contract, Count(Contract) as TotalCount,
Count(Contract) * 1.0 / (Select Count(*) from cust)  as Percentage
from cust
Group by Contract;

-- Payment Method
SELECT Payment_Method, Count(Payment_Method) as TotalCount,
Count(Payment_Method) * 1.0 / (Select Count(*) from cust)  as Percentage
from cust
Group by Payment_Method;


/*--------------------------------------------------------------------------------------------------------------------------------------------
	Revenue
--------------------------------------------------------------------------------------------------------------------------------------------*/

-- total revenue
select sum(Total_Revenue) as Total_Revenue from cust;

-- revenue by gender
select Gender, count(Gender) as TotalCount,
round(sum(Total_Revenue), 2) as Total_Revenue
from cust
group by Gender
order by 3 desc;

-- top 5 states by revenue
select State, count(State) as TotalCount,
round(sum(Total_Revenue), 2) as Total_Revenue
from cust
group by State
order by 3 desc
limit 5;

-- revenue by marital status
select Married, count(Married) as TotalCount,
round(sum(Total_Revenue), 2) as Total_Revenue
from cust
group by Married
order by 3 desc;

/*--------------------------------------------------------------------------------------------------------------------------------------------
	CHURN DISTRIBUTION
--------------------------------------------------------------------------------------------------------------------------------------------*/

-- Custotmer status
select Customer_Status, count(Customer_Status) as TotalCount, round(sum(Total_Revenue), 2) as TotalRev,
round(sum(Total_Revenue)/ (select sum(Total_Revenue) from cust)*100, 2) as RevPercent
from cust
group by Customer_Status;


-- Churn Rate 
select Customer_Status, count(Customer_Status)/ (select count(*) from cust)*100 as Churn_rate
from cust
where Customer_Status = 'Churned';


-- Top 5 states who have the most customers churned
select State, count(State) as total_churn
from cust
 where Customer_Status = 'Churned'
group by State
order by 2 desc
limit 5;


-- Total churn by gender
select Gender, count(Gender) as total_churn
from cust
 where Customer_Status = 'Churned'
group by Gender
order by 2 desc;


-- Total churn by Payment method
select Payment_Method, count(Payment_Method) as total_churn
from cust
 where Customer_Status = 'Churned'
group by Payment_Method
order by 2 desc;

-- Total churn by Contract
select Contract, count(Contract) as total_churn
from cust
 where Customer_Status = 'Churned'
group by Contract
order by 2 desc;

-- Total churn by Internet_Type
select Internet_Type, count(Internet_Type) as total_churn
from cust
 where Customer_Status = 'Churned'
group by Internet_Type
order by 2 desc;


-- Total churn, and cummulative churn by churn category with churn reason
with churn as (select Churn_Category, Churn_Reason, count(Churn_Category) as total_churn
from cust
 where Customer_Status = 'Churned'
group by Churn_Category, Churn_Reason
order by 1, 2, 3 desc)

select *, sum(total_churn) over (partition by Churn_Category order by Churn_Category, Churn_Reason) as cumm_churn,
		  sum(total_churn) over (partition by Churn_Category ) as total_churn_by_category 
from churn;



/*--------------------------------------------------------------------------------------------------------------------------------------------
	Creating VIEWS for Churn Prediction Analysis in python
--------------------------------------------------------------------------------------------------------------------------------------------*/

Create View vw_ChurnData as
	select * from cust where Customer_Status In ('Churned', 'Stayed');

Create View vw_JoinData as
	select * from cust where Customer_Status = 'Joined';

