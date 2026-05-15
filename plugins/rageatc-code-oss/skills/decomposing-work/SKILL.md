---
name: decomposing-work
description: Converts an approved ARCHITECTURE.md into an implementation roadmap of isolated, dependency-ordered chunks. Use when architecture has been approved and work must be decomposed before implementation begins.
---

# Decomposing Work

## Purpose

This skill guides a breakdown-agent through converting an approved ARCHITECTURE.md into a persistent roadmap of implementation chunks. It sits between upstream architecture design (`architecting-software`) and downstream enrichment (`enriching-roadmap`), encoding the decomposition discipline that determines whether developer-agents succeed.

Use this skill when an ARCHITECTURE.md exists and has been confirmed by the human before implementation begins.

## Scope and Constraints

**This skill covers:**
- Reading ARCHITECTURE.md and extracting chunk boundaries
- Writing the roadmap with the chunk schema defined in this skill
- Ordering chunks by dependency and grouping them into phases
- Annotating chunks with file sets for parallel conflict detection
- Flagging ambiguities in the architecture for human resolution

**This skill does NOT cover:**
- Architecture design or evaluation (`architecting-software`)
- Enriching chunks with acceptance criteria and pattern references (`enriching-roadmap`)
- Orchestrating the full build workflow (`orchestrating-software-dev`)
- Implementation, code generation, or technology-specific guidance

**Handoff position:**

```
architecting-software  →  decomposing-work  →  enriching-roadmap  →  developer-agent
(ARCHITECTURE.md)         (ROADMAP.md           (ROADMAP.md            (implementation)
                           structure)            enriched)
```

Receive from upstream: a confirmed `ARCHITECTURE.md` with component boundaries, interfaces, data model, and non-functional requirements.

Hand off downstream: `ROADMAP.md` in the project root — a persistent, phased list of chunks with structural metadata (type, dependencies, files, phases). The `enriching-roadmap` skill then adds acceptance criteria and pattern references to make each chunk executable.

## Inputs Required

Before starting, confirm you have:
- [ ] A confirmed `ARCHITECTURE.md` — reviewed and approved by the human
- [ ] Human confirmation that decomposition should proceed (do not begin autonomously)

If the architecture is ambiguous — missing component boundaries, implicit interfaces, or unclear data ownership — flag specific gaps to the human before producing chunks. Do not infer boundaries from unclear architecture; inferred boundaries produce misaligned briefs.

## Outputs Produced

**Always:**
- `ROADMAP.md` — placed in the project root. Contains a header block, global Definition of Done, and all chunks grouped by phase. Uses the chunk schema defined in the Templates section.

**Propose before finalising:**
Present the draft roadmap to the human before treating it as the working baseline. Label it "proposed" until the human confirms. Apply any corrections before writing the final file.

## Workflow

### Step 1: Read the Architecture

Read `ARCHITECTURE.md` fully. While reading, extract and list:

- **Components** — named services, modules, packages, or domains
- **Integration surfaces** — every API, event contract, shared schema, or data model interface between components
- **Foundational infrastructure** — what must exist before any feature can be implemented (project scaffold, CI/CD, database setup, auth skeleton, shared types, logging wiring)
- **Cross-cutting concerns** — logging, error handling, observability, authentication — but only those explicitly described in the architecture

If any element is ambiguous or absent, log it as an open question. Do not proceed past Step 1 with unresolved questions that would force you to infer chunk boundaries.

**Output:** Four labelled lists (components, integration surfaces, infrastructure, cross-cutting concerns). Unresolved questions listed separately.

### Step 2: Calibrate Scale

Before decomposing, assess the project scale from the architecture and set a target chunk range. This prevents over-decomposition where the overhead of brief-develop-review cycles exceeds the project's complexity.

**Assess these signals:**
- Number of components/services in the architecture
- Team size (solo developer vs team)
- Project complexity (CRUD app vs distributed system)
- Workflow tier (Quick / Standard / Thorough)

**Target chunk ranges:**

