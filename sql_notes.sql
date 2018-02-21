### LIMITS

SELECT occurred_at, account_id, channel
FROM web_events
-- This LIMIT will make sure that it does not query more
-- than 15 lines.
LIMIT 15;




### ORDER BY

SELECT *
FROM demo.orders
-- ORDER BY must go after SELECT and FROM but before LIMIT.
ORDER BY occurred_at
LIMIT 100;

SELECT *
FROM demo.orders
-- Default order is ascending A-Z, 1-9, etc. 
-- Add DESC to the end and it changes to descending order.
ORDER BY occurred_at DESC
LIMIT 100;

-- Practice
-- In order to gain some practice using ORDER BY:

-- 1. Write a query to return the 10 earliest orders in the 
-- orders table. Include the id, occurred_at, and total_amt_usd.

-- 2. Write a query to return the top 5 orders in terms of 
-- largest total_amt_usd. Include the id, account_id, and
--  total_amt_usd.

-- 3. Write a query to return the bottom 20 orders in terms 
-- of least total. Include the id, account_id, and total.

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, occurred_at, total
FROM orders
ORDER BY total
LIMIT 20;

### ORDER BY more than one column at a time.
SELECT id, occurred_at, total
FROM orders
-- You can add commas and use DESC on some and not on others
-- if you want.
ORDER BY total, account_id DESC, occurred_at
LIMIT 20;

-- Questions

-- Write a query that returns the top 5 rows from orders 
-- ordered according to newest to oldest, but with the 
-- largest total_amt_usd for each date listed first for 
-- each date. You will notice each of these dates shows up 
-- as unique because of the time element. When you learn about
-- truncating dates in a later lesson, you will better be 
-- able to tackle this question on a day, month, or yearly basis. 

SELECT *
FROM orders
ORDER BY occured_at DESC, total_amt_usd DESC
LIMIT 5;

-- Write a query that returns the top 10 rows from orders 
-- ordered according to oldest to newest, but with the smallest 
-- total_amt_usd for each date listed first for each date. You will 
-- notice each of these dates shows up as unique because of the 
-- time element. When you learn about truncating dates in a later 
-- lesson, you will better be able to tackle this question on 
-- a day, month, or yearly basis.

SELECT *
FROM orders
ORDER BY occured_at, total_amt_usd
LIMIT 10;




### WHERE Statements
-- Using the WHERE statement, we can subset out tables based 
-- on conditions that must be met.

-- Common symbols used within WHERE statements include:

-- > (greater than)

-- < (less than)

-- >= (greater than or equal to)

-- <= (less than or equal to)

-- = (equal to)

-- != (not equal to)

SELECT *
FROM demo.orders
-- Make sure WHERE goes here so you don't get errors.
WHERE account_id = 4251 
-- Now it'll only show account 4251
ORDER BY occurred_at
LIMIT 1000;

-- Questions
-- Write a query that

-- Pull the first 5 rows and all columns from the orders table 
-- that have a dollar amount of gloss_amt_usd greater than or 
-- equal to 1000.

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

-- Pull the first 10 rows and all columns from the orders table 
-- that have a total_amt_usd less than 500.

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

-- Notice that with WHERE statements, we don't need to use
-- ORDER BY unless we want to order our data.

### WHERE with Non-Numeric Data

-- We can use the = and != here.
-- If you're using an operator with values that are non-numeric,
-- you need to put the value in single quotes.

SELECT *
FROM demo.accounts
WHERE name = 'United Technologies'

SELECT *
FROM demo.accounts
WHERE name != 'United Technologies'

-- Practice Question Using WHERE with Non-Numeric Data

-- Filter the accounts table to include the company name, 
-- website, and the primary point of contact (primary_poc) for 
-- Exxon Mobil in the accounts table.

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';



### Arithmetic Operators

SELECT 	 account_id,
	   	 occurred_at,
	   	 standard_qty,
	   	 gloss_qty,
	   	 poster_qty,
	   	 -- Derived Column here:
	   	 -- Use AS to name the derived column
	   	 gloss_qty + poster_qty AS nonstandard_qty
FROM demo.orders

-- Note: Derived Column is a new column that is a manipulation
-- of the existing columns in your database.

-- Common operators to combine columns include:

-- * (Multiplication)
-- + (Addition)
-- - (Subtraction)
-- / (Division)

-- Questions using Arithmetic Operations
-- Using the orders table:

-- Create a column that divides the standard_amt_usd 
-- by the standard_qty to find the unit price for standard 
-- paper for each order. Limit the results to the first 10 
-- orders, and include the id and account_id fields. 

SELECT  id,
		account_id,
		standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

-- Write a query that finds the percentage of revenue that comes 
-- from poster paper for each order. You will need to use only 
-- the columns that end with _usd. (Try to do this without using 
-- the total column). Include the id and account_id fields. 
-- NOTE - you will be thrown an error with the correct solution 
-- to this question. This is for a division by zero. You will 
-- learn how to get a solution without an error to this query 
-- when you learn about CASE statements in a later section. 
-- For now, you might just add some very small value to your 
-- denominator as a work around. 

SELECT id,
	   account_id,
	   poster_amt_usd/(standard_amt_usd 
	    + gloss_amt_usd 
	   	+ poster_amt_usd)
	   AS post_per
FROM orders;



### LIKE

-- Use LIKE with WHERE to find things that contain a string of 
-- characters inside the '$thisGetsSearchedFor$' section.

-- EXAMPLE:

SELECT *
FROM demo.web_events_full
WHERE referrer_url LIKE '%google%';

-- Questions using the LIKE operator
-- Use the accounts table to find:

