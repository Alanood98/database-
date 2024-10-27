use ITI
--1 : Create a scalar function that takes date and returns Month name of that date
CREATE FUNCTION dbo.GetMonthName (@date DATE)
RETURNS VARCHAR(20)
AS
BEGIN
    -- Return the month name for the given date
    RETURN DATENAME(MONTH, @date)
END
SELECT dbo.GetMonthName('2024-2-17') as Month




--2: Create a multi-statements table-valued function that takes 2 integers and returns the values between them
CREATE FUNCTION dbo.GetValuesBetween( @StartValue INT,    @EndValue INT)
RETURNS @ResultTable TABLE(Value int)

AS
BEGIN
    DECLARE @CurrentValue INT = @StartValue
  
   
    WHILE @CurrentValue < @EndValue
    BEGIN
        set @CurrentValue +=1
			if(@CurrentValue < @EndValue)
			insert into @ResultTable(value) 
			select @CurrentValue
			else 
			break 
    END
   
    RETURN
END
SELECT * FROM dbo.GetValuesBetween(2, 9)


--3:Create inline function that takes Student No and returns Department Name with Student full name

creat function dbo.GetDepNameStuName(@studentId int)
 returns table
as
RETURN
(
    select
        d.Dept_Name,
        s.St_Fname + ' ' + s.St_Lname as FullName
    FROM
        Student s
    JOIN
        Department d on s.Dept_Id = d.Dept_Id
    where
        s.St_id = @studentId
)

select * from dbo.GetDNameStuName(10)



--4:
create  function dbo.GetUserMassege(@studentId int)
returns VARCHAR(50)
as
BEGIN
    DECLARE @FirstName VARCHAR(50), @LastName VARCHAR(50), @Message VARCHAR(50)
   
    SELECT @FirstName = St_Fname, @LastName = St_Lname
    FROM Student

    WHERE St_Id = @studentId
   
    if @FirstName is null  and  @LastName is null
        SET @Message = 'First name & last name are null'

    else if @FirstName is null
        SET @Message = 'First name is null'

    else if @LastName is null
        SET @Message = 'Last name is null'

    ELSE
        SET @Message = 'First name & last name are not null'
    RETURN @Message
END
drop function dbo.GetUserMassege
select dbo.GetUserMassege(1)
select dbo.GetUserMassege(5)
select dbo.GetUserMassege(10)
--5:
CREATE FUNCTION dbo.GetManagerDetails(@managerId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        d.Dept_Name,
        i.Ins_Name AS ManagerName,
        d.Manager_hiredate AS HireDate
    FROM
        Department d
    JOIN
        Instructor i ON d.Dept_Manager = i.Ins_Id
    WHERE
        i.Ins_Id = @managerId
)

select * from GetManagerDetails(2)




--8:
DECLARE @DeptName NVARCHAR(50), @ManagerName NVARCHAR(50)
DECLARE DeptCursor CURSOR FOR
SELECT d.Dept_Name, i.Ins_Name
FROM Department d
JOIN Instructor i ON d.Dept_Manager = i.Ins_Id
OPEN DeptCursor
FETCH NEXT FROM DeptCursor INTO @DeptName, @ManagerName
WHILE @@FETCH_STATUS = 0
BEGIN
    select 'Department: ' + @DeptName + ' - Manager: ' + @ManagerName
    FETCH NEXT FROM DeptCursor INTO @DeptName, @ManagerName
END
CLOSE DeptCursor
DEALLOCATE DeptCursor





--9:
use ITI
declare InsName cursor
for select distinct Ins_Name
    from Instructor
    where Ins_Name is not null
for read only
declare @name varchar(20),@all_names varchar(300)='' --> initial value
open InsName
fetch InsName into @name
while @@FETCH_STATUS=0
    begin
        set @all_names=concat(@all_names,',',@name)
        fetch InsName into @name   --Next Row 
    end
select @all_names
close InsName
deallocate InsName