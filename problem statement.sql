SELECT * FROM practice_db.employees
ORDER BY id ASC 

INSERT INTO practice_db.employees (id, name, department, salary) VALUES
(1, 'Arif Rahman', 'Data Engineering', 65000),
(2, 'Sultana Razia', 'HR', 45000),
(3, 'Imran Hossain', 'Data Engineering', 72000),
(4, 'Fahim Shakil', 'Marketing', 38000),
(5, 'Nusrat Jahan', 'IT Support', 50000);


-- ১. AND: যারা Data Engineering ডিপার্টমেন্টে আছে এবং বেতন ৬০,০০০ এর বেশ
SELECT * FROM practice_db.employees WHERE department = 'Data Engineering' and salary>60000
-- ২. OR: যারা HR অথবা Marketing ডিপার্টমেন্টে আছ
SELECT * FROM practice_db.employees WHERE DEPARTMENT = 'HR' OR DEPARTMENT = 'Marketing'
-- ৩. IN: OR এর কাজটা আরও সহজে করা (ডিপার্টমেন্টের লিস্ট ধরে)
SELECT * FROM practice_db.employees WHERE DEPARTMENT IN 'HR' AND 'Marketing'
-- ৪. BETWEEN: যাদের বেতন ৪৫,০০০ থেকে ৬৫,০০০ এর মধ্যে (inclusive)
SELECT * FROM practice_db.employees WHERE SALARY BETWEEN 45000 AND 65000
-- ۵. LIKE: যাদের নাম 'Arif' দিয়ে শুরু হয়েছে (% মানে এর পরে যেকোনো কিছু থাকতে পারে)
SELECT * FROM practice_db.employees where name like 'Arif%'     
-- ৬. NOT LIKE: যাদের নাম 'A' দিয়ে শুরু হয়ন
SELECT * FROM practice_db.employees where name NOT LIKE 'A%'


--rides share(Day 3 and 4)
-- প্রবলেম ১: (Day 3 - ফাইনান্স টিমের রিকোয়েস্ট)
-- "আমাদের প্ল্যাটফর্মের সামগ্রিক পারফরম্যান্স কেমন? মোট কয়টি রাইড হয়েছে, কত টাকা আয় হয়েছে 
-- এবং গড়ে প্রতি রাইডে কত কিলোমিটার পথ পাড়ি দেওয়া হয়েছে?"

SELECT * FROM practice_db.rides;
INSERT INTO practice_db.rides VALUES 
(1, 'Chittagong', 'Bike', 120, 4.5),
(2, 'Dhaka', 'Car', 450, 12.0),
(3, 'Chittagong', 'Car', 350, 8.2),
(4, 'Dhaka', 'Bike', 90, 3.0),
(5, 'Sylhet', 'Bike', 110, 4.0),
(6, 'Chittagong', 'Bike', 150, 5.5),
(7, 'Dhaka', 'Car', 600, 15.8);

SELECT 
Count(ride_id) as Count_order,
SUM(fare) as Total_Fare,
AVG(distance_km) as AVG_Dis
FROM 
practice_db.rides;



-- প্রবলেম ২: (Day 4 - অপারেশনস টিমের রিকোয়েস্ট)
-- "আমরা জানতে চাই কোন সিটিতে আমাদের ব্যবসা কেমন চলছে। প্রতিটি সিটির মোট রাইড সংখ্যা এবং মোট রেভিনিউ কত?"
-- অ্যাপ্লিকেশন: যেহেতু উত্তরটি সিটি ভিত্তিক (City-wise) আলাদা আলাদা করে চেয়েছে, তাই এখানে আমাদের ব্যবহার করতে হবে GROUP BY।

SELECT 
*
FROM 
practice_db.rides;

SELECT 
CITY,
sum(fare) as Total_Revenue,
count (ride_id) as Total_ride
FROM 
practice_db.rides
GROUP BY CITY;

-- প্রবলেম ৩: (Day 4 - স্ট্র্যাটেজি টিমের রিকোয়েস্ট)
-- "আমাদের শুধু সেইসব শহরের তালিকা দিন, যেখানে আমাদের মোট আয় (Total Revenue) 
-- ৫০০ টাকার বেশি হয়েছে। কম আয়ের শহরগুলো ফিল্টার করে বাদ দিন।"


SELECT 
    city,
    SUM(fare) AS total_revenue
FROM practice_db.rides
GROUP BY city
HAVING SUM(fare) > 500;


-- টাস্ক ১ (বিজনেস অ্যানালিস্ট রিকোয়েস্ট): আমাদের প্ল্যাটফর্মে গাড়ি (Car) এবং বাইক (Bike)—এই দুই ধরণের যানবাহনের মধ্যে 
-- গড় ভাড়া (Average Fare) এবং সর্বোচ্চ দূরত্ব (Maximum Distance) কত? (হিন্ট: vehicle_type এর ওপর GROUP BY করো 
-- এবং AVG ও MAX ফাংশন ব্যবহার করো)।

