# Assignment
#Q1.

create database Assign;

use Assign;

CREATE TABLE employees (
    emp_id INTEGER NOT NULL PRIMARY KEY,
    emp_name VARCHAR(25) NOT NULL,
    age INTEGER CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL DEFAULT 30000
);

# Q2.
# Constraints are rules in a database that ensure the data is accurate, consistent, and valid. They help maintain data integrity by preventing invalid data entries.

# Common Types of Constraints:
#PRIMARY KEY – Uniquely identifies each record.
#Example: emp_id INT PRIMARY KEY

#NOT NULL – Prevents empty (NULL) values.
#Example: emp_name TEXT NOT NULL

#UNIQUE – Ensures no duplicate values.
#Example: email VARCHAR(255) UNIQUE

#CHECK – Validates data against a condition.
#Example: age INT CHECK(age >= 18)

#DEFAULT – Sets a default value.
#Example: salary DECIMAL DEFAULT 30000.00

#FOREIGN KEY – Links data between tables.
#Example: dept_id INT REFERENCES departments(dept_id)

#Q3.
#The NOT NULL constraint ensures that a column must have a value — it prevents missing or undefined data in important fields (like names, emails, etc.).
# No, a primary key cannot contain NULL values.
# A primary key must uniquely identify each record, and NULL means "unknown" or "missing", which violates uniqueness and reliability. Every row must have a non-null, unique value for the primary key.

#Q4.

ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

ALTER TABLE employees
DROP INDEX unique_email; -- MySQL

# Q5.
# When you insert, update, or delete data that violates a constraint, the database will reject the operation and return an error. This protects the integrity and consistency of your data.
#example
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    age INT CHECK (age >= 18)
);

INSERT INTO employees (emp_id, email, age)
VALUES (101, 'test@example.com', 25);

INSERT INTO employees (emp_id, email, age)
VALUES (102, 'test@example.com', 30);

#Q6.
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

ALTER TABLE products
MODIFY price DECIMAL(10, 2) DEFAULT 50.00;

#Q7.

SELECT 
    Students.student_name, 
    Classes.class_name
FROM 
    Students
INNER JOIN 
    Classes
ON 
    Students.class_id = Classes.class_id;

#Q8.

SELECT 
    o.order_id, 
    c.customer_name, 
    p.product_name
FROM 
    Products p
LEFT JOIN 
    Orders o ON p.order_id = o.order_id
LEFT JOIN 
    Customers c ON o.customer_id = c.customer_id;
    
#Q9.

SELECT 
    p.product_name,
    SUM(s.amount) AS total_sales
FROM 
    Sales s
INNER JOIN 
    Products p ON s.product_id = p.product_id
GROUP BY 
    p.product_name;
    
#Q10.

SELECT 
    o.order_id,
    c.customer_name,
    SUM(od.quantity) AS total_quantity
FROM 
    Orders o
INNER JOIN 
    Customers c ON o.customer_id = c.customer_id
INNER JOIN 
    Order_Details od ON o.order_id = od.order_id
GROUP BY 
    o.order_id, c.customer_name;

# SQL Commands

use sakila;

-- Get all primary keys in the database
SELECT 
    TABLE_NAME, 
    COLUMN_NAME 
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    CONSTRAINT_NAME = 'PRIMARY'
    AND TABLE_SCHEMA = 'mavenmovies';

-- Get all foreign key relationships
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    CONSTRAINT_NAME != 'PRIMARY'
    AND REFERENCED_TABLE_NAME IS NOT NULL
    AND TABLE_SCHEMA = 'mavenmovies';
    
    
    
#Q2.

select * from actor;

#Q3.

select * from customer;

#Q4.

SELECT DISTINCT country FROM country;

#Q5.

select * from customer
where active = 1;

#Q6.

SELECT rental_id
FROM rental
WHERE customer_id = 1;

#Q7.

select title from film
where rental_duration > 5;

#Q8.

select count(title) as no_of_films from film
where replacement_cost between 15 and 20;

