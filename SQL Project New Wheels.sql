/*

-----------------------------------------------------------------------------------------------------------------------------------
                                               Guidelines
-----------------------------------------------------------------------------------------------------------------------------------

The provided document is a guide for the project. Follow the instructions and take the necessary steps to finish
the project in the SQL file			
-----------------------------------------------------------------------------------------------------------------------------------

											Database Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------
*/

-- [1] To begin with the project, you need to create the database first
-- Write the Query below to create a Database
Drop  database if exists vehdb;
create database vehdb;

-- [2] Now, after creating the database, you need to tell MYSQL which database is to be used.
-- Write the Query below to call your Database

use vehdb;
/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [3] Creating the tables:

/*Note:
---> To create the table, refer to the ER diagram and the solution architecture. 
---> Refer to the column names along with the data type while creating a table from the ER diagram.
---> If needed revisit the videos Week 2: Data Modeling and Architecture: Creating DDLs for Your Main Dataset and Normalized Datasets
---> While creating a table, make sure the column you assign as a primary key should uniquely identify each row.
---> If needed revisit the codes used to create tables for the gl_eats database. 
     This will help in getting a better understanding of table creation.*/

-- Syntax to create table-

-- To drop the table if already exists

-- To create a table temp_t

DROP TABLE IF EXISTS temp_t;

CREATE TABLE temp_t
(
	shipper_id integer,
    shipper_name varchar(20),
    shipper_contract_details varchar(15),
    product_id integer,
    vehicle_maker varchar(20),
    vehicle_model varchar(30),
    vehicle_color varchar(15),
    vehicle_model_year integer,
    vehicle_price decimal(14,2),
    quantity integer,
    customer_id varchar(20),
    customer_name varchar(25),
    gender varchar(7),
    job_title varchar(50),
    phone_number varchar(15),
    email_address varchar(50),
    city varchar(25),
    country varchar(20),
    state varchar(25),
    customer_address varchar(40),
    order_date date,
    order_id varchar(15),
    ship_date date,
    ship_mode varchar(15),
    shipping varchar(10),
    postal_code integer,
    discount decimal(4,2),
    credit_card_type varchar(30),
    credit_card_number bigint,
    customer_feedback varchar(15),
    quarter_number integer,
	PRIMARY KEY(order_id, customer_id)
);
                                                      

-- Create a table vehicles_t

DROP TABLE IF EXISTS vehicles_t;

CREATE TABLE vehicles_t
(
	shipper_id integer,
    shipper_name varchar(20),
    shipper_contract_details varchar(15),
    product_id integer,
    vehicle_maker varchar(20),
    vehicle_model varchar(30),
    vehicle_color varchar(15),
    vehicle_model_year integer,
    vehicle_price decimal(14,2),
    quantity integer,
    customer_id varchar(20),
    customer_name varchar(25),
    gender varchar(7),
    job_title varchar(50),
    phone_number varchar(15),
    email_address varchar(50),
    city varchar(25),
    country varchar(20),
    state varchar(25),
    customer_address varchar(40),
    order_date date,
    order_id varchar(15),
    ship_date date,
    ship_mode varchar(15),
    shipping varchar(10),
    postal_code integer,
    discount decimal(4,2),
    credit_card_type varchar(30),
    credit_card_number bigint,
    customer_feedback varchar(15),
    quarter_number integer,
	PRIMARY KEY(order_id, customer_id)
);

-- Create a table order_t

DROP TABLE IF EXISTS order_t;

CREATE TABLE order_t
(
	order_id varchar(15),
    customer_id varchar(20),
    shipper_id integer,
    product_id integer,
    quantity integer,
    vehicle_price decimal(10,2),
    order_date date,
    ship_date date,
    discount decimal(4,2),
    ship_mode varchar(15),
    shipping varchar(10),
    customer_feedback varchar(15),
    quarter_number integer,
	PRIMARY KEY(order_id)
);

-- Create a table customer_t

DROP TABLE IF EXISTS customer_t;

