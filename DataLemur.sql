create database adobe_int;
use adobe_int;
DROP TABLE transactions;

create table transactions (
customer_id int,
product varchar(50),
revenue int);

insert into transactions values (123, 'photoshop' , 50),
(123, 'premier pro' , 100),
(123, 'after effects' , 50),
(234, 'illustrator' , 200),
(234, 'premier pro' , 100),
(562, 'illustrator' , 200),
(913, 'photoshop' , 50),
(913, 'premier pro' , 100),
(913, 'illustrator' , 200);

select * from transactions;

select customer_id,
SUM( CASE WHEN product != 'photoshop' then  revenue end ) as Total_revenue
from transactions
where customer_id IN (select customer_id from transactions where product = 'photoshop')
group by customer_id;


-------------------------------------------------------------------------------------------------------------------------
# Problem 1: linkedin (Data Science Skills)

# Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job.
 You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.
 Write a query to list the candidates who possess all of the required skills for the job. Sort the the output by candidate ID in ascending order.

Assumption:

There are no duplicates in the candidates table.

create table if not exists candidates(
candidate_id int,
skill varchar(50));

insert into candidates values (123, 'Python'),
(123,'Tableau'),
(123,'PostgreSQL'),
(234, 'R'),
(234,'PowerBI'),
(234,'SQL Server'),
(345,'Python'),
(345,'Tableau');

select * from candidates;

select candidate_id
from candidates
where skill IN( 'python' , 'tableau' , 'postgreSQL')
group by candidate_id
having count(skill)=3
order by candidate_id  asc;

# Second Method

select candidate_id
from candidates
where
		case skill
		when 'python' then candidate_id 
		when 'tableau' then candidate_id 
		when 'postgreSQL' then candidate_id end;
        
        
----------------------------------------------------------------------------------------------------------------------
# Problem : paypal(FinalAccount Balance)


create table if not exists transactions_1 ( 
`tansaction_id` INT NOT NULL,
  `account_id` INT NOT NULL,
  `transaction_type` VARCHAR(45) NOT NULL,
  `amount` DECIMAL NOT NULL);
  
 
  insert into transactions_1 values
(123,101,10.00,'Deposit'),
(124,101,20.00	,'Deposit'),
(126,201,20.00	,'Deposit'),
(125,101,5.00,'Withdrawal'),
(128,201,10.00,'Withdrawal'),
(130,301,98.00,'Deposit'),
(140,201,16.00,'Deposit');
  insert into transactions_1 values (132, 301, 36.00 ,'withdrawal'); 
  select * from  transactions_1 ;
 
select account_id,
 SUM(case transaction_type
 when 'Deposit' then amount
 else -amount
 end) as balance_amount
 from transactions_1
 GROUP BY account_id
 order by account_id asc;
 
 --------------------------------------------------------------------------------------------------------------------
 # Problem : LinkedIn Power Creators (Part 1) 
 
 
# Part- 1
# The LinkedIn Creator team is looking for power creators who use their personal profile as a company or influencer page.
If someone's LinkedIn page has more followers than the company they work for, we can safely assume that person is a power creator.

Write a query to return the IDs of these LinkedIn power creators ordered by the IDs.

Assumption:

Each person with a LinkedIn profile in this database works at one company only.
 
 create table if not exists personal_profiles(
 profile_id int NOT NULL,
 `name` varchar(50) NOT NULL,
 followers int NOT NULL ,
 employer_id int NOT NULL);
 
insert  into personal_profiles values
(1 , "Nick Singh" , 92000 ,4),
(2 , "Zach Wilson" , 199000, 2),
(3 , "Daliana Liu" , 171000, 1),
(4 , "Ravit Jain" , 107000, 3),
(5 , "Vin Vashishta" , 139000, 6),
(6 , "Susan Wojcicki" , 39000, 5);

select * from personal_profiles;

create table company_pages(
company_id integer,
name varchar(50),
followers integer);
 
Insert  into company_pages values
(1 , "The Data Science Podcast" , 8000),
(2 , "Airbnb" , 700000),
(3 , "The Ravit Show" , 6000),
(4 , "DataLemur" , 200),
(5 , "YouTube" ,16000000),
(6 , "DataScience.Vin" , 4500);

select * from company_pages;
select * from personal_profiles;

select  p.profile_id from personal_profiles p
join company_pages c on p.employer_id = c.company_id
where p.followers > c.followers
order by profile_id;

