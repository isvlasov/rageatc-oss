---
name: decomposing-work
description: Converts an approved ARCHITECTURE.md into an implementation roadmap of isolated, dependency-ordered chunks. Use when architecture has been approved and work must be decomposed before implementation begins.
---

# Decomposing Work

Converts a confirmed ARCHITECTURE.md into a persistent roadmap of implementation chunks — the decomposition discipline that determines whether developer-agents succeed.

**Position:** architecting-software (ARCHITECTURE.md) → decomposing-work (ROADMAP.md structure) → enriching-roadmap (acceptance criteria, pattern references) → developer-agent.

**Inputs:** a confirmed ARCHITECTURE.md and human confirmation to proceed — do not begin autonomously. If the architecture is ambiguous (missing component boundaries, implicit interfaces, unclear data ownership), flag specific gaps to the human before producing chunks. Inferred boundaries produce misaligned briefs.

**Output:** `ROADMAP.md` in the project root — header block, global Definition of Done, chunks grouped by phase, per the Templates section. Present the draft as "proposed" and write the final file only after the human confirms.

**Not covered:** architecture design, enrichment, orchestration, implementation.

## Workflow

### Step 1: Read the Architecture

Read ARCHITECTURE.md fully and extract four labelled lists:

- **Components** — named services, modules, packages, domains
- **Integration surfaces** — every API, event contract, shared schema, or data-model interface between components
- **Foundational infrastructure** — what must exist before any feature (project scaffold, CI/CD, database setup, auth skeleton, shared types, logging wiring)
- **Cross-cutting concerns** — logging, error handling, observability, authentication — only those explicitly described in the architecture

Log anything ambiguous or absent as an open question. Do not proceed with unresolved questions that would force you to infer chunk boundaries.

### Step 2: Calibrate Scale

Assess project scale (component count, team size, complexity, workflow tier) and set a target chunk range — this prevents over-decomposition, where brief-develop-review overhead exceeds the project's complexity.

| Project scale | Target chunks | Example |
|---------------|---------------|---------|
| Small (1-2 components, solo dev) | 5-12 | Personal recipe app, CLI tool |
| Medium (3-5 components, small team) | 10-20 | SaaS feature, API service |
| Large (5+ components, team) | 15-40 | Platform, multi-service system |

Use this as a sanity check after Step 5: if the chunk count significantly exceeds the target, consolidate chunks that form natural vertical slices.

### Step 3: Identify the Walking Skeleton (chunk-001)

Non-negotiable, before any other chunk. The Walking Skeleton is the thinnest end-to-end implementation through all major architectural layers — a single request or operation traversing the full system with no real business logic. It validates that the layers connect and establishes the project structure every subsequent chunk plugs into.

State the single traversal (e.g., "HTTP request to `/health` returns 200 from behind the database connection"), the layers it touches, and the infrastructure it establishes. **Always Phase 0, chunk-001, no dependencies; every other chunk depends on it.**

### Step 4: Extract Remaining Chunks

Map each element from Step 1 to chunks:

| Architecture element | Chunk type |
|---|---|
| Component / service / module | One or more `feature` chunks (start with the thinnest viable path through the component) |
| API boundary / shared interface / event contract | One `interface` chunk (contract before either side implements) |
| Shared data model or schema | One `infrastructure` chunk (schema and migrations before data access) |
| Foundation infrastructure (CI, scaffold, auth skeleton, shared types) | `infrastructure` chunks in Phase 0 |
| Third-party integration or adapter | One `integration` chunk |
| Cross-cutting concern | Scaffold in Phase 0 as `infrastructure`; harden in Phase 3 as `hardening` |

**Granularity: each chunk is a coherent vertical slice** — the smallest unit that produces an independently testable capability end-to-end. Don't split tightly coupled code (a service from its routes) just to reduce file count. Chunks typically touch 2–5 files; beyond 5, verify the files are genuinely coupled, and if not, split. Never split a single file's functionality across chunks unless it genuinely has independent concerns. (A previous hard 1-3 file constraint caused artificial splits — vertical slices aligned with how code is written and tested work better.)

Write a draft entry per chunk using the Templates schema; leave `Depends on` for Step 5.

### Step 5: Build the Dependency Graph

Fill `Depends on` for every chunk, applying:

- Interface chunks precede both sides of the integration they define
- Infrastructure chunks precede chunks requiring that infrastructure
- The Walking Skeleton precedes everything
- Feature chunks may depend on their component's interface chunks but not on sibling feature chunks (keep them parallel-safe)

Verify the graph is a DAG — a cycle means the decomposition has a structural problem; resolve it before proceeding. Chunks with no dependencies beyond the Walking Skeleton are the first parallel candidates.

### Step 6: Assign Phases

Group by dependency depth:

| Phase | Content |
|---|---|
| **Phase 0 — Foundation** | Walking Skeleton, CI/CD scaffold, shared types and interfaces, database schema, auth skeleton, logging wiring |
| **Phase 1 — Core domains** | Primary capability of each component; no cross-component integration yet |
| **Phase 2 — Integration** | Cross-component flows, API composition, third-party adapters, auth flows using the skeleton |
| **Phase 3 — Hardening** | Comprehensive error handling, observability, performance-sensitive paths, security hardening |

