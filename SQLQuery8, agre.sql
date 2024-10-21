use Company_SD
--q1: For each project, list the project name and the total hours per week (for all employees) spent on that project
select Pname,SUM(Hours)
from Project join Works_for
ON Pno = Pnumber
group by pname

--q2:For each department, retrieve the department name and the maximum, minimum and average salary of its employees
select Dname,max(salary),min(salary),avg(salary)
from Departments
join Employee on Dnum = Dno
group by Dname