SELECT 
    vehicle_type,
    AVG(fare) AS Average_fare,
    MAX(distance_km) AS Maximum_Distance
FROM practice_db.rides
where vehicle_type='Bike' or vehicle_type='Car'
GROUP BY vehicle_type;

SELECT
*
FROM practice_db.rides;


-- টাস্ক ২ (অডিট টিমের রিকোয়েস্ট): ঢাকা (Dhaka) শহরে আমাদের মোট কয়টি রাইড হয়েছে এবং 
-- সেই রাইডগুলোর সর্বনিম্ন ভাড়া (MIN) কত ছিল? (হিন্ট: এখানে শুধু ঢাকার ডাটা ফিল্টার করতে 
-- গ্রুপের আগে WHERE city = 'Dhaka' ব্যবহার করতে হবে)।
SELECT
count(ride_id) as Total_ride,
Min(fare) as Minimum_Fare
FROM practice_db.rides 
where city = 'Dhaka';


INSERT INTO practice_db.customers VALUES 
(1, 'Arif', 'Chittagong'),
(2, 'Sultana', 'Dhaka'),
(3, 'Imran', 'Sylhet'),
(4, 'Fahim', 'Chittagong');

INSERT INTO practice_db.orders VALUES 
(101, 1, '2026-06-01', 1500),
(102, 2, '2026-06-01', 3200),
(103, 1, '2026-06-02', 4500),
(104, 5, '2026-06-03', 2000);

-- প্রব্লেম ১: (মার্কেটিং টিমের রিকোয়েস্ট)
-- "আমাদের এমন গ্রাহকদের তালিকা দিন যারা অলরেডি অর্ডার করেছেন, যেন আমরা তাদের লয়্যালটি পয়েন্ট হিসাব করতে পারি।"
-- অ্যাপ্লিকেশন: এখানে আমাদের শুধু সেই ডাটা দরকার যা দুটি টেবিলেই কমন (ম্যাচিং)। এর জন্য আমরা ব্যবহার করব INNER JOIN।
SELECT * from practice_db.customers;
SELECT * FROM practice_db.orders;

select 
c.customer_name,c.customer_id,
o.amount
from practice_db.customers as c
INNER JOIN practice_db.orders as o
ON C.customer_id=O.customer_id;
 
-- প্রবলেম ২: (ডাটা কোয়ালিটি ও অডিট টিমের রিকোয়েস্ট)
-- "আমাদের ডাটাবেসের সব গ্রাহকের তালিকা এবং তাদের অর্ডারের তথ্য দিন। যদি কোনো গ্রাহক এখনো কোনো 
-- অর্ডার না করে থাকেন, তাও তাকে তালিকায় রাখুন (অর্ডারের তথ্য ফাঁকা বা NULL দেখাবে)।"
SELECT * from practice_db.customers;
SELECT * FROM practice_db.orders;

SELECT
c.customer_name,o.order_id
FROM practice_db.customers AS c
LEFT JOIN practice_db.orders AS o 
ON c.customer_id=o.customer_id;


-- প্রবলেম ৩: (সিস্টেম বাগ/ত্রুটি খোঁজার জন্য রিকোয়েস্ট) 
-- "এমন কোনো অর্ডার কি আমাদের সিস্টেমে আছে, যা কোনো ভ্যালিড কাস্টমার প্রোফাইল ছাড়াই প্লেস হয়েছে? (ডাটাবেসের ইন্টিগ্রিটি চেক)।"
-- অ্যাপ্লিকেশন: আমরা অর্ডার টেবিলকে বামে রেখে কাস্টমার টেবিলের সাথে LEFT JOIN করব এবং দেখব কাস্টমার টেবিলে কার ডাটা missing।

SELECT * FROM practice_db.customers;
SELECT * FROM practice_db.orders;

SELECT
o.order_id,
o.customer_id as order_customer,
c.customer_name
FROM practice_db.orders AS o
LEFT JOIN practice_db.customers AS c 
ON c.customer_id=o.customer_id
where c.customer_name IS NULL;


-- টাস্ক ১ (বিজনেস অ্যানালিস্ট রিকোয়েস্ট): প্রতিটি সিটিতে (City) আমাদের মোট কত টাকার অর্ডার হয়েছে তা বের করো। 
-- (হিন্ট: এখানে customers এবং orders টেবিল দুটি JOIN করতে হবে এবং তারপর city এর ওপর GROUP BY করে SUM(amount)
-- করতে হবে)।

