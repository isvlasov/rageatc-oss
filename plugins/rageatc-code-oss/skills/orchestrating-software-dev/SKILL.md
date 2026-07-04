---
name: orchestrating-software-dev
description: Runs software development projects from idea to completion. Use when starting a software project, adding a feature, fixing a bug, or resuming an in-progress build.
---

# Orchestrating Software Development

## Purpose

This skill is the orchestrator's handbook for running software projects using rageatc-code-oss. It defines which tier to select, which agents and skills to invoke at each lifecycle stage, and how to respond to every decision point along the way.

The orchestrator coordinates; agents execute. How agents do their work is in their preloaded skills and agent definitions — never restated here.

### Orchestrator-Owned Stages

Four stages are executed directly by the orchestrator rather than delegated to agents:

- **Stage 1 — Product Definition** (managing-product): dialogic by nature — requires real-time interaction with the user to extract requirements.
- **Stage 4 — Interface Design** (designing-interfaces, rageatc-design-oss): dialogic — explores the product's domain with the user to establish design direction. Conditional on the project having a UI.
- **Stage 6 — Enrichment** (enriching-roadmap): requires simultaneous access to PRD, architecture, and all chunk relationships — context loss from delegation outweighs the overhead of orchestrator execution.
- **Stage 7 — Planning** (planning-software): requires full understanding of the enriched roadmap to produce a coherent workflow contract.

These are deliberate exceptions to the "orchestrator coordinates, agents produce" default. The justification is context fidelity: these artefacts depend on holding the full project picture simultaneously, and delegating them would mean either duplicating massive context or risking the agent missing connections. If context window limits become a constraint, session resumption via project files (ORCHESTRATION-PLAN.md, ORCHESTRATION-LOG.md) is the safety net.

## Scope and Constraints

**This skill covers:**
- Tier selection (Quick, Standard, Thorough)
- The ten-stage lifecycle — entry through completion and learnings
- The gate pattern applied after every major artefact
- The per-chunk execution protocol, including status-code handling and review perspective selection
- Cross-session resumption via ORCHESTRATION-PLAN.md
- Orchestration logging for software-specific events

**This skill does NOT cover:**
- How any agent or skill does its work internally — that lives in the referenced skill or agent definition
- Domain skills (building-telegram-bots, working-with-pi, etc.)
- Deployment procedures — handled by rageatc-tech-oss and domain skills

---

## Tier Selection

Select the tier before invoking any agent. It governs depth at every subsequent stage.

| Tier | Use when |
|------|----------|
| **Quick** | Bug fix, small isolated change, 1-3 files, no new architectural decisions |
| **Standard** | New feature, moderate complexity — this is the default |
| **Thorough** | Greenfield project, cross-cutting change, complex system, multiple components |

**Default is Standard.** Choose Quick or Thorough only when the project characteristics clearly match. When in doubt, start Standard and note the choice in the orchestration log.

**Signals for Quick:** Single component, reversible, no new dependencies, scope is clear without upstream work.

**Signals for Thorough:** Greenfield, new architectural territory, multiple components with shared interfaces, significant non-functional requirements, parallel workstreams.

Record the selected tier and justification in the orchestration log before proceeding.

---

## Lifecycle Stages

### Stage 0 — Upstream Entry

rageatc-code-oss sits downstream of rageatc-core-oss's thinking pipeline. The handoff point is when solutioning determines the solution is a software product.

- **Thorough:** Run `/shaping` (rageatc-core-oss) — ideating → understanding-the-ask → solutioning — before Stage 1. Output is concept_v1.md with a decision record.
- **Standard:** Run `/shaping` when direction is unclear. Skip if the user arrives with a specific, bounded request.
- **Quick:** Skip. Problem is already clear and bounded.

---

### Stage 1 — Product Definition

Apply the `managing-product` skill. This is an interactive orchestrator-led dialogue — not a task to delegate.

Gate: Present PRD.md to the human for approval before proceeding. Do not advance without explicit confirmation. Log the approval.

