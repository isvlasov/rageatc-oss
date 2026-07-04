---
name: planning-software
description: Transforms an approved enriched roadmap into an orchestration plan. Use when creating an orchestration plan, producing a build plan, or resuming a project from a saved plan. Not for roadmap creation/enrichment or workflow tier selection.
---

# Planning Software

Produces an orchestration plan from an approved enriched roadmap. The plan is the orchestrator's execution contract — it records the workflow tier, tracks chunk progress, and holds everything project-specific a fresh session needs to resume; the execution protocol itself lives in orchestrating-software-dev, which any resuming session loads.

The plan describes **process** (agent sequence, review perspectives, gates); the roadmap describes **content** (what to build in each chunk). Separate documents, separate owners — never duplicate roadmap content into the plan.

**Inputs** (request anything missing before proceeding): approved enriched ROADMAP.md; workflow tier (decided upstream by orchestrating-software-dev); project name; confirmation that PRD.md and ARCHITECTURE.md exist (referenced, not duplicated).

**Outputs:** ORCHESTRATION-PLAN.md (the workflow contract) and an empty append-only ORCHESTRATION-LOG.md, both in the project root.

**Not covered:** roadmap creation/enrichment, tier selection, the per-chunk execution protocol and log entry format (both defined in orchestrating-software-dev).

## Workflow

### Step 1: Read the enriched roadmap

Read ROADMAP.md completely. Note: total chunk count and IDs; phased (Thorough) or flat; parallel dispatch annotations; any chunk already in-progress.

### Step 2: Determine plan depth from workflow tier

| Tier | Plan depth |
|------|------------|
| Quick | Short — no phases section, flat chunk list, no whole-project review step |
| Standard | Full — sequential chunks, whole-project review at end |
| Thorough | Full with phases — phase groupings, parallel dispatch annotations, whole-project review at end |

### Step 3: Write the orchestration plan

Populate the Template below:

- **Header** — project name, tier, date, pointers to upstream artefacts
- **Upstream steps** — mark all complete (they are done by the time this skill runs). Quick lists PRD + architecture only; Standard/Thorough add interface design, decomposition, enrichment.
- **Build Progress** — one todo per chunk, chunk-level only (no sub-steps); whole-project review entry for Standard/Thorough. Markers: `[ ]` not started, `[~]` in-progress, `[x]` complete.
- **Execution** — pointer to the per-chunk protocol plus the review perspectives resolved for this tier.
- **Completion** — Quick omits; Standard/Thorough point to Stage 9 (whole-project review and user emulation).
- **Resumption Note** — tells a fresh session how to find the current position.

### Step 4: Initialise ORCHESTRATION-LOG.md

Create it with a header comment only — the entry format lives in orchestrating-software-dev:

```markdown
# Orchestration Log

<!-- Append-only. Do not edit previous entries. -->
```

## Template

Adapt to the workflow tier per the annotations.

```markdown
# Orchestration Plan — [Project Name]

**Tier:** [Quick / Standard / Thorough]
**Created:** [YYYY-MM-DD]
**Roadmap:** ROADMAP.md
**PRD:** PRD.md
**Architecture:** ARCHITECTURE.md

---

## Upstream Steps

- [x] PRD — PRD.md
- [x] Architecture — ARCHITECTURE.md
[Standard/Thorough add:]
- [x] Interface Design — .interface-design/system.md (if project has UI)
- [x] Decomposition — ROADMAP.md (structure)
- [x] Enrichment — ROADMAP.md (executable)

---

## Build Progress

<!-- Update status markers as work proceeds: [ ] not started, [~] in-progress, [x] complete -->

- [ ] chunk-001: [name]
- [ ] chunk-002: [name]
[... repeat for all chunks ...]
[Standard/Thorough add:]
- [ ] Whole-project review

---

## Execution

For each chunk, in dependency order, run the Per-Chunk Execution Protocol from the orchestrating-software-dev skill.

**Review perspectives (resolved for this tier):**

[Quick:]
- spec-compliance

[Standard:]
- spec-compliance → code-quality → design-compliance (if system.md exists and chunk touches UI)

[Thorough:]
- spec-compliance → code-quality → design-compliance (if system.md exists and chunk touches UI) → security (if chunk handles user input or sensitive data)

---

## Completion

[Quick: omit this section]

[Standard/Thorough:]

After all chunks are marked complete, run Stage 9 (Completion Review — whole-project review, then user emulation) from the orchestrating-software-dev skill.

---

## Resumption Note

New session? Read this file. Find the first `[~]` or `[ ]` chunk in Build Progress. Resume from there using the Per-Chunk Execution Protocol from orchestrating-software-dev.
```

## Edge Cases

**Resuming mid-chunk:** for a `[~]` chunk, check ORCHESTRATION-LOG.md for the last completed step, re-read the chunk from ROADMAP.md, and resume where the developer-agent left off.

**Tier change after plan creation:** do not modify an existing plan's tier mid-project. If scope expands significantly, note it in ORCHESTRATION-LOG.md and create a revised plan.

**Parallel chunks (Thorough only):** note parallelisable chunks in Build Progress (e.g., `- [ ] chunk-003: [name] [parallel with chunk-004]`); dispatch concurrently when file sets do not conflict.

**Quick tier with security concern:** override the spec-compliance-only default — load the security perspective for any chunk handling authentication, user input, or sensitive data.
