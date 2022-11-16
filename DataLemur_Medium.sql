-------------------------------------------DataLemur (Medium_level)------------------------------------------------------
# Problem Medium Level : Sportify Top 5 Artit

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
(1,	45202,	2),
(3,	45202,	2),
(15, 45202,	6),
(2,	55511,	2),
(1,	19960,	3),
(9,	19960,	15),
(23, 12636,	9),
(24, 12636,	7),
(2,	12636,	23),
(29, 12636,	7),
(1,	69820,	1),
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
(7,	22222,	8),
(8,	44552,	1),
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
    
    
    
 