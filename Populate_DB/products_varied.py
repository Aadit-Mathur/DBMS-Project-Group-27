import os
import random
from datetime import date, timedelta
from decimal import Decimal

import psycopg2
from psycopg2.extras import execute_values
from dotenv import load_dotenv


# ============================================================
# DBMS PROJECT - PRODUCT SEED
#
# Creates exactly 800 products:
#   - 200 existing sellers
#   - exactly 4 products per seller
#   - products assigned to meaningful categories
#   - category-specific product names, brands, descriptions
#
# IMPORTANT:
#   - Does NOT truncate anything.
#   - Reads existing seller/category IDs from NeonDB.
#   - Does not assume IDs start at 1.
#   - Run after customer/seller/category seeding.
# ============================================================

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
MAPPING_CSV = os.path.join(os.path.dirname(__file__), "seller_category_mapping.csv")

if not DATABASE_URL:
    raise RuntimeError("DATABASE_URL is not set in .env")


# ============================================================
# PRODUCT CATALOG
#
# Each category has:
#   brands       -> category-appropriate brands
#   products     -> 11 or 12 product families
#   variants     -> 4 variants per family
#   base_price   -> approximate Indian retail price
#
# This gives:
#   12 families x 4 variants = 48 products
#   11 families x 4 variants = 44 products
#
# Electronics and Mobiles & Accessories have 48 each.
# The other 16 categories have 44 each.
# Total = 800.
# ============================================================

