---
name: playwright-cli
description: Automates browser interactions. Use when navigating websites, interacting with web pages, filling forms, taking screenshots, testing web applications, or extracting data from web pages.
allowed-tools: Bash(playwright-cli:*)
---

# Browser Automation with playwright-cli

Workflow: `open` a browser, `goto` a page, read the snapshot the CLI returns, then interact with elements via their refs (`e15`) from that snapshot.

## Commands

### Core

```bash
playwright-cli open
# open and navigate right away
playwright-cli open https://example.com/
playwright-cli goto https://playwright.dev
playwright-cli type "search query"
playwright-cli click e3
playwright-cli dblclick e7
playwright-cli fill e5 "user@example.com"
playwright-cli drag e2 e8
playwright-cli drop e5 --path=./file.png   # drop files onto an element from outside the page
playwright-cli drop e5 --data="k=v"        # drop data onto an element
playwright-cli hover e4
playwright-cli select e9 "option-value"
playwright-cli upload ./document.pdf
playwright-cli check e12
playwright-cli uncheck e12
playwright-cli snapshot
playwright-cli snapshot --filename=after-click.yaml
playwright-cli eval "document.title"
playwright-cli eval "el => el.textContent" e5
playwright-cli dialog-accept
playwright-cli dialog-accept "confirmation text"
playwright-cli dialog-dismiss
playwright-cli resize 1920 1080
playwright-cli close
```

### Navigation

```bash
playwright-cli go-back
playwright-cli go-forward
playwright-cli reload
```

### Keyboard

```bash
playwright-cli press Enter
playwright-cli press ArrowDown
playwright-cli keydown Shift
playwright-cli keyup Shift
```

### Mouse

```bash
playwright-cli mousemove 150 300
playwright-cli mousedown
playwright-cli mousedown right
playwright-cli mouseup
playwright-cli mouseup right
playwright-cli mousewheel 0 100
```

### Save as

```bash
playwright-cli screenshot
playwright-cli screenshot e5
playwright-cli screenshot --filename=page.png
playwright-cli screenshot --hires        # full device pixel ratio
playwright-cli pdf --filename=page.pdf
```

### Tabs

```bash
playwright-cli tab-list
playwright-cli tab-new
playwright-cli tab-new https://example.com/page
playwright-cli tab-close
playwright-cli tab-close 2
playwright-cli tab-select 0
```

### Storage

```bash
playwright-cli state-save
playwright-cli state-save auth.json
playwright-cli state-load auth.json

# Cookies
playwright-cli cookie-list
playwright-cli cookie-list --domain=example.com
playwright-cli cookie-get session_id
playwright-cli cookie-set session_id abc123
playwright-cli cookie-set session_id abc123 --domain=example.com --httpOnly --secure
playwright-cli cookie-delete session_id
playwright-cli cookie-clear

# LocalStorage — same verbs exist for sessionstorage-*
playwright-cli localstorage-list
playwright-cli localstorage-get theme
playwright-cli localstorage-set theme dark
playwright-cli localstorage-delete theme
playwright-cli localstorage-clear
```

### Network

```bash
playwright-cli route "**/*.jpg" --status=404
playwright-cli route "https://api.example.com/**" --body='{"mock": true}'
playwright-cli route-list
playwright-cli unroute "**/*.jpg"
playwright-cli unroute
```

### DevTools

```bash
playwright-cli console
playwright-cli console warning
playwright-cli network
playwright-cli show              # open browser devtools
playwright-cli devtools-start    # alias for show
playwright-cli run-code "async page => await page.context().grantPermissions(['geolocation'])"
playwright-cli tracing-start
playwright-cli tracing-stop
playwright-cli video-start
playwright-cli video-stop video.webm
```

## Open parameters

```bash
# Browser runs headless by default. Pass --headed to open a visible browser window.
# This is a session-creation flag — it cannot be toggled after open.
playwright-cli open --headed
playwright-cli open --headed https://example.com/
playwright-cli open --headed --browser=firefox https://example.com/

# Use --no-sandbox when running in restricted environments (containers, CI)
playwright-cli open --no-sandbox

# Use specific browser when creating session
playwright-cli open --browser=chrome
playwright-cli open --browser=firefox
playwright-cli open --browser=webkit
playwright-cli open --browser=msedge

# Use persistent profile (by default profile is in-memory)
playwright-cli open --persistent
# Use persistent profile with custom directory
playwright-cli open --profile=/path/to/profile

# Start with config file (default: .playwright/cli.config.json)
playwright-cli open --config=my-config.json

# Close the browser
playwright-cli close
# Delete user data for the default session
playwright-cli delete-data
```

## Attach to an existing browser

```bash
playwright-cli attach --extension=chrome   # connect via Playwright Extension
playwright-cli attach --cdp=chrome         # attach to running Chrome/Edge by channel
playwright-cli attach --cdp=<url>          # attach via CDP endpoint
playwright-cli detach                      # detach, leaving the external browser running
```

## Install browsers

Install browsers that are not already available. Required when using Firefox or WebKit on a fresh system.

```bash
playwright-cli install-browser
playwright-cli install-browser --browser=firefox
playwright-cli install-browser --browser=webkit
```

## Snapshots

After each command, playwright-cli provides a snapshot of the current browser state.

```bash
> playwright-cli goto https://example.com
### Page
- Page URL: https://example.com/
- Page Title: Example Domain
### Snapshot
[Snapshot](.playwright-cli/page-2026-02-14T19-22-42-679Z.yml)
```

You can also take a snapshot on demand with `playwright-cli snapshot`. If `--filename` is not provided, a new snapshot file is created with a timestamp. Default to automatic naming; use `--filename=` when the artifact is part of the workflow result.

## Browser Sessions

```bash
# create new browser session named "mysession" with persistent profile
playwright-cli -s=mysession open example.com --persistent
# same with manually specified profile directory (use when requested explicitly)
playwright-cli -s=mysession open example.com --profile=/path/to/profile
playwright-cli -s=mysession click e6
playwright-cli -s=mysession close  # stop a named browser
playwright-cli -s=mysession delete-data  # delete user data for persistent session

playwright-cli list
# Close all browsers
playwright-cli close-all
# Forcefully kill all browser processes
playwright-cli kill-all
```

## Local installation

If a globally available `playwright-cli` binary is missing or fails, install the CLI locally: `npm install -g @playwright/cli@latest`. Note the package is `@playwright/cli` — the unscoped npm package `playwright-cli` is an unrelated legacy package.

## Security defaults

- `file://` URLs are blocked by default — only `http:`, `https:`, `about:`, and `data:` schemes are allowed
- File uploads are restricted to the workspace root
- These are security defaults, not bugs

## Specific tasks

* **Request mocking** [references/request-mocking.md](references/request-mocking.md)
* **Running Playwright code** [references/running-code.md](references/running-code.md)
* **Browser session management** [references/session-management.md](references/session-management.md)
* **Storage state (cookies, localStorage)** [references/storage-state.md](references/storage-state.md)
* **Test generation** [references/test-generation.md](references/test-generation.md)
* **Tracing** [references/tracing.md](references/tracing.md)
* **Video recording** [references/video-recording.md](references/video-recording.md)
