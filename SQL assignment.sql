## Question 1. Create a table called employees with the following structure?
##: emp_id (integer, should not be NULL and should be a primary key).
##: emp_name (text, should not be NULL).
##: age (integer, should have a check constraint to ensure the age is at least 18)Q
##: email (text, should be unique for each employee)Q
##: salary (decimal, with a default value of 30,000).

## Write the SQL query to create the above table with all constraints
##Answer.
Create Database SQL_Assignment;
use SQL_Assignment;
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name CHAR(30) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(50) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000
);

# Question 2. 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
##examples of common types of constraints.

#Answer - Constraints are a kind of limits that we set to keep the data categorised, It helps us maintain 
# Data accuracy, Uniqueness, Referential Integrity and consitency.

# Examples - Primary key, Unique, Not null, Check, Default and Foreign Key.

# Question 3. .Why would you apply the NOT NULL constraint to a column? 
# Can a primary key contain NULL values? Justify your answer.
# Answer - We apply NOT NULL constraint to a column to make sure that a record in this column should not be left "Null value", It should contain some value.alter
# No, A primary key can not have a null Value, It is because. When we use Primary key it means this column has unique value that can be used
# as identity in the table and it can't be left empty or with "NULL" value. For example emp_Id of any table can be a primary key but it can't be left empty. 

# Question 4.  Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
# example for both adding and removing a constraint.

# Answer - We can add a constraints on an existing table by using "Alter table" statement using "Add constraints" or ("Modify" to add not null)
# example -  my exsting table "Employees" has a column "email" with constraints "unique". I will change it to "not null"

ALTER TABLE employees
MODIFY email VARCHAR(50) NOT NULL;

# In order to remove constraints we need to use "alter table" statement with "drop constraints" followed by the constraints name. 
# example. I will remove constraints from my existing table "email"

alter table employees
drop constraint email;

# Now I am adding the constraints "unique" to column email again to make sure my table is working properly. 

Alter table employees
add constraint email_id unique (email);

# question 3. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
# Provide an example of an error message that might occur when violating a constraint.

# Answer - If we try to inset, update, or delete data in a way that violates constraints then we will get an error. 
# example - the emp_id column of my table is empty now I will add some data and try to violate the connstraints "Unique" to see the error. 
INSERT INTO Employees (emp_id, emp_name, age, email)
VALUES 
    (101, 'Alice', 25, 'alice@gmail.com'),
    (102, 'Bob', 30, 'bob@gmail.com'),
    (103, 'Charlie', 22, 'charlie@gmail.com');
    
select * from employees;
# now lets try to add duplicates in the emp_id. 
INSERT INTO Employees (emp_id, emp_name, age, email)
VALUES (101, 'David', 28, 'david@example.com');
# we get this error - 0	10	21:43:51	INSERT INTO Employees (emp_id, emp_name, age, email)
# VALUES (101, 'David', 28, 'david@example.com')	Error Code: 1062. Duplicate entry '101' for key 'employees.PRIMARY'	0.000 sec

# question 6. You created a products table without constraints as follows:
# Answer - 
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2));
#Now, you realise that
# The product_id should be a primary key
Alter table products
add constraint Unique_product_id unique (product_id);
# The price should have a default value of 50.00
ALTER TABLE products
MODIFY price DECIMAL(10, 2) DEFAULT 50.00;

# question 7. You have two tables. 
create table Students (
	student_id varchar(30) UNIQUE ,
    student_name char(60) not null,
    class_id int);
INSERT INTO Students (student_id, student_name, class_id)
VALUES
    (1, 'Alice', 101),
    (2, 'Bob', 102),
    (3, 'Charlie', 101);
    
Create table classes ( class_id int, class_name char(40));
insert into classes (class_id, class_name)
values 
	(101, 'Math'),
    (102, 'Science'),
    (103, 'History');
# Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
#Answer - 