-- All the companies whose names start with 'C'.

SELECT name
FROM accounts
WHERE name LIKE 'C%';

-- All companies whose names contain the string 'one' 
-- somewhere in the name.

SELECT name
FROM accounts
WHERE name LIKE '%one%';

-- All companies whose names end with 's'.

SELECT name
FROM accounts
WHERE name LIKE '%s';



### IN

-- The IN operator is useful for both numeric and text colums.
-- It allows you to use =, but for more than one column values.

-- EXAMPLES:

SELECT *
FROM demo.accounts
WHERE name IN ('Walmart', 'Apple');

SELECT *
FROM demo.orders
WHERE account_id IN (1001, 1021);

-- Questions using IN operator:

-- Use the accounts table to find the account name, 
-- primary_poc, and sales_rep_id for Walmart, Target,
-- and Nordstrom.

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

-- Use the web_events table to find all information 
-- regarding individuals who were contacted via the
-- channel of organic or adwords.

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');




### NOT

-- The NOT operator is an extremely useful operator for 
-- working with the previous two operators we introduced:
-- IN and LIKE. By specifying NOT LIKE or NOT IN, we can 
-- grab all of the rows that do not meet a particular criteria.

-- EXAMPLES:

SELECT    sales_rep_id,
	      name
  FROM 	  demo.accounts
 WHERE 	  sales_rep_id NOT IN(321500, 321570)
 ORDER BY sales_rep_id; 

SELECT *
  FROM demo.web_events_full
 WHERE referrer_url NOT LIKE '%google%';

-- Questions using the NOT operator
-- We can pull all of the rows that were excluded from the 
-- queries in the previous two concepts with our new operator.

-- Use the accounts table to find the account name,
-- primary poc, and sales rep id for all stores except Walmart,
-- Target, and Nordstrom.

SELECT name,
	   primary_poc,
	   sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

-- Use the web_events table to find all information regarding
-- individuals who were contacted via any method except using
-- organic or adwords methods.

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

-- Use the accounts table to find:

-- All the companies whose names do not start with 'C'.

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';

-- All companies whose names do not contain the string
-- 'one' somewhere in the name.

SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

-- All companies whose names do not end with 's'.

SELECT *
FROM accounts
WHERE name NOT LIKE '%s';



### AND
-- Filter based on multiple criteria using AND

SELECT *
FROM demo.orders
-- Make sure you always specify the column you want to look
-- at after the AND. 
-- WHERE occured_at >= 'date' <= 'date' will return an error.
WHERE occurred_at >= '2016-04-01' AND occurred_at <= '2016-10-01'
ORDER BY occurred_at DESC



### BETWEEN
-- Sometimes we can make a cleaner statement using BETWEEN than 
-- we can using AND. Particularly this is true when we are using 
-- the same column for different parts of our AND statement. In
-- the previous video, we probably should have used BETWEEN.

-- Instead of writing :

WHERE column >= 6 AND column <= 10
-- we can instead write, equivalently:
WHERE column BETWEEN 6 AND 10


-- Questions using AND and BETWEEN operators
-- Write a query that returns all the orders where the
-- standard_qty is over 1000, the poster_qty is 0, and
-- the gloss_qty is 0.

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

-- Using the accounts table find all the companies whose
-- names do not start with 'C' and end with 's'.

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND LIKE '%s';

-- Use the web_events table to find all information
-- regarding individuals who were contacted via
-- organic or adwords and started their account at any
-- point in 2016 sorted from newest to oldest.

-- You will notice that using BETWEEN is tricky for dates!
-- While BETWEEN is generally inclusive of endpoints,
-- it assumes the time is at 00:00:00 (i.e. midnight) for dates.
-- This is the reason why we set the right-side endpoint of the
-- period at '2017-01-01'.

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;



## OR

-- Similar to the AND operator, the OR operator can combine
-- multiple statements. Each time you link a new statement
-- with an OR, you will need to specify the column you are
-- interested in looking at. You may link as many statements
-- as you would like to consider at the same time. This
-- operator works with all of the operations we have seen
-- so far including arithmetic operators (+, *, -, /),
-- LIKE, IN, NOT, AND, and BETWEEN logic can all be linked
-- together using the OR operator.

SELECT account_id,
	   occurred_at,
	   standard_qty,
	   gloss_qty,
	   poster_qty
FROM   demo.orders
-- If either of these are true then it will display them
WHERE  standard_qty = 0 OR gloss_qty = 0;

-- When combining multiple of these operations, we frequently
-- might need to use parentheses to assure that logic we want
-- to perform is being executed correctly.

SELECT account_id,
	   occurred_at,
	   standard_qty,
	   gloss_qty,
	   poster_qty
FROM   demo.orders
-- As long as one of these statements is true then the entire
-- block in the parenthesis is to be considered true.
WHERE  (standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0)
-- So it will include what is in the block above AND what is
-- down here in the query.
AND    occurred_at  >= '2016-10-1';

-- Questions using the OR operator
-- Find list of orders ids where either gloss_qty or poster_qty
-- is greater than 4000. Only include the id field in the
-- resulting table.

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

-- Write a query that returns a list of orders where the
-- standard_qty is zero and either the gloss_qty or
-- poster_qty is over 1000.

SELECT *
FROM orders
WHERE standard_qty = 0
AND (gloss_qty > 1000 OR poster_qty > 1000);

-- Find all the company names that start with a 'C' or 'W',
-- and the primary contact contains 'ana' or 'Ana',
-- but it doesn't contain 'eana'.

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
AND primary_poc NOT LIKE '%eana%';