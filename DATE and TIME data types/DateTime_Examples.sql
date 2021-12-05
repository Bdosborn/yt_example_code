-- Create the example tables and add in some data.
-- 

-- DROP TABLE [dbo].[ORDERS]

CREATE TABLE [dbo].[ORDERS] (
     [order_number]         INT NOT NULL
    ,[order_datetime]       DATETIME NULL
    ,[order_date]           DATE NULL
    ,[delivery_datetime]    DATETIME NULL
    ,[last_visit_date]       DATE NULL
)
GO

INSERT INTO [dbo].[ORDERS] ([order_number], [order_datetime], [order_date], [delivery_datetime], [last_visit_date])
VALUES  
    ('1','2021-10-01 10:30:00', '2021-10-01', '2021-10-12 10:11:10', '2021-11-01'),
    ('2','2021-10-01 12:45:00', '2021-10-01', '2021-10-10 14:10:11', '2021-10-15'),
    ('3','2021-10-30 13:25:00', '2021-10-30', '2021-11-05 13:22:12', '2021-12-30'),
    ('4','2021-09-22 16:30:00', '2021-09-22', '2021-09-25 14:12:13', '2021-12-22'),
    ('5','2021-01-10 18:15:00', '2021-01-10', '2021-02-01 11:15:14', '2022-01-10'),
    ('6',CURRENT_TIMESTAMP, CONVERT(DATE, CURRENT_TIMESTAMP), DATEADD(DAY, 5, CURRENT_TIMESTAMP), DATEADD(MONTH, 5, CURRENT_TIMESTAMP))
GO


-- bring back just the order datetime values
SELECT [order_datetime]
FROM
    [dbo].[ORDERS]
GO


-- convert the order_datetime field into a string data type using the style number 22
SELECT
     [order_datetime]
    ,CONVERT(VARCHAR(20), [order_datetime], 22) 'ORDER_DATE_STRING'
FROM
    [dbo].[ORDERS]

-- convert the order_datetime field into the UK date format only, omitting  the time parts
SELECT
     [order_datetime]
    ,CONVERT(VARCHAR(10), [order_datetime], 103) 'ORDER_DATE_STRING'
FROM
    [dbo].[ORDERS]



-- use the FORMAT function to convert to a string with the format of day period month period year
SELECT
     [order_datetime]
    ,FORMAT([order_datetime] ,'dd.MM.yyyy') 'ORDER_DATE_STRING'
FROM
    [dbo].[ORDERS]

-- use FORMAT to add text to the output, but omitting the escape characters outputs a jumble of values and text
SELECT
     [order_datetime]
    ,FORMAT([order_datetime],'day dd of MMM in the year yyyy') 'ORDER_DATE_STRING'
FROM
    [dbo].[ORDERS]

-- use FORMAT to add text to the output, this time escape the characters that would be interpreted as value placeholders
SELECT
     [order_datetime]
    ,FORMAT([order_datetime],'\da\y dd o\f MMM in \t\he \year yyyy') 'ORDER_DATE_STRING'
FROM
    [dbo].[ORDERS]



-- try to select the Orders where the order date is the first of december 2021 assuming the UK date format
SELECT
     [order_number]
    ,[order_date]
FROM
    [dbo].[ORDERS]
WHERE
    [order_date] = '01/10/2021'

-- try to select the Orders where the order date is the first of december 2021 assuming the ISO format
SELECT
     [order_number]
    ,[order_date]
FROM
    [dbo].[ORDERS]
WHERE
    [order_date] = '20211001'



-- convert a datetime variable into a VARCHAR data type, removing the time value
-- converts to style 103 which is dd/mm/yyyy
DECLARE @MyDate AS DATETIME
SET @MyDate = '2021-10-30 20:30:40'

SELECT CONVERT(VARCHAR , @MyDate, 103)
GO
-- convert datetime variable to a varchar to remove the time part
-- then convert back to a datetime, making sure to include the style code for the date layout
DECLARE @MyDate AS DATETIME
SET @MyDate = '2021-10-30 20:30:40'

SELECT CONVERT(DATETIME, CONVERT(VARCHAR , @MyDate, 103), 103)
GO
-- convert datetime to a date only, or a time only using the DATE and TIME data types
DECLARE @MyDate AS DATETIME
SET @MyDate = '2021-10-30 20:30:40'

