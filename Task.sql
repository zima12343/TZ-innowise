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
FName		varchar(20) NOT NULL,
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
	Balance		numeric(8,2) DEFAULT 0, 
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
Balance		numeric(8,2) DEFAULT 0
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
           ,[FName]
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
           ,[AccountNumber]
		   ,[Balance])
     VALUES
			(1,2,'Xjq04iu4KI5u', (SELECT ROUND(RAND() * 1000, 2))),
			(1,1,'Pe5Ts5ef4J8L', (SELECT ROUND(RAND() * 1000, 2))),
			(2,1,'cWfv4OXmYx0K', (SELECT ROUND(RAND() * 1000, 2))),
			(2,3,'sBTB37rU3TBB', (SELECT ROUND(RAND() * 1000, 2))),
			(2,2,'lnksjdLOS4pR', (SELECT ROUND(RAND() * 1000, 2))),
			(3,1,'RvQoPGKr9CRX', (SELECT ROUND(RAND() * 1000, 2))),
			(3,5,'S5QHIN9vyb3P', (SELECT ROUND(RAND() * 1000, 2))),
			(5,4,'NgFwmLgZCsbl', (SELECT ROUND(RAND() * 1000, 2))),
			(3,3,'j2yoCdUgJfrX', (SELECT ROUND(RAND() * 1000, 2))),
			(4,3,'Q67UTuxVkTcD', (SELECT ROUND(RAND() * 1000, 2)))


INSERT INTO [Cards]
           ([CardNumber]
           ,[ValidDate]
           ,[CVC]
           ,[AccountId]
		   ,[Balance])
     VALUES
            (5404366485148734, '01.11.2025', 631, 1, (SELECT ROUND(RAND() * 1000, 2))),
		    (5404365883659243, '01.12.2022', 290, 2, (SELECT ROUND(RAND() * 1000, 2))),
			(5404365053557763, '01.01.2023', 725, 3, (SELECT ROUND(RAND() * 1000, 2))),
			(5404367836469803, '01.02.2024', 137, 4, (SELECT ROUND(RAND() * 1000, 2))),
			(5404361197558981, '01.06.2022', 807, 3, (SELECT ROUND(RAND() * 1000, 2))),
			(5404362699176645, '01.12.2023', 888, 5, (SELECT ROUND(RAND() * 1000, 2))),
			(5404365334689831, '01.10.2024', 435, 6, (SELECT ROUND(RAND() * 1000, 2))),
			(5404367292029547, '01.05.2025', 544, 7, (SELECT ROUND(RAND() * 1000, 2))),
			(5404369161050729, '01.07.2022', 904, 8, (SELECT ROUND(RAND() * 1000, 2)))


UPDATE A 
SET Balance = (SELECT SUM(Balance) 
			   FROM Cards 
			   WHERE a.IdAccount = AccountId)
FROM  Cards c
	INNER JOIN Accounts a ON a.IdAccount = c.AccountId
WHERE (a.Balance - (SELECT SUM(Balance) 
					FROM Cards 
					WHERE a.IdAccount = AccountId)) < 0
	

			--Задание 1
SELECT b.* 
FROM Banks b 
	INNER JOIN BankBranches bb ON bb.BankId = b.IdBank
WHERE BB.City = 'Москва'

		--Задание 2
SELECT b.Title Bank, 
		LName, 
		FName, 
		MName, 
		c.CardNumber, 
		a.AccountNumber 
FROM Cards c
	INNER JOIN Accounts a ON a.IdAccount = c.AccountId
	INNER JOIN Clients cl ON cl.IdClient = a.ClientId
	INNER JOIN Banks b ON b.IdBank = a.BankId


			--Задание 3 (C помощью подзапроса)
SELECT DISTINCT a.*, 
				ABS(a.Balance - (SELECT SUM(Balance) 
								 FROM Cards 
								 WHERE a.IdAccount = AccountId))
FROM  Cards c
	INNER JOIN Accounts a ON a.IdAccount = c.AccountId
WHERE a.Balance <> (SELECT SUM(Balance) 
					FROM Cards 
					WHERE a.IdAccount = AccountId)


					--Задание 4.1
SELECT ss.Title, 
	   COUNT(ss.Title) [COUNT]
FROM Clients c
	INNER JOIN SocialStatuses ss ON ss.IdStatus = c.StatusId
GROUP BY ss.Title

					--Задание 4.2

SELECT Title, 
	   (SELECT COUNT(*) 
	    FROM Clients 
	    WHERE StatusId = IdStatus) [COUNT]
FROM  SocialStatuses;


					--Задание 5

CREATE PROCEDURE [sp_AddForStatus]
	@StatusId int,
	@Sum numeric(8,2),
	@RetVal varchar(30) OUTPUT
