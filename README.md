**Second-Hand Marketplace SQL Analytics**



**Project Overview**

This project analyses a synthetic second-hand marketplace dataset using SQL.

The goal is to explore how SQL can be used to answer business-oriented questions related to marketplace performance, including revenue, transaction volume, selling conversion rate, seller activity and user engagement.

The dataset was generated with Python for portfolio and learning purposes. Therefore, the findings should be interpreted as examples of analytical reasoning rather than as real marketplace conclusions.



**Dataset**

The project includes five CSV files:

* users.csv: information about users, including user ID, name, country and registration date.
* categories.csv: product categories available in the marketplace.
* listings.csv: items listed by sellers, including price, category, listing date and status.
* transactions.csv: completed sales, including buyer, listing, transaction date and final price.
* favorites.csv: user interactions with listings through favorites.



The dataset is synthetic and does not contain real user or company data.



**Tools Used**

* Python
* SQL
* SQLite
* DB Browser for SQLite
* GitHub



**Files in This Repository**

* generate\_data.py: Python script used to generate the synthetic dataset.
* marketplace\_analysis.sql: SQL script containing table creation logic, import verification queries and analytical queries.
* key\_findings.md: summary of the main analytical observations and interpretation limits.
* users.csv, categories.csv, listings.csv, transactions.csv, favorites.csv: synthetic data files used for the analysis.



**Main Business Questions**

The analysis answers questions such as:

* Which categories generate the highest total revenue?
* Which categories have the highest number of completed transactions?
* How does the average selling price differ across categories?
* Which categories have the strongest selling conversion rate?
* Which sellers completed more than one sale?
* Which listings are still active and unsold?
* Which items received the highest number of favorites?





**SQL Concepts Applied**

The SQL analysis uses:

* SELECT
* WHERE
* INNER JOIN
* GROUP BY
* HAVING
* ORDER BY
* Aggregate functions such as COUNT, SUM, AVG
* Calculated metrics
* Aliases
* Filtering conditions
* Data quality checks



**Key Analytical Insights**

The analysis shows that total revenue is driven by both average selling price and transaction volume. In the synthetic dataset, Shoes ranks first by total revenue because it combines the highest average selling price with a high number of transactions. Accessories shows a different pattern: it has the lowest average selling price but the highest number of transactions, allowing it to rank second by total revenue. The selling conversion rate analysis shows that Books has the highest conversion rate, but this does not automatically translate into the highest total revenue. This highlights the importance of comparing multiple metrics rather than relying on a single indicator. The favorites analysis adds an engagement perspective. For example, Clothing contains the most favorited individual item, but it has the lowest category-level conversion rate and total revenue. This suggests that item-level interest does not necessarily imply strong category-level sales performance.



**Limitations**

This project is based on synthetic data. As a result, the analysis should not be interpreted as evidence of real marketplace trends or user behaviour.

The purpose of the project is to demonstrate the ability to:

* generate and structure synthetic data;
* work with relational tables;
* write SQL queries using joins, filters and aggregations;
* build business-oriented metrics;
* interpret results while considering data limitations.

In a real marketplace setting, additional variables such as item condition, brand, seller reputation, shipping options, listing quality, images, seasonality and user behaviour over time would be needed to draw stronger conclusions.



**How to Use This Project**

1. Open the CSV files to inspect the synthetic dataset.

2\. Open marketplace\_analysis.sql in DB Browser for SQLite or another SQL environment.

3\. Create the tables and import the CSV files.

4\. Run the analysis queries.

5\. Read key\_findings.md for a summary of the main observations.

