-- 584. Find Customer Referee
SELECT
name
FROM Customer
WHERE referee_id <> 2 OR referee_id IS NULL

-- 595. Big Countries
SELECT
name,
population,
area
FROM World
WHERE area >= 3000000 OR population >= 25000000

-- 1148. Article Views I
SELECT author_id AS id
FROM Views
WHERE author_id = viewer_id
GROUP BY author_id
ORDER BY author_id ASC


-- 1683. Invalid Tweets
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15

-- 2356. Number of Unique Subjects Taught by Each Teacher
SELECT 
teacher_id,
COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id

-- 1141. User Activity for the Past 30 Days I
SELECT activity_date AS day,
COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date

-- 596. Classes More Than 5 Students
SELECT
class
FROM Courses
GROUP BY class
HAVING COUNT(DISTINCT student) >=5

-- 619. Biggest Single Number
SELECT MAX(num) as num
FROM (
    SELECT num
    FroM MyNumbers
    GROUP By num
    HAVING COUNT(num) = 1
) AS unique_numbers


-- 1378. Replace Employee ID With The Unique Identifier
SELECT unique_id, name
FROM Employees AS e
LEFT JOIN EmployeeUNI as u ON e.id = u.id

-- 1068. Product Sales Analysis I
SELECT product_name, year, price
FROM Sales as s
JOIN Product as p ON s.product_id = p.product_id

--1581. Customer Who Visited but Did Not Make Any Transactions
SELECT customer_id, COUNT(*) AS count_no_trans
FROM Visits as v
LEFT JOIN Transactions as t ON v.visit_id = t.visit_id
WHERE transaction_id IS NULL
GROUP BY customer_id

-- 197. Rising Temperature
WITH TempWithYesterday AS (
    SELECT id, temperature, recordDate,
           LAG(temperature, 1) OVER (ORDER BY recordDate) AS lag_1_temp,
           LAG(recordDate, 1) OVER (ORDER BY recordDate) AS lag_1_date
    FROM Weather
)
SELECT id as Id

-- 1661. Average Time of Process per Machine
SELECT
m1 as machine_id,
ROUND(AVG(end_time - start_time), 3) as processing_time
FROM (
    SELECT 
    machine_id as m1,
    process_id as p1,
    timestamp as start_time
    FROM Activity
    WHERE activity_type = 'start'
) as start_times
INNER JOIN (
    SELECT 
    machine_id as m2,
    process_id as p2,
    timestamp as end_time
    FROM Activity
    WHERE activity_type = 'end'
) as end_times on (start_times.m1 = end_times.m2 AND start_times.p1 = end_times.p2)
GROUP BY m1

-- 577. Employee Bonus
SELECT name, bonus
FROM Employee as e
LEFT JOIN Bonus as b ON e.empId = b.empId
WHERE bonus < 1000 OR bonus IS NULL

--1280. Students and Examinations
SELECT
st.student_id,
st.student_name,
sub.subject_name,
Count(e.student_id) as attended_exams
FROM Students as st
CROSS JOIN Subjects as sub

-- 1729. Find Followers Count
SELECT
user_id,
COUNT(follower_id) as followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC

-- 1757. Recyclable and Low Fat Products
SELECT
product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y'

-- 175. Combine Two Tables
SELECT firstName, lastName, city, state
FROM Person
LEFT JOIN Address
ON Person.personId = Address.personId

-- 181. Employees Earning More Than Their Managers
SELECT E2.name AS Employee
FROM Employee AS E1
LEFT JOIN Employee AS E2
ON E1.id = E2.managerId
WHERE E1.salary < E2.salary

-- 182. Duplicate Emails
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1

-- 3475. DNA Pattern Recognition
SELECT 
    sample_id,
    dna_sequence,
    species, 
    dna_sequence LIKE 'ATG%' as has_start,
    (dna_sequence LIKE '%TAA') OR (dna_sequence LIKE '%TAG') OR (dna_sequence LIKE '%TGA') as has_stop,
    dna_sequence LIKE '%ATAT%' as has_atat,
    dna_sequence LIKE '%GGG%' as has_ggg
FROM Samples


-- 1393. Capital Gain/Loss
SELECT stock_name,
SUM(CASE
    WHEN operation = 'Buy' THEN - price
    ELSE price
END) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name

-- 3497. Analyze Subscription Conversion
SELECT 
    user_id,
    ROUND(AVG(
        CASE WHEN activity_type = 'free_trial' THEN activity_duration
    END), 2) AS trial_avg_duration,
    ROUND(AVG(
        CASE WHEN activity_type = 'paid' THEN activity_duration
    END), 2) AS paid_avg_duration
FROM UserActivity
GROUP BY user_id
HAVING paid_avg_duration IS NOT NULL

-- 177. Nth Highest Salary
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
DECLARE M INT;
SET M = N - 1;
  RETURN (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET M
  );
END

-- 1341. Movie Rating
# Write your MySQL query statement below
SELECT title as results
FROM (
    SELECT title, AVG(MovieRating.rating) AS grade
    FROM MovieRating
    LEFT JOIN Movies ON MovieRating.movie_id = Movies.movie_id
    WHERE MONTH(MovieRating.created_at) = 2 AND YEAR(MovieRating.created_at) = 2020
    GROUP BY Movies.title
    ORDER BY grade DESC, Movies.title ASC
    LIMIT 1
) AS a
UNION ALL
SELECT name as results
FROM (
    SELECT Users.name, COUNT(MovieRating.user_id) as count_user_id
    FROM MovieRating
    LEFT JOIN Users ON MovieRating.user_id = Users.user_id
    GROUP BY MovieRating.user_id
    ORDER BY count_user_id DESC, Users.name ASC
    LIMIT 1
) AS b

-- 176. Second Highest Salary
SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary