~OSINT API Research & Integration~

# ~Overview
Everything below should contain information revolving around the tools chosen. 
It covers authentication methods, request structures, and example usage.

Selected OSINT APIs

VirusTotal - Provides threat intelligence and malware analysis for IP addresses, URLs, and domains.

SecurityTrails - Offers WHOIS and historical domain data for cybersecurity investigations.

AbuseIPDB - Allows reporting and querying of IP addresses to identify malicious activity.

API Authentication & Request Methods

Each API requires authentication using an API key, which must be included in the request headers.

1. VirusTotal

Authentication: API Key (loaded from environment variables)

Example Query (Python):

import requests
import os
from dotenv import load_dotenv

# Load API keys environment variables
load_dotenv()
API_KEY = os.getenv("VIRUSTOTAL_API_KEY")
IP = "8.8.8.8"
URL = f"https://www.virustotal.com/api/v3/ip_addresses/{IP}"
HEADERS = {"x-apikey": API_KEY}

response = requests.get(URL, headers=HEADERS)
print(response.json())

2. SecurityTrails

Authentication: API Key (loaded from environment variables)

Example Query (Python):

import requests
import os
from dotenv import load_dotenv

# Load API keys environment variables
load_dotenv()
API_KEY = os.getenv("SECURITYTRAILS_API_KEY")
DOMAIN = "example.com"
URL = f"https://api.securitytrails.com/v1/domain/{DOMAIN}/whois"
HEADERS = {"APIKEY": API_KEY}

response = requests.get(URL, headers=HEADERS)
print(response.json())

3. AbuseIPDB

Authentication: API Key (loaded from environment variables)

Example Query (Python):

import requests
import os
from dotenv import load_dotenv

# Load API keys environment variables
load_dotenv()
API_KEY = os.getenv("ABUSEIPDB_API_KEY")
IP = "8.8.8.8"
URL = "https://api.abuseipdb.com/api/v2/check"
HEADERS = {
    "Key": API_KEY,
    "Accept": "application/json"
}
PARAMS = {"ipAddress": IP}

response = requests.get(URL, headers=HEADERS, params=PARAMS)
print(response.json())

# How to Run the Scripts

Ensure Python 3 and requests and python-dotenv libraries are installed:

pip install requests python-dotenv

The .env file with API keys:

VIRUSTOTAL_API_KEY=your_api_key_here
SECURITYTRAILS_API_KEY=your_api_key_here
ABUSEIPDB_API_KEY=your_api_key_here

Run the script using:

python ALLOSINT.py
(make sure it is run from the ALLOINT.py!!!Not from main.py)

# Troubleshooting

If you encounter issues:

Invalid API Key Errors

Double-check that your API keys are correct in .env.

Ensure that your account has API access (e.g., Censys requires a paid plan).

ModuleNotFoundError: No module named 'requests'

Run pip install requests again.

API Rate Limits Exceeded

Some APIs have daily limits. If you get rate limit errors, wait or upgrade to a paid plan.

Environment Variables Not Loading (None values for API keys)

Make sure you restart your terminal after editing .env.

Verify .env exists in the same directory as ALLOSINT.py.

Try manually loading it in Python:

import os
from dotenv import load_dotenv
load_dotenv()
print(os.getenv("VIRUSTOTAL_API_KEY"))  # Should print your key



Notes

*API keys should be kept secure and not hardcoded in public repositories.

*Always load API keys from environment variables using dotenv.

*Some APIs have rate limits; check the API documentation for limits and usage guidelines.

*Be mindful of privacy regulations when storing threat data.

*Implement proper data retention policies.

*Consider the sensitivity of scan results.

# References

VirusTotal API 
https://www.virustotal.com/gui/home/upload

SecurityTrails API 
https://securitytrails.com/

AbuseIPDB API 
https://www.abuseipdb.com/api.html
