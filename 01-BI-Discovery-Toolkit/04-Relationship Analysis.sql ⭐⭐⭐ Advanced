/*******************************************************************************************

 BI DISCOVERY TOOLKIT
 ------------------------------------------------------------------------------------------
 File        : 04 - Relationship Analysis.sql

 Author      : Mohadeseh Mohammadi
 Version     : 1.0

 Skill Level : ⭐⭐⭐ Advanced

 Description
 ------------------------------------------------------------------------------------------
 This script helps BI Developers understand
 relationships between tables before designing
 a Data Warehouse.

 Understanding relationships is essential for:

 • Star Schema Design
 • Fact and Dimension Identification
 • ETL Planning
 • Data Model Creation

*******************************************************************************************/






/*******************************************************************************************
STEP 1
List All Foreign Key Relationships

Goal
-----
Understand how tables are connected.

Business Question:

Which tables depend on other tables?

*******************************************************************************************/
SELECT

    fk.name AS ForeignKeyName,

    OBJECT_SCHEMA_NAME(fk.parent_object_id) AS ChildSchema,

    OBJECT_NAME(fk.parent_object_id) AS ChildTable,

    COL_NAME(fc.parent_object_id, fc.parent_column_id) AS ChildColumn,


    OBJECT_SCHEMA_NAME(fk.referenced_object_id) AS ParentSchema,

    OBJECT_NAME(fk.referenced_object_id) AS ParentTable,

    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS ParentColumn


FROM sys.foreign_keys fk

JOIN sys.foreign_key_columns fc

ON fk.object_id = fc.constraint_object_id

ORDER BY

    ParentTable,

    ChildTable;





/*******************************************************************************************
STEP 2
Find Parent Tables

Goal
-----
Identify tables referenced by many other tables.

These are usually Master Data candidates.

Examples:

Customer
Product
Employee

*******************************************************************************************/


SELECT

    OBJECT_SCHEMA_NAME(fk.referenced_object_id) AS SchemaName,

    OBJECT_NAME(fk.referenced_object_id) AS ParentTable,

    COUNT(*) AS NumberOfReferences


FROM sys.foreign_keys fk


GROUP BY

    fk.referenced_object_id


ORDER BY

    NumberOfReferences DESC;






/*******************************************************************************************
STEP 3
Find Child Tables

Goal
-----
Identify transaction tables.

Tables with many outgoing relationships
are often transactional.

*******************************************************************************************/


SELECT

    OBJECT_SCHEMA_NAME(fk.parent_object_id) AS SchemaName,

    OBJECT_NAME(fk.parent_object_id) AS ChildTable,

    COUNT(*) AS NumberOfRelationships


FROM sys.foreign_keys fk


GROUP BY

    fk.parent_object_id


ORDER BY

    NumberOfRelationships DESC;





/*******************************************************************************************
STEP 4
Analyze Specific Table Relationship

Change only:

@TableName

*******************************************************************************************/


DECLARE @TableName sysname='InvoiceLines';


SELECT

    fk.name AS ForeignKeyName,

    OBJECT_NAME(fk.parent_object_id) AS ChildTable,

    COL_NAME(fc.parent_object_id,fc.parent_column_id) AS ChildColumn,

    OBJECT_NAME(fk.referenced_object_id) AS ParentTable,

    COL_NAME(fc.referenced_object_id,fc.referenced_column_id) AS ParentColumn


FROM sys.foreign_keys fk

JOIN sys.foreign_key_columns fc

ON fk.object_id=fc.constraint_object_id


WHERE OBJECT_NAME(fk.parent_object_id)=@TableName;








/*******************************************************************************************
Relationship Investigation

Question 1

Which table is the business event?

Example:

Sales Transaction

↓

Fact Candidate


--------------------------------


Question 2

Which tables describe the event?

Example:

Customer

Product

Employee

↓

Dimension Candidates


--------------------------------


Question 3

What is the relationship type?


One Customer

       |

       |

Many Invoices


--------------------------------


Question 4

Can this relationship become a Star Schema?


FactSales

    |

-----------------

DimCustomer

DimProduct

DimDate

*******************************************************************************************/




/*******************************************************************************************

Expected Outcome
────────────────────────────

After completing this script, you should know:

✔ How tables are connected.

✔ Main Parent tables.

✔ Main Transaction tables.

✔ Potential Fact tables.

✔ Potential Dimension tables.

✔ Relationship paths for Data Modeling.

*******************************************************************************************/
