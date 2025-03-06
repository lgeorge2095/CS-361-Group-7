#Authentication: API Key (included in the request headers)
#Example Query (Python):
import requests

API_KEY = "your_abuseipdb_api_key"
IP = "8.8.8.8"
URL = f"https://api.abuseipdb.com/api/v2/check?ipAddress={IP}"

HEADERS = {
	"Accept": "application/json",
	"Key": API_KEY
}

response = requests.get(URL, headers=HEADERS)
print(response.json())