CATALOG = {
    "Electronics": {
        "brands": ["Auralis", "VistaCore", "Nexon", "Orion", "Zenith"],
        "products": [
            ("43-inch 4K Smart TV", "4K HDR smart television"),
            ("50-inch 4K Smart TV", "4K HDR smart television"),
            ("55-inch QLED TV", "QLED smart television"),
            ("65-inch QLED TV", "QLED smart television"),
            ("Soundbar 2.1 Channel", "wireless home theatre soundbar"),
            ("Bluetooth Party Speaker", "portable high-output Bluetooth speaker"),
            ("True Wireless Earbuds", "wireless in-ear audio earbuds"),
            ("Over-Ear Wireless Headphones", "Bluetooth over-ear headphones"),
            ("Mirrorless Camera", "interchangeable-lens mirrorless camera"),
            ("Action Camera", "compact 4K action camera"),
            ("Wi-Fi 6 Router", "dual-band Wi-Fi 6 wireless router"),
            ("Portable Projector", "Full HD portable LED projector"),
        ],
        "variants": ["Core", "Plus", "Pro", "Max"],
        "base_price": 2499,
        "step": 1700,
    },

    "Mobiles & Accessories": {
        "brands": ["Astra", "MobiOne", "Voltix", "NexCell", "Pixelra"],
        "products": [
            ("5G Smartphone 128GB", "5G smartphone with 128GB storage"),
            ("5G Smartphone 256GB", "5G smartphone with 256GB storage"),
            ("AMOLED Smartphone 256GB", "AMOLED display smartphone"),
            ("Budget 5G Smartphone", "value-oriented 5G smartphone"),
            ("20W USB-C Charger", "compact USB-C fast charger"),
            ("33W GaN Charger", "GaN fast charging adapter"),
            ("65W GaN Charger", "multi-device GaN charger"),
            ("10000mAh Power Bank", "portable USB-C power bank"),
            ("20000mAh Power Bank", "high-capacity USB-C power bank"),
            ("USB-C Braided Cable", "durable USB-C charging cable"),
            ("Wireless Charging Pad", "Qi-compatible wireless charging pad"),
            ("MagSafe-Compatible Stand", "magnetic smartphone charging stand"),
        ],
        "variants": ["Black", "Blue", "Silver", "Graphite"],
        "base_price": 499,
        "step": 700,
    },

    "Computers & Laptops": {
        "brands": ["ByteCraft", "Vertex", "CoreNova", "ZenByte", "TechEdge"],
        "products": [
            ("14-inch Student Laptop", "portable laptop for everyday study and office work"),
            ("15.6-inch Performance Laptop", "performance-oriented Windows laptop"),
            ("15.6-inch Creator Laptop", "laptop designed for creative workloads"),
            ("14-inch Business Laptop", "business-focused lightweight laptop"),
            ("Gaming Laptop", "dedicated-GPU gaming laptop"),
            ("24-inch Full HD Monitor", "Full HD IPS desktop monitor"),
            ("27-inch QHD Monitor", "QHD IPS desktop monitor"),
            ("Mechanical Keyboard", "backlit mechanical desktop keyboard"),
            ("Wireless Keyboard Mouse Combo", "wireless keyboard and mouse set"),
            ("USB-C Docking Station", "multi-port USB-C laptop dock"),
            ("1TB NVMe SSD", "PCIe NVMe solid-state drive"),
        ],
        "variants": ["Base", "Plus", "Pro", "Elite"],
        "base_price": 1899,
        "step": 2600,
    },

    "Home Appliances": {
        "brands": ["HomeZen", "ArcticNest", "Cresta", "EverCool", "AeroHome"],
        "products": [
            ("Single Door Refrigerator", "energy-efficient single-door refrigerator"),
            ("Double Door Refrigerator", "frost-free double-door refrigerator"),
            ("Front Load Washing Machine", "fully automatic front-load washing machine"),
            ("Top Load Washing Machine", "fully automatic top-load washing machine"),
            ("1.5 Ton Split AC", "inverter split air conditioner"),
            ("2 Ton Split AC", "large-room inverter split air conditioner"),
            ("Ceiling Fan", "high-air-delivery ceiling fan"),
            ("Tower Fan", "oscillating tower fan"),
            ("Air Purifier", "HEPA air purifier for indoor spaces"),
            ("Room Heater", "electric room heater with thermostat"),
            ("40-inch Smart TV", "smart LED television"),
        ],
        "variants": ["White", "Silver", "Graphite", "Premium"],
        "base_price": 2499,
        "step": 3200,
    },

    "Kitchen Appliances": {
        "brands": ["CookEase", "KitchPro", "SpiceMate", "ChefNest", "HomeChef"],
        "products": [
            ("Mixer Grinder 750W", "multi-jar mixer grinder"),
            ("Mixer Grinder 1000W", "high-power mixer grinder"),
            ("Air Fryer 4L", "digital hot-air fryer"),
            ("Air Fryer 6L", "large-capacity digital air fryer"),
            ("Microwave Oven 20L", "solo microwave oven"),
            ("Microwave Oven 28L", "convection microwave oven"),
            ("Induction Cooktop", "portable induction cooktop"),
            ("Electric Kettle 1.5L", "stainless-steel electric kettle"),
            ("Rice Cooker 1.8L", "automatic electric rice cooker"),
            ("OTG 30L", "countertop oven toaster grill"),
            ("Hand Blender", "variable-speed immersion blender"),
        ],
        "variants": ["Classic", "Plus", "Pro", "Digital"],
        "base_price": 1199,
        "step": 550,
    },

    "Furniture": {
        "brands": ["Woodora", "UrbanNest", "CasaCraft", "TimberLine", "Oak & Loom"],
        "products": [
            ("Study Table", "engineered-wood study table"),
            ("Office Desk", "spacious work-from-home desk"),
            ("Computer Table", "compact computer workstation"),
            ("Bookshelf", "multi-shelf storage bookcase"),
            ("Bedside Table", "two-drawer bedside table"),
            ("TV Unit", "living-room television console"),
            ("Shoe Rack", "multi-tier shoe storage unit"),
            ("Coffee Table", "modern living-room coffee table"),
            ("Dining Table", "four-seater dining table"),
            ("Office Chair", "ergonomic adjustable office chair"),
            ("Accent Chair", "upholstered accent chair"),
        ],
        "variants": ["Walnut", "Teak", "Oak", "Espresso"],
        "base_price": 2499,
        "step": 700,
    },

    "Clothing": {
        "brands": ["ThreadCraft", "IndigoLane", "UrbanWeave", "CottonRoot", "EthnicEdit"],
        "products": [
            ("Men's Cotton T-Shirt", "regular-fit cotton T-shirt"),
            ("Men's Casual Shirt", "cotton casual shirt"),
            ("Men's Formal Shirt", "formal cotton-blend shirt"),
            ("Men's Chino Trousers", "slim-fit chino trousers"),
            ("Women's Cotton Kurta", "printed cotton kurta"),
            ("Women's Anarkali Kurta", "flowing ethnic anarkali"),
            ("Women's Casual Top", "everyday casual top"),
            ("Women's Straight Trousers", "comfortable straight-fit trousers"),
            ("Women's Saree", "lightweight printed saree"),
            ("Unisex Hoodie", "fleece-lined casual hoodie"),
            ("Kids' Cotton T-Shirt", "soft cotton children's T-shirt"),
        ],
        "variants": ["Navy", "Black", "Olive", "Maroon"],
        "base_price": 599,
        "step": 180,
    },

    "Footwear": {
        "brands": ["SoleStory", "StrideOne", "WalkMate", "UrbanSole", "StepCraft"],
        "products": [
            ("Men's Running Shoes", "lightweight running shoes"),
            ("Men's Casual Sneakers", "everyday casual sneakers"),
            ("Men's Formal Loafers", "synthetic-leather formal loafers"),
            ("Men's Walking Shoes", "cushioned walking shoes"),
            ("Women's Running Shoes", "lightweight women's running shoes"),
            ("Women's Casual Sneakers", "everyday women's sneakers"),
            ("Women's Ballet Flats", "comfortable flat footwear"),
            ("Women's Sandals", "casual everyday sandals"),
            ("Unisex Sports Shoes", "multi-purpose sports footwear"),
            ("Kids' Velcro Shoes", "easy-wear children's shoes"),
            ("Men's Leather Sandals", "casual leather sandals"),
        ],
        "variants": ["Black", "White", "Grey", "Blue"],
        "base_price": 799,
        "step": 220,
    },

    "Beauty & Personal Care": {
        "brands": ["GlowNest", "AuraCare", "PureBloom", "VedaGlow", "SattvaSkin"],
        "products": [
            ("Vitamin C Face Serum", "brightening facial serum"),
            ("Hyaluronic Acid Serum", "hydrating facial serum"),
            ("Gentle Face Cleanser", "mild daily facial cleanser"),
            ("Foaming Face Wash", "refreshing foaming face wash"),
            ("Daily Moisturizer", "lightweight daily moisturizer"),
            ("Sunscreen SPF 50", "broad-spectrum sunscreen"),
            ("Anti-Dandruff Shampoo", "anti-dandruff hair cleanser"),
            ("Herbal Shampoo", "plant-extract daily shampoo"),
            ("Conditioner", "moisturising hair conditioner"),
            ("Body Lotion", "daily hydrating body lotion"),
            ("Beard Grooming Kit", "beard oil, balm and comb kit"),
        ],
        "variants": ["100ml", "150ml", "200ml", "250ml"],
        "base_price": 299,
        "step": 90,
    },

    "Grocery & Food": {
        "brands": ["FarmBasket", "PureHarvest", "DesiHarvest", "DailyGrain", "FreshField"],
        "products": [
            ("Basmati Rice 5kg", "premium long-grain basmati rice"),
            ("Sona Masoori Rice 5kg", "everyday sona masoori rice"),
            ("Toor Dal 1kg", "polished toor dal"),
            ("Moong Dal 1kg", "split yellow moong dal"),
            ("Wheat Flour 5kg", "whole wheat atta"),
            ("Multigrain Atta 5kg", "multigrain whole wheat flour"),
            ("Sugar 5kg", "refined white sugar"),
            ("Tea 500g", "Indian black tea blend"),
            ("Filter Coffee 500g", "South Indian filter coffee blend"),
            ("Mixed Nuts 500g", "assorted roasted nuts"),
            ("Breakfast Oats 1kg", "rolled oats for breakfast"),
        ],
        "variants": ["Classic", "Premium", "Select", "Family Pack"],
        "base_price": 149,
        "step": 45,
    },

    "Books": {
        "brands": ["Saraswati Press", "MangoTree Publishing", "Campus Reads", "PageTurner", "ScholarHouse"],
        "products": [
            ("Indian Polity Handbook", "reference guide to Indian polity and governance"),
            ("Modern Indian History", "study guide to modern Indian history"),
            ("Introduction to Economics", "introductory economics textbook"),
            ("Database Systems", "academic introduction to database systems"),
            ("Data Structures in C++", "data structures and algorithms textbook"),
            ("Python Programming", "practical Python programming guide"),
            ("Digital Electronics", "undergraduate digital electronics textbook"),
            ("Signals and Systems", "engineering signals and systems textbook"),
            ("The Monsoon Letters", "contemporary Indian fiction"),
            ("The Mango Orchard", "Indian literary fiction"),
            ("Everyday Indian Cooking", "Indian home-cooking recipe collection"),
        ],
        "variants": ["Paperback", "Hardcover", "Student Edition", "Revised Edition"],
        "base_price": 249,
        "step": 85,
    },

    "Stationery & Office Supplies": {
        "brands": ["PaperTrail", "DeskMate", "WriteWell", "OfficeOrbit", "CampusPro"],
        "products": [
            ("A5 Spiral Notebook", "ruled spiral notebook"),
            ("A4 Project Notebook", "large ruled project notebook"),
            ("Gel Pen Pack", "smooth-writing gel pens"),
            ("Ball Pen Pack", "everyday ball pens"),
            ("Highlighter Set", "assorted fluorescent highlighters"),
            ("Mechanical Pencil Set", "mechanical pencils with refills"),
            ("Desk Organizer", "multi-compartment desk organizer"),
            ("Document Folder", "durable document storage folder"),
            ("Sticky Notes Set", "assorted adhesive note pads"),
            ("Printer Paper 500 Sheets", "A4 multipurpose printer paper"),
            ("Whiteboard Marker Set", "low-odour whiteboard markers"),
        ],
        "variants": ["Blue", "Black", "Assorted", "Premium"],
        "base_price": 99,
        "step": 35,
    },

    "Sports & Fitness": {
        "brands": ["FitNation", "ActivePeak", "SportSphere", "TrailBlaze", "PlayField"],
        "products": [
            ("Yoga Mat", "non-slip exercise yoga mat"),
            ("Resistance Band Set", "multi-resistance fitness bands"),
            ("Adjustable Dumbbell", "adjustable cast-iron dumbbell"),
            ("Kettlebell", "powder-coated fitness kettlebell"),
            ("Cricket Bat", "English-willow style cricket bat"),
            ("Cricket Ball Pack", "practice cricket balls"),
            ("Football", "machine-stitched football"),
            ("Badminton Racket", "lightweight badminton racket"),
            ("Skipping Rope", "adjustable speed skipping rope"),
            ("Cycling Helmet", "ventilated cycling helmet"),
            ("Fitness Bottle", "leak-resistant sports bottle"),
        ],
        "variants": ["Blue", "Black", "Red", "Green"],
        "base_price": 399,
        "step": 180,
    },

    "Toys & Games": {
        "brands": ["WonderBox", "TinyTots", "PlayCraft", "BrainyKids", "FunSphere"],
        "products": [
            ("Building Blocks Set", "colourful construction blocks"),
            ("Magnetic Tiles Set", "magnetic construction tile set"),
            ("Wooden Puzzle", "educational wooden puzzle"),
            ("Jigsaw Puzzle 500 Piece", "500-piece illustrated jigsaw puzzle"),
            ("Strategy Board Game", "family strategy board game"),
            ("Classic Carrom Board", "wooden carrom board"),
            ("Remote Control Car", "battery-powered remote control car"),
            ("Science Experiment Kit", "hands-on science activity kit"),
            ("Art & Craft Kit", "children's creative art kit"),
            ("Plush Animal Toy", "soft plush animal toy"),
            ("Kids' Musical Keyboard", "entry-level children's keyboard"),
        ],
        "variants": ["Junior", "Classic", "Deluxe", "Family"],
        "base_price": 299,
        "step": 120,
    },

    "Automotive": {
        "brands": ["RoadReady", "DriveMate", "AutoGear", "MotorWorks", "WheelWise"],
        "products": [
            ("Car Vacuum Cleaner", "compact 12V car vacuum cleaner"),
            ("Car Air Compressor", "portable tyre inflator"),
            ("Car Phone Holder", "dashboard and vent phone mount"),
            ("Microfiber Cleaning Kit", "automotive cleaning cloth kit"),
            ("Car Seat Cover Set", "universal-fit car seat covers"),
            ("Bike Cover", "water-resistant motorcycle cover"),
            ("Car Dashboard Cleaner", "interior dashboard cleaning kit"),
            ("Tyre Inflator Gauge", "digital tyre pressure inflator"),
            ("LED Headlight Bulb", "automotive LED replacement bulb"),
            ("Emergency Roadside Kit", "basic vehicle emergency kit"),
            ("Car Sunshade", "foldable windshield sunshade"),
        ],
        "variants": ["Standard", "Plus", "Pro", "Premium"],
        "base_price": 299,
        "step": 150,
    },

    "Home & Kitchen": {
        "brands": ["CasaCraft", "HomeCanvas", "KitchenKart", "NestNook", "TableTop"],
        "products": [
            ("Non-Stick Fry Pan", "non-stick kitchen frying pan"),
            ("Stainless Steel Cookware Set", "multi-piece stainless steel cookware"),
            ("Glass Storage Container Set", "airtight glass food containers"),
            ("Dinner Set", "ceramic dinnerware set"),
            ("Water Bottle Set", "reusable household water bottles"),
            ("Kitchen Knife Set", "multi-piece kitchen knife set"),
            ("Cotton Bedsheet", "soft cotton bedsheet"),
            ("Bath Towel Set", "absorbent cotton bath towels"),
            ("Curtain Set", "ready-to-hang window curtains"),
            ("Storage Basket Set", "woven household storage baskets"),
            ("Wall Decor Set", "decorative wall art set"),
        ],
        "variants": ["Small", "Medium", "Large", "Family"],
        "base_price": 349,
        "step": 140,
    },

    "Travel & Luggage": {
        "brands": ["TravelTrail", "RoamReady", "Voyage", "CarryOn", "NomadGear"],
        "products": [
            ("Cabin Trolley Bag", "compact cabin-size trolley suitcase"),
            ("Medium Trolley Bag", "medium hard-shell trolley suitcase"),
            ("Large Trolley Bag", "large check-in trolley suitcase"),
            ("Laptop Backpack", "padded laptop travel backpack"),
            ("Travel Duffle Bag", "spacious travel duffle bag"),
            ("Weekender Bag", "compact weekend travel bag"),
            ("Passport Holder", "travel document organiser"),
            ("Packing Cube Set", "multi-size packing organiser set"),
            ("Travel Neck Pillow", "memory-foam travel neck pillow"),
            ("Toiletry Travel Kit", "compact travel toiletry organiser"),
            ("Foldable Travel Backpack", "lightweight foldable daypack"),
        ],
        "variants": ["Black", "Navy", "Olive", "Charcoal"],
        "base_price": 399,
        "step": 250,
    },

    "Pet Supplies": {
        "brands": ["PetNest", "Pawfect", "FurryFriends", "TailWaggers", "WhiskersCo"],
        "products": [
            ("Adult Dog Food 3kg", "complete dry food for adult dogs"),
            ("Puppy Food 3kg", "balanced dry food for puppies"),
            ("Adult Cat Food 2kg", "complete dry food for adult cats"),
            ("Cat Litter 5kg", "clumping cat litter"),
            ("Dog Leash", "adjustable nylon dog leash"),
            ("Dog Collar", "adjustable pet collar"),
            ("Pet Grooming Brush", "deshedding grooming brush"),
            ("Interactive Pet Toy", "engagement toy for dogs and cats"),
            ("Pet Feeding Bowl", "stainless steel feeding bowl"),
            ("Pet Bed", "washable padded pet bed"),
            ("Pet Shampoo", "mild pet grooming shampoo"),
        ],
        "variants": ["Small", "Medium", "Large", "XL"],
        "base_price": 249,
        "step": 90,
    },
}