CREATE TABLE customer_t
(
	customer_id varchar(20),
    customer_name varchar(25),
    gender varchar(7),
    job_title varchar(50),
    phone_number varchar(15),
    email_address varchar(50),
    city varchar(25),
    country varchar(20),
    state varchar(25),
    customer_address varchar(40),
    postal_code integer,
    credit_card_type varchar(30),
    credit_card_number bigint,
	PRIMARY KEY(customer_id)
);

-- Create a table product_t

DROP TABLE IF EXISTS product_t;

CREATE TABLE product_t
(
	product_id integer,
	vehicle_maker varchar(20),
    vehicle_model varchar(30),
    vehicle_color varchar(15),
    vehicle_model_year integer,
    vehicle_price decimal(10,2),
	PRIMARY KEY(product_id)
);

-- Create a table shipper_t

DROP TABLE IF EXISTS shipper_t;

CREATE TABLE shipper_t
(
	shipper_id integer,
    shipper_name varchar(20),
    shipper_contract_details varchar(15),
	PRIMARY KEY(shipper_id)
);


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:

/*Note:

---> If needed revisit the video: Week 2: Data Modeling and Architecture: Introduction to Stored Procedures.
---> Also revisit the codes used to create stored procedures for the gl_eats database. 
	 This will help in getting a better understanding of the creation of stored procedures.*/

-- Syntax to create stored procedure-

-- To Create stored procedure vehicles_p
 
DROP PROCEDURE IF EXISTS vehicles_p;

DELIMITER $$ 
CREATE PROCEDURE vehicles_p(quanum integer)
BEGIN
       INSERT INTO vehicles_t (
	shipper_id,
    shipper_name,
    shipper_contract_details,
    product_id,
    vehicle_maker,
    vehicle_model,
    vehicle_color,
    vehicle_model_year,
    vehicle_price,
    quantity,
    customer_id,
    customer_name,
    gender,
    job_title,
    phone_number,
    email_address,
    city,
    country,
    state,
    customer_address,
    order_date,
    order_id,
    ship_date,
    ship_mode,
    shipping,
    postal_code,
    discount,
    credit_card_type,
    credit_card_number,
    customer_feedback,
    quarter_number
) SELECT * FROM temp_t
where quarter_number = quanum;
END;

-- CALL vehicles_p(4);

-- Create a stored procedure order_p

drop procedure if exists order_p;
DELIMITER $$ 
CREATE PROCEDURE order_p(quanum integer)
BEGIN
       INSERT INTO order_t (
	order_id,
    customer_id,
    shipper_id,
    product_id,
    quantity,
    vehicle_price,
    order_date,
    ship_date,
    discount,
    ship_mode,
    shipping,
    customer_feedback,
    quarter_number
) SELECT 
	order_id,
    customer_id,
    shipper_id,
    product_id,
    quantity,
    vehicle_price,
    order_date,
    ship_date,
    discount,
    ship_mode,
    shipping,
    customer_feedback,
    quarter_number
FROM vehicles_t
where quarter_number = quanum;
END;

-- CALL order_p(4);

-- Create stored proceduer customer_p

drop procedure if exists customer_p
DELIMITER $$ 
CREATE PROCEDURE customer_p()
BEGIN
       INSERT INTO customer_t (
	customer_id,
    customer_name,
    gender,
    job_title,
    phone_number,
    email_address,
    city,
    country,
    state,
    customer_address,
    postal_code,
    credit_card_type,
    credit_card_number
) SELECT 
   distinct
    customer_id,
    customer_name,
    gender,
    job_title,
    phone_number,
    email_address,
    city,
    country,
    state,
    customer_address,
    postal_code,
    credit_card_type,
    credit_card_number
FROM vehicles_t
where customer_id not in ( select distinct customer_id from customer_t);
END;

-- CALL customer_p();

-- Create a stored procedure product_p

drop procedure if exists product_p
DELIMITER $$ 
CREATE PROCEDURE product_p()
BEGIN
       INSERT INTO product_t (
	product_id,
	vehicle_maker,
    vehicle_model,
    vehicle_color,
    vehicle_model_year,
    vehicle_price
) SELECT 
   distinct
    product_id,
	vehicle_maker,
    vehicle_model,
    vehicle_color,
    vehicle_model_year,
    vehicle_price
