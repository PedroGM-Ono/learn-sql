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