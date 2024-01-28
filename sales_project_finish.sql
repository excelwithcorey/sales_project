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

-------------------------------------------------------------------
------------------Creating New Columns for Dates-------------------
-------------------------------------------------------------------
Extracting the days, months and year will eventually allow me to anlyze the data further.
I will be utilizing the dates to find trends among the dataset. 
The dates will give me a better insights to which timeframe performed the best and worst. 

ALTER TABLE product_sales ADD COLUMN day_name VARCHAR(10);

UPDATE product_sales
SET day_name =
	CASE EXTRACT (DOW FROM date)
	WHEN 0 THEN 'Sunday'
	WHEN 1 THEN 'Monday'
	WHEN 2 THEN 'Tueday'
	WHEN 3 THEN 'Wednesday'
	WHEN 4 THEN 'Thursday'
	WHEN 5 THEN 'Friday'
	WHEN 6 THEN 'Saturday'
	END;

ALTER TABLE product_sales 
ADD COLUMN month NUMERIC, 
ADD COLUMN month_name VARCHAR (15);

UPDATE product_sales
SET month_name = TO_CHAR(date, 'Month');
UPDATE product_sales
SET month = EXTRACT(MONTH FROM date);

ALTER TABLE product_sales ADD COLUMN year VARCHAR (5)

UPDATE product_sales
SET year = EXTRACT(YEAR FROM date);

-------------------------------------------------------------------
--------------------Exploratory Data Analysis----------------------
-------------------------------------------------------------------

SELECT * FROM product_sales;

-------------------------------------------------------------------
-------------------------Revenue Analysis--------------------------
-------------------------------------------------------------------

SELECT
    year,
    ROUND(SUM("s_p1" + "s_p2" + "s_p3" + "s_p4"), 2) AS total_rev
FROM product_sales
GROUP BY year
ORDER BY total_rev DESC;

A: 2014 is the most profitable year.
We can exclude 2010 and 2023 because they do not have a full  year of data.

SELECT
    month_name,
    ROUND(SUM("s_p1" + "s_p2" + "s_p3" + "s_p4"), 2) AS total_sales
FROM product_sales
GROUP BY month_name
ORDER BY to_date(month_name, 'Month'), month_name;

SELECT
    day_name,
    ROUND(SUM("s_p1" + "s_p2" + "s_p3" + "s_p4"), 2) AS total_rev
FROM product_sales
GROUP BY day_name
ORDER BY total_rev DESC;


-------------------------------------------------------------------
-------------------------Product Analysis--------------------------
-------------------------------------------------------------------

Q1. What is the average quantity sold in each year?

SELECT 
	year,
	ROUND(AVG (q_p1),2) AS q_p1,
	ROUND(AVG (q_p2),2) AS q_p2,
	ROUND(AVG (q_p3),2) AS q_p3,
	ROUND(AVG (q_p4),2) AS q_p4
FROM product_sales
GROUP BY year
ORDER BY to_date(year, 'year'), year;

A: Product 1 sold the most units year over year on average. 

Q2: What is the total quantity of units that were sold in each year?

SELECT 
	year,
	ROUND(SUM (q_p1),2) AS tot_q_p1,
	ROUND(SUM (q_p2),2) AS tot_q_p2,
	ROUND(SUM (q_p3),2) AS tot_q_p3,
	ROUND(SUM (q_p4),2) AS tot_q_p4
FROM product_sales
GROUP BY year
ORDER BY to_date(year, 'year'), year;

A: Product 1 is ranked as the top selling product. Product 1 had the highest unit of sales in 2014.

These two queries gave insights to:
- Product 1 is leading total units sold.
- 2014 has the highest sales volume for product 1.
- The lowest performing product is p4.
- P3 is the second best perorming product. 

Q3: How much revenue did each product bring in each year? Which product performed the best?

SELECT
	year,
	SUM (s_p1) AS tot_rev_p1,
	SUM (s_p2) AS tot_rev_p2,
	SUM (s_p3) AS tot_rev_p3,
	SUM (s_p4) AS tot_rev_p4
FROM product_sales
GROUP BY year
ORDER BY to_date(year, 'year'), year;

A: Product 3 returned the most profitable product each year and performed the best year over year. 

Q4: On average which product performed the best each year?

SELECT 
	year,
	ROUND(AVG (s_p1),2) AS avg_s_p1,
	ROUND(AVG (s_p2),2) AS avg_s_p2,
	ROUND(AVG (s_p3),2) AS avg_s_p3,
	ROUND(AVG (s_p4),2) AS avg_s_p4
FROM product_sales
GROUP BY year
ORDER BY to_date(year, 'year'), year;

A: Product 3 performed the best each year. 

Findings:
- Product 3 is the highest performing product in total revenue. 
- Product 4 has the lowest revenue generated year over year. 
	- P3 is priced at a higher price point and sold the 2 most units in return generated more revenue. 
	- Although product 1 sold the most units, it can be assumed that its lower price point is the outcome of its popularity.


Q4. What is the year over year revnue change from each product.

WITH TotalRevenue AS (
    SELECT
        year,
        SUM("s_p1") AS total_s_p1,
        SUM("s_p2") AS total_s_p2,
        SUM("s_p3") AS total_s_p3,
        SUM("s_p4") AS total_s_p4
    FROM product_sales
    GROUP BY year
)

SELECT
    year,
    total_s_p1,
    total_s_p2,
    total_s_p3,
    total_s_p4,
    ROUND(
        (total_s_p1 - LAG(total_s_p1) OVER (ORDER BY year)) / LAG(total_s_p1) OVER (ORDER BY year) * 100,
        2
    ) AS percent_change_s_p1,
    ROUND(
        (total_s_p2 - LAG(total_s_p2) OVER (ORDER BY year)) / LAG(total_s_p2) OVER (ORDER BY year) * 100,
        2
    ) AS percent_change_s_p2,
    ROUND(
        (total_s_p3 - LAG(total_s_p3) OVER (ORDER BY year)) / LAG(total_s_p3) OVER (ORDER BY year) * 100,
        2
    ) AS percent_change_s_p3,
    ROUND(
        (total_s_p4 - LAG(total_s_p4) OVER (ORDER BY year)) / LAG(total_s_p4) OVER (ORDER BY year) * 100,
        2
    ) AS percent_change_s_p4
FROM TotalRevenue
ORDER BY year;


A: 2014 the data demonstrates the highest percentage increase for all products except p4.
p1= 2.55%
p2= 4.58%
p3= 4.18%
p4= -0.41%



-------------------------------------------------------------------
-------------------Customer Purchase Analysis----------------------
-------------------------------------------------------------------

Q1. What months perform the best and evaluate which month is the slowest time of the year.
SELECT 
	month_name,
	ROUND(SUM (s_p1),2) AS tot_s_p1,
	ROUND(SUM (s_p2),2) AS tot_s_p2,
	ROUND(SUM (s_p3),2) AS tot_s_p3,
	ROUND(SUM (s_p4),2) AS tot_s_p4
FROM product_sales
GROUP BY month_name
ORDER BY to_date(month_name, 'Month'), month_name;

SELECT 
	month_name,
	ROUND(SUM (q_p1),2) AS tot_q_p1,
	ROUND(SUM (q_p2),2) AS tot_q_p2,
	ROUND(SUM (q_p3),2) AS tot_q_p3,
	ROUND(SUM (q_p4),2) AS tot_q_p4
FROM product_sales
GROUP BY month_name
ORDER BY to_date(month_name, 'Month'), month_name;

A: In order, Jul and Jan are the top 2 performing months. Feb and Dec we can see a drop in sales and revenue. 
Findings:
- All products see the same trends throughout the year. 
- Product 1 seems like it has peaks in Jul and Oct whereas other products stays nuetral. 

Q2. What days are customers most likely to buy? 

SELECT 
    day_name,
    ROUND(SUM(s_p1), 2) AS tot_s_p1,
    ROUND(SUM(s_p2), 2) AS tot_s_p2,
    ROUND(SUM(s_p3), 2) AS tot_s_p3,
    ROUND(SUM(s_p4), 2) AS tot_s_p4
FROM product_sales
GROUP BY day_name
ORDER BY tot_s_p1 DESC;

SELECT 
    day_name,
    ROUND(AVG(q_p1), 2) AS AVG_q_p1,
    ROUND(AVG(q_p2), 2) AS AVG_q_p2,
    ROUND(AVG(q_p3), 2) AS AVG_q_p3,
    ROUND(AVG(q_p4), 2) AS AVG_q_p4
FROM product_sales
GROUP BY day_name
ORDER BY  avg_q_p1 DESC;

A: 
Depending on the product the sales volume changes each day. 
P1 = Friday
P2 = Thursday
P3 = Saturday
P4 = Saturday

[gather more insights as to what this might mean.]