SELECT * FROM practice_db.CUSTOMERS;
SELECT * FROM practice_db.ORDERS;

SELECT 
 C.CITY,SUM(o.amount)
FROM practice_db.CUSTOMERS AS C
LEFT JOIN practice_db.ORDERS AS O
ON C.CUSTOMER_ID=O.CUSTOMER_ID
GROUP BY C.CITY

-- টাস্ক ২ (ইউজার রিটেনশন টিম রিকোয়েস্ট): আমাদের সেইসব গ্রাহকদের (Customers) নাম খুঁজে বের করো যারা এখনো পর্যন্ত একটি 
-- অর্ডারও করেননি, যাতে মার্কেটিং টিম তাদের ইমেইলে ডিসকাউন্ট কুপন পাঠাতে পারে। (হিন্ট: LEFT JOIN ব্যবহার করো এবং WHERE 
-- ক্লজে চেক করো অর্ডারের কোনো কলাম IS NULL কিনা)।

SELECT * FROM practice_db.CUSTOMERS;
SELECT * FROM practice_db.ORDERS;

SELECT 
C.CUSTOMER_ID,C.CUSTOMER_NAME
FROM 
practice_db.CUSTOMERS AS C
LEFT JOIN practice_db.ORDERS AS O
ON C.CUSTOMER_ID=O.CUSTOMER_ID
where O.customer_id IS NULL;


INSERT INTO practice_db.transactions VALUES 
(1, 101, 'Shopping', 5000, '2026-06-01'),
(2, 102, 'Groceries', 1200, '2026-06-01'),
(3, 101, 'Dining', 2500, '2026-06-02'),
(4, 103, 'Shopping', 12000, '2026-06-02'),
(5, 102, 'Dining', 1800, '2026-06-03'),
(6, 104, 'Groceries', 900, '2026-06-03');

select * from practice_db.transactions;


-- প্রবলেম ১: (রিস্ক ম্যানেজমেন্ট টিমের রিকোয়েস্ট) - Scalar Subquery
-- "আমাদের প্ল্যাটফর্মের সামগ্রিক গড় লেনদেনের পরিমাণ (Average Transaction Amount) কত আগে তা বের করুন। 
-- তারপর যেসব ট্রানজেকশন ওই গড়ের চেয়ে বেশি হয়েছে, শুধু সেগুলোর তালিকা দিন (হাই-ভ্যালু ট্রানজেকশন অ্যালার্ট)।"
-- ভুল পদ্ধতি: তুমি সরাসরি WHERE amount > AVG(amount) লিখতে পারবে না, কারণ এসকিউএলে WHERE ক্লজের ভেতর এগ্রিগেশন 
-- ফাংশন সরাসরি কাজ করে না।
-- সঠিক পদ্ধতি: আগে সাবকোয়েরি দিয়ে গড় মান বের করব, তারপর বাইরের কোয়েরিতে তা তুলনা করব।
SELECT transaction_id,user_id,category,amount,tx_date FROM practice_db.transactions where amount >
(SELECT avg(amount)
FROM practice_db.transactions);

-- প্রবলেম ২: (মার্কেটিং টিমের রিকোয়েস্ট) - Correlated Subquery
-- "প্রতিটি ক্যাটাগরির নিজস্ব যে গড় (Average) লেনদেন, তার চেয়ে বেশি খরচ করা ট্রানজেকশনগুলো বের করে দিন।"
-- লজিক: এখানে সাধারণ সাবকোয়েরি কাজ করবে না। ডাটাবেস যখন বাইরের টেবিলের একটি রো চেক করবে, তখন ভেতরের 
-- কোয়েরিটিকে ঠিক সেই ক্যাটাগরির গড় বের করতে হবে।

SELECT * FROM practice_db.transactions;
SELECT t1.user_id,t1.tx_date,t1.amount from practice_db.transactions t1 where t1.amount>
(SELECT AVG(AMOUNT) FROM practice_db.transactions t2 WHERE t2.category = t1.category);

-- টাস্ক (বিজনেস অ্যানালিস্ট রিকোয়েস্ট): আমাদের প্ল্যাটফর্মে সর্বোচ্চ লেনদেন (Maximum Transaction Amount) যিনি করেছেন, 
-- তার user_id, category এবং amount কত? (হিন্ট: সাবকোয়েরি ব্যবহার করে প্রথমে MAX(amount) বের করো, তারপর মূল 
-- টেবিলে ফিল্টার করো)।

SELECT * FROM practice_db.transactions;
SELECT user_id,category,amount from practice_db.transactions t2 where amount=
(SELECT MAX(AMOUNT) FROM practice_db.transactions);

select user_id,category,amount, MAX(AMOUNT) AS MAX_TRANS FROM practice_db.transactions;

