-------------------------------------------DataLemur (Medium_level)------------------------------------------------------
# Problem Medium Level : Sportify Top 5 Artit

# Assume there are three Spotify tables containing information about the artists, songs, and music charts. 
Write a query to determine the top 5 artists whose songs appear in the Top 10 of the global_song_rank table the highest number of times.
From now on, we'll refer to this ranking number as "song appearances".

Output the top 5 artist names in ascending order along with their song appearances ranking (not the number of song appearances,
but the rank of who has the most appearances). The order of the rank should take precedence.

For example, Ed Sheeran's songs appeared 5 times in Top 10 list of the global song rank table; this is the highest number of appearances, 
so he is ranked 1st. Bad Bunny's songs appeared in the list 4, so he comes in at a close 2nd.

Assumptions:

If two artists' songs have the same number of appearances, the artists should have the same rank.
The rank number should be continuous (1, 2, 2, 3, 4, 5) and not skipped (1, 2, 2, 4, 5).

create table if not exists artists (
artist_id	integer,
artist_name	varchar(100));


insert into artists values 
(101, 'Ed Sheeran'),
(120, 'Drake'),
(125, 'Bad Bunny'),
(145, 'Lady Gaga'),
(160, 'Chris Brown'),
(200, 'Adele'),
(240, 'Katy Perry');



Create Table if not exists songs (
song_id	integer,
artist_id	integer);


Insert into songs values 
(55511,	101),
(45202,	101),
(22222,	120),
(19960,	120),
(12636,	125),
(69820,	125),
(11254,	145),
(33101,	160),
(44552,	125),
(23299,	200),
(89633,	240),
(28079,	200);


Create Table if not exists global_song_rank (
day	integer ,
song_id	integer,
`rank`	integer );

Insert into global_song_rank values
(1, 45202,	2),
(3, 45202,	2),
(15, 45202,	6),
(2, 55511,	2),
(1, 19960,	3),
(9, 19960,	15),
(23, 12636,	9),
(24, 12636,	7),
(2, 12636,	23),
(29, 12636,	7),
(1, 69820,	1),
(17, 44552,	8),
(11, 44552,	16),
(11, 11254,	5),
(12, 11254,	16),
(3, 33101,	16),
(6, 23299,	1),
(14, 89633,	2),
(9, 28079,	9),
(7, 28079,	10),
(40, 11254,	1),
(37, 23299,	5),
(19, 11254,	10),
(23, 89633,	10),
(52, 33101,	7),
(20, 55511,	10),
(7, 22222,	8),
(8, 44552,	1),
(40,11254,	10),
(50, 89633,	1);


select * from artists;
select * from songs;
select * from global_song_rank;


    with cte_artist as (
    SELECT songs.artist_id, COUNT(songs.song_id) AS song_count,
    dense_rank() over(order by  COUNT(songs.song_id) desc ) as top
    FROM songs
    INNER JOIN global_song_rank AS ranking
      ON songs.song_id = ranking.song_id
	WHERE ranking.rank <= 10
    GROUP BY songs.artist_id )
    
    select a.artist_name, cte_artist.top, cte_artist.song_count
    from artists as a 
    join cte_artist on a.artist_id = cte_artist.artist_id
    order by cte_artist.top 
    limit 6;
---------------------------------------------------------------------------------------------------------------------------------
    
 # Problem : Highest-Grossing Items (Amazon)
    
 # This is the same question as problem #12 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table containing information on Amazon customers and their spending on products in various categories.

Identify the top two highest-grossing products within each category in 2022. Output the category, product, and total spend.


CREATE TABLE PRODUCT_SPEND 
(CATEGORY VARCHAR(50),
PRODUCT VARCHAR(50),
USER_ID INT,
SPEND DECIMAL(50,2));

INSERT INTO PRODUCT_SPEND VALUES
('APPLIANCE', 'WASHING MACHINE', 123 ,219.80),
('ELECTRONICS','VACUUM', 178, 152.00 ),
('ELECTRONICS','WIRELESS HEADSET', 156, 249.90	),
('ELECTRONICS','VACUUM', 145, 189.00 ),
('ELECTRONICS','COMPUTER MOUSE', 195, 45.00),
('APPLIANCE', 'REFRIGERATOR', 165, 246.00 ),
('APPLIANCE', 'REFRIGERATOR', 123, 299.99 ),
('APPLIANCE', 'WASHING MACHINE', 123, 220.00 ),
('ELECTRONICS', 'VACUUM', 156, 145.66 ),
('ELECTRONICS', 'WIRELESS HEADSET', 145, 198.00);

