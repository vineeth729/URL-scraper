const fs = require('fs');
const puppeteer = require('puppeteer');

(async () => {
  const url = process.env.SCRAPE_URL;
  if (!url) {
    console.error('❌ SCRAPE_URL environment variable not set.');
    process.exit(1);
  }

  const browser = await puppeteer.launch({
    headless: true,
    executablePath: process.env.PUPPETEER_EXECUTABLE_PATH || '/usr/bin/chromium',
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });

  const page = await browser.newPage();
  await page.goto(url, { waitUntil: 'domcontentloaded' });

  const data = await page.evaluate(() => ({
    title: document.title,
    heading: document.querySelector('h1')?.innerText || 'No <h1> found'
  }));

  fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));
  await browser.close();
})();
