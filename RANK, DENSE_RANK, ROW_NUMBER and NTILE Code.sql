
-- Create the example table and add in some data.

-- DROP TABLE [dbo].[Sales]

CREATE TABLE [dbo].[Sales]
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
	(1,	'Williams',	'Monitor',	 20 ),
	(2,	'Williams',	'Keyboard',	 45 ),
	(3,	'Williams',	'Cable',	 35 ),
	(4,	'Miller',	'Keyboard',	 20 ),
	(5,	'Miller',	'Processor', 10 ),
	(6,	'Garcia',	'Monitor',	 10 ),
	(7,	'Garcia',	'Keyboard',	 20 ),
	(8,	'Garcia',	'Cable',	 15 ),
	(9,	'Garcia',	'Printer',	 35 )
    ;


-- SELECT all rows and columns in the table

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
FROM [dbo].[Sales];



-- ROW_NUMBER()

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,ROW_NUMBER() OVER(ORDER BY [Quantity]) SalesRank
FROM [dbo].[Sales];

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,ROW_NUMBER() OVER(ORDER BY [Quantity] DESC) SalesRank
FROM [dbo].[Sales];

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,ROW_NUMBER() OVER(PARTITION BY [SalesPerson] ORDER BY [Quantity] DESC) SalesRank
FROM [dbo].[Sales];

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,ROW_NUMBER() OVER(PARTITION BY [Product] ORDER BY [SalesPerson], [Quantity] DESC) SalesRank
FROM [dbo].[Sales];


-- RANK()

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,RANK() OVER(ORDER BY [Quantity] DESC) SalesRank
FROM [dbo].[Sales];

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,RANK() OVER(PARTITION BY [Product] ORDER BY [Quantity] DESC) SalesRank
FROM [dbo].[Sales];


-- DENSE_RANK()

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,DENSE_RANK() OVER(ORDER BY [Quantity] DESC) SalesRank
FROM [dbo].[Sales];


SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,DENSE_RANK() OVER(PARTITION BY [Product] ORDER BY [Quantity] DESC) SalesRank
FROM [dbo].[Sales];


-- NTILE()

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,NTILE(1) OVER(ORDER BY [Quantity] DESC) SalesRank
FROM [Sales];

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,NTILE(2) OVER(ORDER BY [Quantity] DESC) SalesRank
FROM [Sales];

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,NTILE(15) OVER(ORDER BY [Quantity] DESC) SalesRank
FROM [Sales];

SELECT 
	 [ID]
	,[SalesPerson]	
	,[Product]		
	,[Quantity]		
	,NTILE(2) OVER(PARTITION BY [Product] ORDER BY [Quantity] DESC) SalesRank
FROM [Sales];