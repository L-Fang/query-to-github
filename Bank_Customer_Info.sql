/*drop database Bank*/
create database Bank




--use Bank
----------------------------------------------------------------------------------
--create 9 tables without Foreign Key
----------------------------------------------------------------------------------
--table 1
create table UserLogins(
UserLoginID smallint primary key,
UserLogin char(15),
UserPassword varchar(20)
)
--table 2

--table 3
create table AccountType(
AccountTypeID smallint primary key,
AccountTypeDescription varchar(30)
)
--table 4
create table SavingsInterestRates(
InterestSavingsRateID smallint primary key,
InterestRateValue numeric(9,9),
InterestRateDescription varchar(20)
)
--table 5
create table AccountStatusType(
AccountStatusTypeID smallint primary key,
AccountStatusDescription varchar(30)
)
--table 6

--table 7
create table TransactionType(
TransactionTypeID smallint primary key,
TransactionTypeName char(10),
TransactionTypeDescription varchar(50),
TransactionFeeAmount money
)
--table 8

--table 9

----------------------------------------------------------------------------------
--create 8 tables with Foreign Key
----------------------------------------------------------------------------------
--table 10

--table 11
-- create table Account(
-- AccountID int primary key,
-- CurrentBalance int,
-- AccountTypeID tinyint foreign key references AccountType (AccountTypeID),
-- AccountStatusTypeID tinyint foreign key references AccountStatusType (AccountStatusTypeID),
-- InterestSavingsRateID tinyint foreign key references SavingsInterestRates (InterestSavingsRateID)
-- )
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