SELECT * FROM PRODUCT_SPEND;

SELECT * FROM  
(SELECT CATEGORY, PRODUCT, SPEND, RANK() OVER (PARTITION BY CATEGORY ORDER BY SPEND DESC ) AS TOP_SPEND
 FROM PRODUCT_SPEND) AS SP
WHERE TOP_SPEND = 1;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Problem : App Click-through Rate (CTR)  [Facebook]

#This is the same question as problem #1 in the SQL Chapter of Ace the Data Science Interview!

Assume you have an events table on app analytics. Write a query to get the app’s click-through rate (CTR %) in 2022. 
Output the results in percentages rounded to 2 decimal places.

Notes:

- To avoid integer division, you should multiply the click-through rate by 100.0, not 100.
- Percentage of click-through rate = 100.0 * Number of clicks / Number of impressions

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Problem : Second Day Confirmation (Tik Tok)

#New TikTok users sign up with their emails and each user receives a text confirmation to activate their account. 
Assume you are given the below tables about emails and texts.

Write a query to display the ids of the users who did not confirm on the first day of sign-up, but confirmed on the second day.

Assumption: action_date is the date when the user activated their account and confirmed their sign-up through the text.

 create table emails
(email_id int,
user_id int,
signup_date datetime
);

insert into emails values
(125,	7771,	'2022-06-14 00:00:00'),
(236,	6950,	'2022-07-01 00:00:00'),
(433,	1052,	'2022-07-09 00:00:00'),
(450,   8963,	'2022-08-02 00:00:00'),
(555,	8963,	'2022-08-09 00:00:00'),
(741,	1235,	'2022-07-25 00:00:00');

create table texts 
(text_id int,
email_id int,
signup_action varchar(50),
action_date datetime
);

insert into texts values
(6878,	125,	"Confirmed", '2022/06/14 00:00:00'),
(6997,	433,	"Not confirmed", '2022/07/19 00:00:00'),
(7000,	433,	"Confirmed", '2022/07/10 00:00:00'),
(9841,	236,	"Confirmed", '2022/07/01 00:00:00'),
(2800,	555,	"Confirmed", '2022/08/11 00:00:00'),
(1568,	741,	"Confirmed", '2022/07/26 00:00:00'),
(1255,	555,	"Not confirmed", '2022/08/09 00:00:00'),
(1522,	741,	"Not confirmed", '2022/07/25 00:00:00'),
(6800,	450,	"Not confirmed", '2022/08/02 00:00:00'),
(2660,	555,	"Not confirmed", '2022/08/09 00:00:00');

select * from texts;

select user_id from emails 
inner join texts on emails.email_id = texts.email_id
where action_date = date_add(signup_date , interval 1 day)
and signup_action = "confirmed";   

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Problem : Repeat Purchases on Multiple Days ( Stitch Fix )

# Assume you are given the table below containing information on user purchases.
Write a query to obtain the number of users who purchased the same product on two or more different days.
Output the number of unique users.
PS. On 26 Oct 2022, we expanded the purchases data set, thus the official output may vary from before.

create table if not exists purchases (
user_id	integer,
product_id	integer,
quantity	integer,
purchase_date	datetime);

insert into purchases values
(333,	1122,	9,	'2022-06-02'),
(333,	1122,	10	,'2022-06-02'),
(536,	3223,	6,	'2022-01-11'),
(827,	3585,	35,	'2022-02-20'),
(536,3223,	5,	'2022-03-02'),
(536,	1435,	10,	'2022-03-02'),
(333,	1122,	8,	'2022-06-02'),
(827,	3585,	12,	'2022-04-09'),
(827,	2452,	45,'2022-04-09'),
(536,	3223,	34,	'2022-04-28');

select * from purchases;

select p1.user_id from purchases as p1
inner join purchases as p2 
on p1.user_id = p2.user_id
where p1.product_id = p2.product_id
and p1.purchase_date <> p2.purchase_date
group by p1.user_id;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Problem : Card Launch Success (JP Morgan)

# Your team at JPMorgan Chase is soon launching a new credit card. You are asked to estimate how many cards you'll issue in the first month.
Before you can answer this question, you want to first get some perspective on how well new credit card launches typically do in their first month.

Write a query that outputs the name of the credit card, and how many cards were issued in its launch month. 
The launch month is the earliest record in the monthly_cards_issued table for a given card. Order the results starting from the biggest issued amount.

