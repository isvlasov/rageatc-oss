---
name: enriching-roadmap
description: Enriches implementation roadmap chunks with acceptance criteria, pattern references, and contextual notes. Use after decomposing-work has produced the structural roadmap and before planning-software creates the orchestration plan. Does not modify chunk structure or dependencies.
---

# Enriching Roadmap

## Purpose

This skill guides enrichment of a confirmed structural roadmap so every chunk becomes self-contained enough for a developer-agent to begin work. It adds acceptance criteria, pattern references, and contextual notes to each chunk entry — without modifying any structural field the decomposing-work skill produced.

Use this skill after `decomposing-work` has produced a confirmed `ROADMAP.md` and before `planning-software` converts it into an orchestration plan.

## Scope and Constraints

**This skill covers:**
- Deriving testable acceptance criteria from PRD success criteria and architecture constraints
- Pointing to concrete code locations for pattern references (especially the walking skeleton)
- Adding contextual notes linking chunks to relevant ARCHITECTURE.md sections
- Adding ADR references and cross-chunk integration notes at Thorough depth

**This skill does NOT cover:**
- Chunk structure, type, dependencies, phases, or file sets — all owned by `decomposing-work`
- Orchestration plan creation — owned by `planning-software`
- Technology-specific implementation guidance — owned by developer-agent skills
- Redefining the chunk schema — use the schema as produced by `decomposing-work`

**Handoff position:**

```
decomposing-work     →     enriching-roadmap     →     planning-software
(ROADMAP.md              (acceptance criteria,          (orchestration
 structural)              pattern refs, notes)            plan)
```

## Inputs Required

Before starting, confirm you have:

- [ ] `ROADMAP.md` — confirmed structural roadmap from `decomposing-work`
- [ ] `ARCHITECTURE.md` — approved architecture; source for pattern references and component context
- [ ] `PRD.md` — source of testable success criteria for acceptance criteria derivation
- [ ] Workflow tier — Quick, Standard, or Thorough (determines enrichment depth)
- [ ] `.interface-design/system.md` (optional) — if the project has a design system, use it to derive design-specific acceptance criteria for UI chunks (e.g., "Uses spacing scale from system.md", "Follows the card pattern defined in system.md")

If the workflow tier was not specified, infer it from the roadmap: 1-3 chunks = Quick, 4-8 chunks = Standard, 9+ chunks or phased DAG = Thorough. State your inference and proceed.

## Outputs Produced

**One file, modified in place:**
- `ROADMAP.md` — same file as input, with three new fields appended to each chunk entry:
  - `Acceptance criteria` — testable conditions derived from PRD and architecture
  - `Pattern references` — pointers to existing code the developer should follow
  - `Contextual notes` — architecture section references and, at Thorough depth, ADR references and cross-chunk integration notes

Do not alter any existing fields (`Type`, `Component`, `Status`, `Size`, `Depends on`, `Files`, `Description`).

Present the enriched roadmap for human review before treating it as the working baseline.

## Workflow

### Step 1: Read All Inputs

Read `PRD.md`, `ARCHITECTURE.md`, and `ROADMAP.md` fully before writing anything.

While reading, build a working map of:
- **PRD success criteria** — the testable outcomes the product must deliver (source for acceptance criteria)
- **Architecture components and their responsibilities** — which sections of ARCHITECTURE.md each chunk relates to
- **Walking skeleton location** — what chunk-001 established and what patterns it set (primary pattern reference for all subsequent chunks)
- **ADRs** (Thorough only) — which decisions constrain which chunks

### Step 2: Determine Enrichment Depth

Apply one tier across the entire roadmap. Do not mix tiers per chunk.

| Tier | Acceptance criteria | Pattern references | Contextual notes |
|---|---|---|---|
| **Quick** | Not invoked — orchestrating-software-dev skips Stage 5 for Quick tier. If invoked directly, use 1-2 per chunk | Not invoked | Not invoked |
| **Standard** | 2-4 per chunk — full coverage of chunk scope | Required — point to walking skeleton or prior chunks | Reference relevant ARCHITECTURE.md section |
| **Thorough** | 3-5 per chunk — full coverage + edge cases and error paths | Required — point to walking skeleton or most relevant prior chunk | ARCHITECTURE.md section + ADR references + cross-chunk integration notes where chunks interact |

### Step 3: Enrich Each Chunk

Process chunks in roadmap order (Phase 0 first). For each chunk:

**Write acceptance criteria:**
- Derive each criterion from a specific PRD success condition or architecture constraint — not from the chunk description alone
- Write in testable form: "Given X, when Y, then Z" or a concrete assertion ("All endpoints return JSON with a consistent error envelope")
- For Quick tier, focus on the single most important observable outcome
- For Standard and Thorough, add criteria for error paths and integration points where they exist in the chunk scope

**Write pattern references (Standard and Thorough):**
- Check whether chunk-001 (walking skeleton) established the relevant pattern first — prefer pointing there
- If a prior completed chunk set a more specific pattern, point to it instead
- Reference concrete file paths or directory locations where the pattern lives: "Follow the handler pattern at `src/api/handlers/health.ts`"
- If no pattern exists yet in the codebase (greenfield, early phase), write "No existing pattern — establish the pattern for subsequent chunks to follow"
- Do not write example code or describe how the pattern works — point to the location only

**Write contextual notes (Standard and Thorough):**
- Reference the ARCHITECTURE.md section that governs this chunk: "See ARCHITECTURE.md > Authentication > JWT Strategy"
- At Thorough depth, add any ADR that constrains this chunk: "Constrained by ADR-003 (stateless auth)"
- At Thorough depth, flag cross-chunk integration points: "Integrates with chunk-008 (email adapter) — confirm shared event schema before implementing"
- If system.md exists and the chunk touches UI: reference the design system — "Apply design tokens from .interface-design/system.md" and add design-specific acceptance criteria (e.g., "Spacing uses the 4px base grid", "Cards follow the card pattern in system.md")