For simple architectures (one or two components, no distinct integration layer), collapse Phases 1 and 2. Do not create empty phases.

### Step 7: Annotate File Sets

List the files each chunk will likely create or modify — the primary mechanism for parallel conflict detection. Concrete paths where known (`src/api/routes/user.ts`); directory-level notation when paths depend on implementation choices (`src/core/auth/`); mark read-only dependencies separately (reads don't conflict).

Overlapping file sets within a phase mean those chunks cannot run in parallel — re-sequence or re-examine the boundary.

### Step 8: Validate and Propose

- [ ] Walking Skeleton is chunk-001, Phase 0, `Depends on: —`
- [ ] Interface chunks precede both sides of their integrations
- [ ] Each chunk is a coherent vertical slice; chunks over 5 files verified as genuinely coupled
- [ ] Chunk count within the Step 2 target range — consolidate if exceeded
- [ ] Dependency graph is acyclic
- [ ] Same-phase parallel chunks have non-overlapping file sets
- [ ] Every architecture component covered by at least one chunk
- [ ] Cross-cutting concerns have dedicated Phase 0 infrastructure chunks

Correct failures, record non-obvious judgements (boundary choices, ordering rationale, scope) in the Decisions Log, then present the proposed roadmap with any open questions. Write `ROADMAP.md` only after the human confirms.

## Templates

### ROADMAP.md Structure

```markdown
# Implementation Roadmap

**Project:** <project name>
**Architecture source:** ARCHITECTURE.md (confirmed <date>)
**Created:** <date>
**Status:** <draft | confirmed | in-progress>

## Definition of Done (applies to every chunk)

- Code compiles and existing tests pass
- New unit tests written and passing
- No files modified outside the declared file set
- Code reviewed and approved by reviewer-agent

---

## Phase 0 — Foundation

### chunk-001: <title>

**Type:** walking-skeleton
**Component:** —
**Status:** pending
**Size:** S | M | L
**Depends on:** —
**Files:** <list of files to create or modify>

**Description:** <what this chunk implements and why it must come first>

<!-- Acceptance criteria added by enriching-roadmap -->

---

## Phase 1 — Core Domains

### chunk-00N: <title>

**Type:** feature
**Component:** <component name from architecture>
**Status:** pending
**Size:** S | M | L
**Depends on:** chunk-001[, chunk-00X]
**Files:** <list>

**Description:** <what and why>

<!-- Acceptance criteria added by enriching-roadmap -->

---

## Phase 2 — Integration
...

## Phase 3 — Hardening
...

---

## Decisions Log

<!-- Append decomposition decisions here. Never edit existing entries. -->

### <date>: <decision title>

<Brief rationale for a non-obvious chunk boundary, ordering decision, or scope choice>
```

### Chunk Schema Reference

Every chunk entry includes all fields:

| Field | Required | Values |
|---|---|---|
| `Title` | Yes | Short imperative phrase (the `### chunk-NNN: <title>` heading) |
| `Type` | Yes | `walking-skeleton` \| `interface` \| `infrastructure` \| `feature` \| `integration` \| `hardening` |
| `Component` | Yes | Component name from architecture, or `—` for cross-cutting chunks |
| `Status` | Yes | `pending` \| `ready` \| `in-progress` \| `done` \| `blocked` |
| `Size` | Yes | `S` (< 50 lines), `M` (50–200 lines), `L` (200–400 lines) |
| `Depends on` | Yes | Chunk IDs, or `—` for chunk-001 |
| `Files` | Yes | Concrete paths or directory-level notation |
| `Description` | Yes | What and why in 2–4 sentences |
| `Acceptance criteria` | Added by enriching-roadmap | Bulleted, testable conditions — not part of initial decomposition |

**Status update rule:** the roadmap is append-only after confirmation — append status changes, never edit previous values.

## Edge Cases

**Prose-heavy architecture, no explicit boundaries:** do not infer. Read for named systems, services, subsystems, data stores; if boundaries remain unclear, log specific questions and present a partial decomposition for discussion rather than filling gaps with assumptions.

**Single-component project:** collapse to Phase 0 (Walking Skeleton + infrastructure) and Phase 1 (features). Skip Phases 2–3 unless hardening or observability is explicitly called for.

**System-wide cross-cutting concern (e.g., authentication):** Phase 0 `infrastructure` chunk for the skeleton (interfaces, middleware wiring, stub); Phase 2 integration chunks for consuming features. Only the wiring that unblocks parallel feature development goes in Phase 0.

**Overlapping file sets that cannot be re-sequenced:** add a dependency so the chunks run sequentially; document the sequencing constraint in the Decisions Log.

**Unfamiliar technology in the architecture:** decompose from component boundaries and interfaces anyway; note the uncertainty in the Decisions Log. Technology-specific knowledge is the developer-agent's responsibility.

**Brownfield:** Step 1 includes reading the existing codebase to identify modified vs created files. The Walking Skeleton may already exist — then chunk-001 becomes an integration chunk connecting new components to the existing scaffold.
