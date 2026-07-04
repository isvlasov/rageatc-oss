---
name: enriching-roadmap
description: Enriches implementation roadmap chunks with acceptance criteria, pattern references, and contextual notes. Use after decomposing-work has produced the structural roadmap and before planning-software creates the orchestration plan. Does not modify chunk structure or dependencies.
---

# Enriching Roadmap

Enriches a confirmed structural roadmap so every chunk becomes self-contained enough for a developer-agent to begin work — adding acceptance criteria, pattern references, and contextual notes without modifying any structural field decomposing-work produced.

**Position:** decomposing-work (ROADMAP.md structural) → enriching-roadmap (acceptance criteria, pattern refs, notes) → planning-software (orchestration plan).

**Inputs:** confirmed ROADMAP.md; approved ARCHITECTURE.md (source for pattern references and component context); PRD.md (source of testable success criteria); workflow tier; optionally `.interface-design/system.md` — if present, derive design-specific acceptance criteria for UI chunks. If the tier was not specified, infer from the roadmap (1-3 chunks = Quick, 4-8 = Standard, 9+ or phased DAG = Thorough), state the inference, and proceed.

**Output:** the same ROADMAP.md, modified in place — three fields appended to each chunk (`Acceptance criteria`, `Pattern references`, `Contextual notes`). Do not alter existing fields (`Type`, `Component`, `Status`, `Size`, `Depends on`, `Files`, `Description`). Present the enriched roadmap for human review before treating it as the working baseline.

**Not covered:** chunk structure and dependencies (decomposing-work), plan creation (planning-software), technology-specific implementation guidance (developer-agent skills).

## Workflow

### Step 1: Read All Inputs

Read PRD.md, ARCHITECTURE.md, and ROADMAP.md fully before writing anything. Build a working map of: PRD success criteria; architecture components and their responsibilities; what chunk-001 (walking skeleton) established (the primary pattern reference for all subsequent chunks); and, Thorough only, which ADRs constrain which chunks.

### Step 2: Determine Enrichment Depth

One tier across the entire roadmap — never mixed per chunk.

| Tier | Acceptance criteria | Pattern references | Contextual notes |
|---|---|---|---|
| **Quick** | Not invoked — orchestrating-software-dev skips enrichment for Quick. If invoked directly, 1-2 per chunk | Not invoked | Not invoked |
| **Standard** | 2-4 per chunk — full coverage of chunk scope | Required — point to walking skeleton or prior chunks | Reference relevant ARCHITECTURE.md section |
| **Thorough** | 3-5 per chunk — coverage + edge cases and error paths | Required — point to walking skeleton or most relevant prior chunk | ARCHITECTURE.md section + ADR references + cross-chunk integration notes where chunks interact |

### Step 3: Enrich Each Chunk

Process in roadmap order (Phase 0 first).

**Acceptance criteria:**
- Derive each criterion from a specific PRD success condition or architecture constraint — not from the chunk description alone
- Testable form: "Given X, when Y, then Z" or a concrete assertion ("All endpoints return JSON with a consistent error envelope")
- Standard/Thorough: add criteria for error paths and integration points where they exist in the chunk scope

**Pattern references (Standard and Thorough):**
- Prefer chunk-001 (walking skeleton) if it established the relevant pattern; if a prior chunk set a more specific one, point there
- Reference concrete locations: "Follow the handler pattern at `src/api/handlers/health.ts`"
- If no pattern exists yet (greenfield, early phase): "No existing pattern — establish the pattern for subsequent chunks to follow"
- Point to the location only — no example code, no explanation of how the pattern works

**Contextual notes (Standard and Thorough):**
- Reference the governing section: "See ARCHITECTURE.md > Authentication > JWT Strategy"
- Thorough: add constraining ADRs ("Constrained by ADR-003 (stateless auth)") and cross-chunk integration flags ("Integrates with chunk-008 (email adapter) — confirm shared event schema before implementing")
- If system.md exists and the chunk touches UI: reference the design system and add design-specific acceptance criteria (e.g., "Spacing uses the 4px base grid", "Cards follow the card pattern in system.md")

### Step 4: Validate Enrichment

- [ ] Every chunk has all three fields appended
- [ ] All acceptance criteria are testable assertions, not descriptions of what the code will do
- [ ] Pattern references point to existing code locations, not explanations
- [ ] No existing chunk field modified
- [ ] Depth consistent across all chunks
- [ ] Thorough cross-chunk notes reference chunk IDs, not vague descriptions

Fix gaps, then present to the human.

## Templates

Append after the existing `Description` field — never between existing fields.

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

**Walking skeleton has no prior patterns:** write "No existing pattern — chunk-001 establishes the foundational pattern. Subsequent chunks follow this structure." Acceptance criteria focus on the end-to-end traversal the skeleton must prove.

**PRD lacks success criteria for a chunk's scope:** derive from that component's architecture constraints and note the source: "Derived from ARCHITECTURE.md > \<Section\> (no direct PRD criterion)."

**Cross-cutting concern chunk (logging, error handling):** assert observable system-level behaviour, not implementation detail — "All unhandled exceptions produce a structured log entry with request ID", not "Logger is wired to the exception handler."

**Thorough tier, no ADRs exist:** omit ADR references — never fabricate them.

**Brownfield with competing patterns:** point to the architecture's designated target pattern and flag the legacy: "Follow the pattern at `<new path>`. Existing code at `<legacy path>` uses the old pattern — do not replicate it."
