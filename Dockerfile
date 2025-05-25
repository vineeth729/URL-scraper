# Stage 1: Scrape with Node.js + Puppeteer + Chromium
FROM node:18-slim AS scraper

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

RUN apt-get update && apt-get install -y \
    chromium fonts-liberation && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY scrape.js ./
RUN npm install puppeteer

ARG SCRAPE_URL
ENV SCRAPE_URL=$SCRAPE_URL

RUN node scrape.js

# Stage 2: Final Flask server image
FROM python:3.10-slim

WORKDIR /app

COPY server.py requirements.txt ./
COPY --from=scraper /app/scraped_data.json ./

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["python", "server.py"]
