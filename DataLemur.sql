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

select  p.profile_id from personal_profiles p                              # Part- 1
join company_pages c on p.employer_id = c.company_id
where p.followers > c.followers
order by profile_id;


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