SELECT Students.student_name, Classes.class_name
FROM Students
INNER JOIN Classes ON Students.class_id = Classes.class_id;

# Question 8. Consider the following three tables:
create table Orders (
    order_id varchar(50) unique,
    order_date date,
    customer_id int
);

insert into Orders (order_id, order_date, customer_id)
values 
    ('1', '2024-01-01', 101),
    ('2', '2024-01-03', 102);

create table Customers (
    customer_id int,
    customer_name varchar(100)  
);

insert into Customers (customer_id, customer_name)
values 
    (101, 'Alice'),
    (102, 'Bob');

create table Products (
    product_id int,
    product_name varchar(100),  
    order_id varchar(50),    
    foreign key (order_id) references Orders(order_id)  
);

insert into Products (product_id, product_name, order_id)
values 
    (1, 'Laptop', '1'),
    (2, 'Phone', NULL);  
    
# Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
# listed even if they are not associated with an order. Hint: (use INNER JOIN and LEFT JOIN)5

# Answer - 
SELECT 
    o.order_id, 
    c.customer_name, 
    p.product_name
FROM 
    Products p
LEFT JOIN 
    Orders o ON p.order_id = o.order_id
INNER JOIN 
    Customers c ON o.customer_id = c.customer_id;

# Question 9 . Given the following tables:
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY, 
    product_id INT, 
    amount DECIMAL(10, 2) 
);

INSERT INTO Sales (sale_id, product_id, amount)
VALUES
    (1, 101, 500),
    (2, 102, 300),
    (3, 101, 700);

 Create table Products (product_id int, product_name char(100));
 Insert	into Products (product_id, product_name)
Values
	(101, 'Laptop'),
	(102, 'Phone');
    
# Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

# answer - 
SELECT 
    p.product_name, 
    SUM(s.amount) AS total_sales_amount
FROM 
    Sales s
INNER JOIN 
    Products p ON s.product_id = p.product_id
GROUP BY 
    p.product_name;
    
# Question 10. You are given three tables.
# Write a query to display the order_id, customer_name, and the quantity of products ordered by each
#customer using an INNER JOIN between all three tables.
# Note - The above-mentioned questions don't require any dataset

# Answer - 
SELECT 
    o.order_id,
    c.customer_name,
    od.quantity
FROM 
    Orders o
INNER JOIN 
    Customers c ON o.customer_id = c.customer_id
INNER JOIN 
    Order_Details od ON o.order_id = od.order_id;
    
##  SQL Commands
# Q1.-Identify the primary keys and foreign keys in maven movies db. Discuss the differences
# Answer
use mavenmovies;
# identifying primary keys. 
SHOW KEYS FROM actor WHERE Key_name = 'PRIMARY';  # table 'actor' has a primery key in the column 'actor_id'
SHOW KEYS FROM actor_award WHERE Key_name = 'PRIMARY'; # table 'actor_award' has a primery key in the column 'actor_award_id'
SHOW KEYS FROM address WHERE Key_name = 'PRIMARY'; # table 'address' has a primery key in the column 'address_id'
SHOW KEYS FROM advisor WHERE Key_name = 'PRIMARY'; # table 'advisor' has a primery key in the column 'advisor_id'
SHOW KEYS FROM city WHERE Key_name = 'PRIMARY'; # table 'city' has a primery key in the column 'city_id'
SHOW KEYS FROM country WHERE Key_name = 'PRIMARY'; # table 'country' has a primery key in the column 'country_id'
SHOW KEYS FROM customer WHERE Key_name = 'PRIMARY';# table 'customer' has a primery key in the column 'customer_id'
SHOW KEYS FROM film WHERE Key_name = 'PRIMARY'; # table 'film' has a primery key in the column 'film_id'
SHOW KEYS FROM film_actor WHERE Key_name = 'PRIMARY'; # table 'film_actor' has a primery key in the column 'actor_id' and film_id
SHOW KEYS FROM film_category WHERE Key_name = 'PRIMARY'; # table 'film_category' has a primery key in the column 'film_id'and'category_id'
SHOW KEYS FROM film_text WHERE Key_name = 'PRIMARY'; # table 'film_text' has a primery key in the column 'film_id'
SHOW KEYS FROM inventory WHERE Key_name = 'PRIMARY'; # table 'inventory' has a primery key in the column 'inventory_id'
SHOW KEYS FROM investor WHERE Key_name = 'PRIMARY';# table 'investor' has a primery key in the column 'investor_id'
SHOW KEYS FROM language WHERE Key_name = 'PRIMARY'; # table 'language' has a primery key in the column 'language_id'
SHOW KEYS FROM payment WHERE Key_name = 'PRIMARY'; # table 'payment' has a primery key in the column 'payment_id'
SHOW KEYS FROM rental WHERE Key_name = 'PRIMARY';# table 'rental' has a primery key in the column 'rental_id'
SHOW KEYS FROM staff WHERE Key_name = 'PRIMARY';# table 'staff' has a primery key in the column 'staff_id'
SHOW KEYS FROM store WHERE Key_name = 'PRIMARY';# table 'store' has a primery key in the column 'store_id'

