/*******************************************************************************************

 BI DISCOVERY TOOLKIT
 ------------------------------------------------------------------------------------------
 File        : 03 - Table Analysis.sql

 Author      : Mohadeseh Mohammadi
 Version     : 1.0

 Skill Level : ⭐⭐ Intermediate

 Description
 ------------------------------------------------------------------------------------------
 This script helps BI Developers understand
 the purpose of every table before designing
 a Data Warehouse.

 Instead of jumping directly into ETL,
 start by understanding the business meaning
 of each table.

*******************************************************************************************/






/*******************************************************************************************
TABLE SELECTION

Change only these two values before running the script.

USER INPUT

Change only these values.
Do not modify the queries below.

Example:

Schema  : Sales
Table   : Invoices

*******************************************************************************************/

DECLARE @TableSchema sysname = 'Sales';
DECLARE @TableName   sysname = 'Invoices';












/*******************************************************************************************
STEP 1
List Tables with Row Counts

Goal
-----
Identify large and small tables.

Why?
-----
Large tables are often transactional.

Small tables are often master data.



Question

Does this table contain millions of rows?

YES

↓

Probably Transaction Table

-----------------------------

Does this table contain only hundreds of rows?

YES

↓

Probably Master Data

*******************************************************************************************/

SELECT

    s.name AS SchemaName,

    t.name AS TableName,

    SUM(p.rows) AS [RowCount]

FROM sys.tables t

JOIN sys.schemas s

ON t.schema_id=s.schema_id

JOIN sys.partitions p

ON p.object_id=t.object_id

WHERE p.index_id IN (0,1)

GROUP BY

    s.name,

    t.name

ORDER BY SUM(p.rows) DESC;



/*******************************************************************************************
STEP 2
Inspect Table Columns

Goal
-----
Understand the structure of a business entity.

Replace:

@TableSchema
@TableName

*******************************************************************************************/


SELECT

COLUMN_NAME,

DATA_TYPE,

CHARACTER_MAXIMUM_LENGTH,

IS_NULLABLE

FROM INFORMATION_SCHEMA.COLUMNS

WHERE TABLE_SCHEMA=@TableSchema

AND TABLE_NAME=@TableName

ORDER BY ORDINAL_POSITION;








/*******************************************************************************************
STEP 3
Primary Key

Goal
-----
Identify the business identifier.

*******************************************************************************************/

SELECT
    c.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
    ON tc.CONSTRAINT_NAME = c.CONSTRAINT_NAME
WHERE tc.TABLE_SCHEMA = @TableSchema
AND tc.TABLE_NAME = @TableName
AND tc.CONSTRAINT_TYPE = 'PRIMARY KEY';






/*******************************************************************************************
STEP 4
Foreign Keys

Goal
-----
Understand table relationships.

*******************************************************************************************/


SELECT
    c.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
    ON tc.CONSTRAINT_NAME = c.CONSTRAINT_NAME
WHERE tc.TABLE_SCHEMA = @TableSchema
AND tc.TABLE_NAME = @TableName
AND tc.CONSTRAINT_TYPE = 'Foreign KEY';







/*******************************************************************************************
STEP 5
Preview Data

Goal
-----
Never design a Data Warehouse
without looking at the actual data.

*******************************************************************************************/




DECLARE @SQL nvarchar(max);

SET @SQL = '

SELECT TOP (100) *

FROM '

+ QUOTENAME(@TableSchema)
+ '.'
+ QUOTENAME(@TableName);


EXEC sp_executesql @SQL;






/*******************************************************************************************
Think Like a BI Developer


Question 1

What does ONE ROW represent?

One Invoice?

One Product?

One Customer?

One Payment?

--------------------------------------

Question 2

What is the Grain?

Example

One row = One Invoice

OR

One row = One Invoice Line

--------------------------------------

Question 3

Does the table continuously grow?

YES

↓

Transaction Table

--------------------------------------

Question 4

Does it change frequently?

YES

↓

Fact Candidate

--------------------------------------

Question 5

Does it describe something?

YES

↓

Dimension Candidate

--------------------------------------

Question 6

Which columns are Measures?

Quantity

Price

Amount

Tax

Discount

--------------------------------------

Question 7

Which columns are Keys?

CustomerID

ProductID

EmployeeID

InvoiceID

--------------------------------------

Question 8

Can this table support Incremental Load?

Look for columns like

ModifiedDate

UpdatedDate

LastEditedWhen

ValidFrom

ValidTo

*******************************************************************************************/





/*******************************************************************************************

TABLE ANALYSIS WORKSHEET

Table Name

______________________________________________

Business Description

______________________________________________

______________________________________________

Business Process

□ Sales

□ Inventory

□ Purchasing

□ Finance

□ HR

□ CRM

Table Type

□ Transaction

□ Master

□ Lookup

□ Bridge

□ Snapshot

□ Reference

Granularity

One Row Represents

______________________________________________

Candidate

□ Fact

□ Dimension

Measures

______________________________________________

______________________________________________

Business Keys

______________________________________________

______________________________________________

Foreign Keys

______________________________________________

Incremental Load Column

______________________________________________

Soft Delete Column

______________________________________________

Slowly Changing Dimension?

□ Yes

□ No

Notes

______________________________________________

______________________________________________

*******************************************************************************************/








/*******************************************************************************************
Expected Outcome
────────────────────────────

After completing this script, you should know:

✔ What this table represents.

✔ The business process.

✔ The granularity.

✔ Whether it is Transactional or Master Data.

✔ Potential Fact/Dimension classification.

✔ Candidate Incremental Load column.

✔ Important Business Keys.
*******************************************************************************************/
