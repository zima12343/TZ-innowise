--Создание бд
CREATE DATABASE Banking;

--Создание таблиц

USE Banking;

CREATE TABLE SocialStatuses (
IdStatus	int			PRIMARY KEY IDENTITY,
Title		varchar(20) NOT NULL
)

CREATE TABLE Clients (
IdClient	int			PRIMARY KEY IDENTITY, 
LName		varchar(20) NOT NULL,
Fmane		varchar(20) NOT NULL,
MName		varchar(20) NOT NULL,
Country		varchar(30) NOT NULL, 
City		varchar(30) NOT NULL,
Street		varchar(30) NOT NULL,
House		varchar(10) NOT NULL,
Flat		varchar(5),
PostCode	varchar(10) NOT NULL,
StatusId	int			NOT NULL,
DOB			date		NOT NULL,
CONSTRAINT [FK_Client_To_SocialStatuses] FOREIGN KEY (StatusId) REFERENCES [SocialStatuses](IdStatus)
) 


CREATE TABLE Banks (
IdBank	int			PRIMARY KEY IDENTITY,
Title	varchar(30) UNIQUE NOT NULL
)

CREATE TABLE BankBranches (
IdBranch	int			PRIMARY KEY IDENTITY,
Title		varchar(60)	NOT NULL,
BankId		int			NOT NULL,
Country		varchar(30) NOT NULL, 
City		varchar(30) NOT NULL,
Street		varchar(30) NOT NULL,
House		varchar(10) NOT NULL,
Flat		varchar(5),
PostCode	varchar(10) NOT NULL,
CONSTRAINT [FK_BankBranches_To_Bank] FOREIGN KEY (BankId) REFERENCES [Banks](IdBank)
)

CREATE TABLE Accounts (
	IdAccount		int PRIMARY KEY IDENTITY,
	BankId			int NOT NULL,
	ClientId		int NOT NULL,
	AccountNumber	varchar(50) NOT NULL UNIQUE,
	UNIQUE(BankId, ClientId),  --1 клиент - 1 счет в банке
	UNIQUE(BankId, AccountNumber),  --В каждом банке уникальный счет
	CONSTRAINT [FK_Accounts_To_Bank] FOREIGN KEY (BankId) REFERENCES [Banks](IdBank),
	CONSTRAINT [FK_Accounts_To_Clients] FOREIGN KEY (ClientId) REFERENCES [Clients](IdClient)
)

CREATE TABLE Cards(
CardNumber	numeric(16,0) PRIMARY KEY,
ValidDate	Date NOT NULL,
CVC			numeric(3,0), 
AccountId	int NOT NULL,
CONSTRAINT [FK_Cards_To_Account] FOREIGN KEY (AccountId) REFERENCES [Accounts](IdAccount)
)

INSERT INTO [SocialStatuses]
           ([Title])
     VALUES
           ('Обычный'),
		   ('Студент'),
		   ('Пенсионер'),
		   ('Инвалид');

INSERT INTO [dbo].[Clients]
           ([LName]
           ,[Fmane]
           ,[MName]
           ,[Country]
           ,[City]
           ,[Street]
           ,[House]
           ,[Flat]
           ,[PostCode]
           ,[StatusId]
		   ,[DOB])
     VALUES
           ('Громов', 'Никанор', 'Анатольевич', 'Россия', 'Чехов', 'Соколиной Горы', '146а', '319', '152650', 1, '03.01.1997'),
		   ('Софийская', 'Динара', 'Владиславовна', 'Россия', 'Солигалич', 'Захаров пер', '43', '646/1', '628205',  2, '21.03.2002'),
		   ('Голубева', 'Зинаида', 'Максимовна', 'Россия', 'Родионово-Несветайский', 'Озерковский 2-й пер', '3', '98', '307611', 1, '27.02.1976'),
		   ('Григорьев', 'Эрнст', 'Николаевич', 'Россия', 'Неман', 'Калужская', '116', '64', '188333', 4, '02.06.1999'),
		   ('Изофатов', 'Феоктист', 'Матвеевич', 'Россия', 'Колывань', 'Графитный проезд', '27', '410', '665335', 3, '21.05.1965')



INSERT INTO [dbo].[Banks]
           ([Title])
     VALUES
           ('Банк ВТБ'),
		   ('Газпромбанк'),
		   ('Альфа-Банк'),
		   ('Россельхозбанк'),
		   ('Промсвязьбанк')



INSERT INTO [BankBranches]
           ([Title]
           ,[BankId]
           ,[Country]
           ,[City]
           ,[Street]
           ,[House]
           ,[Flat]
           ,[PostCode])
     VALUES
           ('Филиал № 7806 «Банк ВТБ»', 1, 'Россия', 'Санкт-Петербург', 'Большая Морская', '29', null, '136548'),
		   ('Операционный офис «На Советской»', 1, 'Россия', 'Могоча', 'Клубная', '2', '13', '745825'),
		   ('Рабочее место № 015/4038', 2, 'Россия', 'Череповец', 'Ленина', '47', null, '582574'),
		   ('Офис продаж № 034/4012', 2, 'Россия', 'Шарыпово', '3-й микрорайон', '23', null, '846436'),
		   ('Операционный офис «Парус» «Альфа-Банк»', 3, 'Россия', 'Чехов', 'Соколиной Горы', '146а', null, '264573'),
		   ('Дополнительный офис «Кремлевский»', 3, 'Россия', 'Волгоград', 'Мира', '23', null, '724547'),
		   ('Дополнительный офис Климово', 4, 'Россия', 'Климово', 'Коммунистическая', '9', null, '264647'),
		   ('Дополнительный офис Красногорское', 4, 'Россия', 'Красногорское', 'Депутатский', '17', null, '757537'),
		   ('Центральный', 5, 'Россия', 'Москва', 'Смирновская', '10 стр. 22', null, '728342')

		  
INSERT INTO [Accounts]
           ([BankId]
           ,[ClientId]
           ,[AccountNumber])
     VALUES
			(1,2,'Xjq04iu4KI5u'),
			(1,1,'Pe5Ts5ef4J8L'),
			(2,1,'cWfv4OXmYx0K'),
			(2,3,'sBTB37rU3TBB'),
			(2,2,'lnksjdLOS4pR'),
			(3,1,'RvQoPGKr9CRX'),
			(3,5,'S5QHIN9vyb3P'),
			(5,4,'NgFwmLgZCsbl'),
			(3,3,'j2yoCdUgJfrX'),
			(4,3,'Q67UTuxVkTcD')


INSERT INTO [Cards]
           ([CardNumber]
           ,[ValidDate]
           ,[CVC]
           ,[AccountId])
     VALUES
            (5404366485148734, '01.11.2025', 631, 1),
		    (5404365883659243, '01.12.2022', 290, 2),
			(5404365053557763, '01.01.2023', 725, 3),
			(5404367836469803, '01.02.2024', 137, 4),
			(5404361197558981, '01.06.2022', 807, 3),
			(5404362699176645, '01.12.2023', 888, 5),
			(5404365334689831, '01.10.2024', 435, 6),
			(5404367292029547, '01.5.2025', 544, 7),
			(5404369161050729, '01.7.2022', 904, 8)


