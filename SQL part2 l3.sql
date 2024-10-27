use ITI

--q1:
create view  SCourseView 
as
select 
    S.St_Fname + ' ' + S.St_Lname as StudentFullName,
    C.Crs_Name as CourseName
FROM 
    Student S
JOIN 
    Stud_Course SC on S.St_Id = SC.St_Id
JOIN 
    Course C on SC.Crs_Id = C.Crs_Id
where
    SC.Grade > 50





--q2:
create view EncryptedManagerView 
as
select
    I.Ins_Name AS managerName,
    T.Top_Name AS topicName
FROM Instructor I
JOIN Ins_Course IC on I.Ins_Id = IC.Ins_Id
JOIN 
    Course C ON IC.Crs_Id = C.Crs_Id
JOIN 
    Topic T ON C.Top_Id = T.Top_Id

	select managerName , topicName from EncryptedManagerView 




--q3:
create view InstructorDepartmentView 
as
select
    I.Ins_Name as InstructorName, 
    D.Dept_Name as DepartmentName
FROM 
    Instructor I
JOIN 
    Department D on I.Dept_Id = D.Dept_Id
where
    D.Dept_Name IN ('SD', 'Java')

select InstructorName,DepartmentName from InstructorDepartmentView 



--q4:
create view V1  as
select * FROM Student
where St_Address in ('Alex', 'Cairo')




--q5:
use Company_SD
create view ProjectEmployeeView as
select p.Pname as projectN, 
    (SELECT COUNT(ESSN) FROM Works_for W WHERE W.Pno = P.Pnumber) AS EmployeeCount
FROM 
    Project P
select projectN , EmployeeCount from ProjectEmployeeView


--q6:
create schema Company
alter schema Company transfer dbo.Departments
alter schema Company transfer dbo.Project

create schema HumanResource
alter schema HumanResource transfer dbo.Employee