| Project scale | Target chunks | Example |
|---------------|---------------|---------|
| Small (1-2 components, solo dev) | 5-12 | Personal recipe app, CLI tool |
| Medium (3-5 components, small team) | 10-20 | SaaS feature, API service |
| Large (5+ components, team) | 15-40 | Platform, multi-service system |

**Use this as a sanity check after Step 4** (dependency graph). If your chunk count significantly exceeds the target range, consolidate by merging chunks that form natural vertical slices. Over-decomposition creates more overhead than it prevents risk.

### Step 3: Identify the Walking Skeleton (chunk-001)

Before any other chunk, identify the Walking Skeleton. This is non-negotiable.

The Walking Skeleton is the thinnest end-to-end implementation through all major architectural layers — a single request or operation that traverses the full system and returns a result, with no real business logic. Its purpose is to validate that all layers connect and to establish the project structure into which all subsequent chunks plug.

Define the skeleton: state what the single traversal is (e.g., "HTTP request to `/health` returns 200 from behind the database connection"), which architectural layers it touches, and what infrastructure it establishes. Assign it `chunk-001`.

**The Walking Skeleton is always Phase 0, Chunk 001. It has no dependencies. Every other chunk depends on it.**

### Step 4: Extract Remaining Chunks

Work through the extracted lists from Step 1. For each element, assign one or more chunks using this mapping:

| Architecture element | Chunk type |
|---|---|
| Component / service / module | One or more `feature` chunks (start with thinnest viable path through that component) |
| API boundary / shared interface / event contract | One `interface` chunk (define the contract before either side implements) |
| Shared data model or schema | One `infrastructure` chunk (schema and migrations before data access layer) |
| Foundation infrastructure (CI, scaffold, auth skeleton, shared types) | One or more `infrastructure` chunks in Phase 0 |
| Third-party integration or adapter | One `integration` chunk |
| Cross-cutting concern (logging, observability, error handling) | Scaffold in Phase 0 as `infrastructure`; harden in Phase 3 as `hardening` |

**Chunk granularity principle:** Each chunk delivers a **coherent vertical slice** — the smallest unit of work that produces a testable capability end-to-end.

- **Primary rule:** Vertical slice coherence. A chunk should represent a deliverable that can be tested independently. Don't split tightly coupled code (e.g., a service from its routes) just to reduce file count.
- **Secondary heuristic:** Chunks typically touch 2–5 files. If a chunk exceeds 5 files, verify the files are genuinely coupled. If they aren't, split.
- **Anti-pattern:** Do not split a single file's functionality across chunks unless the file genuinely has independent concerns.

The previous hard constraint of 1-3 files caused artificial splits in practice. Vertical slices aligned with how code is written and tested produce better results.

For each chunk, write a draft entry using the schema from the Templates section. Do not fill `Depends on` yet — that is Step 5.

### Step 5: Build the Dependency Graph

For each chunk, identify which other chunks must be complete before it can begin. Record these as `Depends on` references using chunk IDs.

Apply these rules:
- Interface chunks must precede both sides of the integration they define
- Infrastructure chunks precede any chunk that requires the infrastructure
- The Walking Skeleton precedes all other chunks
- Feature chunks for a component may depend on that component's interface chunks but not on sibling feature chunks (keep them parallel-safe)

After filling all `Depends on` fields, verify the graph is a DAG (no cycles). If a cycle exists, the decomposition has a structural problem — resolve it before proceeding.

Identify chunks with no dependencies beyond the Walking Skeleton — these are the first parallel candidates.

### Step 6: Assign Phases

Group chunks into phases by dependency depth. Use this default phasing:

| Phase | Content |
|---|---|
| **Phase 0 — Foundation** | Walking Skeleton, CI/CD scaffold, shared types and interfaces, database schema, auth skeleton, logging wiring |
| **Phase 1 — Core domains** | Primary capability of each bounded context or component; no cross-component integration yet |
| **Phase 2 — Integration** | Cross-component flows, API composition, third-party adapters, authentication flows using the auth skeleton |
| **Phase 3 — Hardening** | Comprehensive error handling, observability, performance-sensitive paths, security hardening |

