---
name: architecting-software
description: Designs software architecture from a confirmed PRD. Use when a PRD exists and architecture must be designed before implementation, when writing ADRs, choosing an architecture style, or selecting technology and databases.
---

# Architecting Software

## Purpose

This skill guides an Architect agent through designing software architecture from a confirmed PRD. It sits between upstream product definition (`managing-product`) and downstream task decomposition, encoding the discipline needed to translate "what to build" into "how to build it" — systematically, driver-first, and without the documented failure modes of AI-generated architecture.

Use this skill when a PRD exists and the system structure has not yet been decided.

## Scope and Constraints

**This skill covers:**
- Extracting architectural drivers from a PRD
- Making structural decisions across five dimensions: deployment, structure, communication, data, frontend
- Selecting technology using a weighted decision framework
- Producing ARCHITECTURE.md and ADRs

**This skill does NOT cover:**
- Initial product definition or requirements gathering (that is `managing-product`)
- Task decomposition or implementation briefs (downstream)
- Code generation or framework-specific implementation detail
- CI/CD pipeline design or detailed API specification
- Domain-specific patterns (healthcare, finance, IoT)

**Handoff position:**

```
managing-product  →  architecting-software  →  decomposing-work  →  enriching-roadmap
(PRD.md)             (ARCHITECTURE.md + ADRs)  (ROADMAP.md)         (enriched roadmap)
```

Receive from upstream: a confirmed `PRD.md` with problem statement, target users, success criteria, MoSCoW-prioritised requirements, constraints, and non-goals.

Hand off downstream: `ARCHITECTURE.md` in the project root and optional ADRs in `docs/decisions/` — ready for decomposing-work to begin without architectural ambiguity.

## Inputs Required

Before starting, confirm you have:
- [ ] A confirmed `PRD.md` — complete, reviewed, and finalised by managing-product
- [ ] Team size and composition (if stated or inferable)
- [ ] Any technology constraints stated in the PRD's Constraints section
- [ ] Existing systems the new software must integrate with (or "greenfield")

If team size is absent and cannot be inferred, flag this for human input before Step 3 — it is an architectural driver.

## Outputs Produced

**Always:**
- `ARCHITECTURE.md` — placed in the project root. Uses the codemap-centric structure defined in `references/architecture-template.md`

**When complexity warrants (see Step 2):**
- `docs/decisions/NNNN-title.md` — one ADR per significant structural decision. Uses the MADR minimal format defined in `references/adr-template.md`

## Scale-Adaptive Depth

The depth of architecture documentation varies by workflow tier. The same skill and process apply — the output depth differs.

| Tier | ARCHITECTURE.md depth | ADRs |
|------|----------------------|------|
| **Quick** | 10-20 lines. Overview + key decisions only. Skip codemap if project is small enough to navigate directly. | None |
| **Standard** | Codemap + key decisions. Cover component boundaries and primary patterns. | Optional — only for genuinely significant decisions |
| **Thorough** | Full template — overview, codemap, cross-cutting concerns, invariants, key decisions, dependencies, open questions | Yes — one per significant decision |

The architect should calibrate depth to the project, not produce a 200-line architecture document for a 3-file bug fix. When in doubt, start light and add detail only where it prevents downstream ambiguity.

## Workflow

### Step 1: Extract Requirements into Three Buckets

**What you're doing:** Categorising every PRD requirement so drivers can be identified in Step 2. Do not select any pattern in this step.

Read the PRD and sort requirements into:

**Functional requirements** — what the system must do (features, user stories). These drive component responsibilities but rarely determine structural choices alone.

**Quality attribute requirements** — how well the system must perform. Look for these signals in: success criteria, constraints, acceptance criteria, and any performance or security statements. Translate vague statements:
- "The app must be fast" → quantify: "P95 response time under X ms for the [action] workflow"
- "It must be secure" → decompose: what must be protected, from whom, under what threat model?
- "It should scale" → specify: what load, over what timeframe?

**Constraints** — fixed limitations: budget, timeline, team skills, technology mandates, regulatory requirements, existing systems.

**Output:** Three labelled lists. If a requirement is ambiguous, log it as an open question for human resolution before proceeding.

### Step 2: Identify and Rank Architectural Drivers

**What you're doing:** Finding the 3–7 requirements that force structural decisions. An architectural driver is any requirement — functional, quality attribute, or constraint — that forces a decision affecting many components, creates irreconcilable conflict with another requirement, cannot be met with standard patterns without deliberate choice, or carries significant business risk if unmet.

