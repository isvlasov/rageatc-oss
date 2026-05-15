# Framework Guide

*Last verified: 2026-03-15. Fetch the changelog URLs below to confirm current versions before advising.*

## Framework Fact Sheets

### python-telegram-bot

| Field | Value |
|-------|-------|
| Current stable version | 22.6 |
| Release date | 2026-01-24 |
| Bot API supported | 9.3 |
| Python requirement | >=3.10 |
| Maintenance status | Actively maintained |

**Documentation URLs:**

| Resource | URL |
|----------|-----|
| Stable docs | `https://docs.python-telegram-bot.org/en/stable/` |
| Versioned docs | `https://docs.python-telegram-bot.org/en/v{VERSION}/` |
| Changelog | `https://docs.python-telegram-bot.org/en/stable/changelog.html` |
| PyPI | `https://pypi.org/project/python-telegram-bot/` |
| GitHub releases | `https://github.com/python-telegram-bot/python-telegram-bot/releases` |
| Wiki (all migration guides) | `https://github.com/python-telegram-bot/python-telegram-bot/wiki` |
| v13 → v20 migration guide | `https://github.com/python-telegram-bot/python-telegram-bot/wiki/Transition-guide-to-Version-20.0` |

**Package name note:** PyPI package name is `python-telegram-bot` (hyphens). Import name is `telegram` (e.g., `from telegram import Bot`). These differ — do not confuse them when reading dependency files.

---

### aiogram

| Field | Value |
|-------|-------|
| Current stable version | 3.26.0 |
| Release date | 2026-03-02 |
| Bot API supported | 9.5 |
| Python requirement | >=3.10, <3.15 |
| Maintenance status | Actively maintained |

**Documentation URLs:**

| Resource | URL |
|----------|-----|
| Latest docs | `https://docs.aiogram.dev/en/latest/` |
| Versioned docs | `https://docs.aiogram.dev/en/v{VERSION}/` |
| Changelog | `https://docs.aiogram.dev/en/latest/changelog.html` |
| v2 → v3 migration guide | `https://docs.aiogram.dev/en/latest/migration_2_to_3.html` |
| PyPI | `https://pypi.org/project/aiogram/` |
| GitHub releases | `https://github.com/aiogram/aiogram/releases` |

**Note:** The v2 → v3 migration guide is marked "in progress" by maintainers. Treat it as a breaking-changes reference, not a step-by-step tutorial.

---

### grammY

| Field | Value |
|-------|-------|
| Current stable version | 1.41.1 |
| Release date | 2026-03-02 |
| Bot API supported | 9.5 |
| Runtime support | Node.js, Deno, Bun |
| Maintenance status | Actively maintained |

**Documentation URLs:**

| Resource | URL |
|----------|-----|
| Documentation home | `https://grammy.dev/` |
| Getting started | `https://grammy.dev/guide/getting-started` |
| Guide overview | `https://grammy.dev/guide/` |
| API reference | `https://grammy.dev/ref/core/` |
| Rate limits / flood control | `https://grammy.dev/advanced/flood` |
| Changelog (GitHub Releases) | `https://github.com/grammyjs/grammY/releases` |
| GitHub repo | `https://github.com/grammyjs/grammY` |

**Note:** grammY does not maintain a separate CHANGELOG.md; all changelog entries are in GitHub Releases.

---

### Telegraf

| Field | Value |
|-------|-------|
| Current stable version | 4.16.3 |
| Bot API supported | **7.1 only** |
| Maintenance status | **Feature-frozen / stale** |

**Documentation URLs:**

| Resource | URL |
|----------|-----|
| Docs (v4) | `https://telegraf.js.org/` |
| GitHub releases | `https://github.com/telegraf/telegraf/releases` |
| v3 → v4 migration reference | `https://github.com/telegraf/telegraf/releases/tag/v4.0.0` |

## Telegraf Staleness Warning

When a project uses Telegraf v4, issue this warning to the user before writing any code:

