---
name: writing-skills
description: Creates and updates Claude Code Agent Skills. Use when creating a skill, revising SKILL.md, improving a skill's name or description, or adding progressive disclosure files.
---

# Writing Skills

The reader of every skill is an agent. A line earns its place only if it changes the agent's behaviour versus what it would do anyway — text the agent already knows, filler, and repetition are bloat. Apply that test to every line you write.

The same test scales up. Prefer the simplest thing that fixes an observed failure — often that is nothing at all: if the model already handles the task well, don't write the skill; if a line answers an imagined problem, don't write the line. Simple beats clever, and YAGNI applies to skills as much as to code.

If the skill's intent, triggers, or location (personal `~/.claude/skills/`, project `.claude/skills/`, or a plugin's `skills/`) are unclear, ask before writing.

## How skills load

Three tiers drive every design decision:

1. **Always in context:** every installed skill's `name` and `description` (plus `when_to_use` if set), ~100 tokens each. The listing caps `description` + `when_to_use` at 1,536 chars combined; when the total listing budget overflows, least-used skills' descriptions are truncated first (`/doctor` shows this). At library scale, every description word is a recurring cost.
2. **On trigger:** the SKILL.md body. Keep under ~500 lines / ~5,000 tokens.
3. **On demand:** bundled files, loaded only when referenced. Free until read.

## Workflow

### Step 1 — Choose the invocation mode first

Decide before writing anything else; it shapes the description and the body:

- **Model-invoked** (default): the agent discovers it by description match. Needs a rich trigger description.
- **User-invoked only** (`disable-model-invocation: true`): for task skills with side effects (deploy, commit) or skills the user deliberately runs as `/name`. The description becomes a short human-facing summary — the user, not the matcher, is the audience.
- **Model-only** (`user-invocable: false`): background knowledge; hidden from the `/` menu.

### Step 2 — Name it

Lowercase letters, numbers, hyphens; ≤64 chars; must match the folder name; no "claude" or "anthropic" (reserved). Prefer gerund form (`reviewing-code`). Avoid generic terms (`helper`, `utils`, `tools`).

### Step 3 — Write the description

The description carries discovery — it deserves harder pruning than the body.

- Third person. State what the skill does AND when to use it, with the trigger keywords a user would actually say. Front-load the distinctive words.
- One trigger per genuinely distinct use case; collapse synonyms rather than listing them.
- ≤1,024 chars. No `: ` inside the text (breaks YAML parsing — use em-dashes or rephrase). No XML angle brackets anywhere in frontmatter.
- If it could over-trigger, add explicit exclusions ("Not for X").
- **Do not summarise the workflow in the description.** An agent may act on the description alone and skip the body — a description that reads like the method invites shortcutting it.

### Step 4 — Write the body

- Imperative voice ("Run the script", not "The script should be run"). Forward slashes in all paths. MCP tools fully qualified (`ServerName:tool_name`).
- State the degree of freedom and match strictness to fragility: high (heuristics, judgement), medium (preferred pattern with parameters), low (exact steps, guardrails). One clear default beats a menu of options; add guardrails, options, or process only against observed failures, never imagined ones.
- Structure follows content — there are no mandatory sections. Do NOT write: a Purpose section restating the description; when-to-use text in the body (the description's job); evaluation scenarios in the body (they live in `evals/`, Step 6); piled-up MUST/ALWAYS/CRITICAL (state the expectation once, plainly).
- Use checklists for fragile multi-step sequences so the agent can tick them off.
- No time-sensitive content inline (model IDs, versions, "new in..."). If unavoidable, isolate it in a clearly-marked old-patterns block.

### Step 5 — Split when paths diverge

Inline what every usage path needs; push behind a pointer what only some paths reach. Splitting is also the pressure valve as the body approaches the ~500-line ceiling.

- `references/` — docs the agent consults while working (schemas, standards). Loaded on demand. Give any file over ~100 lines a table of contents; add grep hints for very large files. Keep references one level deep from SKILL.md — nested chains get partially read.
- `assets/` — templates and files used in output. Never loaded into context.
- `scripts/` — deterministic work the agent would otherwise rewrite each time. Only output consumes tokens. Scripts must handle their own errors (solve, don't punt to the agent) and document any non-obvious constants. Say whether to execute or read each script.

Information lives in exactly one place — never in SKILL.md and a reference both. Do not create README, CHANGELOG, or other extraneous files in the skill folder.

### Step 6 — Test in proportion to stakes

Always run the baseline: try the task without the skill and record where the model actually fails. If it doesn't fail, stop — the skill isn't needed.

Full evals earn their cost when a skill enforces discipline, runs unattended, or risks over-triggering: 3+ scenarios drawn from the observed failures, including at least one **should-NOT-trigger** case (a nearby request the skill must leave alone). Store them in `evals/` inside the skill folder — not in the body. Grade outcomes, not paths (agents find valid unexpected routes), and test each model tier the skill serves.

For a simple user-invoked task skill, one dry run of the happy path is enough.

### Step 7 — Final check

- [ ] Invocation mode set deliberately (Step 1), frontmatter fields per the table below
- [ ] Description: third person, triggers, no workflow summary, survives the pruning pass
- [ ] Body under ~500 lines, no forbidden sections (Step 4), one concept in one place
- [ ] References one level deep; each bundled file earns its type (Step 5)
- [ ] Baseline confirmed the skill is needed; tested in proportion to stakes (Step 6)

## Frontmatter reference

Required: `name`, `description`. Optional (one line each — check current Claude Code docs when in doubt; this surface grows quickly):

| Field | Use for |
|---|---|
| `disable-model-invocation: true` | User-only task skills (side effects; `/name` invocation) |
| `user-invocable: false` | Model-only background knowledge; hides from `/` menu |
| `when_to_use` | Extra trigger context, appended to description in the listing |
| `allowed-tools` / `disallowed-tools` | Restrict tool access when the workflow warrants it |
| `context: fork` + `agent` | Run the skill in a forked subagent |
| `argument-hint`, `arguments` | Named/positional args via `$ARGUMENTS`, `$name`, `$N` |
| `paths` | Glob-scoped auto-activation |
| `model`, `effort` | Pin only when necessary — pinned model IDs go stale |
| `hooks`, `shell`, `compatibility`, `metadata`, `license` | Niche; quote metadata values (`version: "1.0"`) |

Dynamic values can be injected with `` !`command` `` syntax.

## Updating an existing skill

Make the smallest change that fixes an observed failure — tighten the description or add a missing trigger before adding content. After deployment, watch real usage: files never read are unnecessary; sections the agent re-reads belong in the body; reference chains it fails to follow are too deep. When a fix applies broadly, update the shared skill rather than cloning near-duplicates. Periodically re-run the baseline test (Step 6.1) — if the model now passes without the skill, retire it.
