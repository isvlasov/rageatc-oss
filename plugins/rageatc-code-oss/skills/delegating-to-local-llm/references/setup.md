# First-Time Setup

Requirements: Apple Silicon Mac (omlx runs on MLX). 32 GB+ unified memory recommended for ~27B 4-bit models; smaller machines need smaller models.

Work through whichever pieces the preflight flagged, in order:

## 1. oMLX (local model server)

- Install the oMLX macOS app; it bundles the `omlx` CLI at `~/.local/bin/omlx`.
- Start the server: `omlx start` (or enable auto-start in the app). It serves an OpenAI-compatible API on `127.0.0.1:8000`.
- The API key lives at `.auth.api_key` in `~/.omlx/settings.json`.

## 2. Models

Download via the oMLX app, or place MLX-format models under `~/.omlx/models/`. Verify they appear:

```bash
curl -s -H "Authorization: Bearer $(jq -r .auth.api_key ~/.omlx/settings.json)" http://127.0.0.1:8000/v1/models
```

## 3. Pi (the subagent harness)

```bash
npm install -g @earendil-works/pi-coding-agent
```

No provider configuration needed — `omlx launch pi` writes the omlx provider into `~/.pi/agent/models.json` on every launch.

## 4. herdr (visibility and control)

- herdr installs to `~/.local/bin/herdr`; update with `herdr update`.
- The user must be running a herdr session — panes can only be spawned inside one.
- Enable Pi state reporting: `herdr integration install pi` (check with `herdr integration status`).
