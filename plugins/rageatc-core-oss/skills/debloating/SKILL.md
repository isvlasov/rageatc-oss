---
name: debloating
description: Raises an artefact's signal-to-noise ratio by removing text that earns nothing for its reader — filler, repetition, over-explanation, ornamental phrasing — and relocating conditional detail to references. Use to slim a skill, agent, or document, cut bloat, tighten prose, or shrink a file that has grown too long. Tuned for SKILL.md files.
---

# Debloating

## What counts as bloat

**Bloat is text that changes nothing for its reader.** The reader is usually the agent, but not always — Step 0 confirms who. Text fails it when: the reader already knows it, it is filler or ceremony, it repeats something already said.

This is judged against the artefact's intent. Without an agreed intent, signal and noise are indistinguishable.

## Scope

- The unit is one file. Read related assets (another skill, a rule, the agent that preloads this skill) only when a specific cut needs that context — for example, to confirm a passage is duplicated elsewhere or already known to the reader. Most files need none of this.
- Tuned for skills; works on any prose artefact.
- Frontmatter descriptions are in scope — they are often bloated. Debloat them too, but preserve the trigger keywords and discoverability that let the skill be found; do not cut past the point where routing still works.
- Flag, do not fix, anything that is not a cut: contradictions, overlap with another skill, aged assumptions, "should this exist at all". Raise it and let the user decide.

## Workflow

### Step 0 — Agree the intent (always first)

Read the whole artefact. State back, and confirm with the user, three things: **why it exists** (its intent), **who the reader is** (usually the agent, sometimes a human), and **what matters to that reader**. These are the measuring stick for every judgement that follows — cut nothing before they are agreed.

### Step 1 — Classify every passage

Sort candidate text by what removing it costs:

- **Tier 1 — lossless removal.** Text that fails the test above: no signal. Filler, ceremony, internal repetition, explaining what the reader already knows.
- **Tier 2 — lossless compression.** The instruction stays; the ornament goes. Same load, shorter and plainer words.
- **Tier 3 — lossy reduction.** Real but marginal signal, removed because the text-to-value ratio is poor — a small loss for a large saving.
- **Offload.** Detail that is genuinely needed but only sometimes (edge cases, long schemas, example catalogues) moves to `references/` with a one-line pointer. Rule: what is needed on every invocation stays in the body; what is needed only conditionally is relocated, not deleted.

**Common SKILL.md offenders:**

- `## Purpose` restating the description — Tier 1.
- When-to-use text, by load mode: subagent-loaded or slash-invoked — the loader already decided, cut it; orchestrator-discovered — a brief "skip when" may stay as self-correction, but "use when" goes (that is the description's job).
- `## Evaluation Scenarios` / `## Success Indicators` — author-facing test material the executing agent never acts on. Cut or offload.
- Piled-up MUST / ALWAYS / CRITICAL — compensation for an unclear expectation, not emphasis. State the expectation once, plainly (Tier 2).
- Ceremony: template sections that are always N/A, tracking nothing downstream reads, multi-stage process where one stage would do.
- Per-step scaffolding labels ("What you're doing:", "Output:") narrating the structure they sit in — Tier 2.
- Handoff text explaining what the *next* skill does — that skill's own job; keep only what to pass it.
- End-of-file "Quick Reference" / recap sections summarising the file they sit in — the reader just read it; internal repetition (Tier 1). Common in reference files.
- Pseudo-quantification: invented numeric precision (± percentage-point confidence adjustments, unsourced distribution percentages) dressing qualitative judgement as arithmetic — changes no action and often contradicts the artefact's own calibration rules (Tier 3).

**Protect:** deliberate emphasis (singular and placed — not piled-up shouting) and load-bearing method — the actual *how*. When unsure whether something carries weight, treat it as Tier 3 and surface it. Never cut silently.

### Step 2 — Present before applying

Show the proposal grouped by tier, so the decisions are visible:

- **Tiers 1 and 2** — list the cuts; one approval covers them, since they are lossless.
- **Tier 3** — itemise each cut with its trade ("lose X, save N lines"); the user accepts or rejects each.
- **Offload** — name the destination file and the pointer that will replace the moved text.

### Step 3 — Apply and review

Edit the file in place — but if the artefact is a deployed or installed copy (e.g. an installed plugin's skill), edit its source instead. Apply the approved cuts and offloads. The user reviews the result via `git diff`.

When an artefact exhibits a bloat pattern this file doesn't name, flag it to the user so it can be added to this skill's offenders list.
