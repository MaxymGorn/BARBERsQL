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