# Advanced SQL for Data Engineering 🚀

Welcome to my centralized repository for tracking and showcasing my daily hands-on practice in **Advanced & Intermediate SQL**, specifically tailored for **Data Engineering** pipelines and analytical workflows. 

The goal of this repository is to maintain continuous learning activity, build robust query-writing logic, and practice optimization techniques that are vital for handling large-scale data infrastructures.

---

## 🛠️ Tech Stack & Environment
- **Database Engine:** PostgreSQL
- **Database Administration Tool:** pgAdmin / DBeaver
- **Focus Areas:** Query Optimization, Data Transformation, Analytical Aggregations

---

## 🗺️ Core Concepts Covered So Far

### 1. Intermediate SQL Fundamentals
- **Filtering & Pattern Matching:** Advanced use of `LIKE`, `NOT LIKE`, `BETWEEN`, and Logical Operators.
- **Data Type Management:** Run-time type casting (`::INT`, `CAST()`) to handle type mismatches (e.g., handling string-formatted salaries).
- **Aggregations & Grouping:** Deep understanding of `GROUP BY` and the critical differences between row-level filtering (`WHERE`) and aggregated filtering (`HAVING`).

### 2. SQL Joins & Relational Data
- Combines multi-table datasets (e.g., `employee` and `departments`) using `INNER JOIN`, `LEFT JOIN`, and alias configurations.
- Solving relational business requests (e.g., mapping employees to their respective department managers).

### 3. Advanced Querying & Analytical Logic
- **Subqueries:** Scalar, Multi-row, and Correlated Subqueries to solve complex nested logic (e.g., filtering employees earning above their specific department's average).
- **Common Table Expressions (CTEs):** Constructing clean, readable, and modular virtual tables using the `WITH` clause to replace unreadable nested subqueries.
- **Window Functions:** Computing analytics across partitions while maintaining individual row identities. Mastered functions include:
  - `ROW_NUMBER()`
  - `RANK()`
  - `DENSE_RANK()` (with `PARTITION BY` and `ORDER BY`)
  - Pagination and N-th highest values extraction using `LIMIT` and `OFFSET`.

---

## 📊 Practice Index & Repository Structure

Below is the structured roadmap of the topics practiced along with their core problem sets:

| Day / Module | Topic Focus | Key Problems Solved | Core Syntax / Functions |
| :--- | :--- | :--- | :--- |
| **Week 1 (Day 1-4)** | Core Filtering & Aggregations | Conditional logic filtering, Department-wise metrics | `WHERE`, `GROUP BY`, `HAVING`, `MAX()`, `MIN()`, `AVG()` |
| **Week 1 (Day 5-7)** | Relational Joins | Multi-table joins, Manager-employee mapping | `INNER JOIN`, `LEFT JOIN`, `ON`, Aliases |
| **Week 2 (Day 8-9)** | Subqueries | Advanced filtering, Department averages | Correlated Subqueries, `IN`, `EXISTS` |
| **Week 2 (Day 10-11)**| CTEs (Common Table Expressions) | Code modularity, Virtual temporary layouts | `WITH ... AS (...)` |
| **Week 2 (Day 12-14)**| Window Functions | N-th Highest Salary, Top 2 Earners per Department | `DENSE_RANK()`, `PARTITION BY`, `LIMIT & OFFSET` |
| **Week 4 (Upcoming)**| Database Optimization | Performance Tuning, Indexing structures | `PRIMARY KEY`, `FOREIGN KEY`, `B-Tree Indexes` |

---

## 🎯 How to Use This Repository
- Each directory contains the structural `.sql` scripts mapping to specific problem sets.
- The datasets are localized under the `practice_db` schema.

## 📈 Learning Journey & Connection
I am consistently sharing my "Aha!" moments, technical cheat sheets, and debugging logs on LinkedIn as I transition deeper into Data Engineering. 

Feel free to explore the code, open an issue if you see room for query optimization, or reach out to connect! 

---
*“No matter how many years you spend in tech, there are always too many learnings!”* 💻🚀