FROM vehicles_t
where product_id not in ( select distinct product_id from product_t);
END;

-- CALL product_p();

-- Create a store procedure shipper_p

drop procedure if exists shipper_p
DELIMITER $$ 
CREATE PROCEDURE shipper_p()
BEGIN
       INSERT INTO shipper_t (
	shipper_id,
    shipper_name,
    shipper_contract_details
) SELECT 
   distinct
    shipper_id,
    shipper_name,
    shipper_contract_details
FROM vehicles_t
where shipper_id not in ( select distinct shipper_id from shipper_t);
END;

-- CALL shipper_p();

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:

/*Note: 

---> If needed revisit the videos: Week-2: Data Modeling and Architecture: Creating views for answers to business questions
---> Also revisit the codes used to create views for the gl_eats database. 
	 This will help in getting a better understanding of the creation of views.*/

-- list of views to be created are "veh_ord_cust_v" and "veh_prod_cust_v"

-- Create a view veh_ord_cust_v

drop view if exists veh_ord_cust_v;

create view veh_ord_cust_v as
select
	c.customer_id,
    c.customer_name,
    c.city,
    c.state,
    c.credit_card_type,
    o.order_id,
    o.shipper_id,
    o.product_id,
    o.quantity,
    o.vehicle_price,
    o.order_date,
    o.ship_date,
    o.discount,
    o.customer_feedback,
    o.quarter_number
from order_t as o
inner join customer_t as c
	on o.customer_id = c.customer_id;

-- Create a view veh_prod_cust_v

drop view if exists veh_prod_cust_v;

create view veh_prod_cust_v as
select
	c.customer_id,
    c.customer_name,
    c.credit_card_type,
    c.state,
    o.order_id,
    o.customer_feedback,
    p.product_id,
    p.vehicle_maker,
    p.vehicle_model,
    p.vehicle_color,
    p.vehicle_model_year
from order_t as o
inner join customer_t as c
	on o.customer_id = c.customer_id
inner join product_t as p
	on o.product_id = p.product_id;



/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Functions Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [7] Creating the functions:

/*Note: 

---> If needed revisit the videos: Week-2: Data Modeling and Architecture: Creating User Defined Functions
---> Also revisit the codes used to create functions for the gl_eats database. 
     This will help in getting a better understanding of the creation of functions.*/

-- Create the function calc_revenue_f

drop function if exists calc_revenue_f;
DELIMITER $$  
CREATE FUNCTION calc_revenue_f (vehicle_price decimal(14,8), discount decimal(4,2), quantity integer) 
RETURNS DECIMAL
DETERMINISTIC  
BEGIN  
	DECLARE revenue decimal; 
    set revenue = quantity * (1 - discount/100) *vehicle_price;
    RETURN (revenue);   
end;

-- Create the function days_to_ship_f

drop function if exists days_to_shift_f;
DELIMITER $$
CREATE FUNCTION days_to_ship_f (order_date date, ship_date date) 
RETURNS INTEGER
DETERMINISTIC
BEGIN  
	DECLARE duration integer;
	SET duration = datediff(ship_date,order_date);  
    RETURN (duration);  
end;
  
/*-----------------------------------------------------------------------------------------------------------------------------------
Note: 
After creating tables, stored procedures, views and functions, attempt the below questions.
Once you have got the answer to the below questions, download the csv file for each question and use it in Python for visualisations.
------------------------------------------------------------------------------------------------------------------------------------ 

  
  
-----------------------------------------------------------------------------------------------------------------------------------

                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS RELATED TO CUSTOMERS
     [Q1] What is the distribution of customers across states?
     Hint: For each state, count the number of customers.*/
select state, count(customer_id) as No_of_customer
from veh_ord_cust_v
group by 1
order by 2 desc;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q2] What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.

Hint: Use a common table expression and in that CTE, assign numbers to the different customer ratings. 
      Now average the feedback for each quarter. 

