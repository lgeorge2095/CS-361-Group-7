from flask import Flask, jsonify
from flask_cors import CORS
import psycopg2

app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "http://localhost:5173"}})

# Database connection settings
DB_CONFIG = {
    "dbname": "threat_intel",
    "user": "admin",
    "password": "CSGroup7",
    "host": "localhost",
    "port": 5432,
}

### 🔹 Fetch Asset Data ###
def fetch_assets():
    # Retrieve asset data from the database.
    try:
        print("Fetching asset data...")
        conn = psycopg2.connect(**DB_CONFIG)
        cursor = conn.cursor()

        query = "SELECT asset_name, asset_type, description FROM assets.assets"
        cursor.execute(query)
        result = cursor.fetchall()

        cursor.close()
        conn.close()
        print("Assets Retrieved:", result)

        return [
            {"asset_name": row[0], "asset_type": row[1], "description": row[2]}
            for row in result
        ]
    except Exception as e:
        print("Database error:", e)
        return []

@app.route("/api/assets", methods=["GET"])
def get_assets():
    # API endpoint to fetch asset data.
    return jsonify(fetch_assets())


### 🔹 Fetch TVA Mapping Data ###
def fetch_tva_mapping():
    # Retrieve TVA mapping data from the database.
    try:
        print("Fetching TVA mapping data...")
        conn = psycopg2.connect(**DB_CONFIG)
        cursor = conn.cursor()

        query = """
            SELECT a.asset_name, t.threat_name, t.vulnerability_description, 
                   t.likelihood, t.impact, t.risk_score
            FROM tva_mapping.tva_mapping t
            JOIN assets.assets a ON t.asset_id = a.id;
        """
        cursor.execute(query)
        result = cursor.fetchall()

        cursor.close()
        conn.close()
        print("TVA Mapping Retrieved:", result)

        return [
            {
                "asset": row[0],
                "threat": row[1],
                "vulnerability": row[2],
                "likelihood": row[3],
                "impact": row[4],
                "risk_score": row[5],
            }
            for row in result
        ]
    except Exception as e:
        print("Database error:", e)
        return []

@app.route("/api/tva-mapping", methods=["GET"])
def get_tva_mapping():
    # API endpoint to fetch TVA mapping data.
    return jsonify(fetch_tva_mapping())

### 🔹 Run Flask Application ###
if __name__ == "__main__":
    print("Starting Flask server on http://127.0.0.1:5000...")
    app.run(debug=True)