AS
IF @Sum < 0 
BEGIN
	SET @RetVal = 'Сумма должна быть > 0'
	return 0
END
	UPDATE a 
	SET Balance = Balance + @Sum 
	FROM Accounts a 
		INNER JOIN Clients c ON c.IdClient = a.ClientId
	WHERE StatusId = @StatusId
	SET @RetVal = 'Выполнено успешно'
RETURN 0

DECLARE @rv varchar(30)
exec sp_AddForStatus 1, 10, @rv OUTPUT
SELECT @rv

		-- Задание 6  С помощью оконной ф-ции 

SELECT DISTINCT LName, 
				FName,
				MName,
				a.AccountNumber,
				(a.Balance - SUM(c.Balance) over(PARTITION BY a.IdAccount)) FreeMoney
FROM  Cards c
	INNER JOIN Accounts a ON a.IdAccount = c.AccountId
	INNER JOIN Clients cl on cl.IdClient = a.ClientId



			-- Задание 7

CREATE PROCEDURE [sp_TransferMoney]
	@AccountId int,
	@CardNum numeric(16,0),
	@Sum numeric(8,2),
	@RetVal varchar(30) OUTPUT
AS
	BEGIN TRANSACTION tr1
	if (SELECT Count(*) 
		FROM Cards 
		WHERE AccountId = @AccountId 
			AND CardNumber = @CardNum) <> 1 
	BEGIN
		SET @RetVal = 'Карта не пренадлежит счёту'
		ROLLBACK TRANSACTION tr1
		RETURN 0
	END
	UPDATE Cards 
	SET Balance = Balance + @Sum
	WHERE CardNumber = @CardNum

	if (SELECT a.Balance - (SUM(c.Balance) over(PARTITION BY a.IdAccount))
		FROM Cards c
			INNER JOIN Accounts a ON a.IdAccount = AccountId
		WHERE AccountId = @AccountId)  < 0 
	BEGIN
		SET @RetVal = 'Перевод выполнить невозможно.'
		ROLLBACK TRANSACTION tr1
		RETURN 0
	END
	SET @RetVal = 'Перевод выполнен успешно'
	COMMIT TRANSACTION TR1
RETURN 0



DECLARE @rv varchar(30)
exec sp_TransferMoney 2, 5404365883659243, 10, @rv OUTPUT
SELECT @rv;



	-- Задание 7

	CREATE TRIGGER tr_Account_Update --Предполагается, что при Insert будут использоваться Default значения 
	ON [Accounts]
	INSTEAD OF UPDATE
	AS 
	DECLARE @IdAccount int
	DECLARE @Sum numeric(8,2)
	DECLARE @ClientId int
	DECLARE @AccountNumber varchar(50)
	DECLARE @BankId int

	SELECT  @IdAccount = IdAccount, 
			@Sum = Balance,
			@ClientId = ClientId,
			@AccountNumber = AccountNumber,
			@BankId = BankId
	FROM inserted
	IF(SELECT SUM(Balance) 
		FROM Cards 
		WHERE AccountId = @IdAccount) <= @Sum 
	UPDATE Accounts 
	SET Balance = @Sum,
		ClientId = @ClientId,
		AccountNumber = @AccountNumber,
		BankId = @BankId
	WHERE IdAccount = @IdAccount 


	SELECT * FROM Accounts
	WHERE IdAccount = 1
	BEGIN TRANSACTION TR1
	UPDATE Accounts SET Balance = 0
	WHERE IdAccount = 1
	ROLLBACK TRANSACTION TR1

	--Триггер для Cards

	CREATE TRIGGER tr_Cards_Update --Предполагается, что при Insert будут использоваться Default значения 
	ON [Cards]
	INSTEAD OF UPDATE
	AS 
	DECLARE @CardNumber numeric(16,0)
	DECLARE @Sum numeric(8,2)
	DECLARE @AccountId int
	SELECT  @CardNumber = CardNumber, 
			@Sum = Balance,
			@AccountId = AccountId
	FROM inserted
	IF(  (SELECT SUM(Balance)+ @Sum 
			FROM Cards 
			WHERE AccountId = @AccountId AND CardNumber <> @CardNumber) <= (SELECT Balance 
																			FROM Accounts 
																			WHERE IdAccount = @AccountId))
		UPDATE Cards 
		SET Balance = @Sum
		WHERE CardNumber = @CardNumber 
	ELSE
		PRINT('Ошибка суммы')


	SELECT * FROM Cards where CardNumber = 5404361197558981
	BEGIN TRANSACTION TR1

	UPDATE Cards SET Balance = 5000
	WHERE CardNumber = 5404361197558981

	ROLLBACK TRANSACTION TR1