--table 12
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
--table 13
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
--table 14
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
--table 15
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
--table 16
create table UserSecurityAnswers(
UserLoginID smallint primary key foreign key references UserLogins(UserLoginID),
UserSecurityAnswer varchar(25),
UserSecurityQuestionID tinyint foreign key references UserSecurityQuestions (UserSecurityQuestionID)
)
--table 17
create table OverDraftLog(
AccountID int primary key foreign key references Account (AccountID),
OverDraftDate datetime,
OverDraftAmount money,
OverDraftTransactionXML xml
)
------------------------------------------------------------------------------------------------------
--Insert Values
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
insert into UserSecurityQuestions
(UserSecurityQuestionID,UserSecurityQuestion)
values
(1,'where were you born?'),
(2,'which city was your mother born?'),
(3,'which city was your father born?'),
(4,'which color do you like?'),
(5,'what is your major?')
--table 3
insert into AccountType
(AccountTypeID,AccountTypeDescription)
values
(101,'Checking Account'),
(102,'Savings Account'),
(103,'Certificate of Deposit (CD)'),
(104,'Money Market Account'),
(105,'Individual Retirement Account')
--table 4
insert into SavingsInterestRates
(InterestSavingsRateID,InterestRateValue,InterestRateDescription)
values
(201,'0.0005','Fixed 6 month.'),
(202,'0.0010','Fixed 1 year.'),
(203,'0.0015','Fixed 2 years.'),
(204,'0.0020','Fixed 3 years.'),
(205,'0.0025','Fixed 5 years.')
--table 5
insert into AccountStatusType
(AccountStatusTypeID,AccountStatusDescription)
values
(151,'Test'),
(152,'Closed'),
(153,'Active'),
(154,'Inactive'),
(155,'Locked')
--table 6
insert into Employee
(EmployeeID, EmployeeFirstName,EmployeeMiddleInitial,EmployeeLastName,EmployeeManager)
values
(120001,'Faith','A','Kate',0),
(120002,'Gill','B','Lin',1),
(120003,'Henry','C','Mathew',0),
(120004,'Ivy','D','New',0),
(120005,'Jerry','E','Olay',0)
--table 7
insert into TransactionType
(TransactionTypeID,TransactionTypeName,TransactionTypeDescription,TransactionFeeAmount)
values
(111,'CD','Customer Deposit',''),
(112,'CC','Certified Cheque',''),
(113,'DR','Overdraft',''),
(114,'DD','Direct Deposit',''),
(115,'DC','Other Charge','')
--table 8
insert into LoginErrorLog
(ErrorLogID,ErrorTime,FailedTransactionXML)
values
(1501,'Oct 1,2018','http:\\150110012018.xml'),
(1502,'Oct 5,2018','http:\\150210012018.xml'),
(1503,'Oct 10,2018','http:\\150310012018.xml'),
(1504,'Oct 15,2018','http:\\150410012018.xml'),
(1505,'Oct 20,2018','http:\\150510012018.xml')
--table 9
insert into FailedTransactionErrorType
(FailedTransactionErrorTypeID,FailedTransactionDescription)
values
(171,'FialedTransactionError171'),
(172,'FialedTransactionError172'),
(173,'FialedTransactionError173'),
(174,'FialedTransactionError174'),
(175,'FialedTransactionError175')
--table 10
insert into FailedTransactionLog
(FailedTransactionID,FailedTransactionErrorTypeID,FailedTransactionErrorTime,FailedTransactionXML)
values
(1601,'175','Sep 1,2018','http:\\FailedTransactionError09012018.xml'),
(1602,'174','Sep 3,2018','http:\\FailedTransactionError09032018.xml'),
(1603,'173','Sep 5,2018','http:\\FailedTransactionError09052018.xml'),
(1604,'172','Sep 9,2018','http:\\FailedTransactionError09092018.xml'),
(1605,'171','Sep 16,2018','http:\\FailedTransactionError09162018.xml')
--table 11
insert into Account
(AccountID,CurrentBalance,AccountTypeID,AccountStatusTypeID,InterestSavingsRateID)
values
(1000000001,222221,101,151,201),
(1000000002,2228,102,152,201),
(1000000003,22229,103,153,203),
(1000000004,22668,104,154,204),
(1000000005,567221,105,155,205)
--table 12
insert into LoginAccount
(UserLoginID,AccountID)
values
(1001,1000000001),
(1002,1000000002),
(1003,1000000003),
(1004,1000000004),
(1005,1000000005)
--table 13
insert into Customer
(CustomerID,AccountID,CustomerAddress1,CustomerAddress2,CustomerFirstName,CustomerMiddleInitial,CustomerLastName,
City,State,ZipCode,EmailAddress,HomePhone,CellPhone,WorkPhone,SSN,UserLoginID)
values
(13000001,1000000005,'10 Don Mills Rd',Null,'Charles','L','Pearson','Toronto','ON','M2J1X1','CP@cp.com','4160000005','6470000005','4370000005','131',1001),
(13000002,1000000004,'110 Bloor Rd',Null,'Michael','F','James','Vacouver','BC','B2J2X1','MJ@mj.com','4160000004','6470000004','4370000004','132',1002),
(13000003,1000000003,'25 Henry Rd',Null,'Janet','C','Miller','Montreal','QC','Q2J3X1','JM@jm.com','4160000003','6470000003','4370000003','133',1003),
(13000004,1000000002,'80 Don Mills Rd',Null,'Eric','K','Hanson','Toronto','ON','M2J4X1','EH@eh.com','4160000002','6470000002','4370000002','134',1004),
(13000005,1000000001,'98 Don Mills Rd',Null,'Jessic','N','Washington','Toronto','ON','M2J5X1','JW@jw.com','4160000001','6470000001','4370000001','135',1005)
--table 14
insert into CustomerAccount
(AccountID,CustomerID)
values
(1000000005,13000001),
(1000000004,13000002),
(1000000003,13000003),
(1000000002,13000004),
(1000000001,13000005)
--table 15
insert into TransactionLog
(TransactionID,TransactionDate,TransactionTypeID,TransactionAmount,NewBalance,AccountID,CustomerID,EmployeeID,UserLoginID)
values
('1500001','Aug 1,2018',111,'12000','25888',1000000001,13000005,120001,1001),
('1500002','Aug 11,2018',114,'100','49009',1000000002,13000004,120002,1002),
('1500003','Aug 21,2018',111,'500','125000',1000000003,13000003,120003,1003),
('1500004','Aug 31,2018',112,'282000','325888',1000000004,13000002,120004,1004),
('1500005','Aug 10,2018',111,'380','246808',1000000005,13000001,120005,1005)
--table 16
insert into UserSecurityAnswers
(UserLoginID,UserSecurityAnswer,UserSecurityQuestionID)
values
(1001,'Canada',1),
(1002,'Toronto',2),
(1003,'USA',1),
(1004,'Purple',4),
(1005,'Canada',3)
--table 17
insert into OverDraftLog
(AccountID,OverDraftDate,OverDraftAmount,OverDraftTransactionXML)
values
(1000000001,'Sep 2,2018','100','Http:\\201809020001overdraft.xml'),
(1000000002,'Sep 12,2018','200','Http:\\201809120002overdraft.xml'),
(1000000003,'Sep 21,2018','300','Http:\\201809210003overdraft.xml'),
(1000000004,'Oct 2,2018','180','Http:\\201810020004overdraft.xml'),
(1000000005,'Sep 28,2018','108','Http:\\201809280005overdraft.xml')

---------------------------------------------------------------------------------------------------