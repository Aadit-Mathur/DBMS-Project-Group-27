import os
import random
from datetime import date, timedelta

import psycopg2
from dotenv import load_dotenv


# ============================================================
# DBMS PROJECT - INITIAL MASTER DATA SEED
#
# Populates:
#   CUSTOMER  -> 600 rows
#   SELLER    -> 200 rows
#   CATEGORY  -> 18 rows
#
# IMPORTANT:
#   This script does NOT truncate existing data.
#   If you want IDs to restart from 1, truncate/restart the
#   relevant tables yourself before running this script.
#
# Reads DATABASE_URL from .env
# ============================================================

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    raise RuntimeError("DATABASE_URL is not set in .env")


# ============================================================
# CUSTOMER NAME DATA
#
# 300 first names, each used exactly twice.
# Therefore, among 600 customers, no first name appears
# more than twice.
#
# Names are shuffled using a fixed seed, so the result is
# reproducible without being alphabetical.
# ============================================================

FIRST_NAMES = [
    "Abeer",
    "Aditi",
    "Akhil",
    "Amol",
    "Anand",
    "Anaya",
    "Anirban",
    "Anshul",
    "Apoorva",
    "Aravind",
    "Archana",
    "Arjun",
    "Arushi",
    "Asif",
    "Asmita",
    "Atharv",
    "Avinash",
    "Ayesha",
    "Bakul",
    "Balram",
    "Bela",
    "Bhakti",
    "Bharat",
    "Bhumika",
    "Binal",
    "Bipin",
    "Brijesh",
    "Chaitanya",
    "Chandni",
    "Chinmay",
    "Darpan",
    "Darshana",
    "Deepti",
    "Devendra",
    "Dhanvi",
    "Dilip",
    "Esha",
    "Falguni",
    "Firoz",
    "Geeta",
    "Girish",
    "Gitanjali",
    "Govind",
    "Hardeep",
    "Harleen",
    "Hemant",
    "Hiral",
    "Hrithik",
    "Ishwar",
    "Jagdish",
    "Janvi",
    "Jaspreet",
    "Jignesh",
    "Jyoti",
    "Kamal",
    "Kanchan",
    "Kartik",
    "Kavisha",
    "Kavita",
    "Keerthi",
    "Khyati",
    "Krish",
    "Kunal",
    "Lalit",
    "Leena",
    "Lisha",
    "Lokesh",
    "Madhav",
    "Mahima",
    "Malav",
    "Manisha",
    "Mansi",
    "Meghna",
    "Mukul",
    "Namita",
    "Naveena",
    "Neeraj",
    "Niharika",
    "Nilesh",
    "Nivedita",
    "Om",
    "Padmini",
    "Palak",
    "Pari",
    "Pawan",
    "Prachi",
    "Pradeep",
    "Prisha",
    "Rachna",
    "Raghav",
    "Rajat",
    "Ranjit",
    "Rashi",
    "Renu",
    "Ritesh",
    "Rupal",
    "Sachin",
    "Saloni",
    "Samarth",
    "Sandeep",
    "Sanjana",
    "Saransh",
    "Shankar",
    "Shikha",
    "Shilpa",
    "Shreyas",
    "Shrikant",
    "Siddhant",
    "Sonal",
    "Soumya",
    "Srinivas",
    "Subodh",
    "Sudarshan",
    "Suhas",
    "Sunita",
    "Surabhi",
    "Tarun",
    "Tina",
    "Vaishnavi",
    "Vandana",
    "Varad",
    "Vasudha",
    "Veer",
    "Vibhor",
    "Vijaya",
    "Vikrant",
    "Vimal",
    "Vinod",
    "Vivek",
    "Yamini",
    "Yogesh",
    "Zubin",
    "Abhishek",
    "Akshara",
    "Alka",
    "Amar",
    "Ambika",
    "Anamika",
    "Ananya",
    "Ankur",
    "Anup",
    "Anupama",
    "Aparna",
    "Archit",
    "Arvind",
    "Asha",
    "Ashok",
    "Astha",
    "Athira",
    "Atul",
    "Avantika",
    "Badri",
    "Bala",
    "Balaji",
    "Bani",
    "Beena",
    "Bhaskar",
    "Bhavana",
    "Bhavani",
    "Binod",
    "Boby",
    "Brij",
    "Chandan",
    "Chandrika",
    "Charan",
    "Chaya",
    "Chetna",
    "Chiranjit",
    "Chitra",
    "Danish",
    "Darsh",
    "Dayanand",
    "Deepali",
    "Deepika",
    "Devesh",
    "Dhananjay",
    "Dheeraj",
    "Diksha",
    "Dinesh",
    "Dipak",
    "Dipti",
    "Durga",
    "Eklavya",
    "Elina",
    "Fahad",
    "Faisal",
    "Farida",
    "Fardeen",
    "Gagan",
    "Garima",
    "Gautam",
    "Gauri",
    "Gopal",
    "Gopi",
    "Gowtham",
    "Hafiz",
    "Hari",
    "Harpreet",
    "Harshad",
    "Heena",
    "Hemal",
    "Himanshu",
    "Hina",
    "Hitesh",
    "Inder",
    "Jai",
    "Jasleen",
    "Jatin",
    "Jayant",
    "Jeevan",
    "Kailash",
    "Kalpana",
    "Kamini",
    "Kanishk",
    "Karan",
    "Karishma",
    "Kartikeya",
    "Kaushal",
    "Kavitha",
    "Kedar",
    "Kiran",
    "Kishore",
    "Kriti",
    "Krupal",
    "Kusum",
    "Laxman",
    "Leela",
    "Leher",
    "Lohit",
    "Madhuri",
    "Mahendra",
    "Maithili",
    "Mala",
    "Malavika",
    "Manas",
    "Mandar",
    "Manoj",
    "Maya",
    "Mayank",
    "Megha",
    "Menaka",
    "Mohan",
    "Monika",
    "Muskan",
    "Nandita",
    "Narendra",
    "Nargis",
    "Nayan",
    "Neelam",
    "Nidhi",
    "Nikhita",
    "Nimisha",
    "Niranjan",
    "Nirmal",
    "Onkar",
    "Padma",
    "Parag",
    "Parul",
    "Pasha",
    "Pavan",
    "Payal",
    "Pragya",
    "Prakash",
    "Pranita",
    "Prasad",
    "Prerna",
    "Purva",
    "Pushkar",
    "Rachit",
    "Radha",
    "Radhika",
    "Raghu",
    "Ragini",
    "Rajendra",
    "Rajesh",
    "Raksha",
    "Ram",
    "Ramesh",
    "Ramya",
    "Ranjana",
    "Rashid",
    "Ratna",
    "Ravindra",
    "Renuka",
    "Richa",
    "Riddhima",
    "Ritu",
    "Rohini",
    "Ronak",
    "Roshan",
    "Rupesh",
    "Sadhana",
    "Sagar",
    "Saksham",
    "Samar",
    "Sameera",
    "Sandhya",
    "Sanjiv",
    "Sanket",
    "Sarita",
    "Satish",
    "Sejal",
    "Shailendra",
    "Shalini",
    "Shantanu",
    "Sharad",
    "Sharda",
    "Shefali",
    "Shivendra",
    "Shivani",
    "Shreeram",
    "Shubhi",
    "Shweta",
    "Smita",
    "Snehal",
    "Sohini",
    "Sonam",
    "Sowmya",
    "Sruthi",
    "Subhash",
    "Suchitra",
    "Sudha",
    "Sudhanshu",
    "Sudip",
    "Supriya",
    "Surendra",
    "Sushant",
    "Swara",
    "Swati",
    "Tanuja",
    "Tejal",
    "Tejaswini",
    "Umesh",
    "Upasana",
    "Urvashi",
    "Vaishali",
    "Vallari",
    "Vamsi",
    "Varun",
    "Vasavi",
    "Vatsal",
    "Vidya",
    "Vijay",
    "Vineeta",
    "Vishakha",
    "Vishwas",
    "Vrinda",
    "Yogita",
    "Zeenat",
]

