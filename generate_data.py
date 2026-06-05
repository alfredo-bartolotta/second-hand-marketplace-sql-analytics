import csv
import random
from datetime import datetime, timedelta
from pathlib import Path

#create data folder if it doesn't exist
Path("data").mkdir(exist_ok=True)

#List for synthetic data
first_names=["Marco", "Luca", "Alessandro", "Giulia", "Sofia", "Anna",
    "Emma", "Pierre", "Lukas", "Maria", "Elena", "Francesco",
    "Laura", "Matteo", "Camille", "Jan", "Kasia", "Nina", "Giorgia", "Joao",
    "Natalie", "George", "Freddie", "Martina", "Pash"]

last_names= ["Rossi", "Bianchi", "Romano", "Martin", "Nowak", "Schmidt",
    "Garcia", "Dubois", "Kowalski", "Ferrari", "Moretti", "Costa", "Geraci",
    "Mattarella", "Barone", "Helg", "Essian", "Gucci", "Versace"]

countries = ["Italy", "France", "Germany", "Poland", "Spain","Netherlands", 
"Belgium", "Lithuania"]

categories = [(1, "Clothing"),(2, "Shoes"),(3, "Bags"),(4, "Accessories"),
    (5, "Electronics"),(6, "Books")]

product_titles = {
    1: ["Denim jacket", "Black dress", "Vintage shirt", "Wool sweater", "Summer skirt"],
    2: ["White sneakers", "Running shoes", "Leather boots", "Sandals", "Sport shoes"],
    3: ["Leather bag", "Small backpack", "Tote bag", "Crossbody bag", "Travel bag"],
    4: ["Silver necklace", "Gold earrings", "Sunglasses", "Watch", "Scarf"],
    5: ["Wireless headphones", "Phone case", "Smartwatch", "Bluetooth speaker", "Tablet cover"],
    6: ["Novel book", "Business book", "English grammar book", "Data science book", "Travel guide"]}

#function to generate random dates between start_date and end_date
def random_date (start_date, end_date):
	days_between= (end_date - start_date).days
	random_days= random.randint(0, days_between)
	return start_date+timedelta(days=random_days)

#Generate users profile
start_registration=datetime(2020,1,1)
end_registration=datetime(2025,12,31)
users=[]
for user_id in range(1, 101):
    first_name = random.choice(first_names)
    last_name = random.choice(last_names)
    name = first_name + " " + last_name
    country = random.choice(countries)
    registration_date = random_date(start_registration, end_registration).strftime("%Y-%m-%d")
    users.append([user_id,name,country,registration_date])

 #generate listings
listings = []

start_listing = datetime(2024, 1, 1)
end_listing = datetime(2024, 12, 31)

for listing_id in range(1, 301):
    seller_id = random.randint(1, 100)
    category_id = random.randint(1, 6)
    title = random.choice(product_titles[category_id])
    price = round(random.uniform(5, 150), 2)
    listing_date = random_date(start_listing, end_listing)
    status = random.choice(["sold", "sold", "sold", "active", "active"])
    listings.append([listing_id,seller_id,category_id,title,price,listing_date.strftime("%Y-%m-%d"),status])

 #generate transactions
transactions = []
transaction_id = 1

for listing in listings:
    listing_id = listing[0]
    seller_id = listing[1]
    listing_date = datetime.strptime(listing[5], "%Y-%m-%d")
    status = listing[6]
    original_price = listing[4]

    if status == "sold":
        buyer_id = random.randint(1, 100)

        # Make sure buyer and seller are not the same person
        while buyer_id == seller_id:
            buyer_id = random.randint(1, 100)

        transaction_date = listing_date + timedelta(days=random.randint(1, 30))
        final_price = round(original_price * random.uniform(0.80, 1.00), 2)

        transactions.append([
            transaction_id,
            listing_id,
            buyer_id,
            transaction_date.strftime("%Y-%m-%d"),
            final_price])

        transaction_id += 1

#generate favorites
favorites = []

for favorite_id in range(1, 501):
    user_id = random.randint(1, 100)
    listing_id = random.randint(1, 300)
    favorite_date = random_date(start_listing, end_listing).strftime("%Y-%m-%d")

    favorites.append([
        favorite_id,
        user_id,
        listing_id,
        favorite_date])

#Save CVS files
def save_csv(file_name, header, rows):
    "Saves a list of rows into a CSV file"
    with open(file_name, mode="w", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)
        writer.writerow(header)
        writer.writerows(rows)


save_csv("data/users.csv",["user_id", "name", "country", "registration_date"],users)

save_csv("data/categories.csv",["category_id", "category_name"],categories)

save_csv("data/listings.csv",["listing_id", "seller_id", "category_id", "title", "price", "listing_date", "status"],listings)

save_csv("data/transactions.csv",["transaction_id", "listing_id", "buyer_id", "transaction_date", "final_price"],transactions)

save_csv("data/favorites.csv",["favorite_id", "user_id", "listing_id", "favorite_date"],favorites)

print("Synthetic marketplace data generated successfully.")
print("Users:", len(users))
print("Categories:", len(categories))
print("Listings:", len(listings))
print("Transactions:", len(transactions))
print("Favorites:", len(favorites))