-- "প্রথমে আমাদের প্রতিটি ইউজারের মোট খরচের পরিমাণ (Total Expense) হিসাব করুন। তারপর সেই হিসাব থেকে যেসব 
-- ইউজারের মোট খরচ ৫০০০ টাকার বেশি, তাদের ইউজার আইডি এবং মোট খরচ সুন্দর করে দেখান।"

SELECT * FROM practice_db.transactions;

-- Using Subquery
SELECT * from(
select user_id,sum(amount) as Total_Expense from practice_db.transactions group by user_id) as USER_SUMMARY WHERE Total_Expense>5000

-- Using CTE
WITH user_expense_summary AS (
    SELECT 
        user_id, 
        SUM(amount) AS total_expense
    FROM practice_db.transactions
    GROUP BY user_id
)
SELECT user_id,total_expense from user_expense_summary where total_expense>5000;

--  টাস্ক (অপারেশনস টিমের রিকোয়েস্ট): > ১. প্রথমে একটি CTE তৈরি করো যার নাম দেবে category_stats। 
--  এই CTE-তে প্রতিটি ক্যাটাগরির (category) গড় লেনদেন (Average Amount) হিসাব করা থাকবে।
-- ২. এরপর মূল কোয়েরিতে এই category_stats টেবিল থেকে শুধু সেই ক্যাটাগরিগুলো ফিল্টার করে বের করো 
--  যাদের গড় লেনদেন ৩০০০ টাকার কম।

WITH category_stats as (
SELECT category,avg(amount) as Average_Amount FROM practice_db.transactions group by category
)
SELECT * FROM category_stats where Average_Amount < 3000  
SELECT * FROM practice_db.transactions;
SELECT category,avg(amount) FROM practice_db.transactions group by category


-- Windows function
-- Syntex
-- FUNCTION_NAME() OVER (PARTITION BY কলাম_১ ORDER BY কলাম_২)
SELECT 
    transaction_id,
    user_id,
    category,
    amount,
    ROW_NUMBER() OVER (PARTITION BY category ORDER BY amount DESC) AS row_num,
    RANK() OVER (PARTITION BY category ORDER BY amount DESC) AS rnk,
    DENSE_RANK() OVER (PARTITION BY category ORDER BY amount DESC) AS dense_rnk
FROM practice_db.transactions;

--প্রবলেম ২: (ফ্রড ডিটেকশন টিমের রিকোয়েস্ট) - LAG()
-- "প্রতিটি ইউজারের ক্ষেত্রে, তিনি কারেন্ট যে ট্রানজেকশনটি করছেন, তার ঠিক আগের ট্রানজেকশনের 
-- অ্যামাউন্ট (Previous Amount) কত ছিল তা পাশাপাশি কলামে দেখতে চাই।"
-- অ্যাপ্লিকেশন: আগের রোর ডাটা কারেন্ট রোতে টেনে আনার জন্য আমরা ব্যবহার করব LAG()।
Select
    transaction_id,
    user_id,
    tx_date,
    amount,
LAG(amount, 1) OVER (PARTITION BY user_id ORDER BY tx_date) AS previous_amount
FROM practice_db.transactions;

-- আমাদের একটি টেবিল আছে যেখানে কর্মচারীদের বেতন আছে। আমরা সবার বেতনের পাশে আমাদের কোম্পানির 
-- গড় বেতন (Average Salary) কত, তাও দেখতে চাই:

-- chatgpt problems and solution

INSERT INTO practice_db.employee (id, name, department, salary, city) VALUES
(1, 'Rahim', 'IT', 60000, 'Dhaka'),
(2, 'Karim', 'HR', 45000, 'Chattogram'),
(3, 'Ayesha', 'Finance', 70000, 'Dhaka'),
(4, 'Nusrat', 'IT', 55000, 'Sylhet'),
(5, 'Sakib', 'Marketing', 50000, 'Dhaka'),
(6, 'Anika', 'HR', 65000, 'Khulna'),
(7, 'Rifat', 'IT', 80000, 'Dhaka'),
(8, 'Mim', 'Finance', 40000, 'Chattogram'),
(9, 'Tanvir', 'Marketing', 55000, 'Rajshahi'),
(10, 'Farhana', 'IT', 75000, 'Dhaka');

