---
name: delegating-to-codex
description: Delegates a task to OpenAI Codex running as an interactive session in a herdr pane - uses the user's ChatGPT subscription, visible in herdr, steerable mid-session. Use when delegating work to codex, offloading a task to a GPT model (sol, terra, luna), or running a second opinion from a non-Claude frontier model. Not for Claude Code's own Agent tool or local-LLM delegation (delegating-to-local-llm).
---

# Delegating to Codex

The subagent is an interactive Codex CLI session in a herdr pane, billed to the user's ChatGPT subscription. herdr provides the control loop — spawn, state, read, send — and its codex integration reports state automatically. The session stays visible and steerable; you own acceptance of its work.

## Preflight

```bash
which codex && codex login status && herdr agent list >/dev/null && echo ok
```

Fixes: `npm install -g @openai/codex` to install; `codex login` if not logged in (interactive — hand to the user); `herdr integration install codex` if the integration is missing; herdr itself requires the user to be inside a herdr session.

## Model and effort

Pass both explicitly — the user's `~/.codex/config.toml` defaults may lag behind the current family. Current family (5.6, mid-2026 — verify with the user when in doubt):

| Model | Effort | Use for |
|---|---|---|
| `gpt-5.6-terra` | `high` | Default worker — solid for most delegated tasks |
| `gpt-5.6-sol` | `medium` | Harder reasoning, design questions, second opinions |
| `gpt-5.6-luna` | `medium` | Quick, light tasks |

## Delegate

1. **Spawn with the task as the prompt argument** — short kebab task name; cwd is the project the task touches. Pin the pane to your own workspace — spawning defaults to whichever workspace the user has focused at that moment. Do NOT send the initial task via `herdr agent send`: the starting TUI can swallow the head of the text (observed: a task beginning "Create a file zdravstvuy.txt" arrived as ".txt ..."). The prompt argument avoids this entirely:

   ```bash
   WS=$(herdr pane get "$HERDR_PANE_ID" | jq -r '.result.pane.workspace_id')
   herdr agent start <task-name> --cwd <dir> --workspace $WS --no-focus -- \
     codex -m <model-id> -c model_reasoning_effort="<effort>" --sandbox workspace-write -a never "<task>"
   ```

   Task text is single-line and self-contained: goal, relevant paths, done-criterion — Codex has not read your conversation. Capture `pane_id` from the JSON response. Add `--search` when the task needs the web. The sandbox/approval pair keeps the subagent autonomous but write-restricted to its workspace; escalate to a different sandbox mode only with the user's consent.
2. **Confirm it started:** `herdr agent wait <task-name> --status working --timeout 30000`. On timeout, read the pane to see what state the session is in.
3. **Wait for completion:** `herdr agent wait <task-name> --status idle --timeout 600000` (scale to the task). The wait resolves on the next status change; read the status it reports: a finished run settles to idle, `blocked` means Codex is waiting on input (read the pane, respond via send + enter, wait again), and errors also settle — so always verify.
4. **Verify:** `herdr agent read <task-name> --lines 60` for the subagent's account, then check the actual outputs (files, command results) yourself. Acceptance is your judgement, not its claim.
5. **Steer if needed** — by now the TUI is fully alive, so send is safe:

   ```bash
   herdr agent send <task-name> "<follow-up>"
   sleep 1 && herdr pane send-keys <pane-id> enter
   ```

   Then repeat steps 2–4. If the working-wait times out, the Enter raced the composer — send Enter again.
6. **Hand over:** summarise the result, leave the pane open, and tell the user the agent name — they can jump to it with `herdr agent focus <task-name>`. Close only when the user is done: `herdr pane close <pane-id>`.

## Guardrails

- Delegate self-contained tasks; keep multi-task work as separate delegations or steers, not one sprawling prompt.
