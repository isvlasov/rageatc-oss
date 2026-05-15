# rageatc-code-oss

Scale-adaptive software development for Claude Code — from bug fixes to greenfield systems.

## What Is This?

rageatc-code-oss provides the discipline layer for software creation: when to use which pattern, how to structure decisions, and how to maintain quality as velocity increases. It scales from quick bug fixes to complex greenfield builds using three workflow tiers (Quick, Standard, Thorough).

It depends on rageatc-core-oss for workflow infrastructure and orchestration. It complements rageatc-tech-oss for tool knowledge.

## Workflow Tiers

| Tier | Use when | Key characteristics |
|------|----------|---------------------|
| **Quick** | Bug fix, small isolated change, 1-3 files | Minimal docs, flat chunks, spec-compliance review only |
| **Standard** | New feature, moderate complexity (default) | Full PRD, enriched roadmap, spec-compliance + code-quality review |
| **Thorough** | Greenfield, cross-cutting, complex systems | Full /shaping, ADRs, phased DAG, security review, parallel dispatch |

## Skills

### Orchestration

| Skill | Purpose |
|-------|---------|
| **orchestrating-software-dev** | The orchestrator's handbook — tier selection, ten-stage lifecycle, gate pattern, per-chunk execution protocol, cross-session resumption |

### Upstream (defining what to build)

| Skill | Purpose |
|-------|---------|
| **managing-product** | Extract product requirements, produce structured PRDs with MoSCoW prioritisation |
| **scaffolding-project** | Create standard project file structure (PRD, ARCHITECTURE, roadmap, plan, STATUS, learnings, CLAUDE.md) with update instructions |
| **architecting-software** | Design architecture from PRD — driver extraction, pattern selection, ADRs, ARCHITECTURE.md |

### Decomposition and Planning

| Skill | Purpose |
|-------|---------|
| **decomposing-work** | Convert ARCHITECTURE.md into dependency-ordered roadmap of vertical-slice chunks |
| **enriching-roadmap** | Make chunks executable — acceptance criteria, pattern references, contextual notes |
| **planning-software** | Transform enriched roadmap into orchestration plan (the workflow contract) |

### Implementation

| Skill | Purpose |
|-------|---------|
| **test-driven-development** | Red-green-refactor TDD cycle — no production code without a failing test first |
| **verifying-work** | Evidence before completion claims — mandatory verification before any status report |
| **using-worktrees** | Git worktree isolation per chunk — safe parallel development, clean merges |
| **systematic-debugging** | Root cause investigation before fixes — four mandatory phases, 3-fix escalation |

### Review and Evaluation

| Skill | Purpose |
|-------|---------|
| **reviewing-code** | Perspective-based code review — spec-compliance, code-quality, design-compliance, security, whole-project |
| **evaluating-as-user** | User emulation methodology — deriving test scenarios from PRD, three-layer evaluation (journeys, universal checks, exploratory), five quality dimensions |

### Domain (independent of workflow)

| Skill | Purpose |
|-------|---------|
| **finding-docs** | Retrieve up-to-date library documentation via Context7 CLI |
| **building-telegram-bots** | Telegram bot development with framework verification |

## Agents

| Agent | Function | Model | Preloaded skills |
|-------|----------|-------|-----------------|
| **architect-agent** | Designs architecture from confirmed PRD | opus | architecting-software |
| **breakdown-agent** | Decomposes architecture into implementation chunks | opus | decomposing-work |
| **developer-agent** | Implements code per enriched roadmap chunk with TDD | sonnet | test-driven-development, verifying-work |
| **reviewer-agent** | Reviews code with orchestrator-selected perspectives | sonnet | reviewing-code |
| **user-emulation-agent** | Emulates end user evaluating the running product | opus | evaluating-as-user, playwright-cli |

## Workflow

```
[/shaping]  →  managing-product  →  scaffolding  →  architecting  →  [designing]  →  decomposing  →  enriching  →  planning  →  build loop  →  review  →  [user emulation]
(rageatc-core-oss)  (PRD.md)            (file structure)  (ARCHITECTURE.md)  (system.md)    (ROADMAP.md)    (enriched)    (plan.md)     (per chunk)     (whole-project)  (running product)
```

The enriched roadmap replaces a separate briefing step — chunks contain acceptance criteria, pattern references, and contextual notes sufficient for the developer-agent to begin work.

For the full orchestration guide, see the `orchestrating-software-dev` skill.

## Relationship to Other Plugins

- **rageatc-core-oss** — Thinking engine (workflow, orchestration, research). rageatc-code-oss skills operate within core workflows. The orchestrator-role rule delegates by default but allows orchestrator-owned stages documented in orchestrating-software-dev.
- **rageatc-design-oss** — Interface design craft (designing-interfaces skill). Provides Stage 4 (Interface Design) — domain exploration, token architecture, design system creation. Conditional: only runs for projects with a UI.
- **rageatc-tech-oss** — Technical capabilities (tool knowledge). Complementary — tech handles tool selection, code handles software creation practice.

## Attribution

rageatc-code-oss v2 incorporates practices inspired by [Superpowers](https://github.com/obra/superpowers) by Jesse Vincent (MIT licence). Specifically: TDD enforcement patterns, structured verification discipline, worktree isolation approach, and status-code communication model.