**Scale calibration — determine project complexity before proceeding:**

| Signal | Simple | Moderate | Complex |
|---|---|---|---|
| User types | 1 | 2 | 3+ |
| External integrations | 0–1 | 2–3 | 4+ |
| Explicit quality attribute requirements | None | 1–2 | 3+ |
| Team size | 1–5 | 6–20 | 20+ |
| Compliance requirements | None | Light | Regulated |

- **Simple:** Produce a focused ARCHITECTURE.md. Skip ADRs unless a decision is genuinely non-obvious.
- **Moderate:** Produce ARCHITECTURE.md. Write ADRs for decisions that involve meaningful trade-offs.
- **Complex:** Produce full ARCHITECTURE.md with ADRs for every significant structural decision.

**Rank drivers** by: (a) business impact if unmet, and (b) difficulty of satisfying given other constraints. Primary drivers are high on both axes. Document ranked list before Step 3.

**Output:** Ranked list of 3–7 architectural drivers with brief justification for each.

### Step 3: Make Structural Decisions in Constraint Order

**What you're doing:** Selecting the structural pattern for each of five dimensions, in order. Each decision constrains the next. Every selection must trace to a named driver — if a pattern cannot be justified by a driver, default to the simpler option.

Make decisions in this sequence:

#### 3a. Deployment Model

| Signal | Serverless | Containers/VMs |
|---|---|---|
| Traffic pattern | Variable, spiky | Predictable, sustained |
| Request duration | Short (under 15 min) | Any, including long-running |
| Cold start tolerance | Acceptable | Low latency required always |
| Ops maturity | Low — managed infra preferred | Medium–high |
| Cost model preference | Pay-per-request (cheap at low scale) | Provisioned compute (cheap at high scale) |
| Vendor lock-in tolerance | High | Low |

**Default:** Containers for sustained workloads; serverless for event-driven background jobs. Most production systems blend both.

#### 3b. Deployment Topology

| Signal | Monolith | Modular Monolith | Microservices |
|---|---|---|---|
| Team size | 1–5 | 5–50 | 50+ |
| Domain clarity | Unknown or emerging | Moderately understood | Well-understood, stable bounded contexts |
| Scaling requirements | Uniform, modest | Mostly uniform | Highly variable per domain |
| Operational maturity | Low | Medium | High — requires mature CI/CD, observability |
| Data isolation requirement | Low | Medium | High — compliance or ownership |

**Default: modular monolith.** Move to microservices only when you have organisational signals: deployment coordination is a bottleneck, teams step on each other's code, or domains have dramatically differing scaling needs. Microservices are an organisational scaling pattern first; do not apply them speculatively.

**Conway's Law check:** State what team structure this architecture requires. If it conflicts with known team constraints, revise the structure.

#### 3c. Internal Code Organisation

Governs the structure inside a service or monolith — independent of deployment topology.

| Signal | Layered | Hexagonal | Clean |
|---|---|---|---|
| Project complexity | Simple–medium | Medium–complex | Complex |
| Team experience | Beginner–intermediate | Intermediate–advanced | Advanced |
| Expected lifespan | Short (MVP, prototype) | Medium–long | Long |
| Testing requirements | Light | High testability required | Maximum testability |
| External dependencies | Few, stable | Many or likely to change | Many, business logic must be isolated |
| Business logic complexity | Simple CRUD | Moderate domain logic | Rich domain model |

**Default: layered for MVPs and simple projects; hexagonal when external dependencies are many or likely to change and testability matters.** Clean Architecture is hexagonal with more explicit layer naming — treat them as interchangeable unless you need the additional structure.

Caution: layered architecture tends to degrade into a "big ball of mud" as complexity grows because layers are not enforced. If you expect significant lifespan or domain complexity, choose hexagonal.

**Dependency direction rule:** State which way dependencies flow and encode it as an invariant. For hexagonal/clean: infrastructure depends on core, never the reverse. For layered: presentation → application → domain → infrastructure.

#### 3d. Communication Pattern

| Need | Request-Response | Event-Driven |
|---|---|---|
| User needs immediate result | Yes | No |
| Strong consistency required | Yes | No (needs saga/outbox pattern) |
| Background or async workflows | No | Yes |
| High fan-out (one event, many consumers) | No | Yes |
| Simple CRUD | Yes | Overkill |

**Default:** Request-response. Add event-driven for specific async workflows (background jobs, multi-step workflows, high fan-out). Introducing event-driven architecture adds observability and debugging complexity — only when a specific driver requires it.

#### 3e. Data Strategy

