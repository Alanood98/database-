use ITI 
--q1:
select 
    I.Ins_Name, 
    D.Dept_Name
FROM 
    Instructor I
 JOIN 
    Department D ON I.Dept_Id = D.Dept_Id

--q2:
SELECT 
    s.St_Fname + ' ' + s.St_Lname as StudentFullName, 
    c.Crs_Name as CourseName
FROM 
    Student s
JOIN 
    Stud_Course SC ON s.St_Id = SC.St_Id
JOIN 
    Course c ON SC.Crs_Id = c.Crs_Id
where 
    SC.Grade IS NOT NULL



--q3:
SELECT 
    T.Top_Name, 
    COUNT(C.Crs_Id) AS CourseCount
FROM 
    Topic T
JOIN 
    Course C ON T.Top_Id = C.Top_Id
GROUP BY 
    T.Top_Name
--q4:
SELECT 
    MAX(Salary) AS MaxSalary, 
    MIN(Salary) AS MinSalary
FROM 
    Instructor

--q5:
SELECT 
    D.Dept_Name
FROM 
    Department d

WHERE 
    Dept_Id in  (select Top 1 Dept_Id
					from Instructor )
	

	
--q6:
select I.Ins_Name, COALESCE(CAST(I.Salary AS VARCHAR(10)), 'Bonus') AS SalaryOrBonus
FROM Instructor I

--q7:

Select Dept_Id,Salary
From ( select Dept_Id,Salary,Dense_Rank() over(partition by Dept_Id order by Salary desc) as DR
	  from Instructor) as NewTable
where DR=2





--q8:

select St_Fname+' '+St_Lname as fullName
from (select *, ROW_NUMBER() over(order by NEWID()) as RN
		from Student)
		as NewTable
where RN = 2

--AdventureWorks2012 DB
use AdventureWorks2012
--q1:
select * from production.Product
where Name like 'B%'



--q2:
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select * from production.ProductDescription
where Description like '%[_]%'



----q3:
--select OrderDate ,SUM(TotalDue) as TotalDue
--from Sales.SalesOrderHeader
--where OrderDate between '20010701' and '20140731'
--group by OrderDate
--order by OrderDate
--q4:
select AVG(distinct ListPrice) as AverageP
from Production.Product
--q5:
select CONCAT('The ', Name, ' is only! ', ListPrice) as [Product Price List]
FROM Production.Product
where ListPrice between 100 and 120

--q6:Using union statement, retrieve the today’s date in different styles using convert or format funtion.

select FORMAT(GETDATE(), 'MMMM dd, yyyy')
union
select FORMAT(GETDATE(), 'dd / MM / yyyy')
union
select FORMAT(GETDATE(), 'yyyyMMdd')

