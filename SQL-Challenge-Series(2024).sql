use pw;

CREATE TABLE SalesData (
    SalesDate DATE ,
    YTD_Sales DECIMAL(10, 2)
);

INSERT INTO SalesData (SalesDate, YTD_Sales)
VALUES 
 ('2023-01-31',100.00),
 ('2023-02-28',250.00),
 ('2023-03-31',300.00),
 ('2023-04-30',320.00),
 ('2023-05-31',410.00),
 ('2023-06-30',470.00),
 ('2023-07-31',530.00),
 ('2023-08-31',650.00),
 ('2023-09-30',700.00),
 ('2023-10-31',820.00),
 ('2023-11-30',950.00),
 ('2023-12-31',1000.00);
 
 Select * from SalesData;
 -- we will analyze MTD (Month to Date) sales from YTD (Year to Date) sales data.
 
 Select  SalesDate, YTD_Sales,  lag(YTD_Sales,1,0) over(order by SalesDate ) as pr_mt,  (YTD_Sales - lag(YTD_Sales,1,0) over(order by SalesDate )) as MTD
 from (
 select SalesDate, YTD_Sales, lag(YTD_Sales,1,0) over(order by SalesDate ) as pr_mt
 from SalesData) as Tb;
 
 