SELECT * FROM practice_db.employee;
/**
Day 1 (SELECT, WHERE, ORDER BY, LIMIT)
Problem 1
সব Employee দেখাও।

Problem 2
শুধু Employee-এর নাম দেখাও।

Problem 3
Salary 60000-এর বেশি এমন Employee দেখাও।

Problem 4
Dhaka শহরের Employee দেখাও।

Problem 5
সব Employee Salary অনুযায়ী ছোট থেকে বড় ক্রমে সাজাও।

Problem 6
সব Employee Salary অনুযায়ী বড় থেকে ছোট ক্রমে সাজাও।

Problem 7
শুধু প্রথম ৩ জন Employee দেখাও।

Problem 8
IT Department-এর Employee দেখাও।

Problem 9
Salary 50000 বা তার বেশি এমন Employee দেখাও।

Problem 10
শুধু name এবং salary দেখাও।
**/
-- Problem 7
-- শুধু প্রথম ৩ জন Employee দেখাও।
SELECT * FROM practice_db.employee limit 3;

/**
Day 2 (AND, OR, NOT, IN, BETWEEN, LIKE)
Problem 1
IT Department এবং Salary 60000-এর বেশি এমন Employee দেখাও।

Problem 2
HR অথবা Finance Department-এর Employee দেখাও।

Problem 3
HR Department বাদে সব Employee দেখাও।

Problem 4
Salary 50000 থেকে 70000-এর মধ্যে এমন Employee দেখাও।

Problem 5
যাদের নাম A দিয়ে শুরু তাদের দেখাও।

Problem 6
যাদের নাম a দিয়ে শেষ তাদের দেখাও।

Problem 7
Dhaka অথবা Chattogram-এর Employee দেখাও।

Problem 8
IT, HR, Finance Department-এর Employee দেখাও।

Problem 9
Salary 55000-এর বেশি এবং Dhaka-তে থাকে এমন Employee দেখাও।

Problem 10
যাদের নামের মধ্যে "ra" আছে তাদের দেখাও।
**/

--Problem 2
--HR অথবা Finance Department-এর Employee দেখাও।
SELECT * FROM practice_db.employee where department='HR' or department='Finance';
select * from practice_db.employee;

-- Problem 3
-- HR Department বাদে সব Employee দেখাও।
SELECT * FROM practice_db.employee where department!='HR';

/**
Problem 4
Salary 50000 থেকে 70000-এর মধ্যে এমন Employee দেখাও।
**/
SELECT * FROM practice_db.employee where salary BETWEEN 50000 AND 70000;
-- Problem 5
-- যাদের নাম A দিয়ে শুরু তাদের দেখাও।
SELECT * FROM practice_db.employee where name LIKE 'A%';
-- Problem 6
-- যাদের নাম a দিয়ে শেষ তাদের দেখাও।
SELECT * FROM practice_db.employee where name LIKE '%a';
-- Problem 7
-- Dhaka অথবা Chattogram-এর Employee দেখাও।
SELECT * FROM practice_db.employee where city='Dhaka' OR city='Chattogram';

/**
Problem 9
Salary 55000-এর বেশি এবং Dhaka-তে থাকে এমন Employee দেখাও।*/
SELECT * FROM practice_db.employee where city='Dhaka' and (salary::int)>55000;
/*Problem 10
যাদের নামের মধ্যে "ra" আছে তাদের দেখাও। **/
SELECT * FROM practice_db.employee where salary>'55000' and city='Dhaka';
SELECT * FROM practice_db.employee where name='%ra%';

-- Day 3 (COUNT, SUM, AVG, MIN, MAX)
/*Problem 1
মোট কতজন Employee আছে? */
SELECT * FROM practice_db.employee;
SELECT count(name) FROM practice_db.employee;
/*Problem 2
সব Employee-এর মোট Salary কত?*/
SELECT * FROM practice_db.employee;
SELECT sum(salary::INT) FROM practice_db.employee;

/*Problem 3
গড় Salary কত? */
SELECT * FROM practice_db.employee;
SELECT avg(salary::int) from practice_db.employee;

/* Problem 4
সবচেয়ে বেশি Salary কত?*/
SELECT * FROM practice_db.employee;
SELECT MAX(salary::int) from practice_db.employee;
/* Problem 5
সবচেয়ে কম Salary কত? */
SELECT * FROM practice_db.employee;
SELECT MIN(salary::int) from practice_db.employee;
/* Problem 6
IT Department-এ কতজন Employee আছে?*/
SELECT * FROM practice_db.employee;
SELECT COUNT(name) from practice_db.employee;

/* Problem 7
HR Department-এর মোট Salary কত?*/
SELECT * FROM practice_db.employee;
SELECT COUNT(name) from practice_db.employee where department='HR';
/* Problem 8
Finance Department-এর Average Salary কত? */ 
SELECT * FROM practice_db.employee;
SELECT AVG(SALARY::INT) from practice_db.employee where department='Finance';
/* Problem 9
Dhaka শহরে কতজন Employee আছে?*/
SELECT * FROM practice_db.employee;
SELECT count(name) from practice_db.employee where city='Dhaka';