def load_seller_category_mapping(path):
    """Load the fixed seller -> category mapping created from seller.csv."""
    import csv

    mapping = {}
    with open(path, "r", encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f)
        required = {"seller_id", "name", "category"}
        if not required.issubset(reader.fieldnames or []):
            raise RuntimeError(
                f"Mapping CSV must contain columns: {sorted(required)}"
            )

        for row in reader:
            seller_id = int(row["seller_id"])
            mapping[seller_id] = row["category"].strip()

    if len(mapping) != 200:
        raise RuntimeError(
            f"Expected 200 seller mappings, found {len(mapping)}."
        )

    return mapping


def assign_sellers_to_categories(sellers, category_names, mapping):
    """Apply the fixed CSV mapping; no heuristic matching or balancing."""
    category_sellers = {category: [] for category in category_names}
    valid_categories = set(category_names)

    for seller in sellers:
        seller_id = seller["seller_id"]

        if seller_id not in mapping:
            raise RuntimeError(f"No category mapping for seller_id {seller_id}.")

        category = mapping[seller_id]

        if category not in valid_categories:
            raise RuntimeError(
                f"Seller {seller_id} mapped to unknown category: {category}"
            )

        category_sellers[category].append(seller)

    if sum(len(v) for v in category_sellers.values()) != len(sellers):
        raise RuntimeError("Not all sellers were assigned to a category.")

    return category_sellers


