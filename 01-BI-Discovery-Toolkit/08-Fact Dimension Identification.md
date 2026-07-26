/*******************************************************************************************

 BI DISCOVERY TOOLKIT
 ------------------------------------------------------------------------------------------

---

File        : 08 - Fact Dimension Identification.md

Author      : Mohadeseh Mohammadi

Version     : 1.0

Skill Level : ⭐⭐⭐⭐ Advanced

---

Description
 ------------------------------------------------------------------------------------------

Before designing a Star Schema,
identify which tables should become Facts
and which tables should become Dimensions.

The objective is NOT to create the final model.

The objective is to identify candidates.

*******************************************************************************************/


/*******************************************************************************************
# STEP 1

## Identify Candidate Facts

Goal
----

Find tables that record business events.

Typical Characteristics

✔ Continuously growing

✔ Contain transactions

✔ Mostly Foreign Keys

✔ Contain numeric measures

✔ Usually large tables

Examples

Orders

InvoiceLines

CustomerTransactions

StockItemTransactions

Questions

• What business event does this table record?

• Does one row represent an event?

• Does this table continuously grow?

*******************************************************************************************/


/*******************************************************************************************
# STEP 2

## Identify Candidate Dimensions

Goal
----

Find descriptive entities.

Typical Characteristics

✔ Descriptive attributes

✔ Smaller tables

✔ Slowly changing

✔ Used for filtering

Examples

Customers

Products

Suppliers

Employees

Cities

Dates

Questions

• Does this table describe something?

• Will users filter reports by this table?

*******************************************************************************************/


/*******************************************************************************************
# STEP 3

## Identify Measures

Goal
----

Find business metrics.

Examples

Quantity

Unit Price

Extended Price

Discount

Tax

Profit

Questions

• Which columns can be aggregated?

• SUM?

• AVG?

• COUNT?

*******************************************************************************************/


/*******************************************************************************************
# STEP 4

## Identify Business Keys

Goal
----

Identify relationships between Facts and Dimensions.

Typical Examples

CustomerID

ProductID

SupplierID

EmployeeID

OrderID

InvoiceID

Questions

• Which columns uniquely identify business entities?

• Which columns will become foreign keys in the Fact table?


*******************************************************************************************/


/*******************************************************************************************
# STEP 5

## Determine the Grain

Goal
----

Define exactly what ONE ROW represents.

Examples

One row = One Invoice

One row = One Invoice Line

One row = One Customer

One row = One Daily Snapshot

Questions

• What is the lowest level of detail?

• Can two rows represent the same event?

*******************************************************************************************/

/*******************************************************************************************

# STEP 6

## Draft the Star Schema

Goal
----

Create the first conceptual model.

Example

             DimCustomer
                  │
                  │
DimProduct ─── FactSales ─── DimDate
                  │
                  │
            DimEmployee

Questions

• Which dimensions connect to the Fact?

• Are any Bridge tables required?

• Are any Degenerate Dimensions required?

*******************************************************************************************/


/*******************************************************************************************
## Candidate Facts

✔ Sales.InvoiceLines

✔ Sales.CustomerTransactions

✔ Warehouse.StockItemTransactions

---

## Candidate Dimensions

✔ Sales.Customers

✔ Warehouse.StockItems

✔ Purchasing.Suppliers

✔ Application.People

✔ Application.Cities

✔ Dimension.Date

---

## Candidate Measures

Quantity

UnitPrice

ExtendedPrice

TaxAmount

LineProfit

---

## Grain

FactSales

One row = One Invoice Line


After completing this step, you should know:

✔ Candidate Fact Tables

✔ Candidate Dimensions

✔ Business Measures

✔ Business Keys

✔ Grain Definition

✔ Initial Star Schema


*******************************************************************************************/


/*******************************************************************************************
# Fact vs Dimension Decision Checklist

When identifying a Fact table, ask yourself:

□ Does this table record a business event?

□ Does it continuously grow?

□ Does it contain numeric measures?

□ Does it contain multiple foreign keys?

□ Can business users aggregate its data?

→ If YES to most questions,
it is probably a Fact table.

---

When identifying a Dimension, ask yourself:

□ Does this table describe a business entity?

□ Is it mainly descriptive?

□ Is it used for filtering reports?

□ Does it change slowly?

→ If YES to most questions,
it is probably a Dimension table.

*******************************************************************************************/
