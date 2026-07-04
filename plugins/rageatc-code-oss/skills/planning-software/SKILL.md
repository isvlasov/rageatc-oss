---
name: planning-software
description: Transforms an approved enriched roadmap into a self-contained orchestration plan. Use when creating an orchestration plan, producing a build plan, or resuming a project from a saved plan. Not for roadmap creation/enrichment or workflow tier selection.
---

# Planning Software

Produces a self-contained orchestration plan from an approved enriched roadmap. The plan is the orchestrator's execution contract — it records the workflow tier, tracks chunk progress, and contains the full per-chunk protocol so any orchestrator session (including a fresh one) can resume without conversation history.

The plan describes **process** (agent sequence, review perspectives, gates); the roadmap describes **content** (what to build in each chunk). Separate documents, separate owners — never duplicate roadmap content into the plan.

**Inputs** (request anything missing before proceeding): approved enriched ROADMAP.md; workflow tier (decided upstream by orchestrating-software-dev); project name; confirmation that PRD.md and ARCHITECTURE.md exist (referenced, not duplicated).

**Outputs:** ORCHESTRATION-PLAN.md (the workflow contract) and an empty append-only ORCHESTRATION-LOG.md, both in the project root.

**Not covered:** roadmap creation/enrichment, tier selection, per-chunk execution itself, the log entry format (defined in orchestrating-software-dev).

## Workflow

### Step 1: Read the enriched roadmap

Read ROADMAP.md completely. Note: total chunk count and IDs; phased (Thorough) or flat; parallel dispatch annotations; any chunk already in-progress.

### Step 2: Determine plan depth from workflow tier

| Tier | Plan depth |
|------|------------|
| Quick | Short — no phases section, flat chunk list, no whole-project review step |
| Standard | Full — sequential chunks, complete per-chunk protocol, whole-project review at end |
| Thorough | Full with phases — phase groupings, parallel dispatch annotations, whole-project review at end |

### Step 3: Write the orchestration plan

Populate the Template below:

- **Header** — project name, tier, date, pointers to upstream artefacts
- **Upstream steps** — mark all complete (they are done by the time this skill runs). Quick lists PRD + architecture only; Standard/Thorough add interface design, decomposition, enrichment.
- **Build Progress** — one todo per chunk, chunk-level only (no sub-steps); whole-project review entry for Standard/Thorough. Markers: `[ ]` not started, `[~]` in-progress, `[x]` complete.
- **Per-Chunk Execution Protocol** — written once, used for every chunk. For Thorough with parallel chunks, note which can run concurrently.
- **Completion** — Quick omits; Standard/Thorough include whole-project review against PRD.
- **Resumption Note** — tells a fresh session how to find the current position.

### Step 4: Initialise ORCHESTRATION-LOG.md

Create it with a header comment only — the entry format lives in orchestrating-software-dev:

```markdown
# Orchestration Log

<!-- Append-only. Do not edit previous entries. -->
```

## Template

Adapt to the workflow tier per the annotations. The per-chunk protocol intentionally summarises orchestrating-software-dev content so the plan is self-contained for cross-session resumption — if the protocol changes there, update this template to match.

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

## Per-Chunk Execution Protocol

### 1. Assign the chunk

Read the next uncomplete chunk from ROADMAP.md. Provide developer-agent with:
- Chunk section from ROADMAP.md (acceptance criteria, file set)
- Relevant ARCHITECTURE.md section(s)
- For Standard/Thorough: pointer to patterns from earlier chunks if relevant

### 2. Worktree setup

Orchestrator creates an isolated worktree for this chunk using the using-worktrees skill, then points developer-agent to the worktree path.

### 3. Developer executes

Developer-agent: TDD (red-green-refactor) → verify → report status code.

| Status code | Orchestrator action |
|------------|---------------------|
| DONE | Send to reviewer-agent |
| DONE_WITH_CONCERNS | Review concerns, then send to reviewer-agent |
| NEEDS_CONTEXT | Provide missing context, developer continues |
| BLOCKED | Escalate — is this an architecture gap or scope issue? |

### 4. Review loop

Invoke reviewer-agent with the appropriate perspectives:

[Quick:]
- spec-compliance

[Standard:]
- spec-compliance → code-quality → design-compliance (if system.md exists and chunk touches UI)

[Thorough:]
- spec-compliance → code-quality → design-compliance (if system.md exists and chunk touches UI) → security (if chunk handles user input or sensitive data)

**Decision:**
- Accept → merge worktree, proceed to Step 5
- Revise → return to developer-agent with specific findings
- After 3 iterations without acceptance → escalate (signals a brief or architecture gap)

### 5. After each chunk

1. Update chunk status in Build Progress above
2. Append step to ORCHESTRATION-LOG.md
3. Update LEARNINGS.md only if something noteworthy happened

---

## Completion

[Quick: omit this section]

[Standard/Thorough:]

After all chunks are marked complete:

1. Invoke reviewer-agent with whole-project perspective against PRD.md
2. If accepted: mark plan complete
3. If revise: address findings and re-run whole-project review

---

## Resumption Note

New session? Read this file. Find the first `[~]` or `[ ]` chunk in Build Progress. Resume from there using the Per-Chunk Execution Protocol above.
```

## Edge Cases

**Resuming mid-chunk:** for a `[~]` chunk, check ORCHESTRATION-LOG.md for the last completed step, re-read the chunk from ROADMAP.md, and resume where the developer-agent left off.

**Tier change after plan creation:** do not modify an existing plan's tier mid-project. If scope expands significantly, note it in ORCHESTRATION-LOG.md and create a revised plan.

**Parallel chunks (Thorough only):** note parallelisable chunks in Build Progress (e.g., `- [ ] chunk-003: [name] [parallel with chunk-004]`); dispatch concurrently when file sets do not conflict.

**Quick tier with security concern:** override the spec-compliance-only default — load the security perspective for any chunk handling authentication, user input, or sensitive data.
