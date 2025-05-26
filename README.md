# Multi-Stage Web Scraper with Node.js, Puppeteer & Flask
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)
![Puppeteer](https://img.shields.io/badge/Puppeteer-40B5A4?style=for-the-badge&logo=puppeteer&logoColor=white)
This project demonstrates a multi-stage Docker build that:

- 🕷️ Scrapes data from a user-provided URL using **Node.js**, **Puppeteer**, and **Chromium**
- 🐍 Serves the scraped data as JSON via a lightweight **Flask** web server
- 🐳 Uses Docker **multi-stage builds** to keep the final image small and efficient

---

## 🛠 Technologies Used

- Node.js 18 (slim)
- Puppeteer (headless browser automation)
- Chromium
- Python 3.10 (slim)
- Flask (Python web server)
- Docker (Multi-stage build)

---

## 📁 Project Structure
```text
project/
├── Dockerfile             # Multi-stage Dockerfile (Node.js + Python)
├── scrape.js              # Puppeteer script to scrape title and heading
├── server.py              # Flask server to serve scraped JSON
├── requirements.txt       # Flask dependency
```
## ⚙️ How It Works

### 1️⃣ Scraper Stage (Node.js + Puppeteer)

- Installs Chromium and Puppeteer
- Accepts a `SCRAPE_URL` as a build argument
- Uses Puppeteer to scrape:
  - `<title>` of the page
  - First `<h1>` heading
- Outputs `scraped_data.json`

### 2️⃣ Final Stage (Python + Flask)

- Copies only `scraped_data.json` into a minimal Python image
- Runs a Flask server that serves the JSON on `/`

---

## 🚀 Getting Started

### ✅ Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed on Windows 11 (or other OS)

---

### 🧱 Build the Docker Image

```bash
docker build --build-arg SCRAPE_URL=https://example.com -t scraper-server .
```

Replace https://example.com with the target website you want to scrape.


🏃 Run the Container
```bash
docker run -p 5000:5000 scraper-server
```

Then open your browser and navigate to:

http://localhost:5000

✅ Example Output

```json
{
  "title": "Example Domain",
  "heading": "Example Domain"
}
```