# indentifying the foreign keys. 
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME 
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE 
    TABLE_SCHEMA = 'mavenmovies' AND 
    REFERENCED_TABLE_NAME IS NOT NULL;
    
# question 2. List all details of actors
SELECT * FROM actor;

#Question 3 -List all customer information from DB.
#Answer 
select * from customer;
# Question 4.List different countries.
#Answer
select * from country;
# Question 5 -Display all active customers.
#Answer
select * from customer
where active = '1';
#Question 6 -List of all rental IDs for customer with ID 1.
#Answer
SELECT rental_id
FROM rental
WHERE customer_id = 1;

#Question 7 - Display all the films whose rental duration is greater than 5 .
#Answer
Select * from film
where rental_duration > '5';

#Question 8. List the total number of films whose replacement cost is greater than $15 and less than $20.
#Answer
select count(*) as Total_fils
from film
where replacement_cost > '15' and replacement_cost < '20';

# Question 9. - Display the count of unique first names of actors.
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;

# Question 10 - Display the first 10 records from the customer table .
#Answer
SELECT * 
FROM customer
LIMIT 10;

#Question - 11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
# Answer
SELECT * 
FROM customer
WHERE first_name LIKE 'b%'
LIMIT 3;

#question 12. Display the names of the first 5 movies which are rated as ‘G’.
SELECT title
FROM film
WHERE rating = 'G'
LIMIT 5;

#Question 13-Find all customers whose first name starts with "a".
#Answer -
SELECT First_name
FROM customer
WHERE first_name LIKE 'a%';
# Question 14- Find all customers whose first name ends with "a".
#Answer
SELECT first_name
FROM customer
WHERE first_name LIKE '%a';

#Question - 15- Display the list of first 4 cities which start and end with ‘a’ .
#Answer
select city
from city
where city like 'a%a'
limit 4;

# question - 16- Find all customers whose first name have "NI" in any position.
#Answer
select first_name from customer
where first_name like "%NI%";
#question 17- Find all customers whose first name have "r" in the second position .
#Answer
SELECT first_name 
FROM customer
WHERE first_name LIKE '_r%';
#Question 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
#Answer
Select first_name 
from customer
where first_name like 'a%' and length(first_name) >=5;
#Question 19- Find all customers whose first name starts with "a" and ends with "o".
#Answer
select first_name
from customer
where first_name like 'a%o';
#question 20 - Get the films with pg and pg-13 rating using IN operator.
#Answer
SELECT *
FROM film
WHERE rating IN ('PG', 'PG-13');
#question 21 - Get the films with length between 50 to 100 using between operator.
#Answer
Select * from film
where length between 50 and 100;
#Question 22 - Get the top 50 actors using limit operator.
#Answer
select * from actor
limit 50;
#question 23 - Get the distinct film ids from inventory table.
#Answer
SELECT DISTINCT film_id
FROM inventory;

