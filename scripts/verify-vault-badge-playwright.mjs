/**
 * E2E: open Admin Portal dashboard and assert dynamic Vault badge.
 * Requires: http://localhost (frontend + WAF + Kong) and Keycloak user test/test.
 */
import { chromium } from "playwright";

const APP_URL = process.env.APP_URL || "http://localhost/";
const TIMEOUT = 90_000;

async function main() {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  page.setDefaultTimeout(TIMEOUT);

  try {
    await page.goto(APP_URL, { waitUntil: "domcontentloaded" });

    // Keycloak login (login-required)
    await page.waitForURL(/\/auth\/|\/realms\//, { timeout: TIMEOUT }).catch(() => {});
    const userField = page.locator("#username, input[name='username']").first();
    if (await userField.isVisible({ timeout: 15_000 }).catch(() => false)) {
      await userField.fill("test");
      await page.locator("#password, input[name='password']").first().fill("test");
      await page.locator("#kc-login, input[type='submit'], button[type='submit']").first().click();
    }

    await page.waitForURL(/localhost/, { timeout: TIMEOUT });
    await page.waitForSelector("text=Intent Admin", { timeout: TIMEOUT });
    await page.getByRole("button", { name: /Intent Admin/i }).click();

    // Dashboard tab is default; wait for metrics load (Vault badge)
    const vaultBadge = page.locator("span", { hasText: /^Vault:/ });
    await vaultBadge.waitFor({ state: "visible", timeout: TIMEOUT });
    const text = (await vaultBadge.first().innerText()).trim();
    console.log("Vault badge text:", text);

    if (!/^Vault:\s*OK$/i.test(text)) {
      throw new Error(`Expected 'Vault: OK', got '${text}'`);
    }
    console.log("PASS: Admin Portal shows dynamic Vault badge", text);
  } finally {
    await browser.close();
  }
}

main().catch((err) => {
  console.error("FAIL:", err.message);
  process.exit(1);
});
