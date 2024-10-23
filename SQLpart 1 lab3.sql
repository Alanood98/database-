use Company_SD
--q1:
select Dependent_name as names, Sex as gender
from Dependent
where Sex = 'F'
and ESSN in
(select SSN from employee where Sex = 'F')
union
select Dependent_name as name, Sex as gender
from Dependent
where Sex = 'm'
 and ESSN in
 (select SSN from employee where Sex = 'M')
--q2:
select Pname,
       (select sum(Hours)
        from Works_for
        where Works_for.Pno = Project.Pnumber) as total_hours
from Project



--q3:


select *
from Departments
where Dnum in (select Dno from employee
	where ssn in (select min(SSN) 
	from employee))



--q4:
select Dname,
    (select max(salary) from employee e where d.Dnum = e.Dno) as MaxSalary,
    (select min(salary) from employee e where d.Dnum = e.Dno) as MinSalary,
    (select avg(salary) from employee e where d.Dnum = e.Dno) as AvgSalary
from Departments d
--q5:
select fname + ''+ lname as fullName
from employee
where SSN in (select MGRSSN
				   from Departments)   and
					 ssn not in (select ESSN from Dependent)



--q6:
select Dnum ,Dname ,
(select count(*) from Employee e  where e.Dno = d.Dnum) as EmployeeCount
from Departments d
where (select avg(Salary) from Employee e where e.Dno = d.Dnum) < (select avg(Salary) from Employee)




--q7:
select e.lname, e.Fname, p.Pname
from Employee e inner join Works_for w on e.SSN = w.ESSn inner join Project p on p.Pnumber = w.Pno
order by e.Dno

--q8:
select salary from(select * ,ROW_NUMBER() over (order by salary desc)as RN from employee) as NewTable
where RN in (1 , 2)


--q9:
select Fname + ' ' + Lname as Fullname
from Employee
where Fname + ' ' + Lname in (Select Dependent_name
from Dependent)


--q10:
select SSN, Fname + ' ' + Lname
from Employee
where exists (select ESSN
				from Dependent
				where ESSN = SSN)

--q11:
insert into Departments(Dname, Dnum, MGRSSN, [MGRStart Date])
values ('DEPT IT', 100, 112233, '2006-11-01')



--q12:
--a:
UPDATE Departments
set MGRSSN = 968574
where Dnum = 100


--b:
UPDATE Departments
set MGRSSN = 102672
where Dnum = 20



--c:
UPDATE EMPLOYEE
set Superssn = 102672
where Ssn = 102660



--q13:
delete from Dependent
where ESSN = 223344

update Departments
set MGRSSN = 102672
where MGRSSN = 223344

update Employee
set Superssn = 102672
where Superssn = 223344

update Works_for
set ESSn = 102672
where ESSn = 223344

delete from Employee
where SSN = 223344


--q14:
UPDATE EMPLOYEE
set Salary += Salary * 0.3
where Ssn IN (SELECT Essn 
              FROM Works_for 
              where Pno IN (select Pnumber 
                            FROM PROJECT 
                          where Pname = 'Al Rabwah'))


							







