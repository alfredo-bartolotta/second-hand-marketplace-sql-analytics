**Key Findings**

This project is based on a synthetic second-hand marketplace dataset generated for portfolio and learning purposes. The findings should therefore be interpreted as examples of analytical reasoning rather than as real marketplace conclusions.



**Overview**

The analysis explores marketplace performance across categories, sellers, transactions and user engagement. The main goal is to understand how SQL can be used to answer business-oriented questions related to revenue, transaction volume, selling conversion, pricing behaviour and favorites.

The dataset includes users, categories, listings, transactions and favorites. This structure makes it possible to analyse both supply-side activity, such as listings and sellers, and demand-side activity, such as purchases and user interest.



**Revenue, Average Selling Price and Transaction Volume**

In this synthetic dataset, Shoes is the top category by total revenue. This result is explained by the combination of the highest average selling price and a high number of transactions. Therefore, Shoes performs well from both a value and volume perspective.

Accessories shows a different pattern. Although it has the lowest average selling price among the categories, it records the highest number of transactions. Its strong transaction volume compensates for the lower unit value and allows the category to rank second by total revenue. This distinction highlights why total revenue should not be interpreted alone. A category can generate high revenue either because it sells many lower-priced items or because it sells fewer higher-priced items.



**Selling Conversion Rate**

The selling conversion rate measures the percentage of listings that resulted in a completed sale. Books has the highest selling conversion rate, with 29 sold listings out of 45 total listings, corresponding to approximately 64%. Bags, Shoes and Accessories also show strong conversion rates, all around 60% or above.Clothing has the lowest conversion rate, around 45%, and also the lowest total revenue. This suggests that, within the synthetic dataset, Clothing has weaker category-level sales performance compared to the other categories.



**Discount Behaviour**

The average discount percentage compares the initial listing price with the final selling price. Books has the highest average discount percentage, around 12.07%, followed by Bags and Clothing. Electronics has the lowest average discount percentage, around 7.40%. The relationship between discounts and sales performance should be interpreted carefully. Books combines the highest average discount with the highest conversion rate, which may suggest a possible relationship between stronger discounts and higher selling probability in this generated dataset. 



**User Interest Through Favorites**

Favorites can be interpreted as a proxy for user interest. They show which items attract attention, even if that interest does not always lead to a completed purchase. The most favorited item is Summer skirt from the Clothing category, followed by Leather bag from Bags. Other highly favorited items include Silver necklace, Sport shoes, Watch, Leather boots and Novel book. This result is interesting because Clothing contains the most favorited individual item but has the lowest conversion rate and the lowest total revenue. This suggests that strong interest in a single item does not necessarily translate into strong performance for the entire category. Bags and Shoes show a more balanced pattern, as they include highly favorited items and also perform well in terms of conversion or revenue. Accessories also has multiple items among the most favorited listings and records the highest number of transactions, supporting the idea that this category benefits from strong user activity and sales volume.



**Data Quality and Interpretation Limits**

The analysis includes checks on the consistency of the relational structure, such as the relationship between sold listings and transactions.

Since the dataset is synthetic, the results should not be used to draw real conclusions about second-hand marketplaces. The main purpose of the project is to demonstrate the ability to design and query a relational database, write SQL queries using joins and aggregations, create business metrics and interpret outputs with awareness of data limitations. In a real marketplace setting, additional variables such as item condition, brand, seller reputation, shipping options, listing quality, images, seasonality and user behaviour over time would be needed to draw stronger conclusions.



