/*******************************************************************************************

 BI DISCOVERY TOOLKIT
 ------------------------------------------------------------------------------------------
 File        : 02 - Schema Analysis.sql

 Author      : Mohadeseh Mohammadi
 Version     : 1.0

 Skill Level : ⭐ Beginner

 Description
 ------------------------------------------------------------------------------------------
 The purpose of this script is to understand the logical structure
 of the source database.

 Most enterprise systems separate business domains into Schemas.

 Examples:

 • Sales
 • Purchasing
 • Warehouse
 • Finance
 • HumanResources

 Understanding Schemas is the first step toward identifying
 business processes.

*******************************************************************************************/


/*******************************************************************************************
STEP 1
List All Schemas

Goal
-----
Display all schemas available in the current database.

Why?
-----
Schemas usually represent business modules.

Example

Sales
Warehouse
Finance
Application

*******************************************************************************************/

SELECT
    name AS SchemaName
FROM sys.schemas
ORDER BY name;



/*******************************************************************************************
STEP 2
Count Tables in Each Schema

Goal
-----
Measure the size of each business module.

Why?
-----
A schema containing many tables often represents
a major business domain.

*******************************************************************************************/

SELECT

    s.name AS SchemaName,

    COUNT(*) AS NumberOfTables

FROM sys.tables t

JOIN sys.schemas s

ON t.schema_id=s.schema_id

GROUP BY

    s.name

ORDER BY NumberOfTables DESC;



/*******************************************************************************************
STEP 3
List Tables by Schema

Goal
-----
Display every table grouped by schema.

Why?
-----
This provides a high-level map of the database.

*******************************************************************************************/

SELECT

    s.name AS SchemaName,

    t.name AS TableName

FROM sys.tables t

JOIN sys.schemas s

ON s.schema_id=t.schema_id

ORDER BY

    s.name,

    t.name;



/*******************************************************************************************
STEP 4
Identify Empty Schemas

Goal
-----
Find schemas that contain no user tables.

Why?
-----
Some schemas are reserved for future development
or system objects.

*******************************************************************************************/

SELECT

    s.name AS SchemaName

FROM sys.schemas s

LEFT JOIN sys.tables t

ON s.schema_id=t.schema_id

WHERE t.object_id IS NULL

ORDER BY s.name;



/*******************************************************************************************
STEP 5
Top Schemas by Number of Rows

Goal
-----
Estimate which business modules contain the most data.

Why?
-----
This helps prioritize exploration.

Large schemas usually contain
Fact Tables.

*******************************************************************************************/

SELECT

    s.name AS SchemaName,

    SUM(p.rows) AS TotalRows

FROM sys.tables t

JOIN sys.schemas s

ON t.schema_id=s.schema_id

JOIN sys.partitions p

ON t.object_id=p.object_id

WHERE p.index_id IN (0,1)

GROUP BY

    s.name

ORDER BY TotalRows DESC;



/*******************************************************************************************

Think Like a BI Developer
--------------------------------------------------------------------------------------------

Don't just look at schema names.

Ask yourself:

□ Which schema probably contains transactional data?

□ Which schema contains master data?

□ Which schema looks like configuration?

□ Which schema is likely to become the Data Warehouse source?

□ Which business process should I start with?

Example

Sales
    ↓
Invoices
    ↓
InvoiceLines
    ↓
Customers
    ↓
StockItems

This could become your first Star Schema.

*******************************************************************************************/



/*******************************************************************************************

Discovery Notes

Business Modules Found

_____________________________________________________

_____________________________________________________

_____________________________________________________

Largest Schema

_____________________________________________________

Most Interesting Schema

_____________________________________________________

Candidate for First BI Subject Area

_____________________________________________________

Questions

□ Which schema should I analyze first?

□ Which schema probably contains Facts?

□ Which schema probably contains Dimensions?

□ Which schema can be ignored for now?

*******************************************************************************************/
