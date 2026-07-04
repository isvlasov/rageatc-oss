---
name: orchestrating-software-dev
description: Runs software development projects from idea to completion. Use when starting a software project, adding a feature, fixing a bug, or resuming an in-progress build.
---

# Orchestrating Software Development

The orchestrator's handbook for running software projects with rageatc-code-oss: which tier to select, which agents and skills to invoke at each stage, and how to respond at every decision point. The orchestrator coordinates; agents execute. How agents do their work lives in their preloaded skills and agent definitions — never restated here.

**Orchestrator-owned stages.** Four stages are executed directly rather than delegated, because the artefact depends on holding the full project picture (or live dialogue with the user) that delegation would lose:

- **Stage 1 — Product Definition** (managing-product): dialogic requirements extraction
- **Stage 4 — Interface Design** (designing-interfaces, rageatc-design-oss): dialogic; only when the project has a UI
- **Stage 6 — Enrichment** (enriching-roadmap): needs PRD, architecture, and all chunk relationships simultaneously
- **Stage 7 — Planning** (planning-software): needs the full enriched roadmap to produce a coherent contract

If context window limits bite, session resumption via project files (ORCHESTRATION-PLAN.md, ORCHESTRATION-LOG.md) is the safety net.

---

## Tier Selection

Select the tier before invoking any agent; it governs depth at every subsequent stage.

| Tier | Use when |
|------|----------|
| **Quick** | Bug fix, small isolated change, 1-3 files, no new architectural decisions |
| **Standard** | New feature, moderate complexity — this is the default |
| **Thorough** | Greenfield project, cross-cutting change, complex system, multiple components |

**Signals for Quick:** single component, reversible, no new dependencies, scope clear without upstream work. **Signals for Thorough:** greenfield, new architectural territory, multiple components with shared interfaces, significant non-functional requirements, parallel workstreams. When in doubt, start Standard.

Record the selected tier and justification in the orchestration log before proceeding.

---

## Lifecycle Stages

### Stage 0 — Upstream Entry

rageatc-code-oss sits downstream of rageatc-core-oss's thinking pipeline; the handoff point is when solutioning determines the solution is a software product.

- **Thorough:** run `/shaping` (ideating → understanding-the-ask → solutioning) before Stage 1. Output is concept_v1.md with a decision record.
- **Standard:** run `/shaping` only when direction is unclear; skip if the user arrives with a specific, bounded request.
- **Quick:** skip.

### Stage 1 — Product Definition

Apply the `managing-product` skill (orchestrator-led dialogue). Pass the workflow tier — it calibrates PRD depth.

Gate: present PRD.md to the human for approval. Do not advance without explicit confirmation; log the approval.

**Output:** confirmed PRD.md in project root.

### Stage 2 — Scaffolding

**Standard and Thorough only.** Apply the `scaffolding-project` skill (orchestrator-led) to create the project file structure. **Quick:** skip — structure already exists.

### Stage 3 — Architecture

Invoke `architect-agent`. Provide: PRD.md path, output directory, workflow tier; add existing codebase path for brownfield.

Gate: present ARCHITECTURE.md (and any ADRs) for approval. Resolve all open questions flagged by the architect before approving — decomposing an unconfirmed architecture produces misaligned chunks. Log the approval.

**Output:** confirmed ARCHITECTURE.md; ADRs in docs/decisions/ for Thorough.

### Stage 4 — Interface Design

**Conditional: only when the project has a UI; Standard and Thorough only.** After Stage 3, check ARCHITECTURE.md for frontend components, web interface, or UI framework references. If absent, skip and note it in the log. **Quick:** skip — if system.md already exists, the developer uses it.

Apply the `designing-interfaces` skill (rageatc-design-oss, orchestrator-led, dialogic). Greenfield: full exploration workflow. Brownfield: if `.interface-design/system.md` exists, confirm it is current; if direction has changed, run the brownfield entry path.

Gate: present `.interface-design/system.md` for approval before decomposition. Log the approval.

### Stage 5 — Decomposition

Invoke `breakdown-agent`. Provide: ARCHITECTURE.md path, project root path, workflow tier; add existing codebase path for brownfield.

Gate: review the proposed ROADMAP.md before the agent writes it — check chunk structure and dependencies. Confirm or request revisions; log the approval.

**Output:** confirmed ROADMAP.md (structural — chunks, phases, dependencies, file sets).

### Stage 6 — Enrichment

**Standard and Thorough only.** Apply the `enriching-roadmap` skill (orchestrator-led). Provide: ROADMAP.md, ARCHITECTURE.md, PRD.md paths and workflow tier; if `.interface-design/system.md` exists, provide it too — enrichment derives design-specific acceptance criteria for UI chunks. The enriched roadmap becomes the developer's brief — no separate briefing step.

Gate: present the enriched ROADMAP.md for approval. Log the approval.

**Quick:** skip — the developer works directly from the chunk description.

### Stage 7 — Planning

Apply the `planning-software` skill (orchestrator-led). Provide: enriched ROADMAP.md path, workflow tier, project name.

**Output:** ORCHESTRATION-PLAN.md (the workflow contract) and initialised ORCHESTRATION-LOG.md in project root.

### Stage 8 — Build

For each chunk in ORCHESTRATION-PLAN.md, in dependency order, run the Per-Chunk Execution Protocol below.

### Stage 9 — Completion Review

**Standard and Thorough only** (Quick: skip). When all chunks are complete in ORCHESTRATION-PLAN.md:

1. **Whole-project code review.** Invoke `reviewer-agent` with the whole-project perspective (from reviewing-code). Provide: PRD.md path, project root, all source files. Accept → proceed; Revise → address findings and re-run.
2. **User emulation.** Invoke `user-emulation-agent` with the running product. Provide: PRD.md path, running app URL (or CLI command), and system.md path if a design system exists. DONE → mark plan complete; DONE_WITH_CONCERNS → address severity 3-4 findings via developer-agent, then re-run; BLOCKED → check the app is running and accessible, retry.

