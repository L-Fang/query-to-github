
/* In this file, two main tasks are completed 
including creating the database Bank with 10 tables connected by primary keys and foreign keys 
and inserting values for each table*/
----------------------------------------------------------------------------------
-- Create the database Bank
create database Bank
----------------------------------------------------------------------------------
--Part I: Create 10 Tables with Primary Key and Foreign Key
----------------------------------------------------------------------------------
--First, create 5 tables without Foreign Key
----------------------------------------------------------------------------------
--table 1: UserLogins to collect the login information of users
create table UserLogins(
UserLoginID smallint primary key,
UserLogin char(15),
UserPassword varchar(20)
)

--table 2: AccountType to collect the account type of customer account such as checking and saving account
create table AccountType(
AccountTypeID smallint primary key,
AccountTypeDescription varchar(30)
)
--table 3: SavingsInterestRates to save the interest rate, value, and description for customer account
create table SavingsInterestRates(
InterestSavingsRateID smallint primary key,
InterestRateValue numeric(9,9),
InterestRateDescription varchar(20)
)
--table 4: AccoutnStatusType to save the status information for customer account such as active, inactive, locked, etc.
create table AccountStatusType(
AccountStatusTypeID smallint primary key,
AccountStatusDescription varchar(30)
)
--table 5: TransactionType to save the type of transaction for customer such as "Direct Deposit" and "Certified Cheque", etc.
create table TransactionType(
TransactionTypeID smallint primary key,
TransactionTypeName char(10),
TransactionTypeDescription varchar(50),
TransactionFeeAmount money
)

----------------------------------------------------------------------------------
--Secondly, create 6 tables with Foreign Key
----------------------------------------------------------------------------------
--table 6: Account for all the information of account for customer
create table Account(
AccountID int primary key,
CurrentBalance int,	
AccountTypeID smallint,
constraint fk_AccountTypeID
	foreign key (AccountTypeID)
		References AccountType (AccountTypeID),
AccountStatusTypeID smallint,
constraint fk_AccountStatusTypeID
	foreign key (AccountStatusTypeID)
		references AccountStatusType (AccountStatusTypeID),
InterestSavingsRateID smallint,
constraint fk_InterestSavingsRateID
	foreign key (InterestSavingsRateID)
		references SavingsInterestRates (InterestSavingsRateID)
)

--table 7: LoginAccount to save the information of login account for customer
create table LoginAccount(
UserLoginID smallint,
constraint fk_UserLoginID
	foreign key (UserLoginID) 
		references UserLogins(UserLoginID),
AccountID int,
constraint fk_AccountID
	foreign key (AccountID)
		references Account(AccountID)
)
--table 8: Customer to collect all the basic and important information for customer 
-- including name, address, SSN, and contact information, etc.
create table Customer(
CustomerID int primary key,
AccountID int,
constraint fk_AccountID
	foreign key (AccountID)
		references Account (AccountID),
CustomerAddress1 varchar(30),
CustomerAddress2 varchar(30),
CustomerFirstName varchar(30),
CustomerMiddleInitial char(1),
CustomerLastName varchar(30),
City varchar(20),
State char(2),
ZipCode char(10),
EmailAddress varchar(40),
HomePhone char(10),
CellPhone char(10),
WorkPhone char(10),
SSN char(9),
UserLoginID smallint,
Constraint FK_UserLoginID
	foreign key (UserLoginID) 
		references UserLogins (UserLoginID)
)
--table 9: CustomerAccount to save the account information for customer
create table CustomerAccount(
AccountID int,
constraint fk_AccountID
	foreign key (AccountID) 
		references Account (AccountID),
CustomerID int,
constraint fk_CustomerID
	foreign key (CustomerID) 
		references Customer (CustomerID)
)
--table 10: TransactionLog to save the information about transaction including time, value, customer, login, etc.
Create table TransactionLog(
TransactionID int primary key,
TransactionDate timestamp,
TransactionTypeID smallint,
constraint fk_TransactionTypeID	foreign key (TransactionTypeID) references TransactionType(TransactionTypeID),
TransactionAmount money,
NewBalance money,
AccountID int,
constraint fk_AccountID	foreign key (AccountID) references Account (AccountID),
CustomerID int,
constraint fk_CustomerID	foreign key (CustomerID) references Customer (CustomerID),
-- EmployeeID int,
-- constraint fk_EmployeeID	foreign key (EmployeeID) references Employee(EmployeeID),
UserLoginID smallint,
constraint fk_UserLoginID	foreign key (UserLoginID) references UserLogins (UserLoginID)
)

