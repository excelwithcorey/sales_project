<p align="center">
  <img width="600" height="400" src="https://github.com/excelwithcorey/sales_project/assets/153139454/b7b9c561-e261-45ce-b732-1d2688d5a769">
</p>

# Sales Project

## About

This projects aim is to discover sales analysis for (company).
The dataset was downloaded from [Kaggle](https://www.kaggle.com/datasets/ksabishek/product-sales-data/data). Thank you for uploading the data for everyone to use. 

The goal of this project (what is the goal you are seeking to discover?) 

Purpose 
(what is the purpose of the project?)

## About the Data

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| id                      |number referecing specific date          | VARCHAR (10)   |
| date                    | date                                    | DATE           |
| q_p1                    | product 1 number of units sold          | NUMERIC        |
| q_p2                    | product 2 number of units sold          | NUMERIC        |
| q_p3                    | product 3 number of units sold          | NUMERIC        |
| q_p4                    | product 4 number of units sold          | NUMERIC        |
| s_p1                    | total revenue for product 1             | NUMERIC        |
| s_p2                    | total revenue for product 2             | NUMERIC        |
| q_p3                    | total revenue for product 3             | NUMERIC        |
| q_p4                    | total revenue for product 4             | NUMERIC        |

# Methods Used: 
1. Collect Data [Kaggle](https://www.kaggle.com/datasets/ksabishek/product-sales-data/data)
2. Data Cleaning
* Make sure there is no NULL values.
* Double check the format to use in dataset. 
* Validate values. 
3. Feature Engineering:
* Three new columns were added to answer specific questions. 
    * Which day of the week sells the most units?
    * Determine which month of year made the most revenue. 
    * What year performed the best?
* Add a new column 'day_name', 'month_name', and 'year': each of these new columns will extract the days, months and years from date. 
4. Exploratory Data Analysis: Identifying general patterns in the data to make deeper connections. 
5. Insights: Conclude findings of the data that is important and relevant to the business questions and objectives. 


## Analysis Overview

Sales Performance Analysis:
- Identify the top selling product. 
- Calculate the percent change in revenue year to year. 
- Dictate which year did the best in sales.

Product Analysis
- Engaging the performance of each product.
- Describe which product performed the best.

Customer Purchase Analysis:
- Customer purchasing behvaior.
- Anlyze products that customers are more likely to buy.
- Describe which product performed the best

## Business Questions & Objectives

### General Questions 

1. How many products are associated with the dataset?
2. Which months have the highest sales?
3. What year performed the best? 

## Sales Performance Analysis
1. How much revenue in total did the all products bring in each year?
2. What month had the highest revenue in total?
3. Which specific day of the week generates the most revenue?

## Product Analysis
1. What is the average units sold for each product year to year?
2. What is the total quantity of products sold in each year?
3. How much revenue did each product bring in yearly?
4. Calculate the percent change in revenue year to year. Which year performed the best? 

## Customer Purchase Analysis
1. What month are the busiest time of the year?
2. Which days of the week are customers most likely to buy?

## Code Used

You can find the rest of the code here [sales_project]( insert link to SQL)

```sql
----- Create Database -----
CREATE DATABASE EV_Population

----- Create Table -----
CREATE TABLE product_sales; (
	date DATE,
	q_p1 NUMERIC NOT NULL,
	q_p2 NUMERIC NOT NULL,
	q_p3 NUMERIC NOT NULL,
	q_p4 NUMERIC NOT NULL,
	s_p1 NUMERIC NOT NULL,
	s_p2 NUMERIC NOT NULL,
	s_p3 NUMERIC NOT NULL,
	s_p4 NUMERIC NOT NULL
);
```
