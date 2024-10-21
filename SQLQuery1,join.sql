use Company_SD
--q1:Display the Department id, name and id and the name of its manager


select Dname,Dnum, Fname 
from Departments inner join Employee  on MGRSSN = SSN


--q2:Display the name of the departments and the name of the projects under its control
select d.Dname ,p.Pname
from  Departments d 
left join Project p 
ON d.Dnum = p.Dnum


select Dname,Pname 
from Departments D inner join Project P on D.Dnum = P.Dnum

--q3 :Display the full data about all the dependence associated with the name of the employee they depend on him/her
select *
from  dependent d  
 inner join employee e
 ON e.SSN = d.ESSN


 select D.*,E.Fname 
from Dependent D inner join Employee E on ESSN = SSn


 --q4:Display the Id, name and location of the projects in Cairo or Alex city
 select Pnumber,Pname ,City
 from Project
 where City = 'Cairo' or  City = 'Alex'

 --q5:Display the Projects full data of the projects with a name starts with "a" letter
select * from Project
 where Pname LIKE 'a%'

 --q6:display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
 select * 
 from Employee e 
inner join  departments d 
ON d.Dnum =30 and e.Salary between 1000 and 2000

--q7:Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project

select  Fname+''+Lname as fullNAme 

from Employee inner join Works_for on   SSN = ESSn  
   			  inner join Project   on	Pno=Pnumber	

where Pname = 'Al rabwah' and Hours>=10 and Dno =10

--q8:Find the names of the employees who directly supervised with Kamel Mohamed

select X.Fname+''+X.Lname as EmpName
from Employee X inner join Employee Y  on Y.SSN=X.Superssn
where y.Fname='kamel' and y.Lname='mohamed'

--q9:Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name

select Fname ,Pname 
from Employee inner join Works_for on ESSn = SSN
              inner join project   on  Pno = Pnumber
order by Pname

--q10:For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate
select Pnumber , Dname, Lname, Address, Bdate
from employee inner join Departments D on ssn = MGRSSN
              inner join Project P     on P.Dnum = D.Dnum 
where city = 'cairo'

--q11:Display All Data of the managers
select M.* 
from employee m inner join Departments d on m.SSN = d.MGRSSN

--q12:Display All Employees data and the data of their dependents even if they have no dependents
select * 
from employee e left join Dependent d on e.ssn=d.ESSN