### Stage 10 — Learnings

**Only when something noteworthy happened.** Append observations to the project root `LEARNINGS.md` per its inclusion criteria — durable insights a future session would act on, with the likely cause noted while it is still known. Codification happens later, when the user runs `/codify` (rageatc-core-oss).

---

## Gate Pattern

```
Skill or agent produces artefact → Critic reviews (optional) → Human approves
```

Applied after: PRD (Stage 1), architecture (Stage 3), design system (Stage 4, if applicable), roadmap structure (Stage 5), enriched roadmap (Stage 6). If the human requests changes → revise and repeat. Never advance past a gate without explicit approval; log every approval in ORCHESTRATION-LOG.md.

---

## Per-Chunk Execution Protocol

### Assign the chunk

Read ORCHESTRATION-PLAN.md and select the next chunk whose dependencies are met. Provide developer-agent with the chunk section from ROADMAP.md (acceptance criteria, file set), relevant ARCHITECTURE.md section(s), and — Standard/Thorough — a pointer to patterns from earlier chunks if relevant (2-5 lines; coordination, not production).

### Worktree setup

Apply the `using-worktrees` skill. Each chunk runs in an isolated git worktree; use the worktree path as the codebase path for all subsequent steps within the chunk.

### Developer executes

Invoke `developer-agent`. Provide: PRD.md path, chunk section from ROADMAP.md, ARCHITECTURE.md path, worktree path; add CLAUDE.md path if present and `.interface-design/system.md` path for UI chunks. (TDD and verification discipline live in the developer's preloaded skills.)

Respond to the status code the developer reports:

- **DONE** → send to reviewer-agent
- **DONE_WITH_CONCERNS** → review the flagged concerns, then send to reviewer-agent
- **NEEDS_CONTEXT** → provide the missing context; developer continues in the same worktree
- **BLOCKED** → stop and diagnose — architecture gap, scope issue, or brief ambiguity? Resolve before continuing

For iterations (2+), provide the previous review path alongside the worktree path; the developer continues in the existing worktree.

### Review

Invoke `reviewer-agent`. Provide: project context, ROADMAP.md chunk section, ARCHITECTURE.md path, worktree path, changed files list (`git diff --name-only main` in the worktree); for re-reviews, the previous review path.

Select perspectives per the reviewing-code skill's tier defaults, overriding when chunk characteristics warrant it (e.g., security for a Quick auth fix, design-compliance for UI chunks when system.md exists). Tell reviewer-agent which perspective names to apply.

- **Accept** → merge worktree branch, proceed to post-chunk updates
- **Revise** → return to developer-agent with the reviewer's specific findings

**3-iteration cap.** If iteration 3 still produces a revise decision, do not invoke developer-agent a fourth time. Escalate to the human with the chunk, the final review, the worktree path, and the unresolved issues. Persistent failure after 3 rounds signals a brief problem, architecture gap, or complexity mismatch — not a developer failure. The human decides: revise the brief, adjust scope, or accept with known issues.

### After each chunk

1. Mark chunk complete in ORCHESTRATION-PLAN.md (`[x]`)
2. Append entry to ORCHESTRATION-LOG.md (see Orchestration Logging)
3. Update LEARNINGS.md only if something noteworthy happened
4. Move to the next chunk in dependency order

---

## Cross-Session Resumption

New orchestrator session on an in-progress project:

1. Read project CLAUDE.md — identifies the workflow tier and points to all project files
2. Read STATUS.md — current position, recent decisions, next steps
3. Read ORCHESTRATION-PLAN.md — find the first `[~]` or `[ ]` entry in Build Progress
4. If a chunk is in-progress (`[~]`), check ORCHESTRATION-LOG.md for the last completed step within it
5. Resume from that point using the Per-Chunk Execution Protocol

Do not rely on conversation history — project root files are the authoritative record.

---

## Orchestration Logging

Append-only; write immediately after each step, not in batches; log facts, not opinions. ORCHESTRATION-LOG.md is initialised by planning-software (Stage 7) — append only after that point. Entry format:

```markdown
## Step N: <Step Name>

- **Agent:** <agent-name> (or "orchestrator")
- **Inputs:** <files and skills provided>
- **Sufficient inputs check:** <passed or failed>
- **Task:** <one-line summary>
- **Output:** <file(s) created>
- **Notes:** <errors, decisions, or "none">
```

**Software-specific events to log:** tier selection with justification; every gate approval; each chunk's outcome (iteration count, status code, accept/revise); escalations (chunk ID, iteration count, unresolved issues); worktree branch name per chunk; architecture re-entry decisions; BLOCKED diagnoses and resolutions.

---

## Architecture Re-Entry

If the developer or reviewer discovers a fundamental architecture gap during the build:

1. Stop the build loop for the affected chunk
2. Return to Stage 3 — revise ARCHITECTURE.md with architect-agent, obtain human approval
3. If chunk boundaries changed: return to Stage 5 with breakdown-agent
4. If chunk content changed (new acceptance criteria, different patterns, updated integration points): re-run Stage 6 enrichment for the affected chunks only
5. Resume build from the affected chunk

Do not patch around architectural problems at the implementation level. Log the re-entry decision with the specific gap identified.

---

## Parallel Dispatch (Thorough Only)

Chunks annotated as parallelisable in ROADMAP.md (non-overlapping file sets) can be dispatched concurrently. Provide each developer-agent with its own worktree. Merge each worktree individually before starting dependent chunks; resolve conflicts before the next phase.
