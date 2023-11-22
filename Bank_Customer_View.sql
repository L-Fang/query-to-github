---------------------------------------------------------------------------------------
--In this file, three views are created to use this database following with a 'select' query to check if we can get the correct result
---------------------------------------------------------------------------------------
--1a. Create a view to get all customers with checking account from ON province.
--1b. A very simple 'select' query to check if the result is correct.
---------------------------------------------------------------------------------------
create view Ch_ON as
select c.CustomerID,c.CustomerFirstName FirstName,c.CustomerLastName LastName,
c.AccountID CheckingAccount,at.AccountTypeDescription AccountType,c.State Province
from
Customer c
join Account a
on c.AccountID=a.AccountID and State='ON'
join AccountType at
on a.AccountTypeID=at.AccountTypeID and at.AccountTypeID='101' -- here, 101 means checking account
---------------------------------------------------------------------------------------
--Check the view just created
select * from Ch_ON

---------------------------------------------------------------------------------------
--2a. Create a view to get all customers' full name with total account balance (including interest) greater than 10000.
--2b. A very simple 'select' query to check if the result is correct.
---------------------------------------------------------------------------------------
Create View accountBalance
AS
select c.CustomerFirstName || ' ' || c.CustomerMiddleInitial || '. ' || c.CustomerLastName as FullName,
a.CurrentBalance + a.CurrentBalance * s.InterestRateValue as totalBalance
from Customer c
join Account a
on c.AccountID = a.AccountID
join SavingsInterestRates s
on a.InterestSavingsRateID = s.InterestSavingsRateID
where (a.CurrentBalance + a.CurrentBalance * s.InterestRateValue) > 10000

--Check the view just created
select * from accountBalance

---------------------------------------------------------------------------------------
--3a. Create a view to get the number of checking and savings accounts for each customer.
--3b. A very simple 'select' query to check if the result is correct.
---------------------------------------------------------------------------------------
--drop view Count_Ch_Sa
create view Count_Ch_Sa as
select C.CustomerID CustomerID,C.CustomerFirstName First_Name,C.CustomerLastName Last_Name, count(A.AccountTypeID) Num_of_Account,AT.AccountTypeDescription
from
Customer C
join Account A
on C.AccountID=A.AccountID
join AccountType AT
on A.AccountTypeID=AT.AccountTypeID and AT.AccountTypeID in (101,102)
group by CustomerID,C.CustomerFirstName,C.CustomerLastName,AT.AccountTypeDescription
------------------------
select * from Count_Ch_Sa







