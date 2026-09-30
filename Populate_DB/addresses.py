import os
import random

import psycopg2
from dotenv import load_dotenv


# ============================================================
# DBMS PROJECT - ADDRESS SEED
#
# Creates:
#   - exactly 1 Home address for each existing customer
#   - an additional Work address for 30% of customers
#
# Expected with 600 customers:
#   600 Home addresses
#   180 Work addresses
#   780 addresses total
#
# IMPORTANT:
#   This script does NOT truncate anything.
#   It reads the existing customer IDs from NeonDB, so it does
#   not assume customer IDs start at 1.
#
# Address data is deterministic and uses Indian city profiles
# so city/district/state/PIN combinations correspond properly.
# ============================================================

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    raise RuntimeError("DATABASE_URL is not set in .env")


# ============================================================
# INDIAN LOCATION PROFILES
#
# Each profile contains:
#   city
#   district
#   state
#   PIN code prefix / valid PIN examples
#   localities
#   street names
#
# The generator only combines fields within the same profile,
# preventing combinations such as a Bengaluru PIN with a
# Hyderabad district.
# ============================================================

LOCATIONS = [
    {
        "city": "Ahmedabad",
        "district": "Ahmedabad",
        "state": "Gujarat",
        "pins": ["380015", "380009", "380054", "380061", "380058"],
        "localities": [
            "Navrangpura", "Satellite", "Vastrapur", "Bodakdev",
            "Prahlad Nagar", "Maninagar", "Chandkheda", "Thaltej",
        ],
        "streets": [
            "C G Road", "S G Highway", "100 Feet Road",
            "Judges Bungalow Road", "Iskcon Road", "Ashram Road",
        ],
    },
    {
        "city": "Bengaluru",
        "district": "Bengaluru Urban",
        "state": "Karnataka",
        "pins": ["560034", "560038", "560040", "560076", "560102"],
        "localities": [
            "Koramangala", "Indiranagar", "Jayanagar", "HSR Layout",
            "Whitefield", "Malleshwaram", "Rajajinagar", "JP Nagar",
        ],
        "streets": [
            "80 Feet Road", "100 Feet Road", "Outer Ring Road",
            "Bannerghatta Road", "Sarjapur Road", "Hosur Road",
        ],
    },
    {
        "city": "Mumbai",
        "district": "Mumbai Suburban",
        "state": "Maharashtra",
        "pins": ["400050", "400053", "400058", "400076", "400078"],
        "localities": [
            "Bandra West", "Andheri West", "Andheri East", "Powai",
            "Goregaon West", "Borivali West", "Chembur", "Vile Parle",
        ],
        "streets": [
            "Linking Road", "S V Road", "LBS Marg",
            "Andheri Kurla Road", "Western Express Highway",
            "Powai Road",
        ],
    },
    {
        "city": "Pune",
        "district": "Pune",
        "state": "Maharashtra",
        "pins": ["411004", "411007", "411014", "411021", "411038"],
        "localities": [
            "Kothrud", "Viman Nagar", "Baner", "Aundh",
            "Wakad", "Kharadi", "Hadapsar", "Shivajinagar",
        ],
        "streets": [
            "Paud Road", "Baner Road", "Nagar Road",
            "Sinhagad Road", "Karve Road", "FC Road",
        ],
    },
    {
        "city": "Hyderabad",
        "district": "Hyderabad",
        "state": "Telangana",
        "pins": ["500032", "500033", "500034", "500081", "500084"],
        "localities": [
            "Banjara Hills", "Jubilee Hills", "Madhapur", "Gachibowli",
            "Kondapur", "Hitech City", "Begumpet", "Kukatpally",
        ],
        "streets": [
            "Road No. 10", "Road No. 36", "Madhapur Main Road",
            "Gachibowli Road", "Jubilee Hills Road",
            "Kukatpally Main Road",
        ],
    },
    {
        "city": "Chennai",
        "district": "Chennai",
        "state": "Tamil Nadu",
        "pins": ["600018", "600020", "600028", "600034", "600041"],
        "localities": [
            "Adyar", "Besant Nagar", "T Nagar", "Nungambakkam",
            "Anna Nagar", "Velachery", "Mylapore", "Guindy",
        ],
        "streets": [
            "L B Road", "Besant Avenue Road", "Anna Salai",
            "Mount Road", "Velachery Main Road", "Arcot Road",
        ],
    },
    {
        "city": "Delhi",
        "district": "South Delhi",
        "state": "Delhi",
        "pins": ["110016", "110017", "110019", "110025", "110048"],
        "localities": [
            "Saket", "Vasant Kunj", "Greater Kailash",
            "Hauz Khas", "Defence Colony", "Lajpat Nagar",
            "South Extension", "Malviya Nagar",
        ],
        "streets": [
            "Aurobindo Marg", "Ring Road", "Press Enclave Road",
            "Outer Ring Road", "Mahatma Gandhi Marg",
        ],
    },
    {
        "city": "Kolkata",
        "district": "Kolkata",
        "state": "West Bengal",
        "pins": ["700019", "700020", "700029", "700031", "700091"],
        "localities": [
            "Ballygunge", "Salt Lake", "New Town", "Gariahat",
            "Alipore", "Jadavpur", "Kasba", "Park Street",
        ],
        "streets": [
            "Gariahat Road", "EM Bypass", "Rashbehari Avenue",
            "Prince Anwar Shah Road", "Park Street",
        ],
    },
    {
        "city": "Jaipur",
        "district": "Jaipur",
        "state": "Rajasthan",
        "pins": ["302004", "302017", "302018", "302019", "302021"],
        "localities": [
            "Malviya Nagar", "Vaishali Nagar", "Mansarovar",
            "C Scheme", "Jagatpura", "Tonk Road", "Raja Park",
        ],
        "streets": [
            "Tonk Road", "Ajmer Road", "JLN Marg",
            "MI Road", "Sawai Ram Singh Road",
        ],
    },
    {
        "city": "Lucknow",
        "district": "Lucknow",
        "state": "Uttar Pradesh",
        "pins": ["226010", "226016", "226018", "226020", "226021"],
        "localities": [
            "Gomti Nagar", "Indira Nagar", "Aliganj", "Hazratganj",
            "Mahanagar", "Alambagh", "Vibhuti Khand",
        ],
        "streets": [
            "Faizabad Road", "Shaheed Path", "Vibhuti Khand Road",
            "Kanpur Road", "Gomti Nagar Extension Road",
        ],
    },
    {
        "city": "Kochi",
        "district": "Ernakulam",
        "state": "Kerala",
        "pins": ["682016", "682017", "682020", "682024", "682030"],
        "localities": [
            "Kadavanthra", "Kaloor", "Edappally", "Vyttila",
            "Kakkanad", "Palarivattom", "Panampilly Nagar",
        ],
        "streets": [
            "MG Road", "NH 66", "Seaport-Airport Road",
            "Banerji Road", "Sahodaran Ayyappan Road",
        ],
    },
    {
        "city": "Bhopal",
        "district": "Bhopal",
        "state": "Madhya Pradesh",
        "pins": ["462003", "462016", "462026", "462039", "462042"],
        "localities": [
            "Arera Colony", "MP Nagar", "Kolar Road", "Shahpura",
            "Bawadia Kalan", "Gulmohar Colony",
        ],
        "streets": [
            "Link Road No. 1", "Hoshangabad Road",
            "Kolar Road", "Airport Road", "Bawadia Kalan Road",
        ],
    },
    {
        "city": "Indore",
        "district": "Indore",
        "state": "Madhya Pradesh",
        "pins": ["452001", "452010", "452016", "452017", "452020"],
        "localities": [
            "Vijay Nagar", "Palasia", "Rau", "Bhawarkuan",
            "Scheme No. 54", "Sudama Nagar",
        ],
        "streets": [
            "AB Road", "MG Road", "Ring Road",
            "MR 10 Road", "Khandwa Road",
        ],
    },
    {
        "city": "Chandigarh",
        "district": "Chandigarh",
        "state": "Chandigarh",
        "pins": ["160009", "160017", "160019", "160022", "160036"],
        "localities": [
            "Sector 8", "Sector 15", "Sector 17", "Sector 22",
            "Sector 34", "Sector 35",
        ],
        "streets": [
            "Madhya Marg", "Vikas Marg", "Jan Marg",
            "Himalaya Marg", "Udyan Path",
        ],
    },
    {
        "city": "Guwahati",
        "district": "Kamrup Metropolitan",
        "state": "Assam",
        "pins": ["781003", "781005", "781006", "781007", "781022"],
        "localities": [
            "Dispur", "Beltola", "Six Mile", "Zoo Road",
            "Chandmari", "Paltan Bazaar",
        ],
        "streets": [
            "GS Road", "Zoo Road", "VIP Road",
            "Beltola Road", "RG Baruah Road",
        ],
    },
    {
        "city": "Patna",
        "district": "Patna",
        "state": "Bihar",
        "pins": ["800001", "800004", "800013", "800014", "800025"],
        "localities": [
            "Boring Road", "Kankarbagh", "Rajendra Nagar",
            "Patliputra Colony", "Bailey Road", "Danapur",
        ],
        "streets": [
            "Bailey Road", "Boring Road", "Fraser Road",
            "Ashiana-Digha Road", "Kankarbagh Main Road",
        ],
    },
    {
        "city": "Nagpur",
        "district": "Nagpur",
        "state": "Maharashtra",
        "pins": ["440010", "440012", "440015", "440022", "440033"],
        "localities": [
            "Dharampeth", "Sadar", "Manish Nagar", "Wardha Road",
            "Pratap Nagar", "Civil Lines",
        ],
        "streets": [
            "Wardha Road", "Central Avenue Road", "Ring Road",
            "Kamptee Road", "Amravati Road",
        ],
    },
    {
        "city": "Visakhapatnam",
        "district": "Visakhapatnam",
        "state": "Andhra Pradesh",
        "pins": ["530003", "530013", "530016", "530017", "530022"],
        "localities": [
            "MVP Colony", "Seethammadhara", "Dwaraka Nagar",
            "Madhurawada", "Siripuram", "Gajuwaka",
        ],
        "streets": [
            "Beach Road", "NH 16", "MVP Main Road",
            "Seethammadhara Main Road", "Dwaraka Nagar Road",
        ],
    },
    {
        "city": "Vijayawada",
        "district": "NTR",
        "state": "Andhra Pradesh",
        "pins": ["520010", "520012", "520013", "520015", "520016"],
        "localities": [
            "Benz Circle", "Moghalrajpuram", "Patamata",
            "Governorpet", "Labbipet", "Poranki",
        ],
        "streets": [
            "MG Road", "Eluru Road", "Bandar Road",
            "NH 16", "Benz Circle Road",
        ],
    },
    {
        "city": "Coimbatore",
        "district": "Coimbatore",
        "state": "Tamil Nadu",
        "pins": ["641004", "641012", "641018", "641035", "641037"],
        "localities": [
            "RS Puram", "Saibaba Colony", "Peelamedu",
            "Gandhipuram", "Singanallur", "Saravanampatti",
        ],
        "streets": [
            "Avinashi Road", "Trichy Road", "Mettupalayam Road",
            "Sathy Road", "Thadagam Road",
        ],
    },
    {
        "city": "Nashik",
        "district": "Nashik",
        "state": "Maharashtra",
        "pins": ["422005", "422007", "422009", "422010", "422013"],
        "localities": [
            "College Road", "Gangapur Road", "Indira Nagar",
            "Panchavati", "Cidco", "Nashik Road",
        ],
        "streets": [
            "Gangapur Road", "Trimbak Road", "Mumbai-Agra Highway",
            "College Road", "Nashik Road",
        ],
    },
]