-----------------------------------------------------------------------------------------------------------------------------
 # Problem : Highest Number of Products (eBay)       


Create Table if not exists user_transactions (
transaction_id	integer,
product_id	integer,
user_id	integer,
spend	decimal(8,2));

drop table user_transactions;
insert into user_transactions values
(131432	,1324	,128 ,699.78),
(131433	,1313	,128 ,501.00),
(153853	,2134	,102 ,1001.20),
(247826	,8476	,133 ,1051.00),
(247265	,3255	,133 ,1474.00),
(136495	,3677	,133 ,247.56),
(138472	,9642	,124 ,1352.78),
(826491	,1455	,146 ,1476.00),
(274957	,2523	,159 ,827.40),
(837857	,1452	,159 ,150.33),
(727585	,1475	,133 ,4716.00),
(272649 ,9765	,164 ,1342.00),
(727596	,6536	,182 ,1421.00),
(826561	,3464	,135 ,1242.00),
(232495	,2453	,173 ,1564.50);

select * from user_transactions;


select user_id , count(user_id) as No_of_product
from user_transactions
group by user_id
having sum(spend)>=1000
order by No_of_product desc , sum(spend) desc
limit 3;

---------------------------------------------------------------------------------------------------------------------------
 # Problem : Apple Pay Volume (VISA)
 
 create table if not exists transactions_visa (
merchant_id	integer,
transaction_amount	integer,
payment_method	varchar(100)) ;

insert into transactions_visa  values 
(1,	600,	"Contactless Chip"),
(2,	560	,"Magstripe"),
(1,	850	,"Apple Pay"),
(1,	500	,"Apple Pay"),
(2,	400	,"Samsung Pay"),
(3,	1000,	"Google Pay"),
(3,	1600,	"Apple Pay"),
(5,	770	,"Apple Pay"),
(3,	2050,	"Apple Pay"),
(5,	500	,"Google Pay"),
(5,	2500,	"Apple pay"),
(3,	100	,"Contactless chip"),
(4,	1180,	"apple pay"),
(4,	1200,	"apple pay");

select * from transactions_visa;


select merchant_id,
sum( case payment_method
    when 'apple pay' then transaction_amount 
    else 0 end  ) as Transaction_volume
    from transactions_visa
    group by  merchant_id
    order by Transaction_volume desc;

------------------------------------------------------------------------------------------------------------------------------
 # Problem : Ad Campaign ROAS (Google)
 
 
create table if not exists ad_campaigns (
campaign_id	integer,
spend	integer,
advertiser_id int,
revenue	float);

insert into ad_campaigns values 
(2,	900,	1,	1000),
(3,	12000,	2,	3000),
(4,	2000,	4,	500),
(5,	400,	4,	100),
(6,	5500,	2,	1500),
(7,	30000,	6,	12500),
(8,	10000,	1,	12000),
(1,	7500,	3,	5000);

select * from ad_campaigns;

select advertiser_id ,round(sum(revenue)/sum(spend),2) as Roas from
ad_campaigns
group by advertiser_id
order by advertiser_id ;


-------------------------------------------------------------------------------------------------------------------------------
# Problem : LinkedIn Power Creators (Part 2)          MEDIUM LEVEL
 
 # The LinkedIn Creator team is looking for power creators who use their personal profile as a company or influencer page.
  This means that if someone's Linkedin page has more followers than all the company they work for, we can safely assume that person is a Power Creator.
  Keep in mind that if a person works at multiple companies, we should take into account the company with the most followers.

Write a query to return the IDs of these LinkedIn power creators in ascending order.

Assumptions:

A person can work at multiple companies.
In the case of multiple companies, use the one with largest follower base.
 create table if not exists personal_profiles(
 profile_id int NOT NULL,
 `name` varchar(50) NOT NULL,
 followers int NOT NULL ,
 employer_id int NOT NULL);
 
insert  into personal_profiles values
(1 , "Nick Singh" , 92000 ,4),
(2 , "Zach Wilson" , 199000, 2),
(3 , "Daliana Liu" , 171000, 1),
(4 , "Ravit Jain" , 107000, 3),
(5 , "Vin Vashishta" , 139000, 6),
(6 , "Susan Wojcicki" , 39000, 5);
insert into personal_profiles values
(7,'Danny Ma', 91000, 7),
(8,'Chris Dutton', 43000, 8);
select * from personal_profiles;