**Output:** Confirmed PRD.md in project root.

**Tier calibration:** Pass the workflow tier to the managing-product skill — it calibrates PRD depth accordingly.

---

### Stage 2 — Scaffolding

**Standard and Thorough only.** Apply the `scaffolding-project` skill (orchestrator-led).

Apply the `scaffolding-project` skill to create the project file structure.

**Quick:** Skip — project structure already exists for bug fixes.

---

### Stage 3 — Architecture

Invoke `architect-agent`. Provide: PRD.md path, output directory. Add existing codebase path for brownfield projects.

Gate: Present ARCHITECTURE.md (and any ADRs) to the human for approval. Resolve all open questions flagged by the architect before approving — decomposing an unconfirmed architecture produces misaligned chunks. Log the approval.

**Output:** Confirmed ARCHITECTURE.md. ADRs in docs/decisions/ for Thorough tier.

**Tier calibration:** Pass the workflow tier to architect-agent — its preloaded architecting-software skill calibrates depth accordingly.

---

### Stage 4 — Interface Design

**Conditional: only when the project has a UI.** Skip for pure APIs, CLIs, libraries, or backend-only changes.

**Standard and Thorough only.** Apply the `designing-interfaces` skill (rageatc-design-oss plugin, orchestrator-led). This is a dialogic stage — explore the product's domain with the user to establish design direction, token architecture, and visual system.

**Detection:** After Stage 3, check ARCHITECTURE.md for frontend components, web interface, or UI framework references. If present, run this stage. If absent, skip and note the skip in the orchestration log.

**Greenfield:** Run the full exploration workflow — intent, domain, direction proposal, token architecture, self-critique, confirmation.

**Brownfield:** If `.interface-design/system.md` already exists, confirm it is still current. If the project's UI direction has changed, run the brownfield entry path (extract → refine → update).

Gate: Present `.interface-design/system.md` to the human for approval before proceeding to decomposition. Log the approval.

**Output:** Confirmed `.interface-design/system.md` at the project root.

**Quick:** Skip — scope is too small for design system work. If system.md already exists, the developer uses it.

---

### Stage 5 — Decomposition

Invoke `breakdown-agent`. Provide: ARCHITECTURE.md path, project root path. Add existing codebase path for brownfield.

Gate: Review the proposed ROADMAP.md before the agent writes it — check that chunk structure and dependencies look right. Confirm or request revisions. Log the approval once confirmed.

**Output:** Confirmed ROADMAP.md (structural — chunks, phases, dependencies, file sets).

**Tier calibration:** Pass the workflow tier to breakdown-agent — its preloaded decomposing-work skill calibrates depth accordingly.

---

### Stage 6 — Enrichment

**Standard and Thorough only.** Apply the `enriching-roadmap` skill (orchestrator-led). Provide: ROADMAP.md path, ARCHITECTURE.md path, PRD.md path, workflow tier. If `.interface-design/system.md` exists, provide it as an additional input — enrichment derives design-specific acceptance criteria for UI chunks.

Apply the `enriching-roadmap` skill. The enriched roadmap becomes the developer's brief — no separate briefing step is needed.

Gate: Present the enriched ROADMAP.md to the human for approval. Log the approval.

**Quick:** Skip — chunks are simple enough that the developer works directly from the chunk description.

---

### Stage 7 — Planning

Apply the `planning-software` skill (orchestrator-led). Provide: enriched ROADMAP.md path, workflow tier, project name.

This produces ORCHESTRATION-PLAN.md (the workflow contract) and initialises ORCHESTRATION-LOG.md.

**Output:** ORCHESTRATION-PLAN.md and ORCHESTRATION-LOG.md in project root.

---

### Stage 8 — Build

For each chunk in ORCHESTRATION-PLAN.md (in dependency order), run the per-chunk execution protocol. See Per-Chunk Execution Protocol section below.

---

### Stage 9 — Completion Review