# Functions
# Basic Aggregate Functions:

# Question 1:
# Retrieve the total number of rentals made in the Sakila database.
# Hint: Use the COUNT() function.
#Answer
use sakila;
SELECT COUNT(rental_id) AS total_rentals
FROM rental;

#Question 2:
#Find the average rental duration (in days) of movies rented from the Sakila database.
# Hint: Utilize the AVG() function.
#Answer
SELECT AVG(DATEDIFF(return_date, rental_date)) AS average_rental_duration
FROM rental;

# String Functions:
# Question 3:
# Display the first name and last name of customers in uppercase.
# Hint: Use the UPPER () function.
#Answer
select upper(first_name) as first_name_uppercase,
upper(last_name) as last_name_uppercase
from customer;

#Question 4:
#Extract the month from the rental date and display it alongside the rental ID.
#Hint: Employ the MONTH() function.
#Answer
select month(rental_date) as rental_month,
rental_id from rental;

# GROUP BY:
# Question 5:
# Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
# Hint: Use COUNT () in conjunction with GROUP BY.
#Answer

SELECT customer_id,
       COUNT(rental_id) AS rental_count
from rental
GROUP BY customer_id;

# Question 6:
#Find the total revenue generated by each store.
# Hint: Combine SUM() and GROUP BY.

#Answer -  here I am using staff_id because no store_id is available in the table payment.
select * from payment;
select staff_id,
	sum(amount) as total_reveniue
from payment 
group by staff_id;

#Question 7:
#Determine the total number of rentals for each category of movies.
#Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.

#Answer

SELECT c.name AS category_name,
       COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

#Question 8:
#Find the average rental rate of movies in each language.
#Hint: JOIN film and language tables, then use AVG () and GROUP BY
# Answer
SELECT l.name AS language,
       AVG(f.rental_rate) AS average_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;

# Joins
# Questions 9 -
# Display the title of the movie, customers first name, and last name who rented it.
#Hint: Use JOIN between the film, inventory, rental, and customer tables.
#Answer

SELECT f.title AS movie_title,
       c.first_name AS customer_first_name,
       c.last_name AS customer_last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

# Question 10:
# Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
# Hint: Use JOIN between the film actor, film, and actor tables.

SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

#Question 11:
# Retrieve the customer names along with the total amount they've spent on rentals.
# Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
# Answer
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

# Question 12:
# List the titles of movies rented by each customer in a particular city (e.g., 'London').
# Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY

SELECT c.first_name, c.last_name, f.title AS movie_title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.customer_id, f.title
ORDER BY c.first_name, c.last_name;

# Question 13:
# Display the top 5 rented movies along with the number of times they've been rented.
# Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results

#Answer
SELECT f.title AS movie_title, 
       COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 5;

# Question 14:
# Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
# Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
#Answer
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;


# Windows Function:

# Question 1. Rank the customers based on the total amount they've spent on rentals
#Answer
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

# Question 2. Calculate the cumulative revenue generated by each film over time.

#Answer
use sakila;
SELECT f.title AS film_title,
       p.payment_date,
       SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.title, p.payment_date;

# Question 3. Determine the average rental duration for each film, considering films with similar lengths.
#Answer
SELECT ROUND(f.length, -1) AS length_group,
       f.title AS film_title,
       AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL
GROUP BY length_group, f.film_id
ORDER BY length_group, avg_rental_duration DESC;
#Question 4. Identify the top 3 films in each category based on their rental counts.
#Answer
WITH ranked_films AS (
    SELECT c.name AS category_name,
           f.title AS film_title,
           COUNT(r.rental_id) AS rental_count,
           RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.category_id, c.name, f.film_id, f.title
)
SELECT category_name, film_title, rental_count, rank_in_category
FROM ranked_films
WHERE rank_in_category <= 3
ORDER BY category_name, rank_in_category;
#question 4.  Calculate the difference in rental counts between each customer's total rentals and the average rentals
#across all customers.

