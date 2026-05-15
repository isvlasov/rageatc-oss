---
name: planning-software
description: Transforms an approved enriched roadmap into a self-contained orchestration plan. Use when creating an orchestration plan, producing a build plan, or resuming a project from a saved plan. Not for roadmap creation/enrichment or workflow tier selection.
---

# Planning Software

## Purpose

Produce a self-contained orchestration plan from an approved enriched roadmap. The plan is the orchestrator's execution contract — it records the workflow tier, tracks chunk progress, and contains the full per-chunk protocol so any orchestrator session (including a fresh one) can resume work without reading conversation history.

The plan describes **process** (agent sequence, review perspectives, gates). The roadmap describes **content** (what to build in each chunk). These are separate documents with separate owners. Never duplicate roadmap content into the plan.

## Scope and Constraints

**This skill covers:**
- Creating ORCHESTRATION-PLAN.md from an approved enriched roadmap
- Scaling plan depth to the selected workflow tier (Quick, Standard, Thorough)
- Initialising an empty ORCHESTRATION-LOG.md alongside the plan

**This skill does NOT cover:**
- Roadmap creation or enrichment — that is decomposing-work and enriching-roadmap
- Deciding the workflow tier — that is orchestrating-software-dev
- Per-chunk execution itself — that is developer-agent and reviewer-agent work
- Defining the ORCHESTRATION-LOG.md format — that is orchestrating-software-dev

## Inputs Required

Before producing the plan, confirm you have:

- **Approved enriched roadmap** — ROADMAP.md with all chunks, acceptance criteria, and file sets
- **Workflow tier** — Quick, Standard, or Thorough (determined before this skill is invoked)
- **Project name** — for plan header
- **Upstream artefacts** — confirm PRD.md and ARCHITECTURE.md exist (they are referenced in the plan, not duplicated)

If any input is missing, request it before proceeding.

## Outputs

1. **ORCHESTRATION-PLAN.md** — the workflow contract (see Template below)
2. **ORCHESTRATION-LOG.md** — empty append-only log, created alongside the plan

Both files live in the project root alongside PRD.md, ARCHITECTURE.md, and ROADMAP.md.

## Workflow

### Step 1: Read the enriched roadmap

Read ROADMAP.md completely. Note:
- Total chunk count and IDs (e.g., chunk-001 through chunk-007)
- Whether chunks are phased (Thorough only) or flat
- Any parallel dispatch annotations
- Which chunk is currently in-progress, if work has already started

### Step 2: Determine plan depth from workflow tier

Apply the scale rules:

| Tier | Plan depth |
|------|------------|
| Quick | Short — no phases section, flat chunk list, no whole-project review step |
| Standard | Full — sequential chunks, complete per-chunk protocol, whole-project review at end |
| Thorough | Full with phases — phase groupings, parallel dispatch annotations, whole-project review at end |

### Step 3: Write the orchestration plan

Use the Template section below. Populate each section with the data from Steps 1-2:

- **Header** — project name, tier, date, pointers to upstream artefacts
- **Upstream steps** — mark all complete (they're done by the time this skill runs). Quick lists PRD + architecture only; Standard/Thorough add decomposition + enrichment.
- **Build Progress** — one todo per chunk from ROADMAP.md, chunk-level only (no sub-steps). Add whole-project review for Standard/Thorough. Status markers: `[ ]` not started, `[~]` in-progress, `[x]` complete.
- **Per-Chunk Execution Protocol** — written once, used for every chunk. Covers assignment, developer execution, status code handling, review perspectives per tier, and post-chunk updates. For Thorough tier with parallel chunks, note which chunks can run concurrently.
- **Completion** — Quick omits this. Standard/Thorough include whole-project review against PRD.
- **Resumption Note** — tells a fresh session how to find the current position.

### Step 4: Initialise ORCHESTRATION-LOG.md

Create an empty ORCHESTRATION-LOG.md file with a header comment only. The format for log entries is defined in orchestrating-software-dev — do not define it here.

```markdown
# Orchestration Log

<!-- Append-only. Do not edit previous entries. -->
```

## Template

Use this template to produce ORCHESTRATION-PLAN.md. Adapt to the workflow tier (see annotations).

**Note:** The per-chunk protocol below intentionally summarises content from orchestrating-software-dev so the plan is self-contained for cross-session resumption. If the protocol changes in orchestrating-software-dev, update this template to match.

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

**Resuming mid-chunk:** If a chunk is marked `[~]` (in-progress), check ORCHESTRATION-LOG.md for the last completed step. Re-read the relevant chunk from ROADMAP.md and resume from where the developer-agent left off.

**Tier change after plan creation:** Do not modify an existing plan's tier mid-project. If scope expands significantly, note it in ORCHESTRATION-LOG.md and create a revised plan.

**Parallel chunks (Thorough only):** If ROADMAP.md annotates chunks as parallelisable, note this in the Build Progress list (e.g., `- [ ] chunk-003: [name] [parallel with chunk-004]`). The orchestrator dispatches these concurrently when file sets do not conflict.

**Quick tier with security concern:** Override the default spec-compliance-only perspective. Load security perspective for any chunk handling authentication, user input, or sensitive data.

## Evaluation Scenarios

### Scenario 1 — Quick tier plan

**Input:** Approved ROADMAP.md with 2 flat chunks for a bug fix. Tier: Quick.

**Expected output:** Short ORCHESTRATION-PLAN.md — upstream steps show PRD and architecture update only; Build Progress lists 2 chunks with no whole-project review; protocol section shows spec-compliance only; no phases. Whole file under 60 lines.

### Scenario 2 — Standard tier plan

**Input:** Approved enriched ROADMAP.md with 5 sequential vertical-slice chunks for a new feature. Tier: Standard.

**Expected Build Progress section:**
```markdown
## Build Progress

- [ ] chunk-001: Walking Skeleton
- [ ] chunk-002: User Service
- [ ] chunk-003: Recipe Service
- [ ] chunk-004: Shopping Service
- [ ] chunk-005: Frontend Pages
- [ ] Whole-project review
```

Protocol shows spec-compliance → code-quality perspectives. Completion section includes whole-project review step. Resumption note present.

### Scenario 3 — Thorough tier plan with phases

**Input:** Approved enriched ROADMAP.md with 9 chunks in 3 phases, some marked parallelisable. Tier: Thorough.

**Expected output:** Full ORCHESTRATION-PLAN.md with phase groupings in Build Progress; parallel annotations noted; protocol shows spec-compliance → code-quality → security; completion section includes whole-project review. Plan is complete enough that a fresh orchestrator session reading it cold can identify the current phase, the next chunk, and which perspectives to load.

### Scenario 4 — Cross-session resumption

**Input:** An existing ORCHESTRATION-PLAN.md with chunk-001 marked `[x]`, chunk-002 marked `[~]`, remaining chunks `[ ]`.

**Expected behaviour:** Orchestrator reads plan, identifies chunk-002 as in-progress, checks ORCHESTRATION-LOG.md for last completed step, resumes chunk-002 from that point without asking the user for context.
