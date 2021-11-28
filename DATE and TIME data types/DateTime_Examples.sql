

-- DROP TABLE [dbo].[ORDERS]

CREATE TABLE [dbo].[ORDERS] (
     [order_number]         INT NOT NULL
    ,[order_datetime]       DATETIME NULL
    ,[order_date]           DATE NULL
    ,[delivery_datetime]    DATETIME NULL
)

INSERT INTO [dbo].[ORDERS] ([order_number], [order_datetime], [order_date], [delivery_datetime])
VALUES  
    ('1','2021-10-01 10:30:00', '2021-10-01', '2021-10-12 10:11:10'),
    ('2','2021-10-01 12:45:00', '2021-10-01', '2021-10-10 14:10:11'),
    ('3','2021-10-30 13:25:00', '2021-10-30', '2021-11-05 13:22:12'),
    ('4','2021-09-22 16:30:00', '2021-09-22', '2021-09-25 14:12:13'),
    ('5','2021-01-10 18:15:00', '2021-01-10', '2021-02-01 11:15:14'),
    ('6',CURRENT_TIMESTAMP, CONVERT(DATE, CURRENT_TIMESTAMP), DATEADD(DAY, 5, CURRENT_TIMESTAMP))



-- bring back just the order datetime values
SELECT [ORDER_DATETIME]
FROM
    [dbo].[ORDERS]



-- convert the order_datetime field into a string data type using the style number 22
SELECT
     [ORDER_DATETIME]
    ,CONVERT(VARCHAR(20), [ORDER_DATETIME], 22) 'ORDER_DATE_STRING'
FROM
    [dbo].[ORDERS]

-- convert the order_datetime field into the UK date format only, omiting the time parts
SELECT
     [ORDER_DATETIME]
    ,CONVERT(VARCHAR(10), [ORDER_DATETIME], 103) 'ORDER_DATE_STRING'
FROM
    [dbo].[ORDERS]



-- use the FORMAT function to convert to a string with the format of day period month period year
SELECT
     [ORDER_DATETIME]
    ,FORMAT([ORDER_DATETIME] ,'dd.MM.yyyy') 'ORDER_DATE_STRING'
FROM
    [dbo].[ORDERS]

-- use FORMAT to add text to the output, but omitting the escape characters outputs a jumble of values and text
SELECT
     [ORDER_DATETIME]
    ,FORMAT([ORDER_DATETIME],'day dd of MMM in the year yyyy') 'ORDER_DATE_STRING'
FROM
    [dbo].[ORDERS]

-- use FORMAT to add text to the output, this time escape the characters that would be interpreted as value placeholders
SELECT
     [ORDER_DATETIME]
    ,FORMAT([ORDER_DATETIME],'\da\y dd o\f MMM in \t\he \year yyyy') 'ORDER_DATE_STRING'
FROM
    [dbo].[ORDERS]



-- try to select the Orders where the order date is the first of december 2021 assuming the UK date format
SELECT
     [Order_ID]
    ,[Order_Date]
FROM
    [dbo].[ORDERS]
WHERE
    [Order_Date] = '01/10/2021'

-- try to select the Orders where the order date is the first of december 2021 assuming the ISO format
SELECT
     [Order_ID]
    ,[Order_Date]
FROM
    [dbo].[ORDERS]
WHERE
    [Order_Date] = '20211001'



-- convert a datetime variable into a VARCHAR data type, removing the time value
-- converts to style 103 which is dd/mm/yyyy
DECLARE @MyDate AS DATETIME
SET @MyDate = '2021-10-30 20:30:40'

SELECT CONVERT(VARCHAR , @MyDate, 103)

-- convert datetime variable to a varchar to remove the time part
-- then convert back to a datetime, making sure to include the style code for the date layout
DECLARE @MyDate AS DATETIME
SET @MyDate = '2021-10-30 20:30:40'

SELECT CONVERT(DATETIME, CONVERT(VARCHAR , @MyDate, 103), 103)

-- convert datetime to a date only, or a time only using the DATE and TIME data types
DECLARE @MyDate AS DATETIME
SET @MyDate = '2021-10-30 20:30:40'

SELECT 
     CONVERT(DATE, @MyDate)  'date_only'
    ,CONVERT(TIME, @MyDate)  'time_only'



-- getting the current date and time

-- both GETDATE() and CURRENT_TIMESTAMP return the current system date.
-- use CURRENT_TIUMESTAMP in preference as it is an SQL standard function.
SELECT
     GETDATE()
    ,CURRENT_TIMESTAMP


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
     [Order_ID]
    ,[Order_Date]
FROM
    [dbo].[ORDERS]
WHERE
    [order_date] BETWEEN EOMONTH('2021-10-10') AND DATEADD(DAY, 1, EOMONTH('2021-10-10', -1))



DECLARE @MyDate AS DATETIME
SET @MyDate = '2021-10-30'

SELECT DATEDIFF(month, 0, @mydate) 'days_since_zero'

SELECT DATEADD(month, 1461, 0) 'zero_plus_1461_months'

SELECT DATEADD(month, DATEDIFF(month, 0, @mydate), 0) 'month_start'

-- show all orders where the order_date is between the first and the last date of our date variable
SELECT     
     [Order_ID]
    ,[Order_Date]
FROM	[ORDERS]
WHERE	[order_date] BETWEEN     
                        DATEADD(month,  DATEDIFF(month, 0, @mydate), 0)
                        AND DATEADD(day,-1, DATEADD(month, DATEDIFF(month, -1, @mydate), 0))



-- show all orders where the order_date is within the current month
SELECT     
     [Order_ID]
    ,[Order_Date]
FROM	[dbo].[ORDERS]
WHERE	[order_date] BETWEEN     
                        DATEADD(month,  DATEDIFF(month, 0, CURRENT_TIMESTAMP), 0)
                        AND DATEADD(day,-1, DATEADD(month, DATEDIFF(month, -1, CURRENT_TIMESTAMP), 0))