#Ansser
WITH customer_rental_counts AS (
    SELECT c.customer_id,
           c.first_name,
           c.last_name,
           COUNT(r.rental_id) AS total_rentals
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id
),
average_rental_count AS (
    SELECT AVG(total_rentals) AS avg_rentals
    FROM customer_rental_counts
)
SELECT crc.customer_id,
       crc.first_name,
       crc.last_name,
       crc.total_rentals,
       arc.avg_rentals,
       (crc.total_rentals - arc.avg_rentals) AS rental_difference
FROM customer_rental_counts crc
CROSS JOIN average_rental_count arc
ORDER BY rental_difference DESC;
#question 6. Find the monthly revenue trend for the entire rental store over time.
#Answer
SELECT 
    YEAR(p.payment_date) AS year,
    MONTH(p.payment_date) AS month,
    SUM(p.amount) AS monthly_revenue
FROM payment p
GROUP BY YEAR(p.payment_date), MONTH(p.payment_date)
ORDER BY year, month;

#Question - 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spent
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
),
ranked_customers AS (
    SELECT 
        customer_id,
        first_name,
        last_name,
        total_spent,
        ROW_NUMBER() OVER (ORDER BY total_spent DESC) AS spending_rank,
        COUNT(*) OVER () AS total_customers
    FROM customer_spending
)
SELECT 
    customer_id,
    first_name,
    last_name,
    total_spent
FROM ranked_customers
WHERE spending_rank <= total_customers * 0.2
ORDER BY total_spent DESC;
#Question 8. Calculate the running total of rentals per category, ordered by rental count.
#Answer
WITH category_rentals AS (
    SELECT 
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN inventory i ON fc.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.category_id
)
SELECT 
    category_name,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total_rentals
FROM category_rentals
ORDER BY rental_count DESC;

#Question 9. Find the films that have been rented less than the average rental count for their respective categories.
#Answer
WITH film_rentals AS (
    SELECT 
        f.film_id,
        f.title AS film_title,
        c.category_id,
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY f.film_id, c.category_id
),
category_avg_rentals AS (
    SELECT 
        category_id,
        AVG(rental_count) AS avg_rentals
    FROM film_rentals
    GROUP BY category_id
)
SELECT 
    fr.film_title,
    fr.category_name,
    fr.rental_count,
    ca.avg_rentals
FROM film_rentals fr
JOIN category_avg_rentals ca ON fr.category_id = ca.category_id
WHERE fr.rental_count < ca.avg_rentals
ORDER BY fr.category_name, fr.rental_count;

#Question 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
#Answer


SELECT 
    YEAR(p.payment_date) AS year,
    MONTH(p.payment_date) AS month,
    SUM(p.amount) AS monthly_revenue
FROM payment p
GROUP BY YEAR(p.payment_date), MONTH(p.payment_date)
ORDER BY monthly_revenue DESC
LIMIT 5;

#Normalisation & CTE
#Question 1 Identify a table in the Sakila database that violates 1NF. Explain how you
#would normalize it to achieve 1NF.
#Answer - There is no table in Sakila that violates 1NF. 
# It is because evey table's column contain only single, individual values.
# and There are not repeating groups or arrays.
# Question 2. Second Normal Form (2NF):
# Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
# If it violates 2NF, explain the steps to normalize it.
#Answer
# All the tables in Sakila is in 2NF, it is because they are meeting the these 2 criteria.
# (a) They are in 1NF  (b) There are non primeray keys are completely dependent on Primary keys
# 3. Third Normal Form (3NF):
#Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
#present and outline the steps to normalize the table to 3NF.

#Answer - there is no table violating 3NF. Transitive dependenicies is when there is no non key attribute that depends on another non key attribut. 
# if we need to create a new table and move values from the non key attribute that depends on other non key attribute to new table that should depend on primary key. 

