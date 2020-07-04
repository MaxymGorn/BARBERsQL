create table FeddbackCl(
   Id INT IDENTITY PRIMARY KEY,
   Desciption nvarchar(50) not null,
   ClientId int not null references Clients(Id),
   Stars int not null check(Stars>=1 and Stars<=5),
   Time date not null,
   )
go
create table ListFeddbackCl(
   Id INT IDENTITY PRIMARY KEY,
FeddbackClId int not null,
	Constraint Fk_LuF_Id foreign key
	(FeddbackClId)   references FeddbackCl(Id)
   
);go




create table Poistion(
   Id INT IDENTITY PRIMARY KEY,
   NamePos nvarchar(50) not null,
   constraint N_Pos  check(NamePos!=N'')
   );
go

create table Uslugi(
   Id INT IDENTITY PRIMARY KEY,
   NameUsl nvarchar(50) not null,
   Time int null,
   constraint N_Usl  check(NameUsl!=N''));
go
create table ListUsl(
   Id INT IDENTITY PRIMARY KEY,
UslugiId int not null,
	Constraint Fk_Lu_Id foreign key
	(UslugiId)   references Uslugi(Id)
   
);go

CREATE TABLE Barber
(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(30) NOT NULL,
	Surname nvarchar(100) not null,
	Pol bit null,
	PhoneNumber nvarchar(max) not null,
	Email nvarchar(max) not null,
	DateBirthday date not null,
	WorkStart date not null,
	PositionId int not null,
	ListUslugiId int not null,
	ListFeedBackId int  not null,
	Constraint Name_barber check 
	(Name!=N'' and Surname!=N''),
	Constraint Fk_Pos_Id foreign key
	(PositionId)   references Poistion(Id),
		Constraint Fk_Lusl foreign key
	(ListUslugiId)   references ListUsl(Id),
	Constraint Fk_bB_Id foreign key 
	(ListFeedBackId) references ListFeddbackCl(Id)
   
);go

create table Clients
(
Id INT IDENTITY PRIMARY KEY,
Name nvarchar(50),
Surname nvarchar(100),
PhoneNumber nvarchar(max) not null,
Email nvarchar(max) not null,
);go

CREATE TABLE hISTORY
(
Id INT IDENTITY PRIMARY KEY,
BarberId int not null,
ClientId int not null,
FeedbackIdCl int null,
ListUslId int not null,
DateTime date not null,
AllPrice money,
 	Constraint Fk_Pos22_Id foreign key
	(BarberId)   references Barber(Id),
		Constraint Fk2_Lusl foreign key
	(ClientId)   references Clients(Id),
	Constraint Fk2_bB22_Id foreign key 
	(FeedbackIdCl) references ListFeddbackCl(Id),
	Constraint Fk2_bB222_Id foreign key 
	(ListUslId) references ListUsl(Id)
);go


insert Poistion(NamePos)
values (N'чиф-барбер'),(N'синьор-барбер'),(N'джуниор-барбер')

insert Uslugi(NameUsl, Time)
values (N'1-usl',40),(N'2-usl',30),(N'3-usl',60),(N'4-usl',43)

insert ListUsl(UslugiId)
values (1), (2),(3),(4)

insert Clients(Email,Name,Surname,PhoneNumber)
values 
(N'few@gmail.com',N'Max',N'Lepskiy',N'+92906638774'),
(N'jwoewef@gmail.com',N'Vasa',N'Lepskiy',N'+92903458774'),
(N'jpjo@gmail.com',N'Andrey',N'Lepskiy',N'+92903358774'),
(N'wbcwk@gmail.com',N'Ola',N'....',N'+929045538774'),
(N'ubii@gmail.com',N'Sofia',N'Lepskiy',N'+926469038774')

insert FeddbackCl(ClientId,Desciption,Stars,Time)
values 
(1,N'...',5,'2000-02-02 00:00:00'),
(2,N'...',5,'2012-02-02 00:00:00'),
(3,N'...',5,'2010-02-02 00:00:00'),
(4,N'...',5,'2020-02-02 00:00:00')

insert ListFeddbackCl(FeddbackClId)
values(1),(2),(3)

insert Barber(DateBirthday,Email,ListFeedBackId,ListUslugiId,Name,PhoneNumber,Pol,PositionId, Surname, WorkStart)
values 
('1996-10-25 00:00:04',N'rwgfug@gmail.com',1,2,N'Barber-1',N'+743560932',1,2,N'Sur-5','2010-10-10 00:00:00'),
('1992-10-25 00:00:04',N'rwgerfug@gmail.com',2,2,N'Barber-4',N'+743560932',1,3,N'Sur-1','2016-10-10 00:00:00'),
('1995-10-25 00:00:04',N'ervererwgfug@gmail.com',1,1,N'Barber-5',N'+743560932',1,1,N'Sur-5','2019-10-10 00:00:00'),
('2000-10-25 00:00:04',N'ervrwgfug@gmail.com',2,2,N'Barber-2',N'+743560932',1,3,N'Sur-8','2018-10-10 00:00:00'),
('2010-10-25 00:00:04',N'rrergwgfug@gmail.com',2,1,N'Barber-4',N'+743560932',1,2,N'Sur-2','2015-10-10 00:00:00')

insert hISTORY(AllPrice, BarberId,ClientId,DateTime,FeedbackIdCl,ListUslId)
values 
(400,3,2,'2020-03-27 00:00:00',3,2),
(500,2,3,'2020-04-13 00:00:00',2,1),
(700,3,4,'2020-01-07 00:00:00',1,2),
(200,4,2,'2020-03-27 00:00:00',3,1)
go