def get_price_range(category_name, product_type):
    """Return a synthetic but realistic Indian retail price range in INR."""

    p = product_type.lower()

    if category_name == "Electronics":
        if "4k" in p and "tv" in p: return 25000, 50000
        if "qled" in p or "oled" in p: return 45000, 110000
        if "soundbar" in p: return 5000, 30000
        if "headphone" in p: return 1500, 12000
        if "speaker" in p: return 1500, 15000
        if "camera" in p: return 25000, 90000
        if "router" in p: return 1800, 9000
        if "projector" in p: return 7000, 35000
        return 2000, 15000

    if category_name == "Mobiles & Accessories":
        if "smartphone" in p:
            if "256gb" in p or "amoled" in p: return 18000, 65000
            if "budget" in p: return 9000, 18000
            return 14000, 40000
        if "20000mah" in p: return 1100, 2800
        if "10000mah" in p: return 700, 1800
        if "65w" in p: return 1400, 3500
        if "33w" in p: return 700, 1800
        if "20w" in p: return 500, 1200
        if "cable" in p: return 250, 900
        if "charging pad" in p: return 900, 3000
        if "stand" in p: return 600, 2500
        return 400, 3000

    if category_name == "Computers & Laptops":
        if "gaming laptop" in p: return 60000, 160000
        if "creator laptop" in p: return 55000, 140000
        if "performance laptop" in p: return 45000, 100000
        if "business laptop" in p: return 40000, 90000
        if "student laptop" in p: return 30000, 65000
        if "27-inch" in p: return 15000, 35000
        if "24-inch" in p: return 8000, 18000
        if "mechanical keyboard" in p: return 1800, 7000
        if "keyboard mouse" in p: return 1000, 3500
        if "dock" in p: return 2500, 10000
        if "ssd" in p: return 5000, 11000
        return 2000, 10000

    if category_name == "Home Appliances":
        if "single door refrigerator" in p: return 15000, 28000
        if "double door refrigerator" in p: return 25000, 55000
        if "front load washing" in p: return 25000, 55000
        if "top load washing" in p: return 16000, 35000
        if "1.5 ton" in p: return 30000, 55000
        if "2 ton" in p: return 40000, 70000
        if "smart tv" in p: return 22000, 50000
        if "air purifier" in p: return 7000, 25000
        if "ceiling fan" in p: return 1800, 5000
        if "tower fan" in p: return 2500, 6500
        if "room heater" in p: return 1800, 5000
        return 3000, 20000

    if category_name == "Kitchen Appliances":
        if "mixer grinder 750" in p: return 2200, 5000
        if "mixer grinder 1000" in p: return 3000, 6500
        if "air fryer 4" in p: return 3000, 6500
        if "air fryer 6" in p: return 4500, 10000
        if "microwave oven 20" in p: return 5500, 10000
        if "microwave oven 28" in p: return 8500, 16000
        if "induction" in p: return 1500, 3500
        if "kettle" in p: return 1000, 2500
        if "rice cooker" in p: return 1800, 4000
        if "otg" in p: return 5000, 10000
        if "blender" in p: return 1200, 3500
        return 1000, 5000

    if category_name == "Furniture":
        if "study table" in p: return 3000, 9000
        if "office desk" in p: return 5000, 15000
        if "computer table" in p: return 3000, 8000
        if "bookshelf" in p: return 2500, 9000
        if "bedside" in p: return 1800, 5000
        if "tv unit" in p: return 5000, 15000
        if "shoe rack" in p: return 1800, 6000
        if "coffee table" in p: return 2500, 8000
        if "dining table" in p: return 8000, 25000
        if "office chair" in p: return 4500, 18000
        if "accent chair" in p: return 5000, 15000
        return 2500, 12000

    if category_name == "Clothing":
        if "t-shirt" in p: return 399, 1200
        if "casual shirt" in p: return 700, 1800
        if "formal shirt" in p: return 900, 2500
        if "chino" in p or "trousers" in p: return 900, 2500
        if "cotton kurta" in p: return 700, 1800
        if "anarkali" in p: return 1200, 3500
        if "casual top" in p: return 600, 1800
        if "saree" in p: return 900, 5000
        if "hoodie" in p: return 900, 2500
        return 400, 1800

    if category_name == "Footwear":
        if "running shoes" in p: return 1800, 7000
        if "casual sneakers" in p: return 1500, 5500
        if "formal loafers" in p: return 1800, 6000
        if "walking shoes" in p: return 1800, 5500
        if "ballet flats" in p: return 700, 2500
        if "sandals" in p: return 600, 2500
        if "sports shoes" in p: return 1500, 5500
        if "velcro" in p: return 700, 1800
        if "leather sandals" in p: return 1200, 4000
        return 800, 4000

    if category_name == "Beauty & Personal Care":
        if "serum" in p: return 500, 1800
        if "cleanser" in p or "face wash" in p: return 250, 900
        if "moisturizer" in p: return 300, 1200
        if "sunscreen" in p: return 400, 1300
        if "shampoo" in p: return 300, 1000
        if "conditioner" in p: return 300, 900
        if "body lotion" in p: return 250, 800
        if "beard" in p: return 500, 1800
        return 200, 1200

    if category_name == "Grocery & Food":
        if "rice 5kg" in p: return 350, 900
        if "dal 1kg" in p: return 120, 250
        if "flour 5kg" in p or "atta 5kg" in p: return 250, 500
        if "sugar 5kg" in p: return 220, 350
        if "tea 500g" in p: return 180, 700
        if "coffee 500g" in p: return 300, 900
        if "nuts 500g" in p: return 350, 1200
        if "oats 1kg" in p: return 150, 400
        return 100, 1000

    if category_name == "Books":
        if any(x in p for x in ["polity", "history", "economics", "database",
                                "data structures", "python", "digital electronics",
                                "signals"]):
            return 450, 1500
        if "cooking" in p: return 350, 1000
        return 300, 900

    if category_name == "Stationery & Office Supplies":
        if "printer paper" in p: return 250, 450
        if "notebook" in p: return 100, 400
        if "pen pack" in p: return 80, 300
        if "highlighter" in p: return 120, 400
        if "mechanical pencil" in p: return 150, 500
        if "desk organizer" in p: return 200, 800
        if "document folder" in p: return 80, 300
        if "sticky notes" in p: return 100, 350
        if "marker" in p: return 100, 400
        return 80, 500

    if category_name == "Sports & Fitness":
        if "yoga mat" in p: return 500, 1800
        if "resistance" in p: return 400, 1500
        if "dumbbell" in p: return 1000, 5000
        if "kettlebell" in p: return 1200, 4500
        if "cricket bat" in p: return 1500, 10000
        if "cricket ball" in p: return 400, 1500
        if "football" in p: return 500, 2000
        if "badminton" in p: return 700, 3500
        if "skipping" in p: return 150, 600
        if "helmet" in p: return 700, 3000
        if "bottle" in p: return 300, 1200
        return 300, 3000

    if category_name == "Toys & Games":
        if "building blocks" in p: return 500, 2500
        if "magnetic tiles" in p: return 800, 3500
        if "puzzle" in p: return 250, 1000
        if "board game" in p: return 500, 2500
        if "carrom" in p: return 1200, 4500
        if "remote control" in p: return 700, 3000
        if "science" in p: return 500, 2500
        if "art & craft" in p: return 300, 1500
        if "plush" in p: return 300, 1500
        if "keyboard" in p: return 700, 2500
        return 300, 1800

    if category_name == "Automotive":
        if "vacuum" in p: return 1800, 5000
        if "compressor" in p or "inflator" in p: return 1500, 4500
        if "phone holder" in p: return 300, 1200
        if "microfiber" in p: return 250, 900
        if "seat cover" in p: return 1200, 5000
        if "bike cover" in p: return 500, 1800
        if "dashboard cleaner" in p: return 250, 900
        if "headlight" in p: return 800, 3000
        if "roadside" in p: return 1200, 4000
        if "sunshade" in p: return 300, 1200
        return 300, 2500

    if category_name == "Home & Kitchen":
        if "fry pan" in p: return 500, 1800
        if "cookware" in p: return 2000, 7000
        if "storage container" in p: return 500, 2000
        if "dinner set" in p: return 800, 3500
        if "water bottle" in p: return 300, 1200
        if "knife" in p: return 500, 1800
        if "bedsheet" in p: return 700, 2500
        if "towel" in p: return 500, 1800
        if "curtain" in p: return 600, 2500
        if "storage basket" in p: return 400, 1600
        if "wall decor" in p: return 500, 2500
        return 300, 2500

    if category_name == "Travel & Luggage":
        if "cabin trolley" in p: return 2000, 6500
        if "medium trolley" in p: return 3000, 9000
        if "large trolley" in p: return 4000, 12000
        if "laptop backpack" in p: return 1200, 4500
        if "duffle" in p: return 1000, 3500
        if "weekender" in p: return 1000, 3500
        if "passport" in p: return 300, 1200
        if "packing cube" in p: return 500, 1800
        if "neck pillow" in p: return 400, 1500
        if "toiletry" in p: return 300, 1200
        if "foldable" in p: return 500, 1800
        return 500, 4000

    if category_name == "Pet Supplies":
        if "dog food" in p or "puppy food" in p: return 600, 1800
        if "cat food" in p: return 500, 1600
        if "cat litter" in p: return 400, 1200
        if "leash" in p: return 300, 1200
        if "collar" in p: return 250, 900
        if "grooming brush" in p: return 300, 1000
        if "interactive" in p: return 400, 1500
        if "feeding bowl" in p: return 250, 900
        if "pet bed" in p: return 700, 2500
        if "shampoo" in p: return 300, 1000
        return 250, 1500

    raise RuntimeError(
        f"No pricing rule exists for {category_name} / {product_type}"
    )


