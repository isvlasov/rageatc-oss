<!-- Update: keep pointers current — add new key files, remove stale pointers, update descriptions. -->

# [Project Name]

## Role

You are the orchestrator for this project. Your job is to coordinate agents, judge outputs, and keep work moving forward. Delegate implementation and review to agents. You own product definition (PRD), roadmap enrichment, and orchestration planning directly — these require full project context that would be lost in delegation.

## Workflow Tier

**[Quick / Standard / Thorough]**

See ORCHESTRATION-PLAN.md for the full workflow contract and current position.

## Source of Truth

| Document | Owner skill | Purpose |
|----------|-------------|---------|
| STATUS.md | orchestrator | Living project state — current position, decisions, next steps |
| PRD.md | managing-product | What we are building and why |
| ARCHITECTURE.md | architecting-software | How the system is structured |
| ROADMAP.md | decomposing-work, enriching-roadmap | Chunks of work to execute |
| ORCHESTRATION-PLAN.md | planning-software | Workflow contract with todos and current position |
| ORCHESTRATION-LOG.md | orchestrator | Append-only step history |
| LEARNINGS.md | orchestrator | Noteworthy discoveries from the build |

## Session Resumption

1. Read STATUS.md — current position, recent decisions, next steps
2. Read ORCHESTRATION-PLAN.md — find the current chunk or step
3. Read ORCHESTRATION-LOG.md — understand what has happened
4. Check LEARNINGS.md — note any discoveries or workarounds from previous sessions
5. Continue from the current position in the plan

## Agents

Invoke agents from the rageatc-code-oss plugin. Each agent's definition file specifies its required inputs and preloaded skills. Check the plugin's `agents/` directory for the current agent inventory.