/*Problem 10
Marketing Department-এর সর্বোচ্চ Salary কত?*/
SELECT * FROM practice_db.employee;
SELECT MAX(salary::int) FROM practice_db.employee where department='Marketing';

/* Day 4 (GROUP BY, HAVING)
Problem 1
Department অনুযায়ী Employee সংখ্যা দেখাও। */
SELECT * FROM practice_db.employee;
SELECT COUNT(DEPARTMENT),Department FROM practice_db.employee GROUP BY DEPARTMENT;
/*Problem 2
Department অনুযায়ী Average Salary দেখাও।*/
SELECT AVG(SALARY::INT),Department FROM practice_db.employee GROUP BY DEPARTMENT;
/*Problem 3
Department অনুযায়ী মোট Salary দেখাও।*/
SELECT SUM(SALARY::INT),Department FROM practice_db.employee GROUP BY DEPARTMENT;
/* Problem 4
City অনুযায়ী Employee সংখ্যা দেখাও।*/
SELECT * FROM practice_db.employee;
SELECT COUNT(NAME),CITY FROM practice_db.employee GROUP BY CITY;
/*Problem 5
City অনুযায়ী Average Salary দেখাও।*/
SELECT COUNT(NAME),CITY FROM practice_db.employee GROUP BY CITY;
/* Problem 6
যেসব Department-এ ২ জনের বেশি Employee আছে সেগুলো দেখাও। */
SELECT * FROM practice_db.employee;
SELECT COUNT(NAME) as Total_number,department FROM practice_db.employee GROUP BY department HAVING count(name)>2;
/*Problem 7
যেসব Department-এর Average Salary 60000-এর বেশি সেগুলো দেখাও।*/
SELECT * FROM practice_db.employee;
SELECT AVG(SALARY::INT),department FROM practice_db.employee GROUP BY department having AVG(SALARY::INT)>60000 ;
/*Problem 8
যেসব City-তে কমপক্ষে ২ জন Employee আছে সেগুলো দেখাও।*/
SELECT * FROM practice_db.employee;
SELECT COUNT(NAME),CITY FROM practice_db.employee GROUP BY CITY HAVING COUNT(NAME)>=2;
/*Problem 9
Department অনুযায়ী সর্বোচ্চ Salary দেখাও।*/
SELECT * FROM practice_db.employee;
SELECT MAX(SALARY::INT) AS Max_salary,department FROM practice_db.employee GROUP BY department;
/* Problem 10
Department অনুযায়ী সর্বনিম্ন Salary দেখাও।*/
SELECT * FROM practice_db.departments;
SELECT Min(SALARY::INT) AS Max_salary,department FROM practice_db.employee GROUP BY department;


/*Problem 1
Employee নাম এবং Manager নাম দেখাও। */
SELECT * FROM practice_db.employee;
SELECT * FROM practice_db.departments;
select e.name,d.manager from practice_db.employee e join practice_db.departments d on e.department=d.dept_name;

/*Problem 2
সব IT Employee এবং তাদের Manager দেখাও। */
select e.name,d.manager from practice_db.employee e join practice_db.departments d on e.department=d.dept_name where e.department='IT'
/*Problem 3
Employee Name, Department, Manager দেখাও।*/
SELECT * FROM practice_db.employee;
SELECT * FROM practice_db.departments;
select e.name,e.department,d.manager from practice_db.employee e join practice_db.departments d on e.department=d.dept_name;

/*Problem 4
Salary 60000-এর বেশি এমন Employee এবং তাদের Manager দেখাও।*/
select e.name,e.department,d.manager from practice_db.employee e join practice_db.departments d on e.department=d.dept_name having (e.salary::int)>60000;

/*
Problem 5
Dhaka-এর Employee এবং তাদের Manager দেখাও।*/
select e.name,e.department,d.manager,e.city from practice_db.employee e join practice_db.departments d on e.department=d.dept_name where e.city='Dhaka';

/*Problem 6
HR Department-এর Employee এবং Manager দেখাও।*/
select e.name,e.department,d.manager,e.city from practice_db.employee e join practice_db.departments d on e.department=d.dept_name where e.department='HR';

/*Problem 7
সব Employee Count Department অনুযায়ী Manager-এর সাথে দেখাও।*/
select count(e.name),e.department,d.manager from practice_db.employee e join practice_db.departments d on e.department=d.dept_name group by e.department,d.manager ;
/*Problem 8
Finance Department-এর Employee Name এবং Manager দেখাও। */
select e.name,d.manager from practice_db.employee e join practice_db.departments d on e.department=d.dept_name WHERE e.department='Finance';

/* Problem 9
সব Employee-এর Name, Salary এবং Manager দেখাও। */
select e.name,e.salary,d.manager from practice_db.employee e join practice_db.departments d on e.department=d.dept_name;