#Q9.

select count(distinct(first_name)) from actor;

#Q10.

select * from customer
limit 10;

#Q11.

select * from customer
where first_name like "B%"
limit 3;

#Q12.
select title from film
where rating = 'G'
limit 5;

#Q13.

select first_name from customer
where first_name like "A%";

#Q14.

select first_name from customer
where first_name like "%A";

#Q15.

select city from city
where city like "A%A"
limit 4;

#Q16.

select first_name from customer
where first_name like "%ni%";

#Q17.

select first_name from customer
where first_name like "_r%";

#Q18.

select first_name from customer
where first_name like "A____";

#Q19.

select first_name from customer
where first_name like "A%o";

#Q20.

select title,rating from film
where rating in ("PG","PG-13");

#Q21.

SELECT *
FROM film
WHERE length BETWEEN 50 AND 100
ORDER BY length;

#Q22.

select first_name,last_name from actor
limit 50;

#Q23.

select distinct(film_id) from inventory;

# Functions
#Q1.
select count(rental_id) as no_of_rentals from rental;

#Q2.

SELECT 
    AVG(rental_duration) AS average_rental_duration_days
FROM 
    film;
    
#Q3.

select upper(first_name),upper(last_name) from customer;

#Q4.

select rental_id,month(rental_date) as rental_month from rental;

#Q5.

SELECT 
    customer_id,
    COUNT(rental_id) AS rental_count
FROM 
    rental
GROUP BY 
    customer_id
ORDER BY 
    rental_count DESC;
    
#Q6.

SELECT 
    i.store_id,
    SUM(p.amount) AS total_revenue
FROM 
    inventory i
JOIN 
    rental r ON i.inventory_id = r.inventory_id
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    i.store_id;
    
#Q7.

SELECT 
    c.name AS movie_category,
    COUNT(*) AS total_rentals
FROM 
    category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY total_rentals DESC;

#Q8.

SELECT 
    l.name AS language,
    AVG(f.rental_rate) AS average_rental_rate
FROM 
    film f
JOIN 
    language l ON f.language_id = l.language_id
GROUP BY 
    l.name
ORDER BY 
    average_rental_rate DESC;
    
#Joins

#Q9.

SELECT 
    f.title AS movie_title,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name
FROM 
    film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id
ORDER BY 
    f.title, c.last_name, c.first_name;
    
#Q10.

SELECT 
    a.first_name, 
    a.last_name
FROM 
    actor a
JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
JOIN 
    film f ON fa.film_id = f.film_id
WHERE 
    f.title = 'Gone with the Wind'
ORDER BY 
    a.last_name, a.first_name;

#Q11.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_amount_spent
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_amount_spent DESC;

#Q12.

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    film.title AS movie_title
FROM 
    customer
INNER JOIN 
    address ON customer.address_id = address.address_id
INNER JOIN 
    city ON address.city_id = city.city_id
INNER JOIN 
    rental ON customer.customer_id = rental.customer_id
INNER JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN 
    film ON inventory.film_id = film.film_id
WHERE 
    city.city = 'London'
ORDER BY 
    customer.last_name, 
    customer.first_name, 
    film.title;
    
#Advanced Joins and GROUP BY:
#Q13.

SELECT 
    film.title AS movie_title,
    COUNT(rental.rental_id) AS rental_count
FROM 
    film
INNER JOIN 
    inventory ON film.film_id = inventory.film_id
INNER JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY 
    film.title
ORDER BY 
    rental_count DESC
LIMIT 5;

#Q14.

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name
FROM 
    customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
WHERE 
    inventory.store_id IN (1, 2)
GROUP BY 
    customer.customer_id,
    customer.first_name,
    customer.last_name
HAVING 
    COUNT(DISTINCT inventory.store_id) = 2;
    
# Windows Function:

#Q1.
SELECT 
    customer_id,
    first_name,
    last_name,
    total_amount_spent,
    RANK() OVER (ORDER BY total_amount_spent DESC) AS customer_rank