If the architecture is simple (one or two components, no distinct integration layer), collapse Phase 1 and Phase 2 into a single phase. Do not create empty phases.

### Step 7: Annotate File Sets

For each chunk, list the files it will likely create or modify. This is the primary mechanism for parallel conflict detection — before the orchestrator dispatches two chunks simultaneously, it checks whether their file sets overlap.

Rules:
- List concrete paths where known (`src/api/routes/user.ts`)
- Use directory-level notation when paths depend on implementation choices (`src/core/auth/`)
- Mark read-only dependencies separately — files a chunk reads but does not modify do not create conflicts

If two chunks in the same phase have overlapping file sets, they cannot run in parallel. Either re-sequence them or re-examine the chunk boundary.

### Step 8: Validate and Propose

Before writing the roadmap file, run this checklist:

- [ ] Walking Skeleton is `chunk-001`, Phase 0, with `Depends on: —`
- [ ] Interface chunks appear before both sides of any integration they define
- [ ] Each chunk delivers a coherent vertical slice (not artificially split by file count)
- [ ] Chunks exceeding 5 files have genuinely coupled files — verify coupling
- [ ] **Proportionality check:** chunk count is within the target range from Step 2. If exceeded, consolidate vertical slices before proceeding.
- [ ] Dependency graph has no cycles
- [ ] Chunks in the same phase intended for parallel execution have non-overlapping file sets
- [ ] All architecture components are covered by at least one chunk
- [ ] Cross-cutting concerns from the architecture have dedicated Phase 0 infrastructure chunks

Correct any failures. Record any non-obvious decomposition judgements (chunk boundary choices, ordering rationale, scope decisions) in the Decisions Log section of the roadmap. Then present the proposed roadmap to the human. Note any open questions, ambiguous boundaries, or decomposition judgements the human should review.

Write `ROADMAP.md` only after the human confirms.

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

### chunk-002: <title>

**Type:** infrastructure | interface
...

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

Every chunk entry must include all fields:

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

**Status update rule:** Only append status changes; never edit previous values. The roadmap is append-only after confirmation.

## Edge Cases

**Architecture is prose-heavy with no explicit component boundaries:**
Do not infer boundaries. Read the prose for any named systems, services, subsystems, or data stores. If boundaries remain unclear after careful reading, log specific questions for human resolution. Present partial decomposition for discussion rather than filling gaps with assumptions.

**Single-component project (no integration layer):**
Collapse to Phase 0 (Walking Skeleton + any infrastructure) and Phase 1 (feature chunks). Skip Phase 2 and Phase 3 unless hardening or observability is explicitly called for in the architecture. Fewer phases is better when the architecture is simple.

**Cross-cutting concern spans the whole system (e.g., authentication):**
Create a Phase 0 `infrastructure` chunk for the skeleton (interfaces, middleware wiring, stub implementation). Create integration chunks in Phase 2 for the consuming features. Do not attempt to implement authentication fully in Phase 0 — only the wiring that unblocks parallel feature development.

**Two chunks have overlapping file sets and cannot be re-sequenced:**
Add a dependency so the earlier chunk completes before the later one begins. Overlap means sequential, not parallel. Document this as a sequencing constraint in the Decisions Log.

**Architecture specifies a technology the agent is unfamiliar with:**
Proceed with decomposition based on the component boundaries and interface descriptions. Note technology uncertainty in the Decisions Log. Technology-specific implementation knowledge is the developer-agent's responsibility, not the breakdown-agent's.

**Greenfield vs brownfield:**
For brownfield, Step 1 must include reading the existing codebase structure to identify which files will be modified versus created. The Walking Skeleton may already exist — if so, chunk-001 becomes an integration chunk connecting the new components to the existing scaffold.

## Evaluation Scenarios

### Scenario 1: Simple Single-Component API