**Standard and Thorough only.** When all chunks are marked complete in ORCHESTRATION-PLAN.md:

**1. Whole-project code review.** Invoke `reviewer-agent` with the whole-project perspective (from reviewing-code). Provide: PRD.md path, project root, all source files.

- Accept → proceed to user emulation
- Revise → address findings and re-run the whole-project review

**2. User emulation.** Once the code review passes, invoke `user-emulation-agent` with the running product. Provide: PRD.md path, running app URL (or CLI command), and system.md path if the project has a design system. The agent evaluates the product as a real user would — catching broken integrations, confused flows, missing states, and PRD gaps that only surface through actual use.

- DONE → mark plan complete
- DONE_WITH_CONCERNS → address severity 3-4 findings via developer-agent, then re-run user emulation
- BLOCKED → check that the app is running and accessible, then retry

**Quick:** Skip — scope is too small to warrant whole-project review or user emulation.

---

### Stage 10 — Learnings

**Only when something noteworthy happened.** Invoke `learner-agent` (rageatc-core-oss) with the ORCHESTRATION-LOG.md, ORCHESTRATION-PLAN.md, and any artefact versions that illustrate the learning. Set the output path to the project root `LEARNINGS.md` — the learner appends structured analysis below any raw observations already captured there. Pass the output to the human for approval — no skill or agent changes without human review.

Do not run learner-agent after every project. Reserve it for projects that surfaced meaningful workflow improvements.

---

## Gate Pattern

Every major artefact follows the same gate:

```
Skill or agent produces artefact → Critic reviews (optional) → Human approves
```

Applied after: PRD (Stage 1), architecture (Stage 3), design system (Stage 4, if applicable), roadmap structure (Stage 5), enriched roadmap (Stage 6).

If the human requests changes → revise and repeat. Do not advance past a gate without explicit approval. Log every gate approval in ORCHESTRATION-LOG.md.

---

## Per-Chunk Execution Protocol

### Assign the chunk

Read ORCHESTRATION-PLAN.md and select the next chunk whose dependencies are met. Provide developer-agent with:

- The chunk section from ROADMAP.md (acceptance criteria, file set)
- Relevant ARCHITECTURE.md section(s)
- For Standard/Thorough: pointer to patterns from earlier chunks if relevant (2-5 lines of pointers — coordination, not production)

### Worktree setup

Apply the `using-worktrees` skill — do not restate its mechanics here. Each chunk runs in an isolated git worktree. Use the worktree path as the codebase path for all subsequent steps within that chunk.

### Developer executes

Invoke `developer-agent`. Provide: PRD.md path, chunk section from ROADMAP.md, ARCHITECTURE.md path, worktree path. Add CLAUDE.md path if present. For UI chunks: add `.interface-design/system.md` path if it exists.

Developer-agent preloads test-driven-development and verifying-work. TDD methodology and verification discipline live in those skills — do not restate them here.

The developer reports a status code on completion (codes defined in developer-agent). Orchestrator responds:

- **DONE** → send to reviewer-agent
- **DONE_WITH_CONCERNS** → review the flagged concerns, then send to reviewer-agent
- **NEEDS_CONTEXT** → provide the missing context; developer continues in same worktree
- **BLOCKED** → stop and diagnose — is this an architecture gap, scope issue, or brief ambiguity? Resolve before continuing

For iterations (2+), provide the previous review path alongside the worktree path. Do not use worktree isolation again — the developer continues in the existing worktree.

### Review

Invoke `reviewer-agent`. Provide: project context, ROADMAP.md chunk section, ARCHITECTURE.md path, worktree path, changed files list (via `git diff --name-only main` in the worktree). For re-reviews, add the previous review path.

Select perspectives per the reviewing-code skill's tier defaults (defined in its Perspective Model section). Override when chunk characteristics warrant it (e.g., load security for a Quick auth fix, load design-compliance for UI chunks when system.md exists). Tell reviewer-agent which perspective names to apply (e.g., "apply spec-compliance, code-quality, and design-compliance").

