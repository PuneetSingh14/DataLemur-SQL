Part #16 -- we will identify departments with atleast 2 students enrolled in both physics & chemistry
CREATE TABLE Department (
    DepartmentID INT,
    StudentID INT,
    FavouriteSubject VARCHAR(100)
 );

INSERT INTO Department (DepartmentID, StudentID, FavouriteSubject)
VALUES 
    (1, 101, 'Mathematics'),
    (1, 101, 'Physics'),
    (1, 101, 'Chemistry'),
    (1, 102, 'Physics'),
    (1, 102, 'Chemistry'),
    (2, 111, 'Physics'),
    (2, 112, 'Physics'),
    (2, 112, 'Chemistry'),
    (2, 113, 'Biology'),
    (2, 114, 'Computer Science'),
    (3, 121, 'Physics'),
    (3, 121, 'Chemistry'),
    (3, 122, 'Physics'),
    (3, 122, 'Chemistry');

SELECT * FROM Department;

select a.DepartmentID, count(a.StudentID) from
(
select DepartmentID, StudentID, FavouriteSubject from Department where FavouriteSubject in ( 'physics', 'chemistry')
group by 1,2
having count(FavouriteSubject) > 1) as a
group by a.departmentID
having count(a.studentID)>=2;

------------------------------------------------------------------------------------------------------------------------------------------
Part #15  -- we will analyze MTD (Month to Date) sales from YTD (Year to Date) sales data.
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

 Select  SalesDate, YTD_Sales,  lag(YTD_Sales,1,0) over(order by SalesDate ) as pr_mt,  (YTD_Sales - lag(YTD_Sales,1,0) over(order by SalesDate )) as MTD
 from (
 select SalesDate, YTD_Sales, lag(YTD_Sales,1,0) over(order by SalesDate ) as pr_mt
 from SalesData) as Tb;
 
 