FROM (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_amount_spent
    FROM 
        customer c
    JOIN 
        payment p ON c.customer_id = p.customer_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name
) AS customer_totals
ORDER BY 
    customer_rank;
    
#Q2.

SELECT
    f.title AS movie_title,
    p.payment_date,
    p.amount,
    SUM(p.amount) OVER (
        PARTITION BY f.film_id
        ORDER BY p.payment_date
    ) AS running_total
FROM
    film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY
    f.title,
    p.payment_date;

#Q3.

SELECT
    CASE
        WHEN length < 60 THEN 'Short'
        WHEN length BETWEEN 60 AND 90 THEN 'Medium'
        WHEN length BETWEEN 91 AND 120 THEN 'Long'
        ELSE 'Extra Long'
    END AS film_length_group,
    AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_days
FROM
    film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
WHERE
    return_date IS NOT NULL
GROUP BY
    film_length_group
ORDER BY
    avg_rental_days DESC;
    
#Q4.

SELECT
    category_name,
    film_title,
    rental_count
FROM (
    SELECT
        c.name AS category_name,
        f.title AS film_title,
        COUNT(*) AS rental_count,
        RANK() OVER (PARTITION BY c.name ORDER BY COUNT(*) DESC) AS rnk
    FROM
        category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name, f.title
) AS ranked
WHERE
    rnk <= 3
ORDER BY
    category_name,
    rental_count DESC;
    
#Q5.

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.rental_id) AS rental_count,
    COUNT(r.rental_id) - (
        SELECT AVG(rental_count) 
        FROM (
            SELECT COUNT(rental_id) AS rental_count
            FROM rental
            GROUP BY customer_id
        ) AS avg_counts
    ) AS difference_from_average
FROM
    customer c
LEFT JOIN
    rental r ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
ORDER BY
    difference_from_average DESC;
    
#Q6.

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS monthly_revenue,
    @running_total := @running_total + SUM(amount) AS cumulative_revenue,
    ROUND(
        (SUM(amount) - @prev_month_revenue) / @prev_month_revenue * 100, 
        2
    ) AS growth_rate_percent,
    @prev_month_revenue := SUM(amount) AS current_month_revenue
FROM 
    payment,
    (SELECT @running_total := 0, @prev_month_revenue := NULL) AS vars
GROUP BY 
    month
ORDER BY 
    month;
    
#Q7.
WITH customer_spending AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_spending,
        PERCENT_RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_percentile
    FROM
        customer c
    JOIN
        payment p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
)
SELECT
    customer_id,
    customer_name,
    total_spending,
    ROUND(spending_percentile * 100, 2) AS percentile
FROM
    customer_spending
WHERE
    spending_percentile <= 0.2  -- Top 20%
ORDER BY
    total_spending DESC;

#Q8.
WITH category_rentals AS (
    SELECT
        c.category_id,
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM
        category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.category_id, c.name
)
SELECT
    category_name,
    rental_count,
    SUM(rental_count) OVER (
        ORDER BY rental_count DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total,
    ROUND(rental_count * 100.0 / SUM(rental_count) OVER (), 2) AS percentage_of_total
FROM
    category_rentals
ORDER BY
    rental_count DESC;
    
#Q9.

WITH film_rentals AS (
    SELECT
        f.film_id,
        f.title,
        c.name AS category,
        COUNT(r.rental_id) AS rental_count,
        AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id) AS category_avg_rentals
    FROM
        film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        f.film_id, f.title, c.category_id, c.name
)
SELECT
    film_id,
    title,
    category,
    rental_count,
    ROUND(category_avg_rentals, 2) AS category_avg_rentals
FROM
    film_rentals
WHERE
    rental_count < category_avg_rentals
ORDER BY
    category,
    rental_count;
    
