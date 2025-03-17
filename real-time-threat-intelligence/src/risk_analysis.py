import psycopg2

# Database connection settings
DB_HOST = "localhost"
DB_USER = "your_postgres_user"  # Replace with your PostgreSQL username
DB_PASSWORD = "your_postgres_password"
DB_NAME = "threat_intel"
DB_PORT = "5432"  # Default PostgreSQL port

# Connect to PostgreSQL
conn = psycopg2.connect(
    dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD, host=DB_HOST, port=DB_PORT
)
cursor = conn.cursor()

# Fetch threat data with risk scores
cursor.execute("SELECT id, threat_name, likelihood, impact, risk_score FROM tva_mapping.tva_mapping")
threats = cursor.fetchall()

# Print the results
print("\n🔹 Risk Assessment Report 🔹")
for threat in threats:
    threat_id, threat_name, likelihood, impact, risk_score = threat
    print(f"ID: {threat_id} | Threat: {threat_name} | Likelihood: {likelihood} | Impact: {impact} | Risk Score: {risk_score}")

# Close connection
cursor.close()
conn.close()

print("\n✅ Risk scores retrieved successfully!")