/* Problem 10
যেসব Employee-এর Salary Department Average Salary-এর বেশি তাদের Name দেখাও। (Challenge Problem)
*/
select * from practice_db.departments;
SELECT 
e.name, e.department,e.salary::int
from practice_db.employee e
where e.salary::int >(
SELECT AVG(d.salary::int) 
FROM practice_db.departments d 
where d.dept_name=e.department
);

/* প্রতি Department-এর Highest Salary বের করো।*/
/* এগুলো Day 5-এর পরে চেষ্টা করবেন:*/
/* 2nd Highest Salary বের করো। */
SELECT * FROM practice_db.employee order by salary DESC LIMIT 1 OFFSET 1;
/* 3rd Highest Salary বের করো।*/
SELECT * FROM practice_db.employee order by salary DESC LIMIT 1 OFFSET 2;
/* Duplicate Salary খুঁজে বের করো।*/
/* প্রতি Department-এর Highest Salary বের করো।*/
SELECT DEPARTMENT,MAX(SALARY::int) FROM practice_db.employee GROUP BY DEPARTMENT;
/* প্রতি Department-এর Top Earner বের করো।*/
SELECT department, name, salary::int
FROM practice_db.employee
WHERE (department, salary::int) IN
(SELECT DEPARTMENT,MAX(SALARY::int) FROM practice_db.employee GROUP BY DEPARTMENT);
/* Salary Rank তৈরি করো।*/
/* Dhaka-এর Highest Paid Employee বের করো।*/
select * from practice_db.employee where city='Dhaka' order by salary desc LImit 1;
/* Finance Department-এর 2nd Highest Salary বের করো।*/
select * from practice_db.employee where department='Finance' ORDER BY SALARY desc limit 1 offset 1
/* Average Salary-এর বেশি Salary যাদের আছে তাদের বের করো।*/
select name,department,salary from practice_db.employee where (salary::int)>(select avg(salary::int) from practice_db.employee);
/* Highest Salary এবং Lowest Salary-এর পার্থক্য বের করো।*/
select (MAX(salary::int)-MIN(salary::int)) as Difference_salary from practice_db.employee;

--windows function
--ROW_NUMBER() → সব Row-কে Unique Number দেয়।
--RANK() → Tie হলে একই Rank দেয়, কিন্তু পরের Rank-এ Gap থাকে।
--DENSE_RANK() → Tie হলে একই Rank দেয়, কিন্তু Gap থাকে না।

SELECT 
name,salary,
ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROW_NUM
FROM practice_db.employee;

SELECT 
name,salary,
Rank() OVER(ORDER BY SALARY DESC) AS ROW_NUM
FROM practice_db.employee;

SELECT 
name,salary,
DENSE_Rank() OVER(ORDER BY SALARY DESC) AS ROW_NUM
FROM practice_db.employee;

/*Problem 1
সব Employee-এর Salary Ranking দেখাও ROW_NUMBER() ব্যবহার করে।*/
SELECT name,salary, 
Row_number() OVER(ORDER BY SALARY DESC) AS ROW_NUM from practice_db.employee;

/*Problem 2
সব Employee-এর Salary Ranking দেখাও RANK() ব্যবহার করে।*/
SELECT name,salary,
RANK() OVER(ORDER BY SALARY DESC) AS ROW_NUM FROM practice_db.employee;

/*
Problem 3
সব Employee-এর Salary Ranking দেখাও DENSE_RANK() ব্যবহার করে। */
SELECT 
NAME,SALARY,DENSE_RANK() OVER(ORDER BY SALARY DESC) AS ROW_NUM FROM practice_db.employee;

/*
Problem 4
Highest Paid Employee বের করো ROW_NUMBER() ব্যবহার করে। */
SELECT NAME,SALARY, 
ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROW_NUM FROM practice_db.employee LIMIT 1;

WITH salary_ranking as (
SELECT NAME,SALARY::INT,
 DENSE_RANK() OVER(ORDER BY SALARY::INT DESC) AS rnk
 from practice_db.employee
)
SELECT NAME,SALARY,rnk FROM salary_ranking where rnk=1;

/*
Problem 5
2nd Highest Salary Employee বের করো ROW_NUMBER() ব্যবহার করে।
*/
SELECT NAME,SALARY, 
ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROW_NUM FROM practice_db.employee LIMIT 1 OFFSET 1;

WITH salary_ranking as (
SELECT NAME,SALARY::INT,
 DENSE_RANK() OVER(ORDER BY SALARY::INT DESC) AS rnk
 from practice_db.employee
)
SELECT NAME,SALARY,rnk FROM salary_ranking where rnk=2;