create table company_pages(
company_id integer,
name varchar(50),
followers integer);

 
Insert  into company_pages values
(1 , "The Data Science Podcast" , 8000),
(2 , "Airbnb" , 700000),
(3 , "The Ravit Show" , 6000),
(4 , "DataLemur" , 200),
(5 , "YouTube" ,16000000),
(6 , "DataScience.Vin" , 4500);

insert into company_pages values
(7,'Sydney Data Science' ,1000),
(8,'Maven Analytics', 71000),
(9,'Ace The Data Science Interview', 4479),
(10,'Amazon Web Services', 7341669);

select * from company_pages;
select * from personal_profiles;



create table if not exists employee_company (
personal_profile_id	integer,
company_id	integer);

insert into employee_company values
(1, 4),
(1,	9),
(2,	2),
(3,	1),
(3,	10),
(4,	3),
(5,	6),
(6,	5),
(7,	7),
(8,	8);

select * from employee_company;
select * from company_pages;
select * from personal_profiles;


with popular_id as (
select employee.personal_profile_id, max(pages.followers) as Highest_follower
from employee_company as employee
left join company_pages as pages on employee.company_id = pages.company_id
  group by employee.personal_profile_id)
  
  Select p.profile_id 
  from personal_profiles as p
  left join popular_id on p.profile_id = popular_id.personal_profile_id
  where p.followers >popular_id.highest_follower
  group by p.profile_id
  order by p.profile_id;

--------------------------------------------------------------------------------------------------------------------------


# PROBLEM : Page With No Likes (FACEBOOK)
   Assume you are given the tables below about Facebook pages and page likes. 
   Write a query to return the page IDs of all the Facebook pages that don't have any likes. 
   The output should be in ascending order.

CREATE TABLE PAGES (
PAGE_ID	INTEGER,
`NAME` VARCHAR(50));

INSERT INTO PAGES VALUES
(20001,'SQL SOLUTIONS'),
(20045, 'BRAIN EXERCISES'),
(20701, 'TIPS FOR DATA ANALYSTS'),
(31111, 'POSTGRES CRASH COURSE'),
(32728, 'BREAK THE THREAD');

SELECT * FROM PAGES;

CREATE TABLE PAGE_LIKES
(USER_ID INT ,
PAGE_ID INT,
LIKED_DATE DATETIME);

INSERT INTO PAGE_LIKES VALUES
(111,20001, '2022-04-08 00:00:00'),
(121,20045,	'2022-03-12 00:00:00'),
(156,20001,	'2022-07-25 00:00:00'),
(255,20045,	'2022-07-19 00:00:00'),
(125,20001,	'2022-07-19 00:00:00'),
(144,31111,	'2022-06-21 00:00:00');

SELECT * FROM PAGE_LIKES;

WITH FACEBOOK AS (
SELECT PG.PAGE_ID , PL.USER_ID , PL.LIKED_DATE  FROM PAGES AS PG
LEFT JOIN PAGE_LIKES AS PL ON PG.PAGE_ID = PL.PAGE_ID)
SELECT PAGE_ID FROM FACEBOOK WHERE LIKED_DATE IS NULL;

---------------------------------------------------------------------------------------------------------------------------------------------------------

# Unfinished Parts (TESLA)
# PROBLEM : Tesla is investigating bottlenecks in their production, and they need your help to extract the relevant data. 
  Write a SQL query that determines which parts have begun the assembly process but are not yet finished.
  Assumption
  Table parts_assembly contains all parts in production.
  
  CREATE TABLE PARTS_ASSEMBLY (
  PART VARCHAR(50),
  FINISH_DATE	DATETIME,
  ASSEMBLY_STEP INTEGER);
  
INSERT INTO PARTS_ASSEMBLY VALUES
("BATTERY",'2022-01-22 00:00:00',1),
("BATTERY",'2022-02-22 00:00:00',2),
("BATTERY",'2022-03-22 00:00:00',3),
("BUMPER",'2022-01-22 00:00:00',1),
("BUMPER",'2022-02-22 00:00:00',2),
("BUMPER", NULL ,3),
("BUMPER", NULL  ,4),
("DOOR",'2022-01-22 00:00:00',1),
("DOOR",'2022-02-22 00:00:00',2),
('ENGINE','2022-01-01 00:00:00',1),
('ENGINE','2022-01-25 00:00:00',2),
('ENGINE','2022-02-28 00:00:00',3),
('ENGINE','2022-04-01 00:00:00',4),
('ENGINE', NULL ,5);

