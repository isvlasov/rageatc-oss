---
name: designing-workflow
description: Designs workflow structure. Use when planning a workflow, choosing which phases to include, or selecting a workflow pattern for a task.
---

# Designing Workflow

The canonical six-phase menu for rageatc-core-oss — every workflow subsets from these phases based on task characteristics. This skill covers structure (which phases, when); execution (agent coordination, logging, validation) lives in `orchestrating-work`.

## Phase Menu

### Phase 1: Preparation (always)

Understand requirements, explore context, identify the execution approach. The full arc is Ideate → Understand → Solution → Brief, each step optional:

- `ideating` — generate and explore ideas when the user doesn't yet have a clear task
- `understanding-the-ask` — explore user intent through structured dialogue
- `solutioning` — explore solution options when the approach is unclear
- Exploratory research via subagents, reading referenced documents, clarifying ambiguities and constraints

Outputs: clear understanding of requirements; decision record if solutioning was used; captured ideas if ideating was used.

### Phase 2: Planning (always — spend the most user time here)

Create the execution plan for orchestrator and user — NOT for agents, who receive instructions at invocation. Leverage the plan agent, review the plan with the user, identify decision points, dependencies, agent sequence, and file paths. If planning is done right, everything else flows smoothly.

Output: `work/<task-id>/plan.md`.

### Phase 3: Research (optional)

Background investigation, fact-finding, evidence gathering. Include for novel domains, unfamiliar problem spaces, or factual claims needing verification; skip for routine well-understood work or when the necessary knowledge is already in context.

Sub-steps: research brief (orchestrator-owned, per `creating-briefs`) → execute (researcher / source-collector) → fact-check (optional but recommended) → review (critic, iterate if needed).

Outputs: research document, source index (thorough mode), fact-check report.

Research is the primary fact-checking checkpoint — verify claims here to prevent error propagation into artefacts.

### Phase 4: Production (always)

Create the primary deliverable through iterative refinement: artefact brief (orchestrator-owned, per `creating-briefs`) → produce v1 (producer with applicable skills) → review (critic) → iterate until accepted. Fact-check only if Production introduces new claims beyond Research.

Producer-Critic cycles are sub-phase iteration — low-cost quality refinement, not phase-level rework.

Outputs: artefact versions with matching review versions, approved final version.

### Phase 5: Learning (optional — always before Finalisation)

Capture noteworthy observations to the project's `LEARNINGS.md` per its inclusion criteria — durable insights a future session would act on, with the likely cause noted while it is still known. Skip for one-off or trivial tasks. Codification into skill or workflow changes happens later, when the user runs `/codify`.

Output: LEARNINGS.md entries.

### Phase 6: Finalisation (always, unless work stays in the work directory)

Deploy results, update root project files (STATUS.md always; others if stale), commit when explicitly requested. Always the last phase; human approval gates belong here, at irreversible actions like deployment and commits.

## Patterns

- **Minimal** — Preparation → Planning → Production → Finalisation. Requirements clear, domain familiar, low iteration expected.
- **Research-Driven** — adds Research. Unfamiliar domain, evidence needed for decisions, claims to verify.
- **Thorough** — adds Research and Learning. High-stakes work, building new capabilities.

Default when uncertain: Research-Driven. Research prevents costly Production rework; Learning can be added post-hoc if valuable patterns emerge.

## Design Principles

- **Human gates at irreversible actions** (deployment, commits), not routine checkpoints
- **Iteration within structure** — Producer-Critic cycles are cheap refinement inside Production; needing to repeat a phase signals a fundamental issue
- **Quality integration throughout** — validation happens continuously in Production, not only at workflow endpoints
- Domain plugins (e.g. rageatc-code-oss) may define their own stage models tailored to their domain

## Context Between Phases

Persists: task requirements and constraints, research findings, artefact brief, file paths. Resets: working context and agent-specific state — each agent starts fresh.

Boundaries requiring explicit handoffs:

- Research → Production: research findings, fact-check report, research brief
- Production → Finalisation: approved artefact, deployment path

See `orchestrating-work` for how to validate handoffs during execution.