| Signal | Relational (SQL) | Document (NoSQL) |
|---|---|---|
| Schema | Well-defined, stable | Variable, evolving |
| Relationships | Complex — many joins | Few — denormalised |
| Consistency requirement | Strong (ACID) | Eventual acceptable |
| Query patterns | Complex, ad-hoc | Known access patterns, high write throughput |
| Domain examples | Finance, inventory, user accounts | Content, catalogues, real-time apps |

**Default: PostgreSQL.** It handles most applications at significant scale, supports JSON columns for flexibility, and provides ACID guarantees that prevent whole categories of bugs. Add specialised stores only when a specific, measurable problem requires them: Redis for caching/sessions, Elasticsearch for full-text search, a time-series DB for high-volume telemetry.

#### 3f. Frontend Approach

| Signal | SPA | SSR | SSG | MPA |
|---|---|---|---|---|
| SEO required | No | Yes | Yes | Yes |
| Interactivity | High | Medium–high | Low | Low |
| Content update frequency | Any | Real-time or per-user | Infrequent (rebuild on change) | Any |
| Infrastructure complexity | Low — static hosting | Medium — Node server | Low — static hosting | Medium |
| Domain examples | Admin dashboards, internal tools | E-commerce, SaaS, social | Blogs, docs, marketing | Enterprise portals |

**Default: SSG for mostly-static content; SSR for SEO + interactivity + dynamic personalisation; SPA for internal tools and authenticated apps with no SEO requirement.**

**Output:** One selected pattern per dimension with the driver(s) it satisfies stated explicitly. If no driver justifies a more complex option, the simpler default wins.

### Step 4: Select Technology

**What you're doing:** Choosing specific technologies to implement the structural patterns selected in Step 3. Architecture patterns first, technology second — this step follows structural decisions, not the other way around.

For simple projects (Step 2: Simple), apply the simplicity defaults directly — formal decision matrix is only warranted when multiple viable options exist with meaningful trade-offs.

Use a weighted decision matrix for any non-obvious choice:

1. **Define criteria:** Technical fit, performance, ecosystem maturity, team familiarity, total cost of ownership, vendor risk, integration compatibility
2. **Weight criteria** (1–5) by project context — a solo developer weights familiarity heavily; a regulated enterprise weights vendor stability and TCO
3. **Score 2–4 candidates** against each criterion (1–5)
4. **Apply veto conditions** — a technology failing a hard requirement is eliminated regardless of weighted score (missing required compliance certification, critical known vulnerability, not open source when required)
5. **Validate** the top choice with a proof of concept addressing your highest-uncertainty integration point

**Selection anti-patterns to avoid:**
- **Cargo culting:** Do not copy technology choices from Netflix or Stripe; their team size and scale context are different
- **Recency bias:** New technology may lack production-grade ecosystem maturity
- **CV-driven:** Choose for the project, not for learning or portfolio value
- **Premature optimisation:** Start with PostgreSQL, add Redis when you have a cache miss problem; start with a container, move to Kubernetes when coordination complexity requires it

**Build vs buy:** For commodity capabilities (authentication, payments, email delivery, search), prefer a managed service or open-source solution. Build only when the capability is a direct competitive differentiator or when no adequate solution exists.

**Output:** Selected technology for each structural dimension, with brief justification.

### Step 5: Verify Non-Functional Coverage

**What you're doing:** Confirming the architecture explicitly addresses the non-functional concerns that AI-generated architectures consistently miss. Walk through each item and state how the proposed architecture handles it. These items may overlap with your identified drivers — this checklist catches ones that were not surfaced as primary drivers but still require a decision.

Run this checklist against the architecture proposed in Steps 3–4:

- [ ] **Security:** Authentication and authorisation model defined. What must be protected and how?
- [ ] **Observability:** Logging, metrics, and distributed tracing approach defined. How will you know the system is healthy?
- [ ] **Failure recovery:** What happens when a component fails? Retry strategy, circuit breakers, graceful degradation?
- [ ] **Data backup and recovery:** Backup frequency, retention, and recovery time objective (RTO)?
- [ ] **Audit logging:** Are business-critical operations logged with sufficient detail for compliance and debugging?
- [ ] **Performance budget:** Are response time expectations defined for the critical user paths?
- [ ] **Data privacy:** Is any personally identifiable information (PII) handled? What controls apply?
- [ ] **Scalability:** Are the scaling limits of the chosen deployment and topology adequate for stated load expectations?