#Q10.

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(payment_date, '%Y-%m') AS month,
        SUM(amount) AS revenue,
        RANK() OVER (ORDER BY SUM(amount) DESC) AS revenue_rank
    FROM
        payment
    GROUP BY
        DATE_FORMAT(payment_date, '%Y-%m')
)
SELECT
    month,
    revenue,
    revenue_rank
FROM
    monthly_revenue
WHERE
    revenue_rank <= 5
ORDER BY
    revenue_rank;
    
# Normalisation & CTE

#Q1.

-- A table is in First Normal Form (1NF) if:

-- It has only atomic (indivisible) values.

-- There are no repeating groups or arrays.

-- Each column contains values of a single type.

-- First create the CTE as a separate query
CREATE TEMPORARY TABLE temp_numbers AS
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 10
)
SELECT * FROM numbers;

-- Then use it in your INSERT
INSERT INTO film_special_feature (film_id, feature)
SELECT 
    f.film_id,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(f.special_features, ',', n.n), ',', -1)) AS feature
FROM 
    film f
JOIN 
    temp_numbers n
    ON n.n <= (LENGTH(f.special_features) - LENGTH(REPLACE(f.special_features, ',', '')) + 1
WHERE 
    f.special_features IS NOT NULL 
    AND f.special_features != '';

-- Clean up
DROP TEMPORARY TABLE temp_numbers;

#Q2.
-- 1. Identify the primary key. For film_actor, composite (film_id, actor_id).

-- 2. Check each non-key attribute (if there were any besides last_update). If there were attributes like actor_name, they depend only on actor_id, hence partial dependency.

-- 3. To normalize, remove the partial dependencies by moving those attributes to a table where they depend on the full key.

-- Create actor table if it doesn't exist
CREATE TABLE actor (
    actor_id INT PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert unique actors into the actor table
INSERT INTO actor (actor_id, first_name, last_name, last_update)
SELECT DISTINCT 
    actor_id, 
    first_name, 
    last_name, 
    MAX(last_update)  -- Keep the latest update timestamp
FROM film_actor
GROUP BY actor_id, first_name, last_name;

ALTER TABLE film_actor
DROP COLUMN first_name,
DROP COLUMN last_name,
DROP COLUMN last_update; 

ALTER TABLE film_actor
ADD CONSTRAINT fk_film_actor_actor
FOREIGN KEY (actor_id) REFERENCES actor(actor_id);

-- Normalized actor table
SELECT * FROM actor LIMIT 1;

-- Normalized film_actor table
SELECT * FROM film_actor LIMIT 1;

#Q3.

-- 1. Identify the transitive dependency: language_name depends on original_language_id, which is a non-key attribute in the film table.

-- 2. Create a language table with language_id (PK) and language_name.

-- 3. Remove the language_name from the film table, keeping only original_language_id.

-- 4. Establish a foreign key from film.original_language_id to language.language_id.


CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE city (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(50) NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

ALTER TABLE customer
DROP COLUMN address,
DROP COLUMN city,
DROP COLUMN country,
ADD COLUMN address_id INT NOT NULL,
ADD FOREIGN KEY (address_id) REFERENCES address(address_id);

#Q4.

CREATE TABLE film_actors_unnormalized (
    film_id INT,
    title VARCHAR(255),
    description TEXT,
    release_year YEAR,
    actors VARCHAR(255)  -- Stores actor names as "John Doe, Jane Smith"
);
-- Convert comma-separated actors into individual rows
CREATE TABLE film_actors_1NF AS
SELECT 
    film_id, 
    title, 
    description, 
    release_year,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(actors, ',', n), ',', -1)) AS actor_name
FROM film_actors_unnormalized
JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3) numbers  -- Assumes max 3 actors per film
WHERE n <= LENGTH(actors) - LENGTH(REPLACE(actors, ',', '')) + 1;

CREATE TABLE film (
    film_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_year YEAR
);

-- Insert unique film data
INSERT INTO film (film_id, title, description, release_year)
SELECT DISTINCT film_id, title, description, release_year
FROM film_actors_1NF;

