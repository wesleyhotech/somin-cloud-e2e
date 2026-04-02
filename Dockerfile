# Pin to a Playwright image that matches @playwright/test in package.json.
FROM mcr.microsoft.com/playwright:v1.51.0-noble

WORKDIR /app

# Reproducible install: package-lock.json must be committed (run `npm install` locally if you change package.json).
COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

COPY playwright.config.ts tsconfig.json ./
COPY tests ./tests

ENV CI=true
CMD ["npx", "playwright", "test"]
