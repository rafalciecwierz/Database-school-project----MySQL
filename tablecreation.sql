
--DROP DATABASE Projekt
IF OBJECT_ID('Udzial', 'U') IS NOT NULL
DROP TABLE Udzial	
GO
IF OBJECT_ID('Zamowienie', 'U') IS NOT NULL
DROP TABLE Zamowienie
go
IF OBJECT_ID('Towar', 'U') IS NOT NULL
DROP TABLE Towar
go
IF OBJECT_ID('Port', 'U') IS NOT NULL
DROP TABLE Port
go
IF OBJECT_ID('Holownik', 'U') IS NOT NULL
DROP TABLE Holownik
go
IF OBJECT_ID('Barka', 'U') IS NOT NULL
DROP TABLE Barka
go
IF OBJECT_ID('Pracownik', 'U') IS NOT NULL
DROP TABLE Pracownik
go
IF OBJECT_ID('Kontrahent', 'U') IS NOT NULL
DROP TABLE Kontrahent
go

--CREATE DATABASE Projekt
CREATE TABLE Port(
ID INT IDENTITY(1,1) PRIMARY KEY,
Nazwa varchar(100) not null,
CONSTRAINT ck_Nazwa_portu CHECK (Nazwa like '[A-Z]%')
)

CREATE TABLE Towar(
ID INT IDENTITY(1,1) PRIMARY KEY,
Nazwa varchar(100) not null,
WagaNaM3 DECIMAL(7,2) not null,
CONSTRAINT ck_min_wagaNaM3 CHECK (WagaNaM3 > 0)

)

CREATE TABLE Holownik(
ID INT IDENTITY(1,1) PRIMARY KEY,
Nazwa varchar(100) not null unique,
Data_przegladu DATE not null,
minPrac tinyint not null,
maxPrac tinyint not null,
moc int not null,
CONSTRAINT ck_min_moc CHECK (moc > 0),
CONSTRAINT ck_Nazwa_holownika CHECK (Nazwa like '[A-Z]%')
)

CREATE TABLE Barka(
ID INT IDENTITY(1,1) PRIMARY KEY,
Nazwa varchar(100) not null unique,
Data_przegladu DATE not null,
maxobjetosc DECIMAL(7,2) not null,
maxUdzwig INT not null, 
CONSTRAINT ck_max_objetosc CHECK (maxobjetosc > 0),
CONSTRAINT ck_max_udzwig CHECK (maxudzwig > 0),
CONSTRAINT ck_Nazwa_barki CHECK (Nazwa like '[A-Z]%')
)

CREATE TABLE Pracownik(
ID INT IDENTITY(1,1) PRIMARY KEY,
Imie varchar(30) not null,
Nazwisko varchar(30) not null,
PESEL varchar(11) unique not null,
Stanowisko varchar(30) not null,
nr_kontakt varchar(9) not null,
CONSTRAINT ck_imie CHECK (imie like '[A-Z]%'),
CONSTRAINT ck_nawisko CHECK (nazwisko like '[A-Z]%'),
CONSTRAINT ck_Pesel CHECK (Pesel like'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Constraint ck_numer CHECK (nr_kontakt like '[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
CONSTRAINT ck_stanowisko CHECK (stanowisko in('operator holownika','pracownik biurowy','kapitan'))
)

CREATE TABLE Kontrahent(
ID INT IDENTITY(1,1) PRIMARY KEY,
Nazwa varchar(100) not null, 
Adres varchar(150) not null,
NIP varchar(10) unique not null,
nr_kontakt varchar(9) not null,
Constraint ck_numerkontakt CHECK (nr_kontakt like '[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Constraint ck_nip CHECK (NIP like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'), 
CONSTRAINT ck_Nazwa_firmy CHECK (Nazwa like '[A-Z]%')
)

CREATE TABLE Zamowienie(
ID INT IDENTITY(1,1) PRIMARY KEY,
ID_holownika int references holownik(ID),
ID_barki int references barka(ID),
ID_towaru int references towar(ID),
ID_kontrahenta int references kontrahent(ID),
ID_portpoczat INT references Port(id) not null,
ID_portkoniec INT references Port(id) not null,
data_przyjecia date not null,
data_realizacji date,
data_zakonczenia date,
cena DECIMAL(9,2) not null,
CONSTRAINT ck_cena CHECK (cena > 0),
CONSTRAINT ck_data_real CHECK( data_przyjecia < data_realizacji),
CONSTRAINT ck_data_zako CHECK( data_przyjecia < data_zakonczenia),
CONSTRAINT ck_rozne_porty CHECK (ID_portkoniec <> ID_portpoczat)
)

CREATE TABLE Udzial(
ID_zam int references Zamowienie(ID),
ID_prac int references Pracownik(ID)
)
go
--Use Projekt
insert into Port values
('Gdańsk'), 
('Gdynia'), 
('Szczecin');

insert into Towar values
('drewno',1.7),
('złom',2.7),
('deski',2.4);
insert into Holownik values
('Hol1','2017-12-31',2,4,50),
('Hol2','2017-12-31',2,4,50),
('Hol3','2017-12-31',2,4,50);
insert into Barka values
('Bar1','2017-12-31',204.7,2000),
('Bar2','2017-12-31',208.6,2000),
('Bar3','2017-12-31',300.7,2000);
insert into Pracownik values
('Jan','Kowalski','95101001011','operator holownika','456456456'),
('Karol','Nowak','98101002020','kapitan','567567567'),
('Zofia','Soj','67101066766','pracownik biurowy','678678678');

('Lech','Kwaśniewski','52101506258','kapitan','789456123')
('Andrzej','Jeleniewski','90050506294','operator holownika','98765431')
('Tomasz','Dzik','84060356785','operator holownika','741852963')
('Tadeusz','Nieważny','75060805285','kapitan','798147258')
('Krzysztof','Kałamaga','89101010258','pracownik biurowy','789258369')

insert into Kontrahent values
('ABC','Różana 8 64-510 Wronki','1212121212','123123123'),
('DEF','Plac Wolności 8 64-510 Wronki','1313131313','234234234'),
('GHI','Spokojna 3 64-510 Wronki','1414141414','234234234');
insert into Zamowienie values
(1,2,1,2,1,2,'2016-11-01','2016-11-05','2016-11-06',40000.70),
(1,3,2,3,1,3,'2016-11-07','2016-11-14','2016-11-14',40345.70),
(2,3,1,2,3,1,'2016-11-11','2016-11-15','2016-11-21',41242.70);
insert into Udzial values
(1,2),
(2,1),
(3,3);