### Step 4: Validate Enrichment

Before presenting the enriched roadmap, check:

- [ ] Every chunk has `Acceptance criteria`, `Pattern references`, and `Contextual notes` fields appended
- [ ] All acceptance criteria are testable assertions, not descriptions of what the code will do
- [ ] Pattern references point to existing code locations, not explanations of patterns
- [ ] No existing chunk field has been modified
- [ ] Enrichment depth is consistent across all chunks (same tier throughout)
- [ ] Thorough-tier cross-chunk notes reference chunk IDs, not vague descriptions

Fix any gaps, then present the enriched roadmap to the human.

## Templates

### Chunk Entry — Enriched Fields

Append these fields after the existing `Description` field in each chunk. Do not insert them between existing fields.

**Standard tier:**
```markdown
**Acceptance criteria:**
- <Primary testable outcome>
- <Error path or boundary condition>
- <Integration assertion where relevant>

**Pattern references:**
- Follow the handler pattern at `<path>` (established in chunk-001)

**Contextual notes:**
- See ARCHITECTURE.md > <Section name>
```

**Thorough tier:**
```markdown
**Acceptance criteria:**
- <Primary testable outcome>
- <Error path — invalid input or external failure>
- <Boundary condition>
- <Integration assertion>

**Pattern references:**
- Follow the adapter pattern at `<path>` (established in chunk-00N)

**Contextual notes:**
- See ARCHITECTURE.md > <Section name>
- Constrained by ADR-00N (<decision title>)
- Integrates with chunk-00N (<chunk title>) — <specific integration point to verify>
```

## Edge Cases

**Walking skeleton (chunk-001) has no prior patterns to reference:**
Write "No existing pattern — chunk-001 establishes the foundational pattern. Subsequent chunks follow this structure." For acceptance criteria, focus on the end-to-end traversal the skeleton must prove.

**PRD lacks explicit success criteria for a chunk's scope:**
Derive acceptance criteria from the architecture constraints for that component instead. Note the derivation source: "Derived from ARCHITECTURE.md > \<Section\> (no direct PRD criterion)."

**Chunk covers a cross-cutting concern (logging, error handling):**
Acceptance criteria should assert observable system-level behaviour, not implementation detail: "All unhandled exceptions produce a structured log entry with request ID" rather than "Logger is wired to the exception handler."

**Thorough tier — no ADRs exist:**
Omit ADR references from contextual notes. Do not fabricate ADR references. Note in the Decisions Log if the absence of ADRs was expected given the architecture.

**Greenfield project — no existing code for pattern references:**
For early-phase chunks (Phase 0), write "No existing pattern — establish the pattern here." For later chunks, reference the walking skeleton or earliest prior chunk that set the relevant pattern.

**Brownfield project — existing codebase has multiple competing patterns:**
Point to the pattern the architecture designates as the target state, not legacy patterns. Note the discrepancy: "Follow the pattern at `<new path>`. Existing code at `<legacy path>` uses the old pattern — do not replicate it."

## Evaluation Scenarios

### Scenario 1: Standard Tier — New Feature with Walking Skeleton

**Context:** A 6-chunk roadmap for a recipe API. chunk-001 (walking skeleton) established handler and repository patterns. Chunks 2-6 cover recipe CRUD, ingredient management, and search.

**Expected enrichment:**
- Each chunk has 2-4 testable acceptance criteria derived from the PRD's feature requirements
- Pattern references for chunks 002-006 point to the walking skeleton at `src/api/handlers/health.ts` and `src/repositories/health.ts`
- Contextual notes reference the relevant ARCHITECTURE.md section for each component (e.g., "See ARCHITECTURE.md > Recipe Service > Data Model")
- No ADR references (Standard tier)

**Validation:** The developer-agent for chunk-003 (ingredient management) can read the enriched chunk and begin TDD without asking the orchestrator for the acceptance bar or where to look for structural patterns.

### Scenario 2: Thorough Tier — Multi-Component System with ADRs

**Context:** A 14-chunk phased roadmap for a notification service. Multiple ADRs exist (stateless auth, async event schema, retry policy). Chunks in Phase 2 integrate the email adapter with the notification consumer.

**Expected enrichment:**
- Phase 0 chunks: 3-5 acceptance criteria including infrastructure-level assertions ("Database migrations run idempotently")
- Phase 2 integration chunks: Cross-chunk notes flag the specific integration point ("Integrates with chunk-008 (email adapter) — confirm `NotificationEvent` schema matches before implementing dispatch logic")
- ADR references appear on chunks constrained by those decisions (e.g., "Constrained by ADR-002 (async event schema)")
- Pattern references point to the walking skeleton for foundational patterns and to the earliest adapter chunk for the adapter pattern

**Validation:** The orchestrator can assign any Phase 2 chunk with 2-5 lines of pointers ("Do chunk-011, see the ADR noted in its contextual notes") and the developer-agent has sufficient context to proceed without a separate briefing session.

## Success Indicators

This skill succeeds when:
- The enriching agent produces a fully enriched `ROADMAP.md` without asking methodology questions
- Every chunk's acceptance criteria are testable — an agent can assert pass or fail without interpretation
- Pattern references point to file locations, not explanations
- The enriched roadmap enables developer-agents to begin implementation with only 2-5 lines of orchestrator pointers
- Enrichment depth is consistent and matches the specified workflow tier
- No structural field from `decomposing-work` is modified