If a PRD requirement or driver maps to an item on this list, the architecture must address it. If an item has no driver, record a brief statement explaining why it is out of scope or deferred.

**Output:** Completed checklist with one-line architecture decision per item.

### Step 6: Produce Documentation

**What you're doing:** Writing `ARCHITECTURE.md` and any ADRs required.

#### ARCHITECTURE.md

Use the template at `references/architecture-template.md`. The codemap is the most important section — start there. Fill every section. Write at the level of structure and intent, not implementation detail. Length target: 500–1,500 words for most projects. Optionally include a high-level system diagram (C4 Container level) using Mermaid or PlantUML if the system has 3+ major components.

Follow these documentation principles:
- Name modules by their searchable identifiers rather than linking — links rot, symbol search does not
- State architectural invariants as hard rules, not preferences: "The core module MUST NOT import from the infrastructure layer"
- Use concrete, specific language: "requests handled by the auth middleware in `src/middleware/auth.ts`" not "authentication is handled centrally"

#### ADRs

Write one ADR per significant structural decision made in Steps 3–4. Use the MADR minimal template at `references/adr-template.md`. A decision is significant if:
- It affects the system's structural boundaries or data ownership
- It involves a hard-to-reverse technology choice
- It has meaningful trade-offs someone will question in six months
- It directly addresses a primary architectural driver

ADR naming: `docs/decisions/NNNN-brief-title-with-hyphens.md` (e.g., `0001-use-modular-monolith.md`)

For simple projects: if no decision meets the "significant" bar, skip ADRs. One clear reference in ARCHITECTURE.md is sufficient.

**Output:** `ARCHITECTURE.md` in project root, ADRs in `docs/decisions/` (if applicable).

### Step 7: Validate Before Handing Off

**What you're doing:** Running a structured self-review before presenting the architecture. Every failing item must be corrected before output.

**Driver traceability check:**
- [ ] Every structural pattern selection in Step 3 traces to a named driver
- [ ] Every technology choice in Step 4 is justified against a driver or explicit project constraint
- [ ] No component or pattern exists without a stated purpose

**Completeness check:**
- [ ] ARCHITECTURE.md contains all required sections: overview, codemap, cross-cutting concerns, invariants, key decisions, dependencies, and open questions (if any remain unresolved)
- [ ] Codemap identifies where each major capability lives in the codebase
- [ ] Every primary driver is addressed somewhere in the architecture
- [ ] Non-functional requirements checklist from Step 5 is complete

**Simplicity check:**
- [ ] Each complexity addition (event-driven, distributed component, specialised data store) is justified by a named driver
- [ ] No pattern is more complex than the simplest option that satisfies the drivers
- [ ] Conway's Law implication is stated and is consistent with team constraints

**Uncertainty check:**
- [ ] Any assumption the architecture depends on is explicitly flagged
- [ ] Any decision the architect cannot resolve from the PRD is logged as an open question for human resolution

If any item fails, fix it. Do not present architecture with known gaps or unjustified complexity.

**Output:** Validated ARCHITECTURE.md, ADRs, and a brief handoff statement confirming what was decided and what remains open.

## Reference Templates

- `references/architecture-template.md` — codemap-centric architecture document template
- `references/adr-template.md` — MADR minimal ADR template

## Edge Cases

**PRD has no explicit quality attributes:**
If the PRD contains no scaling, performance, or security requirements, the default drivers are: (1) maintainability for the identified team size, and (2) delivery speed. Apply simplicity defaults across all five dimensions. Do not invent quality attribute requirements that are not stated or clearly implied.

**User or PRD specifies a technology before architecture is defined:**
Record the technology preference in the constraints. Still follow Steps 1–3 to determine the structural pattern. If the specified technology conflicts with an architectural driver, surface the conflict explicitly and flag for human decision before proceeding.

**Greenfield vs brownfield:**
For brownfield (extending an existing system), Step 3 is constrained by the existing architectural patterns. Map what exists first. Identify whether the extension fits the existing patterns or whether a new bounded context is warranted. Do not redesign the existing system unless the PRD explicitly requires it.

**Single-developer project:**
Apply the simplicity defaults forcefully: monolith, layered architecture, PostgreSQL, static hosting. The overhead of complex patterns is itself an architectural problem for a one-person team. Document simplicity as the driver.

**Architecture has irreconcilable conflicts:**
Some driver combinations genuinely conflict (maximum performance + minimum cost, strong consistency + horizontal scale). When conflicts are genuine, present both options with their trade-offs explicitly, state which driver takes precedence, and flag for human decision. Do not silently choose and obscure the trade-off.

