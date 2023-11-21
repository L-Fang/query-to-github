---------------------------------------------------------------------------------------
--In this file, some views are created to use this database
---------------------------------------------------------------------------------------
--1.Create a view to get all customers with checking account from ON province.
---------------------------------------------------------------------------------------
create view Ch_ON as
select c.CustomerID,c.CustomerFirstName FirstName,c.CustomerLastName LastName,
c.AccountID CheckingAccount,at.AccountTypeDescription AccountType,c.State Province
from
Customer c
join Account a
on c.AccountID=a.AccountID and State='ON'
join AccountType at
on a.AccountTypeID=at.AccountTypeID and at.AccountTypeID='101' 
-- 101 means checking account
---------------------------------------------------------------------------------------
--Check the view just created
select * from Ch_ON

---------------------------------------------------------------------------------------
--2.Create a view to get all customers with total account balance (including interest rate) greater than 5000.
---------------------------------------------------------------------------------------
Create View accountBalance
AS
select c.CustomerFirstName || ' ' || c.CustomerMiddleInitial || '. ' || c.CustomerLastName as FullName,
a.CurrentBalance + a.CurrentBalance * s.InterestRateValue as totalBalance
from Customer c
join Account a
on c.AccountID=a.AccountID
join SavingsInterestRates s
on a.InterestSavingsRateID = s.InterestSavingsRateID
where (a.CurrentBalance + a.CurrentBalance * s.InterestRateValue) > 5000

--Check the view just created
select * from accountBalance

---------------------------------------------------------------------------------------
--3. Create a view to get counts of checking and savings accounts by customer.
---------------------------------------------------------------------------------------
--drop view Count_Ch_Sa
create view Count_Ch_Sa as
select C.CustomerID CustomerID,C.CustomerFirstName First_Name,C.CustomerLastName Last_Name, count(A.AccountTypeID) count,AT.AccountTypeDescription
from
Customer C
join Account A
on C.AccountID=A.AccountID
join AccountType AT
on A.AccountTypeID=AT.AccountTypeID and AT.AccountTypeID in (101,102)
group by CustomerID,C.CustomerFirstName,C.CustomerLastName,AT.AccountTypeDescription
------------------------
select * from Count_Ch_Sa