------------------------------------------------------------------------------------------------------
--Part II: Insert Values
------------------------------------------------------------------------------------------------------
--table 1
insert into UserLogins
(UserLoginID,UserLogin,UserPassword)
values
(1001,'Andrew','An1001'),
(1002,'Black','Bl1002'),
(1003,'Cathy','Ca1003'),
(1004,'Debra','De1004'),
(1005,'Emily','Em1005')
--table 2
insert into AccountType
(AccountTypeID,AccountTypeDescription)
values
(101,'Checking Account'),
(102,'Savings Account'),
(103,'Certificate of Deposit (CD)'),
(104,'Money Market Account'),
(105,'Individual Retirement Account')
--table 3
insert into SavingsInterestRates
(InterestSavingsRateID,InterestRateValue,InterestRateDescription)
values
(201,'0.0005','Fixed 6 month.'),
(202,'0.0010','Fixed 1 year.'),
(203,'0.0015','Fixed 2 years.'),
(204,'0.0020','Fixed 3 years.'),
(205,'0.0025','Fixed 5 years.')
--table 4
insert into AccountStatusType
(AccountStatusTypeID,AccountStatusDescription)
values
(151,'Test'),
(152,'Closed'),
(153,'Active'),
(154,'Inactive'),
(155,'Locked')
--table 5
insert into TransactionType
(TransactionTypeID,TransactionTypeName,TransactionTypeDescription,TransactionFeeAmount)
values
(111,'CD','Customer Deposit',''),
(112,'CC','Certified Cheque',''),
(113,'DR','Overdraft',''),
(114,'DD','Direct Deposit',''),
(115,'DC','Other Charge','')
--table 6
insert into Account
(AccountID,CurrentBalance,AccountTypeID,AccountStatusTypeID,InterestSavingsRateID)
values
(1000000001,222221,101,151,201),
(1000000002,2228,102,152,201),
(1000000003,22229,103,153,203),
(1000000004,22668,104,154,204),
(1000000005,567221,105,155,205)
--table 7
insert into LoginAccount
(UserLoginID,AccountID)
values
(1001,1000000001),
(1002,1000000002),
(1003,1000000003),
(1004,1000000004),
(1005,1000000005)
--table 8
insert into Customer
(CustomerID,AccountID,CustomerAddress1,CustomerAddress2,CustomerFirstName,CustomerMiddleInitial,CustomerLastName,
City,State,ZipCode,EmailAddress,HomePhone,CellPhone,WorkPhone,SSN,UserLoginID)
values
(13000001,1000000005,'10 Don Mills Rd',Null,'Charles','L','Pearson','Toronto','ON','M2J1X1','CP@cp.com','4160000005','6470000005','4370000005','131',1001),
(13000002,1000000004,'110 Bloor Rd',Null,'Michael','F','James','Vacouver','BC','B2J2X1','MJ@mj.com','4160000004','6470000004','4370000004','132',1002),
(13000003,1000000003,'25 Henry Rd',Null,'Janet','C','Miller','Montreal','QC','Q2J3X1','JM@jm.com','4160000003','6470000003','4370000003','133',1003),
(13000004,1000000002,'80 Don Mills Rd',Null,'Eric','K','Hanson','Toronto','ON','M2J4X1','EH@eh.com','4160000002','6470000002','4370000002','134',1004),
(13000005,1000000001,'98 Don Mills Rd',Null,'Jessic','N','Washington','Toronto','ON','M2J5X1','JW@jw.com','4160000001','6470000001','4370000001','135',1005)
--table 9
insert into CustomerAccount
(AccountID,CustomerID)
values
(1000000005,13000001),
(1000000004,13000002),
(1000000003,13000003),
(1000000002,13000004),
(1000000001,13000005)
--table 10
insert into TransactionLog
(TransactionID,TransactionDate,TransactionTypeID,TransactionAmount,NewBalance,AccountID,CustomerID,UserLoginID)
values
('1500001','Aug 1,2018',111,'12000','25888',1000000001,13000005,1001),
('1500002','Aug 11,2018',114,'100','49009',1000000002,13000004,1002),
('1500003','Aug 21,2018',111,'500','125000',1000000003,13000003,1003),
('1500004','Aug 31,2018',112,'282000','325888',1000000004,13000002,1004),
('1500005','Aug 10,2018',111,'380','246808',1000000005,13000001,1005)

---------------------------------------------------------------------------------------------------