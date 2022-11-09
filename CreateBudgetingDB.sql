--drop database each time i run this, no alters until  i have data
IF (DB_ID('BudgetingApp') is not null)
begin
	use master
	drop database BudgetingApp
end

go

create database BudgetingApp

go

use BudgetingApp;

go

create table Frequency
(
	ID int identity(1,1) primary key,
	Value nchar(7)
)

insert into Frequency (Value)
Values ('Daily'), ('Weekly'), ('Monhtly'), ('Yearly')

create table Category
(
	ID int identity(1,1) primary key,
	Name nvarchar(255)
)

insert into Category (Name)
values ('Transportation'), ('Housing'), ('Groceries'), ('Entertainment'), ('Subscriptions')

create table [User]
(
	ID int identity(1,1) primary key,
	Firstname nvarchar(255),
	Lastname nvarchar(255)
)

go

create table Income 
(
	ID int identity(1,1) primary key,
	UserID int foreign key references [User](ID),
	Name nvarchar(255),
	IsRecurring bit,
	RecurringDate Date,
	Amount money
)

create table Expense 
(
	ID int identity(1,1) primary key,
	UserID int foreign key references [User](ID),
	Name nvarchar(255),
	IsRecurring bit,
	RecurringDate Date,
	Amount money
)

create table Debt
(
	ID int identity(1,1) primary key,
	UserID int foreign key references [User](ID),
	Name nvarchar(255),
	FinalDueDate date,
	FinalAmount money,
	FrequencyID int foreign key references Frequency(ID),
	NextPaymentDate Date,
	NextPaymentAmount money
)

create table Goal
(
	ID int identity(1,1) primary key,
	Name nvarchar(255),
	GoalAmount money,
	GoalDate date,
	FrequencyID int foreign key references Frequency(ID),
	NextSavingDate date,
	NextSavingAmount money
)

create table UserCategory
(
	ID int identity(1,1) primary key,
	CategoryID int foreign key references Category(ID),
	BudgetLimit money,
	BudgetLimitPercentage smallint
)