create table monthly_cards_issued(
card_name varchar(50),
issued_amount int,
issue_month int,
issue_year int
);

  insert into monthly_cards_issued values
 ("Chase Sapphire Reserve", 160000, 12, 2020),
 ("Chase Sapphire Reserve", 170000, 1, 2021),
 ("Chase Sapphire Reserve", 175000, 2, 2021),
 ("Chase Sapphire Reserve", 180000, 3, 2021),
 ("Chase Freedom Flex",	55000,	1, 2021),
 ("Chase Freedom Flex",	60000,	2, 2021),
 ("Chase Freedom Flex",	65000,	3, 2021),
 ("Chase Freedom Flex",	70000,	4, 2021),
 ("Chase Sapphire Reserve", 150000, 11, 2020);

  select * from monthly_cards_issued;

 select distinct ( t1.card_name), t1.issued_amount, t1.issue_year, t1.issue_month from monthly_cards_issued as t1
 inner join monthly_cards_issued as t2
 on t1.card_name = t2.card_name
 where t1.issue_month < t2.issue_month
 and t1.issue_year >= t2.issue_year
 group by t1.card_name;
 
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
# Problem : Teams Power Users (Microsoft - Easy)

# Write a query to find the top 2 power users who sent the most messages on Microsoft Teams in August 2022.
Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending count of the messages.

Assumption: No two users has sent the same number of messages in August 2022.

create table if not exists messages (
message_id	integer,
sender_id	integer,
receiver_id	integer,
content	varchar(100),
sent_date varchar(20));


insert into messages values
(100,2520,	6987,	"Send this out now!",	"08/16/2021"),
(922,3601,	4500,	"Get on the call",	"08/10/2022"),
(819,2310,	4500,	"What's the status on this?	","07/10/2022"),
(743,3601,	8752,	"Let's take this offline",	"06/14/2022"),
(902,4500,	3601,	"Only if you're buying",	"08/03/2022"),
(901,3601,	4500,	"You up?",	"08/03/2022"),
(966,3601,	7852,	"Meet me in five!",	"08/17/2022"),
(942,2520,	3561,	"How much do you know about Data Science?",	"08/17/2022"),
(888,3601,	7855,	"DataLemur has awesome user base!",	"08/12/2022"),
(898,2520,	9630,	"ready for your upcoming presentation?",	"08/13/2022" ),
(990,2520,	8520,	"Maybe it was done by the automation process",	"08/19/2022" );

alter table messages
add column sent_date_new date after sent_date;

select * from messages;

update messages
set sent_date_new = str_to_date(sent_date, '%m/%d/%Y');

describe messages;

ALTER TABLE messages
DROP COLUMN sent_date;


select sender_id , count(message_id) as msg_count from messages
where sent_date_new between "2022-07-31" and "2022-09-01"
group by sender_id
order by msg_count desc
limit 2;


select sender_id , count(message_id) as msg_count from messages
where EXTRACT(MONTH FROM sent_date_new) = '8'
  AND EXTRACT(YEAR FROM sent_date_new) = '2022'
group by sender_id
order by msg_count desc
limit 2;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Problem : Supercloud Customer ( Microsoft)

# A Microsoft Azure Supercloud customer is a company which buys at least 1 product from each Azure product category.

Write a query to report all companies which are Supercloud customers, arranging your order in ascending by customer ID.

create table customer_contracts
(customer_id int,
product_id int,
amount int
);
insert into customer_contracts values
(1,	1,	1000),
(2, 2,	2000),
(2,	6,	2000),
(3,	1,	1100),
(4,	1,	1000),
(4,	6,	2200),
(6,	5,	2000),
(1,	4,	2000),
(7,	7,  5000),
(1,	6,	1500),
(7,	1,	1000),
(7,	4,	4000);

select * from customer_contracts;

create table if not exists products (
product_id	integer,
product_category varchar (50),
product_name varchar(50));

insert into products value
(1,	"Analytics",	"Azure Databricks"),
(2,	"Analytics",	"Azure Stream Analytics"),
(4,	"Containers",	"Azure Kubernetes Service"),
(5,	"Containers",	"Azure Service Fabric"),
(6,	"Compute",	"Virtual Machines"),
(7,	"Compute",	"Azure Functions");

select * from products;

with cte as (
select distinct ps.product_category, cc.customer_id, cc.product_id,  ps.product_name 
from customer_contracts as cc
join products as ps on  cc.product_id = ps.product_id)
select  cte.customer_id from cte
group by cte.customer_id
having count(distinct cte.product_category) = 3
;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------









 