HOUSE_PREFIXES = [
    "A", "B", "C", "D", "E", "F",
]

HOUSE_SUFFIXES = [
    "", "A", "B", "-1", "-2",
]

HOME_ADDRESS_TYPES = ["Home"]
WORK_ADDRESS_TYPES = ["Work"]


def make_address(location, rng, address_type):
    """Create one internally consistent Indian address."""

    house_number = rng.randint(1, 299)

    # Mix normal house numbers with apartment/flat notation.
    format_choice = rng.randrange(4)

    if format_choice == 0:
        house_no = str(house_number)
    elif format_choice == 1:
        house_no = f"{house_number}{rng.choice(HOUSE_SUFFIXES)}"
    elif format_choice == 2:
        house_no = f"Flat {rng.randint(1, 12)}-{rng.randint(1, 8)}"
    else:
        house_no = f"Plot {rng.randint(1, 199)}"

    street = rng.choice(location["streets"])
    locality = rng.choice(location["localities"])
    pin_code = rng.choice(location["pins"])

    # For work addresses, make the address feel more commercial.
    if address_type == "Work":
        commercial_words = [
            "Business Park",
            "Commercial Complex",
            "Corporate Tower",
            "Trade Centre",
            "Market Plaza",
        ]
        house_no = f"Unit {rng.randint(101, 999)}"
        street = f"{street}, {rng.choice(commercial_words)}"

    return (
        house_no,
        street,
        locality,
        location["city"],
        location["district"],
        location["state"],
        pin_code,
        address_type,
    )