LAST_NAMES = [
    "Agarwal", "Ahluwalia", "Bansal", "Batra", "Bedi", "Bhatt",
    "Bhat", "Bhattacharya", "Bhowmik", "Bose", "Chakraborty",
    "Chandra", "Chatterjee", "Chauhan", "Chopra", "Das", "Datta",
    "Desai", "Deshmukh", "Dey", "Dixit", "Dubey", "Dutta",
    "Gandhi", "Garg", "Ghosh", "Gokhale", "Goel", "Goswami",
    "Gupta", "Iyer", "Jain", "Jaiswal", "Joshi", "Kamat",
    "Kapoor", "Kashyap", "Kaur", "Khan", "Khanna", "Kohli",
    "Kulkarni", "Kumar", "Lal", "Mahajan", "Malhotra", "Mandal",
    "Mehta", "Menon", "Mishra", "Mukherjee", "Murthy", "Nair",
    "Nanda", "Narang", "Naik", "Nath", "Nayak", "Nayyar",
    "Pande", "Pandey", "Parikh", "Patel", "Pawar", "Pillai",
    "Prasad", "Qureshi", "Raghavan", "Raghavendra", "Rai", "Rajan",
    "Rao", "Rastogi", "Rathore", "Reddy", "Roy", "Saha",
    "Saini", "Saxena", "Sen", "Shah", "Sharma", "Shetty",
    "Shukla", "Sinha", "Singh", "Sodhi", "Soni", "Srivastava",
    "Subramanian", "Sundaram", "Tandon", "Thakur", "Thomas",
    "Tripathi", "Trivedi", "Varma", "Verma", "Venkatesh", "Yadav",
    "Acharya", "Adhikari", "Banerjee", "Barua", "Basu", "Bhatia",
    "Bisht", "Borkar", "Choudhary", "D'Souza", "Fernandes", "Ganguly",
    "Hegde", "Jadhav", "Kadam", "Kar", "Khatri", "Konduri",
    "Krishnan", "Lohia", "Madhavan", "Mahato", "Manna", "Mishra",
    "Modi", "Mohan", "Naidu", "Nambiar", "Pandit", "Purohit",
    "Rana", "Rawat", "Reddy", "Sarkar", "Sawant", "Shinde",
    "Solanki", "Talwar", "Upadhyay", "Vaidya", "Vasudevan", "Wagh",
]


