The following table lists the OSINT tools we have selected for our application:


| OSINT Tool | Purpose | How it can be Integrated | API Access Methods |
| --- | --- | --- | --- |
| Shodan | Detects exposed services | Shodan API can be directly integrated into back-end. This provides access to all data stored in Shodan. A Node.js library for accessing the API is available. | An API key needed for API access (free by creating an account). Can be accessed through REST API or Streaming API. |
| Have I Been Pwned | Checks breached credentials | HIBP API client can be used with Node.js by installing the HIBP package. It can be used to query the Pwnd Passwords API for breach passwords for free.  | HIBP uses a RESTful API. The free Pwnd Passwords API does not require a key to access. A subscription and key are needed for all APIs that enable searching HIBP by email address or domain. |
| ANY.RUN | Interactive malware analysis | ANY.RUN has a simple API that can be integrated into our web app, so we can automatically submit files and URLs for analysis and retrieve report data. ANY.RUN is mostly used manually as a standalone website, with the same + more functionalities. | ANY.RUN uses REST API. API keys must be generated with a ANY.RUN profile. |