def generate_addresses(customer_ids):
    """
    Generate:
      - one Home address for every customer
      - one Work address for 30% of customers

    A fixed random seed makes the generated data reproducible.
    """

    rng = random.Random(20260930)

    addresses = []

    # Shuffle customer order so city distribution isn't tied to customer ID.
    shuffled_customer_ids = list(customer_ids)
    rng.shuffle(shuffled_customer_ids)

    for index, customer_id in enumerate(shuffled_customer_ids):

        # Select location independently but deterministically.
        location = LOCATIONS[index % len(LOCATIONS)]

        # Every customer gets exactly one Home address.
        home = make_address(location, rng, "Home")

        addresses.append(
            (
                customer_id,
                home[7],   # address_type
                home[0],   # house_no
                home[1],   # street
                home[2],   # locality
                home[3],   # city
                home[4],   # district
                home[5],   # state
                home[6],   # pin_code
            )
        )

        # Roughly 30% of customers get an additional Work address.
        # This uses the shuffled position rather than random sampling,
        # making exactly 180 Work addresses for 600 customers.
        if index % 10 < 3:
            work_location = LOCATIONS[
                (index * 7 + 3) % len(LOCATIONS)
            ]

            work = make_address(work_location, rng, "Work")

            addresses.append(
                (
                    customer_id,
                    work[7],
                    work[0],
                    work[1],
                    work[2],
                    work[3],
                    work[4],
                    work[5],
                    work[6],
                )
            )

    return addresses