# ============================================================
# 200 INDIVIDUAL SELLER NAMES
#
# These are deliberately heterogeneous rather than generated
# from a small prefix/suffix formula.
# ============================================================

SELLER_NAMES = [
    "Nexora Electronics", "Saffron Homeware", "Deccan Digital Store",
    "Kaveri Lifestyle", "MangoTree Books", "BlueKite Technologies",
    "Jaipur Craft House", "Coastal Kitchenware", "Indus Outdoor Supply",
    "Lotus Living", "Mitra Fashion Studio", "Malabar Essentials",
    "Eastern Valley Traders", "Urban Loom", "Veda Wellness",
    "Konkan Auto Mart", "Pioneer Office Solutions", "Chennai Computer Depot",
    "Himalayan Travel Gear", "Prakruti Organics", "Bengaluru Gadget Works",
    "Rajputana Handicrafts", "Godavari Home Store", "Nilgiri Naturals",
    "Surat Textile House", "Pune Tech Bazaar", "Varanasi Heritage",
    "Kerala Kitchen", "Mumbai Mobile Hub", "Delhi Daily Mart",
    "Hyderabad Homeware", "Kolkata Book Corner", "Ahmedabad Appliance Centre",
    "Lucknow Lifestyle", "Indore Sports World", "Nagpur Auto Accessories",
    "Coimbatore Kitchen Mart", "Mysuru Furnishings", "Patna Stationery Hub",
    "Bhubaneswar Craft Collective", "Guwahati Outdoor Store",
    "Chandigarh Living", "Jaipur Jewel Box", "Amritsar Apparel House",
    "Kochi Travel Store", "Visakhapatnam Electronics", "Nashik Fresh Basket",
    "Bhopal Office Mart", "Vadodara Home Essentials", "Ranchi Fitness Depot",
    "Thanjavur Art House", "Udaipur Decor Studio", "Jodhpur Leather Works",
    "Kota Study Store", "Mangalore Coastal Goods", "Vijayawada Value Mart",
    "Madurai Textile Works", "Dehradun Adventure Shop",
    "Srinagar Artisan Collective", "Raipur Retail Hub", "Kanpur Footwear House",
    "Agra Craft Bazaar", "Meerut Sports Supply", "Rajkot Machine Mart",
    "Jalandhar Sports Depot", "Noida Smart Living", "Gurugram Gadget Garage",
    "Faridabad Home Centre", "Ghaziabad Retail Works",
    "Thiruvananthapuram Green Store", "Thrissur Kitchen Studio",
    "Salem Appliance House", "Tiruchirappalli Book Depot",
    "Belagavi Bazaar", "Hubballi Hardware House", "Vellore Tech Point",
    "Warangal Daily Needs", "Amravati General Store", "Aurangabad Lifestyle",
    "Kolhapur Kitchen Works", "Solapur Textile Mart", "Durg Auto House",
    "Jamshedpur Industrial Supply", "Siliguri Travel Goods",
    "Asansol Home Market", "Dhanbad Electronics Point",
    "Cuttack Stationery World", "Puri Coastal Crafts", "Shillong Mountain Goods",
    "Imphal Heritage Store", "Panaji Beachside Retail",
    "Pondicherry Lifestyle Studio", "NCR Tech Traders", "Bharat Bazaar",
    "Shree Ganesh Enterprises", "Lakshmi Trading House", "Sai Krupa Retailers",
    "Omkar Business Solutions", "Aarav Ventures", "Ananya Collections",
    "Astitva Creations", "Aavartan Retail", "Abhivyakti Arts",
    "Ananta Marketplace", "Aranya Naturals", "Avani Enterprises",
    "BharatMart", "Cauvery Traders", "Dharohar India", "Evergreen Retail",
    "Ganga Enterprises", "Golden Peacock Crafts", "Heritage Lane",
    "Indus Mercantile", "Kaveri Traders", "Krishna Retail",
    "Maa Durga Enterprises", "Narmada Marketplace", "Panchvati Stores",
    "Pragati Retail Works", "Rajdhani Traders", "Sahyadri Goods",
    "Saraswati Book House", "Shree Balaji Traders", "Surya Enterprises",
    "Vishwakarma Tools & Supply", "Tulsi Home Store", "Peacock Avenue",
    "Monsoon Marketplace", "Terracotta Trails", "Spice Route Retail",
    "Coconut Grove Goods", "Banyan Tree Living", "Marigold Collections",
    "Neem & Co.", "Chai & Craft", "Desi Pantry", "The Indian Basket",
    "Crafted in Bharat", "Made in India Store", "Everyday Essentials",
    "ValueKart India", "Prime Choice Retail", "SmartBuy Junction",
    "QuickCart Enterprises", "MarketSquare India", "ShopNest Retail",
    "DailyBasket Traders", "ChoicePoint Marketplace", "HomeHive India",
    "StyleStreet Retail", "GadgetGrid", "TechTrove India",
    "MobileMania Store", "Pixel & Parts", "Circuit House India",
    "Computer Corner", "Laptop Lounge", "Kitchen Canvas",
    "Cookware Collective", "HomeChef Depot", "Furniture Foundry",
    "The Living Room Store", "UrbanNest Furnishings", "FitNation India",
    "PlayZone Bazaar", "Book World India", "RoadReady Auto",
    "DriveMate Accessories", "TravelTrail India", "PetPal Supplies",
    "Glow & Groom", "OfficeOrbit", "SchoolBag Central",
    "Little Explorers Store", "SportSphere India", "Footprint Footwear",
    "SoleStory", "Thread & Trend", "Cotton Route", "Ethnic Edit",
    "Modern Muse Apparel", "Beauty Basket India", "Wellness Window",
    "FreshField Grocers", "Farm2Shelf Market", "PureHarvest Foods",
    "NatureNest Organics", "GreenLeaf Marketplace", "Earth & Earthy",
    "Sundar Handicrafts", "Kala Kendra", "Karigar Collective",
    "Bharat Artisan House", "Rangoli Home Studio", "Kosha Fashion House",
    "Mitti & More", "Aangan Decor", "Dastkari Bazaar", "Riwaayat Collections",
    "Royal Living", "Banjara Crafts", "Virasat India", "Amrut Foods",
    "Spice Garden India", "Desi Harvest", "Millet House India",
    "AyurVeda Essentials", "Sattva Naturals", "GlowNest Beauty",
    "The Wardrobe Co", "Indigo Loom", "WeaveWorks India",
    "Desi Drapes", "Sari Street", "SoleCraft India", "Walkway Footwear",
    "TrailBlaze Sports", "WonderBox Toys", "Readers Republic",
    "OfficeCraft Solutions", "AutoGear India", "RoamReady",
    "PetNest Supplies", "CasaCraft India", "KitchenKart India",
    "Appliance Avenue", "DigitalDukaan", "Gadget Grove",
]