**Decision:**
- Accept → merge worktree branch, proceed to post-chunk updates
- Revise → return to developer-agent with the reviewer's specific findings

**3-iteration cap.** If iteration 3 produces a revise decision, do not invoke developer-agent a fourth time. Escalate to the human: provide the chunk, the final review, the worktree path, and the specific unresolved issues. Persistent failure after 3 rounds signals a brief problem, an architecture gap, or a complexity mismatch — not a developer failure. Human decides whether to revise the brief, adjust scope, or accept the output with known issues.

### After each chunk

1. Mark chunk complete in ORCHESTRATION-PLAN.md (`[x]`)
2. Append entry to ORCHESTRATION-LOG.md (see Orchestration Logging section)
3. Update LEARNINGS.md only if something noteworthy happened
4. Move to the next chunk in dependency order

---

## Cross-Session Resumption

New orchestrator session on an in-progress project:

1. Read project CLAUDE.md — it identifies the workflow tier and points to all project files
2. Read STATUS.md — quick overview of current position, recent decisions, and next steps
3. Read ORCHESTRATION-PLAN.md — find the first `[~]` or `[ ]` entry in Build Progress
4. If a chunk is in-progress (`[~]`), check ORCHESTRATION-LOG.md for the last completed step within it
5. Resume from that point using the Per-Chunk Execution Protocol

Do not rely on conversation history — project root files are the authoritative record.

---

## Orchestration Logging

Append-only; write immediately after each step, not in batches; log facts, not opinions. Entry format:

```markdown
## Step N: <Step Name>

- **Agent:** <agent-name> (or "orchestrator")
- **Inputs:** <files and skills provided>
- **Sufficient inputs check:** <passed or failed>
- **Task:** <one-line summary>
- **Output:** <file(s) created>
- **Notes:** <errors, decisions, or "none">
```

**Software-specific events to log:**

- Tier selection with justification
- Every gate approval — which artefact, approved by human (with timestamp if available)
- Each chunk's outcome: iteration count, status code, accept/revise decision
- Escalations (cap reached) — chunk ID, iteration count, unresolved issues
- Worktree branch name per chunk (for traceability)
- Architecture re-entry decisions — if Build reveals an architecture gap requiring a Stage 3 return
- BLOCKED status — diagnosis and resolution

Create ORCHESTRATION-LOG.md at the project root when running planning-software (Stage 7). The file is initialised by the planning-software skill — append only after that point.

---

## Architecture Re-Entry

If the developer or reviewer discovers a fundamental architecture gap during the build stage:

1. Stop the build loop for the affected chunk
2. Return to Stage 3 — revise ARCHITECTURE.md with architect-agent, obtain human approval
3. If chunk boundaries changed: return to Stage 5 with breakdown-agent
4. If chunk content changed (new acceptance criteria, different patterns, updated integration points): re-run Stage 6 enrichment for the affected chunks only — do not re-enrich unchanged chunks
5. Resume build from the affected chunk

Do not patch around architectural problems at the implementation level. Log the re-entry decision with the specific gap identified.

---

## Parallel Dispatch (Thorough Only)

Chunks annotated as parallelisable in ROADMAP.md (non-overlapping file sets) can be dispatched concurrently. Provide each developer-agent with its own worktree. Merge each worktree individually before starting dependent chunks. Resolve any conflicts before moving to the next phase.

---

## Evaluation Scenarios

### Scenario 1 — Quick Tier: Bug Fix

**Context:** User reports the login form accepts empty email addresses. Fix is isolated to one component.

**Tier selected:** Quick — single component, reversible, clear scope.

1. Stage 0: Skip.
2. Stage 1: Short PRD update — problem and acceptance criteria only.
3. Stages 2, 4, 6, 7: Skip.
4. Stage 3: Update existing ARCHITECTURE.md with a stub note on validation location.
5. Stage 5: 1 flat chunk. Gate: confirm chunk scope and file set with human.
6. Stage 8: Assign chunk. Worktree setup. Developer executes. Reports DONE. Invoke reviewer-agent with spec-compliance. Accept. Merge.
7. Stages 9, 10: Skip.

