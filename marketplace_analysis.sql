/*DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS listings;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    country TEXT NOT NULL,
    registration_date TEXT NOT NULL);

CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY,
    category_name TEXT NOT NULL);

CREATE TABLE listings (
    listing_id INTEGER PRIMARY KEY,
    seller_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    price REAL NOT NULL,
    listing_date TEXT NOT NULL,
    status TEXT NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES users(user_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id));

CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    listing_id INTEGER NOT NULL,
    buyer_id INTEGER NOT NULL,
    transaction_date TEXT NOT NULL,
    final_price REAL NOT NULL,
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id),
    FOREIGN KEY (buyer_id) REFERENCES users(user_id));

CREATE TABLE favorites (
    favorite_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    listing_id INTEGER NOT NULL,
    favorite_date TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id));*/

-- Correct import verification--	
SELECT
    (SELECT COUNT(*) FROM users) AS total_users,
    (SELECT COUNT(*) FROM categories) AS total_categories,
    (SELECT COUNT(*) FROM listings) AS total_listings,
    (SELECT COUNT(*) FROM transactions) AS total_transactions,
    (SELECT COUNT(*) FROM favorites) AS total_favorites;
/*This confirms that all the tables were successfully populated*/
	
-- In case we want to know the number of listings by categorIes--
SELECT COUNT(*) AS NUMBER_OF_LISTINGS, CONCAT(listings.category_id," - ", categories.category_name) AS CATEGORY
FROM listings
INNER JOIN categories
ON LISTINGS.category_id=categories.category_id
GROUP BY CATEGORY
ORDER BY NUMBER_OF_LISTINGS DESC;
/*The N. of listings by category helps identify which product categories have the highest supply in the marketplace
Categories with more listings may indicate stronger seller activity or broader product availability. Since the dataset 
is synthetic, this result should be interpreted as an example of supply-side analysis rather than as a real category trend*/

--Total revenue and average selling price by category--
SELECT SUM(final_price) AS TOTAL_REVENUE, ROUND(AVG (final_price),2) AS AVERAGE_SELLING_PRICE, 
CONCAT(listings.category_id," - ", categories.category_name) AS CATEGORY,
COUNT(transaction_id) AS N_OF_TRANSACTIONS
FROM transactions
INNER JOIN listings
ON listings.listing_id=transactions.listing_id
INNER JOIN categories
ON LISTINGS.category_id=categories.category_id
GROUP BY CATEGORY
ORDER BY TOTAL_REVENUE DESC;
/*Shoes is the top category by total revenue because it combines the highest average selling price with a high number of transactions
This suggests that, in this synthetic dataset, its performance is driven by both value and volume. Accessories shows a different pattern, 
as a matter of fact, although it has the lowest average selling price, it records the highest number of transactions. As a result, its strong
transaction volume compensates for the lower unit value and places the category second in total revenue, ahead of other categories with 
higher average selling prices but fewer transactions*/

--Sellers with more than one completed sale--
SELECT CONCAT(users.user_id," - ", users.name) AS SELLER, COUNT(transactions.transaction_id) AS N_OF_COMPLEATED_SALES
FROM transactions
INNER JOIN listings
ON transactions.listing_id=listings.listing_id
INNER JOIN users
ON listings.seller_id=users.user_id
GROUP BY SELLER
HAVING N_OF_COMPLEATED_SALES>1
ORDER BY N_OF_COMPLEATED_SALES DESC;
/*This query can help distinguish occasional sellers from more active sellers, which could be useful in a real marketplace, since sellers
with multiple completed sales may represent a more engaged segment of users*/

--Active listings that have not been sold yet--
SELECT listings.listing_id, listings.title, categories.category_name, listings.listing_date
FROM listings
JOIN categories
ON listings.category_id=categories.category_id
WHERE status= "active"
ORDER BY listings.listing_date ASC;

--Sold listing with seller and buyer information--
SELECT CONCAT(listings.seller_id, " - ", seller.name) AS SELLER, listings.title AS ITEM, 
CONCAT(transactions.buyer_id, " - ", buyer.name) AS BUYER, 
transactions.transaction_date as TRANSACTION_DATE
FROM transactions
JOIN listings
ON listings.listing_id=transactions.listing_id
JOIN users AS BUYER
ON transactions.buyer_id=BUYER.user_id
JOIN users AS SELLER
ON listings.seller_id=SELLER.user_id
WHERE listings.status="sold"
ORDER BY transaction_date ASC;

