use Company_SD
--q1:Display all the employees Data
select * 
from Employee

--q2:Display the employee First name, last name, Salary and Department number
select Fname, Lname, Salary, Dno from Employee

--q3:Display all the projects names, locations and the department which is responsible about it
select Pname, Plocation, Dnum from Project

--q4:If you know that the company policy is to pay an annual commission for each employee with specific percent equals 10% of his/her annual salary .Display each employee full name and his annual commission in an ANNUAL COMM column (alias)
select Fname+' '+Lname as [Full Name], (Salary*12*10/100) as [ANNUAL COMM ]
from Employee
--q5:Display the employees Id, name who earns more than 1000 LE monthly
select SSN ,Fname + ' '+ Lname as [full name]
from Employee
where Salary>1000

--q6:Display the employees Id, name who earns more than 10000 LE annually
select SSN, Fname+' '+Lname as [full name]
from Employee
where Salary > 10000

--q7:Display the names and salaries of the female employees 
select Fname+' '+Lname as [full name], Salary
from Employee
where Sex = 'f'

--q8:Display each department id, name which managed by a manager with id equals 968574
select Dnum, Dname from Departments
where MGRSSN = 968574

--q9:Dispaly the ids, names and locations of  the pojects which controled with department 10
select Pnumber, Pname, Plocation
from Project
where Dnum = 10

--q10:Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=250
insert into Employee (Fname, Lname, SSN, Bdate,  Sex, Salary, Superssn, Dno)
values('Anoud', 'Sultan', 102672, 17-02-1998,  'F', 250, 112233, 30)
--q11:Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or supervisor number to him
insert into Employee (Fname, Lname, SSN, Bdate, Sex, Salary, Superssn, Dno)
values('Muntassar', 'Hassan', 102660, 15-12-1996, 'M', null, null,30)
--q12:Upgrade your salary by 20 % of its last value
update Employee
set Salary = Salary*0.2
where SSN=102672