use ITI 
--1:Create a stored procedure without parameters to show the number of students per department name

alter Proc GetsStudentNum  
as
	select count(s.st_id) as [Number Of Student],d.dept_name 
	from Department d
	join Student s
	ON s.Dept_Id =d.dept_id
	GROUP BY D.Dept_Name

	

GetsStudentNum  


--5:Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
--“Print a message for user to tell him that he can’t insert a new record in that table”

alter trigger PreventInserting
on Department
instead of insert
as
select 'U  can’t insert a new record in Department table'

insert into Department(Dept_Id,Dept_Name)
values(10,'COM10')


--2:Create a stored procedure that will check for the # of employees in the project p1
--if they are more than 
--print message to the user “'The number of employees in the project p1 is 3 or more'”
--if they are less display a message to the user “'The following employees work for the project p1'”
--in addition to the first name and last name of each one. [Company DB] 
use Company_SD

alter PROCEDURE GetsCheckEmployee
AS
BEGIN
    DECLARE @EmployeeCount int
    
    select @EmployeeCount = COUNT(W.Essn)
    FROM Works_for w
	where pno = 200

    
    -- Step 2: Check if there are 3 or more employees
    if @EmployeeCount >= 3
    BEGIN
       select 'The number of employees in the project P1 is 3 or more'
    END
    else
    BEGIN
        select 'The following employees work for the project P1:'
        
        -- Display the first name and last name of employees working on project P1
        select e.Fname + ' ' + e.Lname as FullName
        FROM HumanResource.Employee e
        JOIN Works_for w on w.Essn = e.Ssn
        where W.Pno = (select Pnumber FROM Company.Project where Pnumber = 200)
    END
END
GetsCheckEmployee




--3:Create a stored procedure that will be used in case there is an old employee has left the project and a new one become instead of him. 
--The procedure should take 3 parameters (old Emp. number, new Emp. number and the project number) and it will be used to update works_on table

 use Company_SD
CREATE PROCEDURE GetsNewkEmployee1
    @oldE INT, 
    @newE INT, 
    @ProjectNum INT
AS
BEGIN
    -- Update Employee Last Name, First Name, and Project Number
    UPDATE Works_for 
    SET ESSN = @newE,
   where ESSN = @oldE AND Pno = @ProjectNum
END
EXEC GetsNewkEmployee1 @oldE = 1, @newE = 3, @ProjectNum = 10

--6:Create a trigger that prevents the insertion Process for Employee table in March [Company DB].
 use Company_SD
create trigger t17
on employee
instead of insert
as
	if format(getdate(),'dddd')='March'
		select 'not allowed'
	else
		insert into Employee select * from inserted

--7:
use ITI

CREATE TABLE StudentAudit (
    ServerUserName NVARCHAR(50),
    DateInserted DATETIME,
    Note NVARCHAR(255)
)
create trigger t10
on Student
after insert
as
	BEGIN
    DECLARE @currentUser nvarchar(128) = ORIGINAL_LOGIN() 
    DECLARE @currentDate DATETIME = GETDATE()
    INSERT INTO StudentAudit (ServerUserName, DateInserted, Note)
    select
        @currentUser,
        @currentDate,
       '[' + @currentUser + '] Insert New Row with Key=[' + CAST(i.St_Id AS NVARCHAR(10)) + '] in table [Student]'
    from
        inserted i
END






--8:
create trigger delete_Row
on Student
INSTEAD OF DELETE
as
BEGIN
 DECLARE @currentUser nvarchar(128) = ORIGINAL_LOGIN()
 DECLARE @currentDate DATETIME = GETDATE()
  INSERT INTO StudentAudit (ServerUserName, DateInserted, Note)
    select
        @currentUser,
        @currentDate,
		'Try to delete Row with Key=[' + CAST(i.St_Id AS NVARCHAR(10)) + ']'
		  FROM
        deleted i
		DELETE FROM Student
    WHERE St_Id IN (SELECT St_Id FROM deleted)
	end





