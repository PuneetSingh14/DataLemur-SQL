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




    
 
