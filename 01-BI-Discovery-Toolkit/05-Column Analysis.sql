/*******************************************************************************************

 BI DISCOVERY TOOLKIT
 ------------------------------------------------------------------------------------------
 File        : 05 - Column Analysis.sql

 Author      : Mohadeseh Mohammadi
 Version     : 1.0

 Skill Level : ⭐⭐⭐ Advanced

 Description
 ------------------------------------------------------------------------------------------
 Analyze table columns to understand their structure before
 performing Data Profiling or designing a Data Warehouse.

*******************************************************************************************/

/*******************************************************************************************
USER INPUT

Change only these values.

*******************************************************************************************/

DECLARE @TableSchema sysname = 'Sales';
DECLARE @TableName   sysname = 'Invoices';

/*******************************************************************************************






STEP 1
List All Columns

Goal
-----
Display all columns with their metadata.

*******************************************************************************************/

SELECT

    COLUMN_NAME,
    ORDINAL_POSITION,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    NUMERIC_PRECISION,
    NUMERIC_SCALE,
    IS_NULLABLE

FROM INFORMATION_SCHEMA.COLUMNS

WHERE TABLE_SCHEMA = @TableSchema

AND TABLE_NAME = @TableName

ORDER BY ORDINAL_POSITION;







/*******************************************************************************************
STEP 2
Identity Columns

Goal
-----
Identify auto-generated keys.

*******************************************************************************************/

SELECT

    c.name AS ColumnName,

    ic.seed_value,

    ic.increment_value

FROM sys.identity_columns ic

JOIN sys.columns c

ON ic.object_id = c.object_id

AND ic.column_id = c.column_id

WHERE OBJECT_SCHEMA_NAME(ic.object_id) = @TableSchema

AND OBJECT_NAME(ic.object_id) = @TableName;







/*******************************************************************************************
STEP 3
Default Values

Goal
-----
Identify default values assigned to columns.

*******************************************************************************************/

SELECT

    c.name AS ColumnName,

    dc.definition AS DefaultValue

FROM sys.default_constraints dc

JOIN sys.columns c

ON dc.parent_object_id = c.object_id

AND dc.parent_column_id = c.column_id

WHERE OBJECT_SCHEMA_NAME(dc.parent_object_id) = @TableSchema

AND OBJECT_NAME(dc.parent_object_id) = @TableName;




/*******************************************************************************************
STEP 4
Computed Columns

Goal
-----
Identify calculated columns.

*******************************************************************************************/

SELECT

    name AS ColumnName

FROM sys.columns

WHERE object_id = OBJECT_ID(QUOTENAME(@TableSchema)+'.'+QUOTENAME(@TableName))

AND is_computed = 1;





/*******************************************************************************************
STEP 5
Column Type Summary

Goal
-----
Understand the composition of the table.

*******************************************************************************************/

SELECT

    DATA_TYPE,

    COUNT(*) AS NumberOfColumns

FROM INFORMATION_SCHEMA.COLUMNS

WHERE TABLE_SCHEMA = @TableSchema

AND TABLE_NAME = @TableName

GROUP BY DATA_TYPE

ORDER BY NumberOfColumns DESC;

/*******************************************************************************************
STEP 6
Potential Business Keys

Goal
-----
Identify columns that may uniquely identify business entities.

*******************************************************************************************/

SELECT

COLUMN_NAME

FROM INFORMATION_SCHEMA.COLUMNS

WHERE TABLE_SCHEMA=@TableSchema

AND TABLE_NAME=@TableName

AND
(
COLUMN_NAME LIKE '%Code%'
OR COLUMN_NAME LIKE '%Number%'
OR COLUMN_NAME LIKE '%ID%'
OR COLUMN_NAME LIKE '%Key%'
);



/*******************************************************************************************
Column Investigation

Question 1

Which column is most likely the Business Key?

--------------------------------

Question 2

Which columns are technical keys?

--------------------------------

Question 3

Does the table contain Identity columns?

--------------------------------

Question 4

Are there Computed columns?

--------------------------------

Question 5

Does the table contain Audit columns?

--------------------------------

Question 6

Can you already identify candidate
Business Attributes?
*******************************************************************************************/




/*******************************************************************************************
Expected Outcome

After completing this script, you should know:

✔ Column metadata

✔ Data types

✔ Identity columns

✔ Default values

✔ Computed columns

✔ Candidate Business Keys

✔ Candidate Audit Columns

Ready for:
06 - Data Profiling.sql

*******************************************************************************************/