--Which categories sell faster?--
SELECT ROUND(AVG(julianday(transactions.transaction_date)-Julianday(listings.listing_date)),2) AS TIME_INTERVAL , 
CONCAT(categories.category_id, " - ", categories.category_name) AS CATEGORY
FROM transactions
JOIN listings
ON transactions.listing_id=listings.listing_id
JOIN categories
ON listings.category_id= categories.category_id
GROUP BY CATEGORY
ORDER BY TIME_INTERVAL ASC;
/*Time interval measures the time between listing creation and completed transaction.
CAtegories with a lower average time-to.sale may indicate stronger demand, better pricing alignment or faster
buyer decision-making. Since the dataset is synthetic, the result should be treated as demostration of how SQL date function can support
marketplace performance analysis*/

--Which categories have the highest average discount (%) between listing price and final sellng price--
SELECT ROUND(AVG( (listings.price - transactions.final_price)* 100/listings.price),2) AS AVERAGE_DISCOUNT_PERCENTAGE, 
CONCAT(categories.category_id, " - ", categories.category_name) AS CATEGORY
FROM transactions
JOIN listings
ON transactions.listing_id=listings.listing_id
JOIN categories
ON listings.category_id=categories.category_id
GROUP BY CATEGORY
ORDER BY AVERAGE_DISCOUNT_PERCENTAGE DESC;
/*The average discount percentage helps understand how much sellers reduce their initial price before completing transaction. the relationship between 
discount and seles performance is not straightforward.Books has both the highest average discount percentage and the highest selling conversion rate 
(calculated below), which may suggest that stronger discounts are associated with a higher probability of sale in this generated dataset
Shoes has a lower average discount than Books and Bags, but it still ranks first in total revenue. This indicates that its performance is not mainly driven
 by discounts, but rather by a strong combination of high average selling price and high transaction volume.*/

--Which items receive high user interest but have not been sold yet?--
SELECT listings.title AS ITEM, COUNT(favorites.favorite_id) AS N_OF_FAVORITES, categories.category_name AS CATEGORY_NAME
FROM listings
JOIN favorites
ON listings.listing_id=favorites.listing_id
JOIN categories
ON categories.category_id=listings.category_id
WHERE listings.status="active"
GROUP BY ITEM, CATEGORY_NAME
HAVING COUNT(favorites.favorite_id)>0
ORDER BY N_OF_FAVORITES DESC
LIMIT 10;
/*Favorites can be interpreted as a proxy for user interest. They help identify which items attract attention, even if that interest 
does not always lead to a completed purchase.In this synthetic dataset, the most favorited item is Summer skirt from the Clothing category, 
followed by Leather bag from Bags. This result is interesting when compared with the sales and revenue analysis. Clothing contains the most 
favorited individual item, but it has the lowest selling conversion rate and the lowest total revenue among the categories. This suggests that 
item-level interest does not automatically imply strong category-level performance*/

--Which categories have the highest selling conversion rate?--
SELECT CONCAT(categories.category_id, " - ", categories.category_name) AS CATEGORY, COUNT (listings.listing_id) AS TOTAL_LISTINGS,
SUM (CASE WHEN listings.status= 'sold' THEN 1 ELSE 0 END) AS SOLD_LISTINGS,
ROUND(SUM (CASE WHEN listings.status= 'sold' THEN 1 ELSE 0 END) * 100/COUNT (listings.listing_id) ,2) AS SELLING_CONVERSION_RATE
FROM listings
JOIN categories
ON listings.category_id=categories.category_id
GROUP BY CATEGORY
ORDER BY SELLING_CONVERSION_RATE DESC;
/*Selling conversion rate measures the percentage of listings that resulted in a compleated sale within each category. This metric is useful because a category with many listings
os not necessarily the best performing one if a large share of those listings remains unsold*/

-- Are there transactions linked to listings that are not marked as sold (quality check)--
SELECT transactions.transaction_id,transactions.transaction_date, listings.title, listings.status
FROM transactions
JOIN listings
ON listings.listing_id=transactions.listing_id
WHERE listings.status !='sold';


