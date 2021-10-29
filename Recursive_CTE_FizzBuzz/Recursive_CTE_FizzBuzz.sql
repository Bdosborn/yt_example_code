


-- basic form for a recursive CTE

;WITH count_up AS
(
   SELECT 1 AS 'value'

   UNION ALL

   SELECT [value] + 1
   FROM   [count_up]
   WHERE  [value] < 10
)

-- execute the select from the CTE
SELECT * FROM [count_up]



-- Fizz Buzz solution using a CTE

;WITH FizzBuzz AS
(
	SELECT 
		  1		[count]
		, CONVERT(VARCHAR(10),'1')	'FB'

	UNION ALL

	SELECT 
		  [count] + 1
		, CASE 
			WHEN ([count] + 1) % 15 = 0 THEN 'FizzBuzz'
			WHEN ([count] + 1) % 3  = 0 THEN 'Fizz'
			WHEN ([count] + 1) % 5  = 0 THEN 'Buzz'
		 ELSE CONVERT(VARCHAR(10), ([count] + 1))
		 END
	FROM
		FizzBuzz

	WHERE [count] < 100
)

-- execute the select from the CTE
SELECT * FROM FizzBuzz

GO






-- use a recursive CTE and a table


-- DROP TABLE [dbo].[Employee]

-- create the table
CREATE TABLE [dbo].[Employee](
	[ID]			[int] NULL,
	[Name]			[varchar](10) NULL,
	[Manager_id]	[int] NULL
) 
GO


-- populate the table
INSERT [dbo].[Employee] ([ID], [Name], [Manager_id]) 
VALUES 
	(1, N'Williams', NULL),
	(2, N'Miller', 1),
	(3, N'Garcia', 1),
	(4, N'Smith', 2),
	(5, N'Jones', 3)
GO


-- Define the CTE
;WITH Managers AS
(
    SELECT 
        [ID]
       ,[Name]
       ,'(none)    ' 	AS 'Manager'
    FROM
        [Employee]
    WHERE
        [Manager_id] IS NULL
 
  UNION ALL

    SELECT
        e.[ID]
       ,e.[Name]
       ,m.[Name] 		AS 'Manager'  
    FROM
        [Employee] e

    INNER JOIN [Managers] m ON 
        m.[id] = e.[manager_id]
)

-- execute the select from the CTE
SELECT 
	 [Name]		AS 'employee' 
	,[Manager] 
FROM [Managers]

GO

