/*******************************************************************************************

 BI DISCOVERY TOOLKIT
 ------------------------------------------------------------------------------------------
 File        : 07 - Business Process Discovery.md

 Author      : Mohadeseh Mohammadi
 Version     : 1.0

 Skill Level : ⭐⭐⭐⭐ Advanced

 Description
 ------------------------------------------------------------------------------------------
 Discover the business process behind the source system.

 At this stage, the goal is NOT to design a Data Warehouse.

 The goal is to understand:

 • What business process does this database support?
 • Which tables represent business events?
 • Which tables describe business entities?
 • How does data flow through the business?

*******************************************************************************************/

/*******************************************************************************************

STEP 1
Identify Business Modules

Goal
-----
Identify the business areas supported by the database.

Examples

□ Sales
□ Purchasing
□ Inventory
□ Warehouse
□ CRM
□ HR
□ Finance

Questions

• Which schemas belong to each business area?

• Which module contains the largest number of tables?

*******************************************************************************************/

/*******************************************************************************************

STEP 2
Identify Transaction Tables

Goal
-----
Find tables that store business events.

Typical characteristics

✔ Continuously growing

✔ Usually contain Dates

✔ Usually contain Foreign Keys

✔ Usually become Fact Tables

Examples

Orders

Invoices

Payments

Transactions

Shipment

Questions

• Which tables continuously grow?

• Which tables record business activities?

*******************************************************************************************/

/*******************************************************************************************

STEP 3
Identify Master Data

Goal
-----
Find tables that describe business entities.

Typical characteristics

✔ Smaller tables

✔ Mostly descriptive columns

✔ Rarely grow

✔ Usually become Dimensions

Examples

Customers

Products

Employees

Cities

Suppliers

Questions

• Which tables describe a business object?

• Which tables change infrequently?

*******************************************************************************************/

/*******************************************************************************************

STEP 4
Business Flow

Goal
-----
Draw the business process.

Example

Customer

↓

Order

↓

Order Line

↓

Invoice

↓

Invoice Line

↓

Payment

Questions

• Where does the process start?

• Where does it end?

• What is the main business event?

*******************************************************************************************/

/*******************************************************************************************

STEP 5
Business Events

Goal
-----
Map business activities to database tables.

Example

Business Event                    Table
------------------------------------------------------------
Customer places an order          Sales.Orders
Invoice is created                Sales.Invoices
Customer payment                  Sales.CustomerTransactions
Stock movement                    Warehouse.StockItemTransactions

Questions

• What triggers each event?

• Which table records the event?

*******************************************************************************************/

/*******************************************************************************************

STEP 6
Business Process Validation

Goal
-----
Validate your understanding before starting Data Warehouse Design.

Questions

□ Do you understand the complete business flow?

□ Can you explain every major table?

□ Can you identify Transaction tables?

□ Can you identify Master Data?

□ Can you explain the process without looking at SQL?

□ Are you ready to identify Facts and Dimensions?

*******************************************************************************************/

/*******************************************************************************************

Example

WideWorldImporters

Sales Process

Customer

↓

Order

↓

Order Line

↓

Invoice

↓

Invoice Line

↓

Customer Transaction

Inventory Process

Supplier

↓

Purchase Order

↓

Stock Receipt

↓

Stock Item

↓

Stock Transaction

*******************************************************************************************/


/*******************************************************************************************

Expected Outcome

After completing this step, you should know:

✔ Business Modules

✔ Transaction Tables

✔ Master Data

✔ Business Flow

✔ Business Events

✔ Candidate Facts

✔ Candidate Dimensions

*******************************************************************************************/