#4. Normalization Process:
#Take a specific table in Sakila and guide through the process of normalizing it from the initial 
#unnormalized form up to at least 2NF.

#Question CTE Basics:
#Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
# have acted in from the actor and film_actor tables.
#Answer
WITH ActorFilmCount AS (
    SELECT 
        a.actor_id,
        a.first_name,
        a.last_name,
        COUNT(fa.film_id) AS film_count
    FROM 
        actor a
    JOIN 
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY 
        a.actor_id, a.first_name, a.last_name
)
SELECT 
    first_name,
    last_name,
    film_count
FROM 
    ActorFilmCount;

# Question 6. CTE with Joins:
#Create a CTE that combines information from the film and language tables to display the film title, 
#language name, and rental rate.

#Answer

WITH FilmLanguageInfo AS (
    SELECT 
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM 
        film f
    JOIN 
        language l ON f.language_id = l.language_id
)
SELECT 
    film_title,
    language_name,
    rental_rate
FROM 
    FilmLanguageInfo;
    
#Question 7. CTE for Aggregation:
#a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
#from the customer and payment tables.

#Answer
WITH CustomerRevenue AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_revenue
    FROM 
        customer c
    JOIN 
        payment p ON c.customer_id = p.customer_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name
)
SELECT 
    customer_id,
    first_name,
    last_name,
    total_revenue
FROM 
    CustomerRevenue;
    
    
#Question 8. CTE with Window Functions:
# Utilize a CTE with a window function to rank films based on their rental duration from the film table.
#answer

WITH FilmRanked AS (
    SELECT 
        f.title AS film_title,
        f.rental_duration,
        RANK() OVER (ORDER BY f.rental_duration DESC) AS rank_based_on_duration
    FROM 
        film f
)
SELECT 
    film_title,
    rental_duration,
    rank_based_on_duration
FROM 
    FilmRanked;

#Questioin 9 . CTE and Filtering:
#Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
# customer table to retrieve additional customer details.
#Answer

WITH CustomerRentalCount AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        COUNT(r.rental_id) AS rental_count
    FROM 
        customer c
    JOIN 
        rental r ON c.customer_id = r.customer_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name
    HAVING 
        COUNT(r.rental_id) > 2
)
SELECT 
    crc.customer_id,
    crc.first_name,
    crc.last_name,
    crc.rental_count
FROM 
    CustomerRentalCount crc;
    
#Question 10. CTE for Date Calculations:
#Write a query using a CTE to find the total number of rentals made each month, considering the 
#rental_date from the rental table

#Answer.

WITH MonthlyRentals AS (
    SELECT 
        YEAR(r.rental_date) AS rental_year,
        MONTH(r.rental_date) AS rental_month,
        COUNT(r.rental_id) AS total_rentals
    FROM 
        rental r
    GROUP BY 
        YEAR(r.rental_date), MONTH(r.rental_date)
)
SELECT 
    rental_year,
    rental_month,
    total_rentals
FROM 
    MonthlyRentals
ORDER BY 
    rental_year DESC, rental_month DESC;
    
#Question 11. CTE and Self-Join:
#Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
#together, using the film_actor table.

#Answer

WITH ActorPairs AS (
    SELECT 
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        fa1.film_id
    FROM 
        film_actor fa1
    JOIN 
        film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE 
        fa1.actor_id < fa2.actor_id  
)
SELECT 
    a1.first_name AS actor1_first_name,
    a1.last_name AS actor1_last_name,
    a2.first_name AS actor2_first_name,
    a2.last_name AS actor2_last_name,
    ap.film_id
FROM 
    ActorPairs ap
JOIN 
    actor a1 ON ap.actor1_id = a1.actor_id
JOIN 
    actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY 
    ap.film_id;
#Question 12.  CTE for Recursive Search:
#Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
#considering the reports_to column

#answer