/*
Problem 6
3rd Highest Salary Employee বের করো ROW_NUMBER() ব্যবহার করে।
*/

SELECT NAME,SALARY, 
ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROW_NUM FROM practice_db.employee LIMIT 1 OFFSET 2;

WITH FIND_RANK AS(
SELECT NAME,SALARY,
ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ROW_NUM FROM practice_db.employee
)
SELECT * FROM FIND_RANK where ROW_NUM=2;
/*
Problem 7
প্রতি Department-এর Employee-দের Salary অনুযায়ী Rank দেখাও।
"PARTITION BY department"
*/

SELECT NAME,SALARY,department,
RANK() over(PARTITION BY department) as department_update from practice_db.employee;

/*
Problem 8
প্রতি Department-এর Highest Paid Employee বের করো।
*/

SELECT * FROM practice_db.employee;
WITH FIND_DEPT_HPAID AS (
select name,department,salary,DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY salary::int DESC) AS ROW_NUM from practice_db.employee
)

select * from FIND_DEPT_HPAID WHERE ROW_NUM=1;


/*
Problem 9
প্রতি Department-এর Top 2 Earners বের করো।
*/

WITH FIND_TWO_EARNER AS(
SELECT NAME,DEPARTMENT,SALARY,DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY::INT) AS ROW_NUM FROM practice_db.employee
)
select * from FIND_TWO_EARNER WHERE ROW_NUM<=2;


/*
Problem 10
Finance Department-এর Salary Rank দেখাও।
*/
WITH FIND_FINANCE_DEPT AS(
SELECT NAME,DEPARTMENT,SALARY,RANK() OVER(ORDER BY DEPARTMENT DESC) AS ROW_NUM FROM practice_db.employee
)

select * from FIND_FINANCE_DEPT WHERE DEPARTMENT='Finance';

/*
 Problem 11
 Dhaka City-এর Employee-দের Salary Rank দেখাও।
*/
WITH FIND_FINANCE_DEPT AS(
SELECT NAME,DEPARTMENT,city,SALARY,RANK() OVER(ORDER BY DEPARTMENT DESC) AS ROW_NUM FROM practice_db.employee
)

select * from FIND_FINANCE_DEPT WHERE city='Dhaka';
/*
Problem 12
প্রতি Department-এর Lowest Paid Employee বের করো।
*/
WITH FIND_FINANCE_DEPT AS(
SELECT NAME,DEPARTMENT,SALARY,DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY::INT) AS ROW_NUM FROM practice_db.employee
)

select * from FIND_FINANCE_DEPT WHERE row_num=1;
/*
Problem 13
Marketing Department-এর Highest Paid Employee বের করো।
*/
WITH FIND_FINANCE_DEPT AS(
SELECT NAME,DEPARTMENT,SALARY,DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY::INT) AS ROW_NUM FROM practice_db.employee
)
select * from FIND_FINANCE_DEPT WHERE row_num=1 and department='Marketing';

/*
Problem 14
প্রতি Department-এ কত নম্বর Salary Position-এ আছে তা দেখাও।
(ROW_NUMBER ব্যবহার)
*/
WITH FIND_FINANCE_DEPT AS(
SELECT NAME,DEPARTMENT,SALARY,DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY::INT) AS ROW_NUM FROM practice_db.employee
)
select * from FIND_FINANCE_DEPT;
/*
Problem 15 (Interview Level)
প্রতি Department-এর 2nd Highest Salary Employee বের করো।
*/

WITH FIND_FINANCE_DEPT AS(
SELECT NAME,DEPARTMENT,SALARY,DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY::INT) AS ROW_NUM FROM practice_db.employee
)
select * from FIND_FINANCE_DEPT where row_num=2;

/*
Problem 16
Duplicate Salary আছে কিনা বের করো।
"GROUP BY salary
HAVING COUNT(*) > 1"
*/

/*
Problem 17
Top 3 Highest Salary Employee বের করো।
*/
WITH FIND_FINANCE_DEPT AS(
SELECT NAME,DEPARTMENT,SALARY,DENSE_RANK() OVER(PARTITION BY DEPARTMENT ORDER BY SALARY::INT) AS ROW_NUM FROM practice_db.employee
)
select * from FIND_FINANCE_DEPT where row_num<=3;

/*
Problem 18
Bottom 3 Lowest Salary Employee বের করো।
*/

/*
Problem 19
প্রতি Department-এর Top Earner এবং Lowest Earner এক Query-তে বের করো।
*/

/*
Problem 20 (Data Engineer Interview)
প্রতি Department-এর Salary Difference বের করো।
| department | difference |
| ---------- | ---------- |
| IT         | 25000      |
| HR         | 20000      |

*/

