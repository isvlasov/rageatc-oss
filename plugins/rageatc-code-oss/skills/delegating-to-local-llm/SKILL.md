---
name: delegating-to-local-llm
description: Delegates a task to a local LLM running as a Pi coding-agent session in a herdr pane - the subagent is visible in herdr, can be steered mid-session, and costs no cloud tokens. Use when delegating work to a local model, spawning a Pi subagent, offloading a task to omlx (qwen, gemma), or running agent work offline. Not for Claude Code's own Agent tool or subagents inside Pi.
---

# Delegating to a Local LLM

The subagent is an interactive Pi session pinned to a local omlx model, spawned in a herdr pane. herdr provides the whole control loop — spawn, state, read, send — and Pi's herdr integration reports working/blocked/idle automatically. The session stays visible and steerable; you own acceptance of its work.

## Preflight

```bash
uname -m                                                  # arm64 required (omlx is Apple-Silicon MLX)
KEY=$(jq -r .auth.api_key ~/.omlx/settings.json)
curl -s --max-time 3 -H "Authorization: Bearer $KEY" http://127.0.0.1:8000/v1/models
which pi && herdr agent list >/dev/null && echo ok
```

- curl fails -> `omlx start`; succeeds but lists no models -> models need downloading
- `pi` or `herdr` missing, not arm64, or first run on this machine -> walk the user through `references/setup.md`

## Delegate

1. **Pick the model** from the `/v1/models` response. The user's named choice wins; otherwise ask which model they prefer for the task. Memory headroom is model- and machine-specific: if omlx's prefill guard aborts mid-task ("Prefill context too large for available memory"), the model cannot handle the accumulated context on this machine — restart the task on a lighter model.
2. **Spawn** — short kebab task name; cwd is the project the task touches. Pin the pane to your own workspace — spawning defaults to whichever workspace the user has focused at that moment, which may not be yours:

   ```bash
   WS=$(herdr pane get "$HERDR_PANE_ID" | jq -r '.result.pane.workspace_id')
   herdr agent start <task-name> --cwd <dir> --workspace $WS --no-focus -- omlx launch pi --model <model-id> --api-key $KEY
   ```

   Capture `pane_id` from the JSON response. (`omlx launch` also rewrites Pi's omlx provider config, so it is always current.)
3. **Wait ready:** `herdr agent wait <task-name> --status idle --timeout 30000`
4. **Send the task, then submit it:**

   ```bash
   herdr agent send <task-name> "<task>"
   sleep 1 && herdr pane send-keys <pane-id> enter
   ```

   Task text is literal and single-line — shell-quote it, and make it self-contained: goal, relevant paths, done-criterion. Local models do best with one focused task.

   Confirm submission with `herdr agent wait <task-name> --status working --timeout 15000`. A timeout usually means the Enter fired before the TUI was ready — send Enter again and re-wait; if it still hasn't started, read the pane to see what state the input is in.
5. **Wait for completion:** `herdr agent wait <task-name> --status idle --timeout 600000` (10 min default — local generation is slow; scale to the task). The wait resolves on the next status change; read the status it reports: `done` means the run finished, `blocked` means Pi is asking a question (read the pane, answer via send + enter, wait again), errors also end in `done` — so always verify.
6. **Verify:** `herdr agent read <task-name> --lines 60` for the subagent's account, then check the actual outputs (files, command results) yourself. Acceptance is your judgement, not its claim.
7. **Steer if needed:** repeat steps 4–5 into the same live session.
8. **Hand over:** summarise the result, leave the pane open, and tell the user the agent name — they can jump to it with `herdr agent focus <task-name>`. Close only when the user is done: `herdr pane close <pane-id>`.

## Guardrails

- One local subagent at a time — the model occupies unified memory.
- Delegate self-contained tasks, not conversations that need your session's context.