SELECT PART FROM PARTS_ASSEMBLY WHERE FINISH_DATE IS NULL;
----------------------------------------------------------------------------------------------------------------------------------------------------------------
# PROBLEM : User's Third Transaction (UBER)

Assume you are given the table below on Uber transactions made by users.
Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

CREATE TABLE IF NOT EXISTS TRANSACTIONS_3
(USER_ID INT,
SPEND DECIMAL(50,2),
TRANSACTION_DATE TIMESTAMP);

SELECT * FROM TRANSACTIONS_3;
INSERT INTO TRANSACTIONS_3 VALUES
(111,   100.50,	'2022-01-08 12:00:00'),
(111,	55.00,	'2022-01-10 12:00:00'),
(121,	36.00,	'2022-01-18 12:00:00'),
(145,	24.99,	'2022-01-26 12:00:00'),
(111,	89.60,	'2022-02-05 12:00:00'),
(145,	45.30,	'2022-02-28 12:00:00'),
(121,	22.20,	'2022-04-01 12:00:00'),
(121,	67.90,	'2022-04-03 12:00:00'),
(263,	156.00,	'2022-04-11 12:00:00'),
(230,	78.30,	'2022-06-14 12:00:00'),
(263,	68.12,	'2022-07-11 12:00:00'),
(263,	100.00,	'2022-07-12 12:00:00');

SELECT USER_ID, SPEND , TRANSACTION_DATE FROM (SELECT USER_ID , SPEND , TRANSACTION_DATE ,
 RANK() OVER ( PARTITION BY  USER_ID ORDER BY TRANSACTION_DATE) AS TNX_3
FROM TRANSACTIONS_3) AS T3  WHERE TNX_3 = 3;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

Problem : Pharmacy Analytics (Part 1) CSV HEALTH

# CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. Each drug can only be produced by one manufacturer.

Write a query to find the top 3 most profitable drugs sold, and how much profit they made. Assume that there are no ties in the profits. Display the result from the highest to the lowest total profit.

Definition:

cogs stands for Cost of Goods Sold which is the direct cost associated with producing the drug.
Total Profit = Total Sales - Cost of Goods Sold


create table if not exists pharmacy_sales (
roduct_id	integer,
units_sold	integer,
total_sales	decimal (50,2),
cogs	decimal (50,2),
manufacturer	varchar (50),
drug	varchar (50) );
select * from pharmacy_sales;

LOAD DATA INFILE  
'E:/data_sales.csv'
into table pharmacy_sales
FIELDS TERMINATED by ','
ENCLOSED by '"'
lines terminated by '\n';


select  distinct ( total_sales - cogs)  as total_profit, Drug from pharmacy_sales order by total_profit desc
limit 3;
--------------------------------PART - 2-----------------------------------------------------------------------------------------------------------------------
# CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. Each drug can only be produced by one manufacturer.

Write a query to find out which manufacturer is associated with the drugs that were not profitable and how much money CVS lost on these drugs. 

Output the manufacturer, number of drugs and total losses. Total losses should be in absolute value. Display the results with the highest losses on top.

# Part - 2
select manufacturer , count(drug) as Total_drug , round(sum(cogs - total_sales),0) as total_loss from pharmacy_sales
where cogs > total_sales
group by manufacturer 
order by Total_drug desc;

--------------------------------------------PART: 3-----------------------------------------------------------------------------------------------------------------

# CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. Each drug can only be produced by one manufacturer.

Write a query to find the total sales of drugs for each manufacturer. Round your answer to the closest million, and report your results in descending order of total sales.

Because this data is being directly fed into a dashboard which is being seen by business stakeholders, format your result like this: "$36 million".

# Part - 3
select manufacturer , concat("$"," ",round(sum(total_sales)/1000000)," ","Millions") as sum_of_total_sales_in_Millions from pharmacy_sales
group by manufacturer
order by sum(total_sales) desc ;

--------------------------------------------PART :4----------------------------------------------------------------------------------------------------------------------
# CVS Health is trying to better understand its pharmacy sales, and how well different drugs are selling.

Write a query to find the top 2 drugs sold, in terms of units sold, for each manufacturer. List your results in alphabetical order by manufacturer.

#Part - 4

select * from ( select  manufacturer , drug, rank() over (partition by manufacturer order by units_sold desc) as top
 from pharmacy_sales) as top_2 where top <3;
 