# ============================================================
# CATEGORIES
# ============================================================

CATEGORIES = [
    (
        "Electronics",
        "Consumer electronics including televisions, cameras, audio devices and electronic accessories",
    ),
    (
        "Mobiles & Accessories",
        "Mobile phones, chargers, cases, cables, power banks and related accessories",
    ),
    (
        "Computers & Laptops",
        "Laptops, desktops, monitors, keyboards, mice, storage devices and computer accessories",
    ),
    (
        "Home Appliances",
        "Refrigerators, washing machines, air conditioners, fans and other household appliances",
    ),
    (
        "Kitchen Appliances",
        "Mixers, grinders, microwave ovens, air fryers and other kitchen appliances",
    ),
    (
        "Furniture",
        "Tables, chairs, beds, storage units, desks and other household furniture",
    ),
    (
        "Clothing",
        "Men's, women's and children's clothing and apparel",
    ),
    (
        "Footwear",
        "Shoes, sandals, slippers, sports footwear and other footwear",
    ),
    (
        "Beauty & Personal Care",
        "Skincare, haircare, grooming products and personal care items",
    ),
    (
        "Grocery & Food",
        "Packaged foods, beverages, snacks, staples and household groceries",
    ),
    (
        "Books",
        "Fiction, non-fiction, academic books and educational material",
    ),
    (
        "Stationery & Office Supplies",
        "Notebooks, pens, paper products, office supplies and school supplies",
    ),
    (
        "Sports & Fitness",
        "Sports equipment, fitness accessories and exercise equipment",
    ),
    (
        "Toys & Games",
        "Toys, board games, puzzles and educational games",
    ),
    (
        "Automotive",
        "Automobile accessories, maintenance products, tools and vehicle-related products",
    ),
    (
        "Home & Kitchen",
        "Home decor, cookware, dining products and household furnishings",
    ),
    (
        "Travel & Luggage",
        "Suitcases, backpacks, travel accessories and luggage products",
    ),
    (
        "Pet Supplies",
        "Pet food, grooming products, toys and accessories",
    ),
]


