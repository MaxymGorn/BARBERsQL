create FUNCTION GetMaxDate ()
RETURNS @result_table2 
TABLE(Name nvarchar(max), Surname nvarchar(max),PhoneNumber nvarchar(max), Email nvarchar(max), DateBirthday date,
WorkStart date) 
AS
BEGIN
    insert into @result_table2
	select  b.Name, b.Surname, b.PhoneNumber, b.Email, b.DateBirthday, b.WorkStart
	from Barber b
	where b.WorkStart=(select max(bb.WorkStart) from Barber bb)
	return;
END
go

alter FUNCTION GetMaxClient (@date1 date, @date2 date)
RETURNS @result_table2 
TABLE(Name nvarchar(max), Surname nvarchar(max),PhoneNumber nvarchar(max), Email nvarchar(max), DateBirthday date,
WorkStart date) 
AS
BEGIN
    insert into @result_table2
	select  b.Name, b.Surname, b.PhoneNumber, b.Email, b.DateBirthday, b.WorkStart
	from Barber b, hISTORY h
	where h.BarberId=b.Id and h.DateTime BETWEEN @date1  AND @date2  


	return;
END
go

--1.
select * from GetMaxDate()

--2.
select * from GetMaxClient('1990-10-10 00:00:00','2290-10-10 00:00:00')