**Context:** ARCHITECTURE.md describes a single REST API service with a PostgreSQL database, three endpoint groups (users, items, orders), hexagonal internal structure, and JWT authentication. No external integrations.

**Expected roadmap:**
- Phase 0: Walking Skeleton (health endpoint traversing all layers, chunk-001), database schema and migrations (chunk-002), JWT auth middleware skeleton (chunk-003)
- Phase 1: User endpoint group (chunk-004, depends: 001, 002, 003), Item endpoint group (chunk-005, depends: 001, 002), Order endpoint group (chunk-006, depends: 001, 002, 004, 005)
- Phase 3: Error handling middleware (chunk-007), structured logging (chunk-008)
- No Phase 2 (single service, no integration surface)
- Total: ~8 chunks (within 5-12 target for small project), each a coherent vertical slice, file sets non-overlapping within each phase

**Validation checks:**
- Scale calibration: solo dev + simple API = target 5-12 chunks; 8 is proportionate
- chunk-001 has no dependencies and covers only scaffold files
- chunk-004 and chunk-005 can run in parallel (non-overlapping file sets)
- chunk-006 depends on chunk-004 and chunk-005 because orders reference users and items
- Each chunk is a vertical slice (e.g., user endpoint group includes service + routes + tests)

### Scenario 2: Multi-Component System with Shared Interface

**Context:** ARCHITECTURE.md describes a notification service that receives events from an orders service via a shared event schema, and dispatches email and push notifications through third-party providers. Two components, one shared event schema, two adapters.

**Expected roadmap:**
- Phase 0: Walking Skeleton (end-to-end event received → stub notification sent), shared event schema interface chunk (defines the event contract both sides consume)
- Phase 1: Orders service event publisher (depends on interface chunk), notification service event consumer (depends on interface chunk) — these run in parallel because the interface chunk is pre-defined
- Phase 2: Email adapter (SendGrid integration), push adapter (FCM integration), routing logic connecting consumer to adapters
- Phase 3: Retry logic, dead-letter queue, alerting on failure rates

**Validation checks:**
- Interface chunk precedes both the publisher and consumer chunks
- Publisher and consumer chunks have non-overlapping file sets — they can execute in parallel
- Adapter chunks are `integration` type, not `feature` type
- Walking Skeleton stubs all adapters — no third-party calls in Phase 0

### Scenario 3: Prose-Heavy Architecture with Ambiguous Boundaries

**Context:** ARCHITECTURE.md describes a "content management platform" in narrative form. It names a "content store", a "publishing pipeline", and a "delivery layer" but does not define the interfaces between them or the data model for content.

**Expected agent behaviour:**
- Step 1 produces three candidate components but logs open questions: What data model does the content store use? What is the interface between the content store and the publishing pipeline — a direct call, an event, a shared database table? Does the delivery layer cache? What protocol does it use?
- The agent presents these questions to the human before proceeding
- Decomposition does not begin until boundaries are clarified
- After clarification, the agent proceeds with Step 3 (Walking Skeleton) using the confirmed boundaries
- The Decisions Log records the human's answers as decomposition rationale

## Success Indicators

This skill succeeds when:
- The breakdown-agent produces a complete `ROADMAP.md` from `ARCHITECTURE.md` without asking for clarification on methodology, chunk schema, or dependency representation
- Chunk count is proportionate to project scale (within the target range from Step 2)
- Every chunk delivers a coherent vertical slice — no artificial splits driven by file-count limits
- Every chunk carries enough structural metadata (type, dependencies, files) for the enriching-roadmap skill to add acceptance criteria and pattern references
- The Walking Skeleton is always `chunk-001`, always Phase 0, always with no dependencies — and every subsequent chunk traces its dependency chain back to it
- Interface chunks appear before both sides of any integration they define — no consumer chunk begins before its contract is established
- Chunks intended for parallel execution have provably non-overlapping file sets
- The roadmap persists correctly across sessions — status updates append to existing entries, nothing is edited, the chunk history is complete
- Ambiguous architecture boundaries are surfaced as explicit questions for human resolution, not silently inferred
