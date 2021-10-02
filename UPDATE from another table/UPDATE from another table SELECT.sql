
-- Create the example tables and add in some data.
-- 

-- DROP TABLE [dbo].[Sales]
-- DROP TABLE [dbo].[NewSales]

CREATE TABLE [dbo].[Sales]
(
	 [ID]			INT
	,[SalesPerson]	VARCHAR(50)
	,[Product]		VARCHAR(50)
	,[Quantity]		INT
);

CREATE TABLE [dbo].[NewSales]
(
	 [ID]			INT
	,[SalesPerson]	VARCHAR(50)
	,[Product]		VARCHAR(50)
	,[Quantity]		INT
);

INSERT INTO [dbo].[Sales] (
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]	)
VALUES 
	(1,	'Williams',	'Keyboard',	 40 ),
	(2,	'Williams',	'Cable',	 30 ),
	(3,	'Miller',	'Keyboard',	 20 ),
	(4,	'Miller',	'Processor', 10 ),
	(5,	'Garcia',	'Monitor',	 10 ),
	(6,	'Garcia',	'Keyboard',	 20 )
    ;

INSERT INTO [dbo].[NewSales] (
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]	)
VALUES 
	(1,	'Williams',	'Keyboard',	 45 ),
	(2,	'Williams',	'Cable',	 35 ),
	(3,	'Miller',	'Processor', 15 ),
	(4,	'Garcia',	'Monitor',	 15 ),
    (5,	'Smith',	'Mouse',	 5  )
    ;


SELECT * FROM [Sales]

-- sections are surronded by TRANSACTIONS so no need to repopulate the original table.



-- UPDATE using a FROM clause on another table

BEGIN TRANSACTION



UPDATE [Sales]
SET
    [Quantity] = [n].[Quantity]

FROM    
    [NewSales] AS [n]
WHERE
        [n].[SalesPerson]   = [Sales].[SalesPerson]
    AND [n].[Product]       = [Sales].[Product]



SELECT * FROM [Sales]
ROLLBACK




-- UPDATE using a FROM table but use a JOIN to link the UPDATE table
-- and the source table 

BEGIN TRANSACTION



UPDATE [s] 
SET
    [Quantity] = [n].[Quantity]

FROM
    [Sales] AS [s]
    
    INNER JOIN [NewSales] AS [n] ON
        [n].[SalesPerson]   = [s].[SalesPerson]
    AND [n].[Product]       = [s].[Product]



SELECT * FROM [Sales]
ROLLBACK




-- UPDATE the table using a MERGE statement

BEGIN TRANSACTION



MERGE INTO [Sales] [s]
USING 
    [NewSales] [n] ON
        [n].[SalesPerson]   = [s].[SalesPerson]
    AND [n].[Product]       = [s].[Product]

WHEN MATCHED THEN
UPDATE 
    SET [s].[Quantity] = [n].[Quantity];



SELECT * FROM [Sales]
ROLLBACK




-- UPDATE using a Common Table Expression (CTE) as the source table 

BEGIN TRANSACTION



;WITH CTE AS
(
    SELECT [SalesPerson],[Product],[Quantity] FROM [NewSales] WHERE [Quantity] >= 15
)
UPDATE [s]
SET
    [Quantity]  = [n].[Quantity]
FROM
    [Sales] AS [s]
    
    INNER JOIN [CTE] AS [n] ON
        [n].[SalesPerson]   = [s].[SalesPerson]
    AND [n].[Product]       = [s].[Product]



SELECT * FROM [Sales]
ROLLBACK



