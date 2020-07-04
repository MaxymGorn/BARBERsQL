
CREATE FUNCTION GetFio ()
RETURNS @result_table TABLE(Name nvarchar(max), Surname nvarchar(max)) 
AS
BEGIN
    insert into @result_table 
	select b.Name, b.Surname from Barber b;
	return;
END
go

CREATE FUNCTION GetBarber (@name_pos nvarchar(max))
RETURNS @result_table2 TABLE(Name nvarchar(max), Surname nvarchar(max), DateOfBirthday nvarchar(max),
Email nvarchar(max),PhoneNumber nvarchar(max), Pol nvarchar(max), NamePos nvarchar(max)) 
AS
BEGIN
    insert into @result_table2
	select b.Name, b.Surname, b.DateBirthday, b.Email, b.PhoneNumber, b.Pol, p.NamePos
	from Barber b, Poistion p 
	where p.Id=b.PositionId and p.NamePos=@name_pos
	return;
END
go


CREATE FUNCTION GetBarberUsl (@name_usl nvarchar(max))
RETURNS @result_table2 TABLE(Name nvarchar(max), Surname nvarchar(max), DateOfBirthday nvarchar(max),
Email nvarchar(max),PhoneNumber nvarchar(max), Pol nvarchar(max), NamePos nvarchar(max)) 
AS
BEGIN
    insert into @result_table2
	select b.Name, b.Surname, b.DateBirthday, b.Email, b.PhoneNumber, b.Pol, p.NamePos
	from Barber b, Poistion p , ListUsl lu, Uslugi u
	where p.Id=b.PositionId and b.ListUslugiId=lu.Id and lu.UslugiId=u.Id and 
	u.NameUsl=@name_usl
	return;
END
go

CREATE FUNCTION GetBarberAge (@age int)
RETURNS @result_table2 TABLE(Name nvarchar(max), Surname nvarchar(max), DateOfBirthday nvarchar(max),
Email nvarchar(max),PhoneNumber nvarchar(max), Pol nvarchar(max), NamePos nvarchar(max)) 
AS
BEGIN
    insert into @result_table2
	select b.Name, b.Surname, b.DateBirthday, b.Email, b.PhoneNumber, b.Pol, p.NamePos
	from Barber b, Poistion p 
	where p.Id=b.PositionId  and datediff(year,b.WorkStart,GetDATE())>@age
	
	return;
END
go



create function GetCountBarber(@name_pos1 nvarchar(max), @name_pos2 nvarchar(max))
returns int
as 
begin
declare @res int
	select @res=COUNT(b.Name)
	from Barber b, Poistion p 
	where p.Id=b.PositionId and p.NamePos=@name_pos1 or p.NamePos=@name_pos2
return @res
end 
go


CREATE FUNCTION GetClientCount (@age int)
RETURNS @result_table2 
TABLE(Name nvarchar(max), Surname nvarchar(max),PhoneNumber nvarchar(max), Email nvarchar(max)) 
AS
BEGIN
    insert into @result_table2
	select  cl.Name,cl.Surname,cl.PhoneNumber,cl.Email
	from Clients cl, hISTORY h 
	where cl.Id=h.ClientId  
	group by cl.Name,cl.Surname,cl.PhoneNumber,cl.Email
	having count(cl.Name)>@age
	return;
END
go

--1
select * from GetFio() 
go

--2
select * from GetBarber(N'джуниор-барбер')
go

--3
select * from GetBarberUsl(N'1-usl')
go

--4
select * from GetBarberUsl(N'2-usl')
go

--5
select * from GetBarberAge(2)
go

--6

select dbo.GetCountBarber(N'джуниор-барбер',N'синьор-барбер') as N'Count barber'
go

--7
select * from GetClientCount(1)
go


--8
CREATE TRIGGER tr1
ON Barber
FOR INSERT, update
AS
IF 2 = (SELECT COUNT(b.Id)
        FROM Barber b, Poistion p  
		where b.PositionId=p.Id and p.NamePos=N'чиф-барбер')	
			BEGIN
				ROLLBACK TRAN
				raiserror ('Eror', 16, 10)
			END
			go
--9
CREATE TRIGGER tr2
ON Barber
FOR INSERT, update
AS
declare @res int
select @res=datediff(year,ii.DateBirthday,GetDATE()) from inserted ii
IF 21<=@res
        BEGIN
            ROLLBACK TRAN
            raiserror ('Eror', 16, 10)
        END