---

### Scenario 2 — Standard Tier: New Feature

**Context:** User wants to add recipe management to an existing API (CRUD + search). Existing codebase, 5-6 chunks anticipated.

**Tier selected:** Standard — new feature, follows existing patterns, bounded scope.

1. Stage 0: User request is specific — skip /shaping.
2. Stage 1: Full PRD with MoSCoW. PRD gate. Log approval.
3. Stage 2: Scaffolding (project exists — skip file creation, confirm CLAUDE.md is current).
4. Stage 3: Invoke architect-agent with PRD and existing codebase. Produces ARCHITECTURE.md addendum. Architecture gate. Log approval.
5. Stage 4: Skip — API-only feature, no UI.
6. Stage 5: Invoke breakdown-agent. Walking skeleton as chunk-001. Confirm roadmap structure. Log approval.
7. Stage 6: Apply enriching-roadmap. Enriched gate. Log approval.
8. Stage 7: Apply planning-software. ORCHESTRATION-PLAN.md and ORCHESTRATION-LOG.md created.
9. Stage 8: For each chunk — worktree → developer (DONE on chunk-001 after first iteration) → reviewer (spec-compliance → code-quality) → merge. Update plan after each chunk.
10. Stage 9: Invoke reviewer-agent with whole-project perspective. Accept. Then invoke user-emulation-agent with running product. DONE.
11. Stage 10: Nothing noteworthy — skip.

---

### Scenario 3 — Thorough Tier: Greenfield System

**Context:** User wants to build a real-time notification service. New system, multiple components (producer, consumer, delivery layer), cross-cutting concerns.

**Tier selected:** Thorough — greenfield, cross-cutting, new architectural territory.

1. Stage 0: Run /shaping — ideating → understanding-the-ask → solutioning. Concept confirmed as software.
2. Stage 1: Full PRD with non-goals (mobile push, email digest), constraints, open questions. PRD gate. Log approval.
3. Stage 2: Apply scaffolding-project. Full project file structure created.
4. Stage 3: Invoke architect-agent. Full ARCHITECTURE.md + ADRs (event schema, stateless auth, retry policy). Resolve open question on horizontal scaling before approving. Architecture gate. Log approval.
5. Stage 4: Skip — backend notification service, no UI.
6. Stage 5: Invoke breakdown-agent. Phased DAG — Phase 0 (walking skeleton, shared schema), Phase 1 (producer and consumer — parallel candidates), Phase 2 (delivery layer). Confirm roadmap. Log approval.
7. Stage 6: Apply enriching-roadmap at Thorough depth. Cross-chunk integration notes flag shared event schema. Enriched gate. Log approval.
8. Stage 7: Apply planning-software with phase groupings and parallel annotations.
9. Stage 8: Phase 0 sequential. Phase 1 — dispatch producer and consumer in parallel worktrees (non-overlapping file sets). Merge each before Phase 2. Review with spec-compliance → code-quality → security (delivery layer handles user tokens). 3-iteration cap respected — chunk-009 (integration) revises once and accepts.
10. Stage 9: Whole-project review against PRD. Accept. User emulation of running product. DONE.
11. Stage 10: chunk-009's integration complexity surfaces a learning about event schema contracts — invoke learner-agent. Human approves resulting proposal.

---

## Success Indicators

Orchestration is effective when:

- A new session can read ORCHESTRATION-PLAN.md and resume work without asking the human for context
- Agent invocations pass input validation on first attempt — agents confirm inputs before working
- Gate approvals are logged before every stage transition
- The build loop converges in 1-2 iterations for the majority of chunks
- Escalations document specific unresolved issues, not vague blockers
- The final software satisfies the PRD success criteria, not just the chunk acceptance criteria
