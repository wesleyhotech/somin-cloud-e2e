## 1-minute summary

**In one line:** A Product Test on the [SoMin Cloud](https://cloud.somin.ai/) login page. The tech stack used is Playwright & TypeScript. — This is a **32-case** test-design matrix that serves as the **north star** for this product login feature. It is designed with traceability in mind: the same **scenario IDs** appear as test titles in [`tests/login.spec.ts`](tests/login.spec.ts).

**How I want you to read this (QA + PM):** From a **QA** angle, the README is risk-based coverage: happy path, field validation, authentication failures, and security-flavored edge cases — with an honest split between what the UI can prove today and what needs accounts, time, or back-end/log hooks. From a **PM** angle, it’s a readable artifact for stakeholders: clear scope, no oversold “everything is automated,” and a visible path to **phase 2** (fixtures, env, observability) without changing the story.

**What runs vs what’s documented:** Some tests **assert behavior** now; others are **pseudo-code placeholders** (skipped) until the right fixtures exist. That separation is **intentional** for a GitHub / assessment handoff — judgment over hype.

**Local (fastest):** Node.js LTS installed, then from this folder:

```bash
npm install
npx playwright install
npx playwright test
```

**Docker:** [Docker Desktop](https://docs.docker.com/get-docker/) running, then:

```bash
docker compose build
docker compose run --rm e2e
```

**Optional env:** See [`.env.example`](.env.example). Playwright does not auto-load `.env` here — set variables in your shell (e.g. PowerShell: `$env:E2E_VALID_EMAIL="you@example.com"; npx playwright test`) or add dotenv if you prefer. Never commit real credentials. `BASE_URL` changes the target. `E2E_VALID_EMAIL` enables **TC-N07** (wrong password for a known account). `E2E_VALID_EMAIL` plus `E2E_VALID_PASSWORD` extends **TC-P01** with a full successful-login check when you are ready to assert post-login behavior.

**AI in the workflow (how I’d teach it):** **Cursor** accelerated **drafting and structure**; **verification and curation** are mine — scenarios and checks were aligned to the **real UI** and to **QA risk** (validation, auth, security). That mirrors how I talk about **responsible AI use** in education: tools speed scaffolding; **you** own accuracy, privacy (no secrets in repo — `.env` is gitignored), and **disclosure**.

---

## SoMin Login Automation

Target website: [https://cloud.somin.ai/](https://cloud.somin.ai/)

This project is designed to automatically check the login page with a web browser.


## Test Plan (Simple)
1. **Environment:** Docker  (**SKIPPED FOR NOW**)
2. **Framework:** Playwright  
3. **Language:** TypeScript  
4. **Execution:** One-click setup (**SKIPPED FOR NOW**)
Prepared with help from **Cursor** and **DeepSeek**.


## Important files (where to look)
- `tests/login.spec.ts` -> Main test scenarios (actual automated test plan)
- `playwright.config.ts` -> Base URL and Playwright settings
- `.env.example` -> Optional env vars template (no secrets committed)
- `Dockerfile` -> Docker image for test execution
- `docker-compose.yml` -> Easy command to run test in Docker
- `package.json` -> Dependencies and run scripts
- `README.md` -> This document


## One-click style run (Docker)
Prerequisite: [Docker Desktop](https://docs.docker.com/get-docker/) installed and running.
From this folder, run:
```
powershell
docker compose build
docker compose run --rm e2e
```


## Notes 
- The project is structured for Docker-first execution.
- True zero-setup one-click is marked as **SKIPPED FOR NOW**.
- Current practical requirement is Docker installed on runner machine.


## Test Scenarios — Login Form (cloud.somin.ai)
## 1. Positive Scenarios

| ID | Scenario | Description |
|----|----------|-------------|
| **TC-P01** | Valid credentials (baseline) | Login with exact email case as stored |
| **TC-P02** | Valid credentials with mixed-case email | Email entered with mixed capitalization (e.g., User@Example.com) |
| **TC-P03** | "Remember Me" — Session persistence | User stays logged in after browser restart |
| **TC-P03a** | "Remember Me" — Unchecked | User is logged out after browser close |
| **TC-P03b** | "Remember Me" — Cookie expiration | Session cookie expires after configured duration (e.g., 14-30 days) |
| **TC-P04** | New device detection | System prompts user to trust new device for 30 days |
| **TC-P05** | Redirect after login | User redirected to dashboard or original protected page |
| **TC-P06** | Login timestamp | Last login timestamp recorded in system logs |

---

## 2. Negative Scenarios — Field Validation

| ID | Scenario | Description |
|----|----------|-------------|
| **TC-N01** | Empty email, valid password | Email field left empty, password entered |
| **TC-N02** | Valid email, empty password | Email entered, password field left empty |
| **TC-N03** | Both fields empty | Both email and password fields left empty |
| **TC-N04** | Invalid email format (missing @) | Email entered without "@" symbol (e.g., userexample.com) |
| **TC-N05** | Invalid email format (incomplete) | Email entered with "@" but no domain (e.g., user@) |
| **TC-N06** | Email with leading/trailing spaces | Email entered with spaces before or after (e.g., " user@example.com ") |

---

## 3. Negative Scenarios — Authentication

| ID | Scenario | Description |
|----|----------|-------------|
| **TC-N07** | Wrong password for existing user | Valid email with incorrect password |
| **TC-N08** | Non-existent user | Email not registered in system with any password |
| **TC-N09** | Account lockout after multiple failures | Multiple failed login attempts (e.g., 5x wrong password) |
| **TC-N10** | Expired password | Valid email with expired password |
| **TC-N10a** | Expired password — reset flow | After expired password detection, user completes password reset |
| **TC-N11** | Expired password — cannot bypass | After expiry, user cannot access protected pages without resetting |

---

## 4. Security & Edge Cases

| ID | Scenario | Description |
|----|----------|-------------|
| **TC-S01** | SQL injection in email field | Email field contains SQL injection attempt (e.g., `' OR '1'='1`) |
| **TC-S02** | SQL injection in password field | Password field contains SQL injection attempt |
| **TC-S03** | XSS attempt in email field | Email field contains script injection (e.g., `<script>alert('xss')</script>`) |
| **TC-S04** | Password field masking | Password characters are masked (bullets/asterisks) during input |
| **TC-S05** | Long email (>254 characters) | Very long email entered — system handles without crash |
| **TC-S06** | Long password (>128 characters) | Very long password entered — system handles without crash |
| **TC-S07** | Special characters in email | Email with plus sign (e.g., user+test@example.com) — accepted or validated |
| **TC-S08** | No credentials in URL | Login form submits via POST — credentials not visible in browser URL |
| **TC-S09** | Shared device warning | Warning text appears near "Remember Me" checkbox for shared/public computers |
| **TC-S10** | Session revocation | User can view and revoke active sessions from security settings |
| **TC-S11** | Concurrent sessions | User can log in from multiple devices simultaneously |
| **TC-S12** | Brute force protection | Rapid login attempts trigger rate limiting or temporary block |

---

## Summary

| Category | Count |
|----------|-------|
| Positive Scenarios | 8 |
| Negative Scenarios — Field Validation | 6 |
| Negative Scenarios — Authentication | 6 |
| Security & Edge Cases | 12 |
| **Total** | **32** |

#END#