CREATE TABLE actor (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    actor_name VARCHAR(255) NOT NULL UNIQUE
);

-- Insert unique actors
INSERT INTO actor (actor_name)
SELECT DISTINCT actor_name
FROM film_actors_1NF;

CREATE TABLE film_actor (
    film_id INT,
    actor_id INT,
    PRIMARY KEY (film_id, actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
);

-- Populate junction table
INSERT INTO film_actor (film_id, actor_id)
SELECT f.film_id, a.actor_id
FROM film_actors_1NF fna
JOIN film f ON f.film_id = fna.film_id
JOIN actor a ON a.actor_name = fna.actor_name;


#Q5.

WITH actor_film_counts AS (
    SELECT 
        fa.actor_id,
        COUNT(fa.film_id) AS film_count
    FROM 
        film_actor fa
    GROUP BY 
        fa.actor_id
)
SELECT 
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
    afc.film_count
FROM 
    actor a
JOIN 
    actor_film_counts afc ON a.actor_id = afc.actor_id
ORDER BY 
    afc.film_count DESC;


#Q6.

WITH film_language_cte AS (
    SELECT 
        f.title AS film_title,
        l.name AS language_name,
        f.release_year,
        f.length
    FROM 
        film f
    JOIN 
        language l ON f.language_id = l.language_id
)

SELECT 
    film_title,
    language_name,
    release_year,
    length
FROM 
    film_language_cte
ORDER BY 
    language_name, film_title;

#Q7.

WITH customer_payments AS (
    SELECT 
        p.customer_id,
        SUM(p.amount) AS total_revenue
    FROM 
        payment p
    GROUP BY 
        p.customer_id
)

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    cp.total_revenue
FROM 
    customer c
JOIN 
    customer_payments cp ON c.customer_id = cp.customer_id
ORDER BY 
    cp.total_revenue DESC;

#Q8.

WITH ranked_films AS (
    SELECT 
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank
    FROM 
        film
)

SELECT 
    film_id,
    title,
    rental_duration,
    rental_rank
FROM 
    ranked_films
ORDER BY 
    rental_rank, title;

#Q9.

WITH frequent_customers AS (
    SELECT 
        customer_id,
        COUNT(*) AS rental_count
    FROM 
        rental
    GROUP BY 
        customer_id
    HAVING 
        COUNT(*) > 2
)

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    fc.rental_count
FROM 
    frequent_customers fc
JOIN 
    customer c ON fc.customer_id = c.customer_id
ORDER BY 
    fc.rental_count DESC;

#Q10.

WITH monthly_rentals AS (
    SELECT
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(*) AS total_rentals
    FROM
        rental
    GROUP BY
        DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT
    rental_month,
    total_rentals
FROM
    monthly_rentals
ORDER BY
    rental_month;

#Q11.

WITH actor_pairs AS (
    SELECT 
        fa1.film_id,
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id
    FROM 
        film_actor fa1
    JOIN 
        film_actor fa2 
        ON fa1.film_id = fa2.film_id
       AND fa1.actor_id < fa2.actor_id  -- avoid duplicates and self-pairing
)

SELECT 
    ap.film_id,
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor_1,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor_2
FROM 
    actor_pairs ap
JOIN 
    actor a1 ON ap.actor1_id = a1.actor_id
JOIN 
    actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY 
    ap.film_id, actor_1, actor_2;


#Q12.

WITH RECURSIVE employee_hierarchy AS (
    -- Base case: Select the manager
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM 
        staff
    WHERE 
        staff_id = 3  -- Replace with the specific manager's staff_id

    UNION ALL

    -- Recursive case: Find employees who report to the current staff members
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM 
        staff s
    JOIN 
        employee_hierarchy eh ON s.reports_to = eh.staff_id
)

SELECT 
    staff_id,
    CONCAT(first_name, ' ', last_name) AS employee_name,
    reports_to
FROM 
    employee_hierarchy
ORDER BY 
    staff_id;
