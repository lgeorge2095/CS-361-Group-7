import psycopg2
import json
from OSINT import virustotal_get_ip_report, query_securitytrails, abuseipdb_check_ip

#  Database connection
DB_NAME = "threat_intel"
DB_USER = "admin"
DB_PASSWORD = "CSGroup7"
DB_HOST = "localhost"

#  Connect to PostgreSQL
def connect_db():
    try:
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST
        )
        return conn
    except Exception as e:
        print(f"Database Connection Error: {e}")
        return None

#  Store threat data into the database
def store_threat_data(ip, domain):
	conn = connect_db()
	if not conn:
		return

	cursor = conn.cursor()

	#  Fetch threat data from OSINT APIs
	vt_data = virustotal_get_ip_report(ip)
	st_data = query_securitytrails(domain)
	abuse_data = abuseipdb_check_ip(ip)

	#  Insert into PostgreSQL
	query = """
	INSERT INTO threat_reports (ip, domain, virustotal_reputation, abuseipdb_score, securitytrails_info)
	VALUES (%s, %s, %s, %s, %s)
	"""
	values = (
    	ip,
    	domain,
    	json.dumps(vt_data),
    	json.dumps(abuse_data),
    	json.dumps(st_data)
	)

	cursor.execute(query, values)
	conn.commit()
	cursor.close()
	conn.close()

	print(f" Threat data for {ip} and {domain} stored successfully.")

#  Example Usage
if __name__ == "__main__":
	store_threat_data("8.8.8.8", "example.com")