def validate_addresses(addresses, customer_ids):
    """Validate the generated address relationships."""

    customer_id_set = set(customer_ids)

    if len(addresses) != 780:
        raise RuntimeError(
            f"Expected 780 addresses, generated {len(addresses)}."
        )

    address_customer_ids = {
        address[0]
        for address in addresses
    }

    if address_customer_ids != customer_id_set:
        raise RuntimeError(
            "Not every customer has an address."
        )

    home_count = sum(
        address[1] == "Home"
        for address in addresses
    )

    work_count = sum(
        address[1] == "Work"
        for address in addresses
    )

    if home_count != 600:
        raise RuntimeError(
            f"Expected 600 Home addresses, got {home_count}."
        )

    if work_count != 180:
        raise RuntimeError(
            f"Expected 180 Work addresses, got {work_count}."
        )

    # Each customer must have exactly one Home address.
    home_by_customer = {}

    for address in addresses:
        if address[1] == "Home":
            customer_id = address[0]
            home_by_customer[customer_id] = (
                home_by_customer.get(customer_id, 0) + 1
            )

    if any(count != 1 for count in home_by_customer.values()):
        raise RuntimeError(
            "A customer does not have exactly one Home address."
        )

    # Verify that all address components belong to the same location profile.
    valid_combinations = {
        (
            location["city"],
            location["district"],
            location["state"],
            pin,
        )
        for location in LOCATIONS
        for pin in location["pins"]
    }

    for address in addresses:
        city = address[5]
        district = address[6]
        state = address[7]
        pin = address[8]

        if (city, district, state, pin) not in valid_combinations:
            raise RuntimeError(
                f"Invalid location combination: "
                f"{city}, {district}, {state}, {pin}"
            )