## Evaluation Scenarios

### Scenario 1: Simple Personal Project

**Context:** PRD for a personal habit tracking web app. Single user (the developer). No scaling or compliance requirements stated. Developer is solo.

**Expected outcome:**
- Step 2: Complexity = Simple. No ADRs required unless a decision is genuinely non-obvious.
- Step 3: Static hosting or simple container; monolith; layered internal structure (low complexity, short lifespan); request-response only; SQLite or PostgreSQL; SSG or SPA (no SEO needed for personal tool). All simplicity defaults applied.
- Step 5: NFR checklist brief — security = single-user auth; observability = basic logging; backup = database export periodically.
- Step 6: ARCHITECTURE.md is focused, 300–500 words, codemap covers 3–4 directories. No ADRs.
- Step 7: All driver traces resolve to "maintainability" and "delivery speed." No unjustified complexity.

### Scenario 2: Multi-Service Production SaaS

**Context:** PRD for a B2B SaaS platform with two user types (account admins and end users), third-party payment integration, email delivery, and a stated requirement for 99.9% uptime and SOC 2 compliance.

**Expected outcome:**
- Step 2: Complexity = Complex. Drivers: (1) SOC 2 compliance — forces audit logging, access control model, data residency consideration; (2) 99.9% uptime — forces redundancy and failure recovery patterns; (3) two user types with separate permission models — forces authorisation architecture decision.
- Step 3: Containers (predictable load, long-running processes); modular monolith initially (team size likely 5–15 for SaaS MVP, domain not yet proven); hexagonal internal structure (multiple external integrations: payments, email, auth — must be swappable, testability required); request-response primary with event-driven for email/payment webhooks; PostgreSQL; SSR for marketing pages, SPA for dashboard.
- Step 4: Technology selected with weighted matrix. Authentication → managed service (Auth0 or Clerk) per build/buy framework. Payments → Stripe. Email → SendGrid.
- Step 5: NFR checklist complete — SOC 2 drives audit logging, data encryption, access review. Uptime requirement drives health checks, graceful degradation, backup strategy.
- Step 6: Full ARCHITECTURE.md + ADRs for: (1) modular monolith choice, (2) authentication approach, (3) event handling for webhooks. ARCHITECTURE.md includes invariants (infrastructure MUST NOT leak into core), canonical repository pattern, explicit prohibition on direct DB access.
- Step 7: Every ADR traces to a named driver. Conway's Law: architecture requires a single team owning the full system — consistent with expected team size.

### Scenario 3: Brownfield Extension

**Context:** PRD to add a mobile API to an existing Django monolith that powers a retail inventory management system. Existing database is PostgreSQL. No stated scaling requirements beyond current load.

**Expected outcome:**
- Step 1: Constraints include the existing Django monolith and PostgreSQL. Technology mandate: must integrate with existing system.
- Step 2: Complexity = Moderate. Primary driver: integration with existing data model without disrupting existing system. Secondary driver: API must support mobile client.
- Step 3: Deployment follows existing (containers). Structure: extend the existing monolith with a new API module — do not introduce microservices without a driver. Internal structure: follow existing Django conventions (layered) — do not redesign for hexagonal without a driver. Communication: request-response for mobile API; no event-driven required. Data: existing PostgreSQL; no new data store justified. Frontend: mobile client is out of scope for this architecture.
- Step 5: NFR checklist: mobile API adds authentication consideration (token-based vs session — state the choice). Rate limiting for mobile clients.
- Step 6: ARCHITECTURE.md focuses on the new API module's position in the existing codemap, its contracts with existing modules, and the authentication approach. One ADR: API authentication strategy (token-based vs session vs OAuth).
- Step 7: No new structural patterns introduced beyond what drivers require. Brownfield constraint honoured throughout.

## Success Indicators

This skill succeeds when:
- A downstream agent can begin task decomposition from ARCHITECTURE.md alone, without asking for clarification on how to build it
- Every structural decision in ARCHITECTURE.md traces to a named driver from the PRD — no pattern selected without driver justification (prevents context-free pattern selection)
- Complexity level matched to drivers, not anticipated future scale — simple projects receive a focused ARCHITECTURE.md, complex projects receive full documentation with ADRs (prevents over-engineering for imagined scale)
- The non-functional requirements checklist is complete and every item is addressed (prevents missing non-functional requirements)
- Trade-offs are stated explicitly for every significant choice, not silently assumed (prevents shallow trade-off reasoning)
- No unjustified complexity appears in the proposed architecture
