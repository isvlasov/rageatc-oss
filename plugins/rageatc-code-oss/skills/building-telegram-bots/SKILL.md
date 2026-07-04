---
name: building-telegram-bots
description: Writes correct, version-aware Telegram bot code. Use when writing, extending, or debugging a Telegram bot in python-telegram-bot, aiogram, grammY, or Telegraf. Not for Telegram client API (TDLib), languages other than Python and Node.js, or non-Telegram platforms.
---

# Building Telegram Bots

Prevents stale-knowledge failures when writing Telegram bot code. The Bot API updates roughly quarterly and frameworks more often, so training-time knowledge is unreliable — this skill enforces a verification protocol (detect, fetch, confirm) before any bot code is generated.

## Scope

**Covered:** python-telegram-bot, aiogram (Python); grammY, Telegraf (Node.js)

**Not covered:** Other languages or frameworks; Telegram client API (TDLib); bot deployment and hosting; payment and monetisation APIs

## Verification Protocol

Run this protocol before writing any bot code. Do not skip steps.

### Step 1 — Detect the project framework and version

Read the project dependency manifest:

- Python project: check `pyproject.toml` first, then `requirements.txt`
- Node.js project: read `package.json` → `dependencies` and `devDependencies`

Identify which framework is present and its pinned or constrained version. If a lock file exists (`package-lock.json`, `poetry.lock`, `uv.lock`), read it for the exact resolved version.

See `references/framework-guide.md` → "Detecting Framework Version from Project Files" for manifest patterns.

### Step 2 — Identify the Bot API version the framework targets

Map the framework version to its supported Bot API version.

See `references/framework-guide.md` → "Framework Fact Sheets" for the current mapping table.

**Staleness warning:** If the project uses Telegraf v4.x, issue an explicit warning before proceeding. See `references/framework-guide.md` → "Telegraf Staleness Warning" for required warning text.

### Step 3 — Fetch the current Bot API changelog

Fetch `https://core.telegram.org/bots/api#recent-changes` to identify the current Bot API version. Compare it to the version the project's framework targets. Note any gap.

If the user is asking about a feature introduced in a Bot API version newer than the framework's support ceiling, tell them the framework does not yet support it.

### Step 4 — Fetch framework-specific documentation for the feature being built

Do not rely on training knowledge for method signatures, handler registration patterns, or type names. Fetch the framework's current documentation for the specific feature.

See `references/framework-guide.md` → "Framework Documentation URLs" for the correct URL per framework.

For versioned docs (python-telegram-bot, aiogram), use the URL pattern for the exact version found in Step 1 — not the "latest" or "stable" alias, unless the installed version matches it.

### Step 5 — Confirm all patterns are async

All current framework major versions use async/await. Synchronous bot code indicates a v13-era python-telegram-bot pattern (or aiogram v2). If the installed version is v20+ (python-telegram-bot) or v3+ (aiogram), all handler callbacks must be `async def` and all API calls must be awaited.

### Step 6 — Write the code

Write code only after completing Steps 1–5. Reference the fetched documentation, not training memory, for method signatures and parameter names.

## Common Pitfalls

**Read `references/framework-guide.md` → "Migration Traps" before working on projects that show signs of a version upgrade.** Signs include mixed sync/async patterns, old import paths, or a dependency version bump in git history.

For rate limit and webhook storm patterns, see `references/telegram-bot-api.md` → "Operational Limits" and "Webhook Storm Prevention".

## New Bot Projects — Framework Recommendation

When starting a new bot (no existing project manifest):

- **Python:** Prefer aiogram (most current Bot API support among Python frameworks). python-telegram-bot is also well-maintained.
- **Node.js:** Use grammY. Do not start new projects with Telegraf v4.

Confirm the recommendation by checking `references/framework-guide.md` → "Framework Fact Sheets" for current maintenance status before advising.

## Reference Files

Read these files when the verification protocol directs you to them. Do not load both upfront — load on demand.

- `references/telegram-bot-api.md` — Bot API structure, section anchors, operational limits, webhook vs polling
- `references/framework-guide.md` — Framework fact sheets, detection algorithms, documentation URLs, migration traps

These reference files contain version-specific data last verified on the date shown at the top of each file. If significant time has passed since that date, treat the framework versions and Bot API mappings as approximate and verify against the URLs provided in each file.