Note: For reference, refer to question number 10. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions from this question.*/

select quarter_number, sum(rate)/count(customer_feedback) as rating
from (
	select quarter_number, customer_feedback,
	   case when customer_feedback = 'Very Good' then 5 
			when customer_feedback = 'Good' then 4
            when customer_feedback = 'Okay' then 3
			when customer_feedback = 'Bad' then 2 
            when customer_feedback = 'Very Bad' then 1
            else 0
            end as rate
	from veh_ord_cust_v) as summ
group by 1
order by 2 desc;
      
-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q3] Are customers getting more dissatisfied over time?

Hint: Need the percentage of different types of customer feedback in each quarter. Use a common table expression and
	  determine the number of customer feedback in each category as well as the total number of customer feedback in each quarter.
	  Now use that common table expression to find out the percentage of different types of customer feedback in each quarter.
      Eg: (total number of very good feedback/total customer feedback)* 100 gives you the percentage of very good feedback.
      
Note: For reference, refer to question number 10. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions from this question*/
      
with cus_feedback as
(select quarter_number,
	   sum(case when customer_feedback = 'Very Good' then 1 else 0 end) as very_good,
       sum(case when customer_feedback = 'Good' then 1 else 0 end) as good,
       sum(case when customer_feedback = 'Okay' then 1 else 0 end) as okay,
       sum(case when customer_feedback = 'Bad' then 1 else 0 end) as bad,
       sum(case when customer_feedback = 'Very Bad' then 1 else 0 end) as very_bad,
       count(customer_feedback) as Total
from veh_ord_cust_v
group by 1)

select quarter_number,
	   (very_good/total)*100 perc_vg,
       (good/total)*100 perc_g,
       (okay/total)*100 perc_o,
       (bad/total)*100 perc_b,
       (very_bad/total)*100 perc_vb
from cus_feedback
group by 1
order by 1;

-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.

Hint: For each vehicle make what is the count of the customers.*/

select vehicle_maker, count(customer_id)
from veh_prod_cust_v
group by 1
order by 2 desc
limit 5;

-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle make in each state?

Hint: Use the window function RANK() to rank based on the count of customers for each state and vehicle maker. 
After ranking, take the vehicle maker whose rank is 1.*/

select *
from
(select *, rank() over(partition by state order by total desc) as rnk
from
(select state,
	   vehicle_maker,
       count(customer_id) as total
from veh_prod_cust_v
group by 1,2) states) Ran
where rnk = 1;

-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?

Hint: Count the number of orders for each quarter.*/
select quarter_number, count(order_id) as no_of_orders
from veh_ord_cust_v
group by 1
order by 2 desc;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 

Hint: Quarter over Quarter percentage change in revenue means what is the change in revenue from the subsequent quarter to the previous quarter in percentage.
      To calculate you need to use the common table expression to find out the sum of revenue for each quarter.
      Then use that CTE along with the LAG function to calculate the QoQ percentage change in revenue.
      
Note: For reference, refer to question number 5. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions and the LAG function from this question.*/
 
  select *, 100*(revenue - lag(revenue) over(order by quarter_number))/ lag(revenue) over(order by quarter_number) as percentage_of_quarter_change
 from
 (select quarter_number, sum(calc_revenue_f(vehicle_price,discount,quantity)) as revenue
 from veh_ord_cust_v
 group by 1) rev
      
-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?

Hint: Find out the sum of revenue and count the number of orders for each quarter.*/

select quarter_number, count(order_id) No_of_orders, sum(calc_revenue_f(vehicle_price,discount,quantity)) as revenue
from veh_ord_cust_v
group by 1;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?

Hint: Find out the average of discount for each credit card type.*/

select credit_card_type, avg(discount)
from veh_ord_cust_v
group by credit_card_type;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
   Use days_to_ship_f function to compute the time taken to ship the orders.

Hint: For each quarter, find out the average of the function that you created to calculate the difference between the ship date and the order date.*/

select quarter_number, avg(days_to_ship_f(order_date,ship_date)) as average_duration
from veh_ord_cust_v
group by 1
order by 1;



-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