def generate_customers():
    """Generate 600 customers with high first-name diversity."""

    if len(FIRST_NAMES) < 300:
        raise RuntimeError("Need at least 300 first names.")

    if len(LAST_NAMES) < 100:
        raise RuntimeError("Need at least 100 surnames.")

    # Exactly two occurrences of each of the first 300 names.
    names = FIRST_NAMES[:300] * 2

    # Deterministic shuffle: reproducible, but not alphabetical.
    rng = random.Random(271828)
    rng.shuffle(names)

    # Shuffle surnames separately.
    surnames = LAST_NAMES.copy()
    rng.shuffle(surnames)

    customers = []

    for i in range(600):
        first_name = names[i]
        # Spread surname selection rather than using the same surname
        # sequence repeatedly.
        last_name = surnames[(i * 37 + i // 17) % len(surnames)]

        full_name = f"{first_name} {last_name}"

        email = f"customer{i + 1:04d}@example.in"

        # Unique 10-digit Indian mobile-style numbers.
        phone = f"{7000000000 + i:010d}"

        registration_date = date.today() - timedelta(
            days=rng.randrange(0, 1095)
        )

        customers.append(
            (full_name, email, phone, registration_date)
        )

    return customers


def generate_sellers():
    """Return 200 distinct curated Indian marketplace businesses."""

    if len(SELLER_NAMES) < 200:
        raise RuntimeError(
            f"Need at least 200 seller names; found {len(SELLER_NAMES)}."
        )

    # Deterministically shuffle the curated names so the database does not
    # simply contain the first 200 entries from the source list.
    selected = SELLER_NAMES.copy()
    rng = random.Random(314159)
    rng.shuffle(selected)
    selected = selected[:200]

    if len(set(selected)) != 200:
        raise RuntimeError("Seller names are not unique.")

    sellers = []

    for i, name in enumerate(selected):
        email = f"seller{i + 1:04d}@example.in"
        phone = f"{8000000000 + i:010d}"

        registration_date = date.today() - timedelta(
            days=rng.randrange(0, 1095)
        )

        sellers.append(
            (name, email, phone, registration_date)
        )

    return sellers


def validate_customers(customers):
    """Validate diversity and schema-related uniqueness before insertion."""

    if len(customers) != 600:
        raise RuntimeError(f"Expected 600 customers, got {len(customers)}.")

    if len({c[0] for c in customers}) != 600:
        raise RuntimeError("Customer full names are not all unique.")

    if len({c[1] for c in customers}) != 600:
        raise RuntimeError("Customer emails are not all unique.")

    if len({c[2] for c in customers}) != 600:
        raise RuntimeError("Customer phone numbers are not all unique.")

    first_name_counts = {}

    for customer in customers:
        first = customer[0].split()[0]
        first_name_counts[first] = first_name_counts.get(first, 0) + 1

    maximum_repetition = max(first_name_counts.values())

    if maximum_repetition > 2:
        raise RuntimeError(
            f"A first name appears {maximum_repetition} times; maximum allowed is 2."
        )


def validate_sellers(sellers):
    """Validate seller data before insertion."""

    if len(sellers) != 200:
        raise RuntimeError(f"Expected 200 sellers, got {len(sellers)}.")

    if len({s[0] for s in sellers}) != 200:
        raise RuntimeError("Seller names are not all unique.")

    if len({s[1] for s in sellers}) != 200:
        raise RuntimeError("Seller emails are not all unique.")

    if len({s[2] for s in sellers}) != 200:
        raise RuntimeError("Seller phone numbers are not all unique.")


def seed_database():
    customers = generate_customers()
    sellers = generate_sellers()

    validate_customers(customers)
    validate_sellers(sellers)

    conn = None

    try:
        print("Connecting to NeonDB...")
        conn = psycopg2.connect(DATABASE_URL)

        with conn:
            with conn.cursor() as cursor:

                # --------------------------------------------------------
                # Categories
                # --------------------------------------------------------
                cursor.executemany(
                    """
                    INSERT INTO category
                        (category_name, description)
                    VALUES
                        (%s, %s)
                    ON CONFLICT (category_name) DO NOTHING;
                    """,
                    CATEGORIES,
                )

                # --------------------------------------------------------
                # Customers
                # --------------------------------------------------------
                cursor.executemany(
                    """
                    INSERT INTO customer
                        (name, email, phone, registration_date)
                    VALUES
                        (%s, %s, %s, %s)
                    ON CONFLICT (email) DO NOTHING;
                    """,
                    customers,
                )

                # --------------------------------------------------------
                # Sellers
                # --------------------------------------------------------
                cursor.executemany(
                    """
                    INSERT INTO seller
                        (name, email, phone, registration_date)
                    VALUES
                        (%s, %s, %s, %s)
                    ON CONFLICT (email) DO NOTHING;
                    """,
                    sellers,
                )

                # --------------------------------------------------------
                # Database verification
                # --------------------------------------------------------
                cursor.execute("SELECT COUNT(*) FROM customer;")
                customer_count = cursor.fetchone()[0]

                cursor.execute("SELECT COUNT(*) FROM seller;")
                seller_count = cursor.fetchone()[0]

                cursor.execute("SELECT COUNT(*) FROM category;")
                category_count = cursor.fetchone()[0]

                print()
                print("==========================================")
                print("       DATABASE SEED COMPLETE")
                print("==========================================")
                print(f"Customers : {customer_count}")
                print(f"Sellers   : {seller_count}")
                print(f"Categories: {category_count}")
                print("==========================================")

    except Exception:
        if conn:
            conn.rollback()
        raise

    finally:
        if conn:
            conn.close()


if __name__ == "__main__":
    seed_database()