SELECT 
     CONVERT(DATE, @MyDate)  'date_only'
    ,CONVERT(TIME, @MyDate)  'time_only'
GO


-- getting the current date and time

-- both GETDATE() and CURRENT_TIMESTAMP return the current system date.
-- use CURRENT_TIUMESTAMP in preference as it is an SQL standard function.
SELECT
     GETDATE()
    ,CURRENT_TIMESTAMP



-- getting parts of the date and time

-- use datepart to return the named parts of the order_datetime field
SELECT
     [order_datetime]
    ,DATEPART(year,     [order_datetime])    'year'
    ,DATEPART(quarter,  [order_datetime])    'quarter'
    ,DATEPART(month,    [order_datetime])    'month'
    ,DATEPART(day,      [order_datetime])    'day'
    ,DATEPART(week,     [order_datetime])    'week'
    ,DATEPART(weekday,  [order_datetime])    'weekday'
    ,DATEPART(hour,     [order_datetime])    'hour'
    ,DATEPART(minute,   [order_datetime])    'minute'
    ,DATEPART(second,   [order_datetime])    'second'
FROM
    [dbo].[ORDERS]

-- use datename to return the string names of the month and the weekday
SELECT
     [order_datetime]
	,DATENAME(month,    [order_datetime])	'month'
	,DATENAME(weekday,  [order_datetime])	'weekday'
FROM
    [dbo].[ORDERS]



-- finding the difference between two dates

-- using DATEDIFF to find the number of days between an order date and a delivery date
SELECT
     [order_date]
	,[delivery_datetime]
	,DATEDIFF(day, [order_date], [delivery_datetime]) 'del_days'
FROM
    [dbo].[ORDERS]

-- using DATEDIFF to find the number of months between the last_visit_date and the order_date
SELECT
     [order_date]
	,[last_visit_date]
	,DATEDIFF(month, [order_date], [last_visit_date]) 'visit_months'
FROM
    [dbo].[ORDERS]



-- adding a number of datetime periods to a date

-- using DATEADD to add two months to the order_date value
SELECT
     [order_date]
	,DATEADD(month, 2, [order_date]) 'order+2M'
FROM
    [dbo].[ORDERS]

-- using DATEADD to subtract one year from the order_date value
SELECT
     [order_date]
	,DATEADD(year, -1, [order_date]) 'order+2M'
FROM
    [dbo].[ORDERS]



-- get the first and last dates of a given period

-- return the last date in the selected month
SELECT  
    EOMONTH('2021-10-10') 'month_end'

-- return the last date of the previous month
SELECT  
    EOMONTH('2021-10-10', -1)  'lastmonth_end'

-- return the last date of the previous month, then add one day
-- to return the first day of the next month
SELECT  
    DATEADD(DAY, 1, EOMONTH('2021-10-10', -1)) 'month_start'

-- return the orders between the start and end of the month of october
SELECT
     [order_number]
    ,[Order_Date]
FROM
    [dbo].[ORDERS]
WHERE
    [order_date] BETWEEN DATEADD(DAY, 1, EOMONTH('2021-10-10', -1)) AND EOMONTH('2021-10-10')



-- use dateadd and datediff to get the beginning and end of any period

DECLARE @MyDate AS DATETIME
SET @MyDate = '2021-10-30'

SELECT DATEDIFF(month, 0, @mydate) 'days_since_zero'

SELECT DATEADD(month, 1461, 0) 'zero_plus_1461_months'

SELECT DATEADD(month, DATEDIFF(month, 0, @mydate), 0) 'month_start'

-- show all orders where the order_date is between the first and the last date of our date variable
SELECT     
     [order_number]
    ,[order_date]
FROM	[ORDERS]
WHERE	[order_date] BETWEEN     
                        DATEADD(month,  DATEDIFF(month, 0, @mydate), 0)
                        AND DATEADD(day,-1, DATEADD(month, DATEDIFF(month, -1, @mydate), 0))
GO

-- show all orders where the order_date is within the current month
SELECT     
     [order_number]
    ,[order_date]
FROM	[dbo].[ORDERS]
WHERE	[order_date] BETWEEN     
                        DATEADD(month,  DATEDIFF(month, 0, CURRENT_TIMESTAMP), 0)
                        AND DATEADD(day,-1, DATEADD(month, DATEDIFF(month, -1, CURRENT_TIMESTAMP), 0))
GO