def generate_products(category_sellers, category_ids):
    """
    Generate exactly four genuinely different products per seller.

    IMPORTANT:
    - No artificial Core / Plus / Pro / Max variants.
    - A seller gets four different product families.
    - Product families may naturally repeat across different sellers in
      the same category, but a single seller will not get the same family twice.
    """
    rng = random.Random(987654)
    products = []

    for category_name, sellers in category_sellers.items():
        if not sellers:
            continue

        spec = CATALOG[category_name]
        families = spec["products"]

        if len(families) < 4:
            raise RuntimeError(
                f"Category '{category_name}' has fewer than 4 product families."
            )

        for seller_index, seller in enumerate(sellers):
            # Deterministically rotate through the catalogue so sellers
            # in the same category do not all receive the same four items.
            # Sampling without replacement guarantees four different
            # product families for each seller.
            start = (seller_index * 3) % len(families)

            selected_indices = [
                (start + offset) % len(families)
                for offset in range(4)
            ]

            # Shuffle only the order of the four products, not their identity.
            rng.shuffle(selected_indices)

            for family_idx in selected_indices:
                product_type, description = families[family_idx]

                brand = spec["brands"][
                    (seller_index + family_idx) % len(spec["brands"])
                ]

                low, high = get_price_range(category_name, product_type)
                raw_price = rng.randint(low, high)

                # Natural Indian retail-style price endings.
                if raw_price >= 10000:
                    price = (raw_price // 500) * 500 + rng.choice([0, 49, 99])
                elif raw_price >= 1000:
                    price = (raw_price // 100) * 100 + rng.choice([0, 49, 99])
                else:
                    price = (raw_price // 10) * 10 + rng.choice([0, 9])

                price = max(low, min(price, high))

                stock = rng.randint(8, 150)
                reorder_level = rng.randint(5, 25)

                if rng.random() < 0.12:
                    stock = rng.randint(
                        0,
                        max(3, reorder_level - 1)
                    )

                last_updated = (
                    date.today()
                    - timedelta(days=rng.randint(0, 45))
                )

                # Product family itself provides the variety.
                # Seller name keeps every product name globally unique.
                product_name = (
                    f"{brand} {product_type} ({seller['name']})"
                )

                full_description = (
                    f"{description}. "
                    f"Suitable for everyday Indian household, personal, "
                    f"office, or leisure use."
                )

                products.append(
                    (
                        seller["seller_id"],
                        category_ids[category_name],
                        product_name,
                        full_description,
                        Decimal(str(price)),
                        brand,
                        stock,
                        reorder_level,
                        last_updated,
                    )
                )

    return products


def validate_products(products):
    """Validate product count, uniqueness and inventory constraints."""

    if len(products) != 800:
        raise RuntimeError(
            f"Expected 800 products, generated {len(products)}."
        )

    product_names = [p[2] for p in products]

    if len(set(product_names)) != 800:
        raise RuntimeError("Product names are not unique.")

    if any(p[4] <= 0 for p in products):
        raise RuntimeError("A product has a non-positive price.")

    if any(p[6] < 0 for p in products):
        raise RuntimeError("A product has negative stock.")

    if any(p[7] < 0 for p in products):
        raise RuntimeError("A product has negative reorder level.")

    seller_counts = {}

    for product in products:
        seller_id = product[0]
        seller_counts[seller_id] = seller_counts.get(seller_id, 0) + 1

    if len(seller_counts) != 200:
        raise RuntimeError(
            f"Expected 200 sellers with products, got {len(seller_counts)}."
        )

    if any(count != 4 for count in seller_counts.values()):
        raise RuntimeError("Each seller must have exactly 4 products.")


def seed_database():
    conn = None

    try:
        print("Connecting to NeonDB (15-second timeout)...", flush=True)

        conn = psycopg2.connect(
            DATABASE_URL,
            connect_timeout=15,
            options="-c statement_timeout=60000",
        )

        print("Connected to NeonDB.", flush=True)

        with conn:
            with conn.cursor() as cursor:

                # --------------------------------------------------------
                # Read existing sellers
                # --------------------------------------------------------
                print("Reading existing sellers...", flush=True)

                cursor.execute(
                    """
                    SELECT seller_id, name
                    FROM seller
                    ORDER BY seller_id;
                    """
                )

                sellers = [
                    {
                        "seller_id": row[0],
                        "name": row[1],
                    }
                    for row in cursor.fetchall()
                ]

                print(
                    f"Found {len(sellers)} sellers.",
                    flush=True,
                )

                if len(sellers) != 200:
                    raise RuntimeError(
                        f"Expected 200 sellers, found {len(sellers)}."
                    )

                # --------------------------------------------------------
                # Read existing categories
                # --------------------------------------------------------
                print("Reading existing categories...", flush=True)

                cursor.execute(
                    """
                    SELECT category_id, category_name
                    FROM category
                    ORDER BY category_id;
                    """
                )

                category_rows = cursor.fetchall()

                categories = [
                    row[1]
                    for row in category_rows
                ]

                category_ids = {
                    row[1]: row[0]
                    for row in category_rows
                }

                print(
                    f"Found {len(categories)} categories.",
                    flush=True,
                )

                if len(categories) != 18:
                    raise RuntimeError(
                        f"Expected 18 categories, found {len(categories)}."
                    )

                # --------------------------------------------------------
                # Apply the fixed seller -> category CSV mapping
                # --------------------------------------------------------
                print("Loading fixed seller/category mapping...", flush=True)

                mapping = load_seller_category_mapping(MAPPING_CSV)

                print(
                    f"Loaded {len(mapping)} fixed seller/category mappings.",
                    flush=True,
                )

                category_sellers = assign_sellers_to_categories(
                    sellers,
                    categories,
                    mapping,
                )

                print("Seller/category mapping complete.", flush=True)

                # --------------------------------------------------------
                # Generate products
                # --------------------------------------------------------
                print("Generating 800 products...", flush=True)

                products = generate_products(
                    category_sellers,
                    category_ids,
                )

                print(
                    f"Generated {len(products)} products.",
                    flush=True,
                )

                if len(products) != 800:
                    raise RuntimeError(
                        f"Expected 800 products, generated {len(products)}."
                    )

                validate_products(products)

                print("Product validation passed.", flush=True)

                # --------------------------------------------------------
                # Product tuple expected by the existing schema.
                #
                # This section uses the same tuple produced by
                # generate_products(), so the schema mapping is unchanged.
                # --------------------------------------------------------
                print(
                    "Preparing PostgreSQL batch insert...",
                    flush=True,
                )

                # Inspect the current product tuple shape once.
                if not products:
                    raise RuntimeError("No products generated.")

                # Existing generator returns:
                # seller_id, category_id, product_name, description,
                # price, brand, quantity_in_stock, reorder_level,
                # last_updated
                #
                # product_id is generated by PostgreSQL.
                insert_sql = """
                    INSERT INTO product (
                        seller_id,
                        category_id,
                        product_name,
                        description,
                        price,
                        brand,
                        quantity_in_stock,
                        reorder_level,
                        last_updated
                    )
                    VALUES %s
                """

                print(
                    "Inserting 800 products in one PostgreSQL batch...",
                    flush=True,
                )

                execute_values(
                    cursor,
                    insert_sql,
                    products,
                    page_size=800,
                )

                print(
                    "Batch insert completed.",
                    flush=True,
                )

                # --------------------------------------------------------
                # Verification
                # --------------------------------------------------------
                print("Verifying product count...", flush=True)

                cursor.execute(
                    "SELECT COUNT(*) FROM product;"
                )

                product_count = cursor.fetchone()[0]

                print(
                    f"Database currently contains {product_count} products.",
                    flush=True,
                )

                cursor.execute(
                    """
                    SELECT COUNT(DISTINCT seller_id)
                    FROM product;
                    """
                )

                sellers_used = cursor.fetchone()[0]

                cursor.execute(
                    """
                    SELECT COUNT(DISTINCT category_id)
                    FROM product;
                    """
                )

                categories_used = cursor.fetchone()[0]

                print()
                print("==========================================")
                print("       PRODUCT SEED COMPLETE")
                print("==========================================")
                print(f"Products in database : {product_count}")
                print(f"Sellers represented  : {sellers_used}")
                print(f"Categories represented: {categories_used}")
                print("==========================================")
                print(flush=True)

    except Exception:
        if conn:
            conn.rollback()
        raise

    finally:
        if conn:
            conn.close()


if __name__ == "__main__":
    seed_database()
