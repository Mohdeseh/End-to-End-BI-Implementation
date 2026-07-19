
/*******************************************************************************************

 BI DISCOVERY TOOLKIT
 ------------------------------------------------------------------------------------------
 File        : 06 - Data Profiling.sql

 Author      : Mohadeseh Mohammadi
 Version     : 1.0
 --Skill Level : ⭐⭐⭐⭐ Advanced

 Description
 ------------------------------------------------------------------------------------------
 Analyze the quality and distribution of data before
 designing ETL processes and Data Warehouse models.

 This script helps BI Developers identify:

 • Missing values
 • Data distribution
 • Distinct values
 • Data ranges
 • Data quality issues

*******************************************************************************************/





/*******************************************************************************************
USER INPUT

Change only these values.

*******************************************************************************************/

/*******************************************************************************************
USER INPUT

Change only these values.

*******************************************************************************************/

DECLARE @TableSchema sysname = 'Sales';
DECLARE @TableName   sysname = 'Invoices';
DECLARE @ColumnName  sysname = 'TotalDryItems' --or 'InvoiceDate';










/*******************************************************************************************
STEP 1
Table Size

Goal
-----
Understand dataset size.

*******************************************************************************************/

DECLARE @SQL nvarchar(MAX);

SET @SQL = '
SELECT COUNT(*) AS TotalRows
FROM '
+ QUOTENAME(@TableSchema)
+'.'
+ QUOTENAME(@TableName);

EXEC sp_executesql @SQL;









/*******************************************************************************************
STEP 2
Preview Data

Goal
-----
Inspect actual values before profiling.

*******************************************************************************************/

SET @SQL='

SELECT TOP (100)

*

FROM '

+QUOTENAME(@TableSchema)

+'.'

+QUOTENAME(@TableName);

EXEC sp_executesql @SQL;





/*******************************************************************************************
STEP 3
Null Analysis

Goal
-----
Measure missing values.

*******************************************************************************************/

SET @SQL='

SELECT

COUNT(*) TotalRows,

COUNT('+QUOTENAME(@ColumnName)+') NonNullRows,

COUNT(*)-COUNT('+QUOTENAME(@ColumnName)+') NullRows,

CAST(
(COUNT(*)-COUNT('+QUOTENAME(@ColumnName)+'))*100.0
/COUNT(*)
AS decimal(5,2)
) AS NullPercent

FROM '

+QUOTENAME(@TableSchema)

+'.'

+QUOTENAME(@TableName);

EXEC sp_executesql @SQL;




/*******************************************************************************************
STEP 4
Distinct Values

Goal
-----
Understand column cardinality.

*******************************************************************************************/
SET @SQL='

SELECT

COUNT(DISTINCT '+QUOTENAME(@ColumnName)+') AS DistinctValues

FROM '

+QUOTENAME(@TableSchema)

+'.'

+QUOTENAME(@TableName);

EXEC sp_executesql @SQL;





/*******************************************************************************************
STEP 5
Top Values

Goal
-----
Identify common values.

*******************************************************************************************/
SET @SQL='

SELECT TOP (10)

'+QUOTENAME(@ColumnName)+' AS Value,

COUNT(*) Frequency

FROM '

+QUOTENAME(@TableSchema)

+'.'

+QUOTENAME(@TableName)+'

GROUP BY '

+QUOTENAME(@ColumnName)+'

ORDER BY Frequency DESC';

EXEC sp_executesql @SQL;










/*******************************************************************************************
STEP 6
Numeric Statistics

Goal
-----
Analyze numeric measures.

Run only for numeric columns.

*******************************************************************************************/

DECLARE @DataType sysname;


SELECT @DataType = DATA_TYPE

FROM INFORMATION_SCHEMA.COLUMNS

WHERE TABLE_SCHEMA = @TableSchema

AND TABLE_NAME = @TableName

AND COLUMN_NAME = @ColumnName;



IF @DataType IN
(
    'tinyint',
    'smallint',
    'int',
    'bigint',
    'decimal',
    'numeric',
    'float',
    'real',
    'money',
    'smallmoney'
)

BEGIN

    SET @SQL = '

    SELECT

        COUNT(*) AS TotalRows,

        MIN(' + QUOTENAME(@ColumnName) + ') AS MinValue,

        MAX(' + QUOTENAME(@ColumnName) + ') AS MaxValue,

        AVG(CAST(' + QUOTENAME(@ColumnName) + ' AS decimal(18,2))) AS AvgValue,

        SUM(' + QUOTENAME(@ColumnName) + ') AS TotalValue

    FROM '

    + QUOTENAME(@TableSchema)

    + '.'

    + QUOTENAME(@TableName);



    EXEC sp_executesql @SQL;

END

ELSE

BEGIN

    SELECT

        @ColumnName AS ColumnName,

        @DataType AS DataType,

        'Selected column is not numeric. Please choose a numeric column.' AS Message;

END













/*******************************************************************************************
STEP 7
Date Range

Goal
-----
Analyze available timeline.

Run only for date columns.

*******************************************************************************************/
/*******************************************************************************************
STEP 7
Date Range

Goal
-----
Analyze available timeline.

Run only for date columns.

*******************************************************************************************/

--DECLARE @DataType sysname;


SELECT @DataType = DATA_TYPE

FROM INFORMATION_SCHEMA.COLUMNS

WHERE TABLE_SCHEMA = @TableSchema

AND TABLE_NAME = @TableName

AND COLUMN_NAME = @ColumnName;



IF @DataType IN
(
    'date',
    'datetime',
    'datetime2',
    'smalldatetime'
)

BEGIN

    SET @SQL = '

    SELECT

        MIN(' + QUOTENAME(@ColumnName) + ') AS FirstDate,

        MAX(' + QUOTENAME(@ColumnName) + ') AS LastDate

    FROM '

    + QUOTENAME(@TableSchema)

    + '.'

    + QUOTENAME(@TableName);



    EXEC sp_executesql @SQL;

END

ELSE

BEGIN

    SELECT

        @ColumnName AS ColumnName,

        @DataType AS DataType,

        'Selected column is not a date column. Please choose a date column.' AS Message;

END








/*******************************************************************************************
Data Profiling Investigation

Question 1

Does this column contain NULL values?

--------------------------------

Question 2

How many unique values exist?

--------------------------------

Question 3

Does the data look clean?

--------------------------------

Question 4

Is data cleansing required?

--------------------------------

Question 5

Can this column be used for reporting?

--------------------------------

Question 6

Does this column require transformation?

*******************************************************************************************/



/*******************************************************************************************
✔ Table size identified

✔ Missing values analyzed

✔ Distinct values identified

✔ Most common values identified

✔ Numeric statistics calculated (if applicable)

✔ Date range analyzed (if applicable)

✔ Data quality assessed

*******************************************************************************************/