def seed_database():
    conn = None

    try:
        print("Connecting to NeonDB...")

        conn = psycopg2.connect(DATABASE_URL)

        with conn:
            with conn.cursor() as cursor:

                # --------------------------------------------------------
                # Get existing customers.
                # We do not assume IDs start at 1.
                # --------------------------------------------------------
                cursor.execute(
                    """
                    SELECT customer_id
                    FROM customer
                    ORDER BY customer_id;
                    """
                )

                customer_ids = [
                    row[0]
                    for row in cursor.fetchall()
                ]

                if len(customer_ids) != 600:
                    raise RuntimeError(
                        f"Expected 600 customers in the database, "
                        f"found {len(customer_ids)}. "
                        f"Seed customers first."
                    )

                print(f"Found {len(customer_ids)} customers.")

                # --------------------------------------------------------
                # Generate addresses.
                # --------------------------------------------------------
                addresses = generate_addresses(customer_ids)

                validate_addresses(
                    addresses,
                    customer_ids,
                )

                # --------------------------------------------------------
                # Insert addresses.
                #
                # Column order:
                # address_id       -> generated by BIGSERIAL
                # customer_id
                # address_type
                # house_no
                # street
                # locality
                # city
                # district
                # state
                # pin_code
                # --------------------------------------------------------
                cursor.executemany(
                    """
                    INSERT INTO address (
                        customer_id,
                        address_type,
                        house_no,
                        street,
                        locality,
                        city,
                        district,
                        state,
                        pin_code
                    )
                    VALUES (
                        %s, %s, %s, %s, %s,
                        %s, %s, %s, %s
                    );
                    """,
                    addresses,
                )

                # --------------------------------------------------------
                # Verification
                # --------------------------------------------------------
                cursor.execute(
                    "SELECT COUNT(*) FROM address;"
                )
                address_count = cursor.fetchone()[0]

                cursor.execute(
                    """
                    SELECT COUNT(*)
                    FROM address
                    WHERE address_type = 'Home';
                    """
                )
                home_count = cursor.fetchone()[0]

                cursor.execute(
                    """
                    SELECT COUNT(*)
                    FROM address
                    WHERE address_type = 'Work';
                    """
                )
                work_count = cursor.fetchone()[0]

                cursor.execute(
                    """
                    SELECT COUNT(DISTINCT customer_id)
                    FROM address;
                    """
                )
                customers_with_addresses = cursor.fetchone()[0]

                print()
                print("==========================================")
                print("        ADDRESS SEED COMPLETE")
                print("==========================================")
                print(f"Customers              : {len(customer_ids)}")
                print(f"Customers with address : {customers_with_addresses}")
                print(f"Home addresses         : {home_count}")
                print(f"Work addresses         : {work_count}")
                print(f"Total addresses        : {address_count}")
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
