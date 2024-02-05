use bankanalytics;
select * from finance_1;
select * from finance_2;

# Total Loan Amount in Millions
select 
concat(round(sum(loan_amnt)/1000000,2)," Mn") as Total_Loan_Amount 
from finance_1;

# Total loan issued 
select 
concat(round(count(id)/1000,2)," k") as Total_No_of_Loans_issued 
from finance_1; 

# Average interest rate
select 
concat(round(avg(int_rate)*100,2)," %") as Average_int_rate 
from finance_1;

# Total Funded Amount
select 
concat(round(sum(funded_amnt)/1000000,2)," Mn") as Total_Funded_Amount 
from finance_1;

# Total Revolving Balance
select 
concat(round(sum(revol_bal)/1000000,2)," Mn") as Total_Revolving_Bal 
from finance_2;

# Total Number of Accounts
select 
concat(round(sum(total_acc)/1000,2)," k") as Total_No_of_Accounts 
from finance_2; 

# Yearwise loan Amount Status
select 
year(issue_d) as years,concat(round(sum(loan_amnt)/1000000)," M")  as Loan_Amount 
from finance_1
group by years
order by years;

# Grade and sub grade wise revol_bal
select 
grade,sub_grade,concat(round(sum(revol_bal)/1000000)," M") Revolving_balance 
from finance_1 as  f1 inner join finance_2 f2 on f1.id=f2.id 
group by grade,sub_grade
order by grade,sub_grade;

# Total Payment for Verified Status Vs Total Payment for Non Verified Status
select 
verification_status,concat(round(sum(total_pymnt)/1000000)," M") as Total_Payment 
from finance_1 f1 inner join finance_2 f2 on f1.id=f2.id
group by verification_status;

# State wise and month wise loan status
select 
addr_state, loan_status, count(loan_status) as loans
from finance_1
group by addr_state, loan_status
order by addr_state,loan_status;

select 
monthname(issue_d) Month_Name,loan_status,count(f1.loan_status) as loan_status
from finance_1 as f1 join finance_2 as f2 on f1.id = f2.id
group by Month_Name,loan_status,month(issue_d)
order by month(issue_d) ;

# Home ownership Vs last payment date stats
select 
year(Last_payment_d) as paymnt_year,monthname(Last_payment_d) as paymnt_month,home_ownership,count(Last_payment_d) as loans 
from finance_1 f1 inner join finance_2 f2 on f1.id=f2.id
group by home_ownership,paymnt_year,paymnt_month
order by paymnt_year desc;

#Yearly Interest Received
select 
year(Last_payment_d) as Received_year,concat(round(sum(total_rec_int)/1000000,2)," M") as Interest_received
from finance_2
group by received_year
having received_year is not null
order by received_year;

#Top 5 States by customers
select 
addr_state as state_name, concat(round(count(*)/1000,1)," K") as customers
from finance_1
group by addr_state
order by customers desc
limit 5;

# Overall Report
select * from finance_1 f1
inner join finance_2 f2 on f1.id=f2.id;