> **Warning:** This project uses Telegraf v4, which only supports Bot API 7.1. The current Bot API is {current version — fetch from `https://core.telegram.org/bots/api#recent-changes`}. Bot API features introduced after 7.1 (including reactions, boost management, `setChatMemberTag`, and other modern features) are not available in Telegraf v4 and cannot be added without replacing the framework.
>
> Telegraf v4 support ended in February 2025. A v5 was announced but has not been released as of the last verification date.
>
> **Recommendation:** For new Node.js bots, use grammY. For existing Telegraf projects, confirm the required features are within Bot API 7.1 scope before proceeding.

After issuing the warning, continue only if the user confirms they want to proceed with Telegraf v4 and the required feature is within Bot API 7.1 scope.

## Framework-to-Bot-API Version Mapping

*Approximate mapping — fetch framework changelogs to verify exact version boundaries.*

| Framework version | Bot API supported |
|-------------------|-------------------|
| aiogram >= 3.26.0 | 9.5 |
| grammY >= 1.41.0 | 9.5 |
| grammY >= 1.40.0 | 9.4 |
| python-telegram-bot >= 22.6 | 9.3 |
| telegraf any 4.x | 7.1 |

## Detecting Framework Version from Project Files

### Python projects

**Detection order:**

1. Check for `pyproject.toml` (modern projects — check `[project].dependencies` and `[tool.poetry.dependencies]`)
2. Fall back to `requirements.txt`
3. Look for `python-telegram-bot` (hyphens, PyPI name) or `aiogram`
4. Extract the version constraint; the left-most pinned version indicates the API target

**pyproject.toml examples:**

```toml
[project]
dependencies = [
    "python-telegram-bot==22.6",
    "aiogram>=3.26.0",
]

# Poetry variant:
[tool.poetry.dependencies]
python-telegram-bot = "^22.6"
aiogram = "^3.26.0"
```

**requirements.txt example:**

```
python-telegram-bot==22.6
aiogram==3.26.0
```

### Node.js projects

**Detection order:**

1. Read `package.json` → `dependencies` and `devDependencies`
2. Key `"grammy"` → grammY framework
3. Key `"telegraf"` → Telegraf framework
4. Check `package-lock.json` or `yarn.lock` for the exact resolved version if the constraint is a range

**package.json example:**

```json
{
  "dependencies": {
    "grammy": "^1.41.1"
  }
}
```

## Migration Traps

Read this section when a project shows signs of a version upgrade: mixed sync/async patterns, old import paths, or a dependency version bump in git history.

### python-telegram-bot v13 → v20

v20.0 rewrote the entire architecture from synchronous/threaded to fully async (`asyncio`). Code written for v13 will not run under v20+.

Key changes:
- All `Bot` methods now require `await`
- `Dispatcher` replaced by `Application`
- Handler filters moved to `telegram.ext.filters` sub-module
- v13: `dispatcher.add_handler(MessageHandler(Filters.text, callback))`
- v20+: `application.add_handler(MessageHandler(filters.TEXT, callback))` with `async def callback`

**Migration guide:** `https://github.com/python-telegram-bot/python-telegram-bot/wiki/Transition-guide-to-Version-20.0`

Breaking changes for v21 and v22 are documented only in the changelog — no standalone migration guide exists for those versions.

### aiogram v2 → v3

Three major breaking patterns:

1. `Dispatcher` no longer accepts a `Bot` in `__init__` — pass the bot only at `dispatcher.start_polling(bot)` or webhook start
2. State filter behaviour changed — in v2, omitting a state filter matched all states; in v3, it matches only handlers with no state
3. Enums moved to `aiogram.enums` sub-package (e.g., `aiogram.enums.ChatType`)

**Migration guide:** `https://docs.aiogram.dev/en/latest/migration_2_to_3.html` (noted as incomplete by maintainers)

### Telegraf v3 → v4

No standalone migration guide exists. Migration context is in the v4.0.0 release notes only:
`https://github.com/telegraf/telegraf/releases/tag/v4.0.0`
