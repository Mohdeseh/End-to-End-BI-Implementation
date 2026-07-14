/*******************************************************************************************

 BI DISCOVERY TOOLKIT
 ------------------------------------------------------------------------------------------
 File        : 01 - Database Overview.sql

 Author      : Mohadeseh Mohammadi
 Version     : 1.0

 Description
 ------------------------------------------------------------------------------------------
 This script is the first step of every Business Intelligence project.

 Before building an ETL process, Data Warehouse, SSAS model or Power BI dashboard,
 a BI Developer should understand the source database.

 This script answers questions like:

 • Which database am I connected to?
 • Which SQL Server instance am I using?
 • What SQL Server version is installed?
 • Which login is executing the script?

*******************************************************************************************/


/*******************************************************************************************
STEP 1
Current Database

Goal
-----
Verify that you are connected to the correct database.

Why?
-----
Many developers accidentally execute queries on the wrong database.

*******************************************************************************************/

SELECT
    DB_NAME() AS CurrentDatabase;



/*******************************************************************************************
STEP 2
SQL Server Information

Goal
-----
Identify the SQL Server instance.

Useful when working with multiple servers
(Development / Test / Production).

*******************************************************************************************/

SELECT
    @@SERVERNAME AS ServerName;



/*******************************************************************************************
STEP 3
SQL Server Version

Goal
-----
Know which SQL Server version is running.

Why?
-----
Some features (Temporal Tables, STRING_AGG, JSON, etc.)
depend on SQL Server version.

*******************************************************************************************/

SELECT
    @@VERSION AS SQLServerVersion;



/*******************************************************************************************
STEP 4
Current Login

Goal
-----
Identify which SQL Login is executing the queries.

Useful for troubleshooting permissions.

*******************************************************************************************/

SELECT
    SYSTEM_USER AS CurrentLogin;



/*******************************************************************************************
STEP 5
Database Size

Goal
-----
Understand the approximate size of the source database.

Large databases usually require different ETL strategies.

*******************************************************************************************/

EXEC sp_spaceused;



/*******************************************************************************************
STEP 6
Database Compatibility Level

Goal
-----
Check compatibility level.

Some SQL features depend on compatibility mode.

*******************************************************************************************/

SELECT
    name,
    compatibility_level
FROM sys.databases
WHERE name = DB_NAME();



/*******************************************************************************************
STEP 7
Recovery Model

Goal
-----
Understand database recovery strategy.

Useful for backup planning and production environments.

*******************************************************************************************/

SELECT
    name,
    recovery_model_desc
FROM sys.databases
WHERE name = DB_NAME();



/*******************************************************************************************

Discovery Notes

Write your observations here:

Database Name :
_____________________________________________________

Server :
_____________________________________________________

SQL Version :
_____________________________________________________

Database Size :
_____________________________________________________

Compatibility Level :
_____________________________________________________

Recovery Model :
_____________________________________________________

Questions:

□ Is this Development?
□ Is this Production?
□ Is this a Backup copy?
□ Is the SQL Server version modern enough?
□ Any limitations before starting ETL?

*******************************************************************************************/
