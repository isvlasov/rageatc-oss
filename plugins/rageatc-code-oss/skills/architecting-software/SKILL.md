---
name: architecting-software
description: Designs software architecture from a confirmed PRD. Use when a PRD exists and architecture must be designed before implementation, when writing ADRs, choosing an architecture style, or selecting technology and databases.
---

# Architecting Software

Translates a confirmed PRD ("what to build") into system structure ("how to build it") — systematically, driver-first, without the documented failure modes of AI-generated architecture.

**Position:** managing-product (PRD.md) → architecting-software (ARCHITECTURE.md + ADRs) → decomposing-work (ROADMAP.md).

**Inputs:** a confirmed PRD.md; team size and composition (if absent and not inferable, flag for human input before Step 3 — it is an architectural driver); technology constraints from the PRD; existing systems to integrate with, or "greenfield".

**Outputs:** `ARCHITECTURE.md` in the project root (codemap-centric structure per `references/architecture-template.md`); when complexity warrants, one ADR per significant decision in `docs/decisions/NNNN-title.md` (MADR minimal format per `references/adr-template.md`).

**Not covered:** requirements gathering (managing-product), task decomposition (downstream), code generation, CI/CD design, detailed API specification.

## Scale-Adaptive Depth

Same process at every tier; only output depth differs. Calibrate to the project — do not produce a 200-line architecture document for a 3-file bug fix. When in doubt, start light and add detail only where it prevents downstream ambiguity.

| Tier | ARCHITECTURE.md depth | ADRs |
|------|----------------------|------|
| **Quick** | 10-20 lines. Overview + key decisions only. Skip codemap if the project is navigable directly. | None |
| **Standard** | Codemap + key decisions. Component boundaries and primary patterns. | Only for genuinely significant decisions |
| **Thorough** | Full template — overview, codemap, cross-cutting concerns, invariants, key decisions, dependencies, open questions | One per significant decision |

## Workflow

### Step 1: Extract Requirements into Three Buckets

Sort every PRD requirement — select no patterns yet:

- **Functional** — what the system must do. Drives component responsibilities; rarely determines structure alone.
- **Quality attributes** — how well it must perform. Look in success criteria, constraints, acceptance criteria, performance/security statements. Translate vague statements: "fast" → "P95 under X ms for the [action] workflow"; "secure" → what is protected, from whom, under what threat model; "scales" → what load, over what timeframe.
- **Constraints** — budget, timeline, team skills, technology mandates, regulatory requirements, existing systems.

Log ambiguous requirements as open questions for human resolution before proceeding.

### Step 2: Identify and Rank Architectural Drivers

Find the 3–7 requirements that force structural decisions: anything that affects many components, creates irreconcilable conflict with another requirement, cannot be met with standard patterns without deliberate choice, or carries significant business risk if unmet.

**Scale calibration first:**

| Signal | Simple | Moderate | Complex |
|---|---|---|---|
| User types | 1 | 2 | 3+ |
| External integrations | 0–1 | 2–3 | 4+ |
| Explicit quality attribute requirements | None | 1–2 | 3+ |
| Team size | 1–5 | 6–20 | 20+ |
| Compliance requirements | None | Light | Regulated |

Simple → focused ARCHITECTURE.md, ADRs only for genuinely non-obvious decisions. Moderate → ADRs for meaningful trade-offs. Complex → full documentation, ADR per significant decision.

**Rank drivers** by business impact if unmet and difficulty of satisfying given other constraints; primary drivers are high on both. Document the ranked list with brief justification before Step 3.

### Step 3: Make Structural Decisions in Constraint Order

Select a pattern for each of five dimensions, in sequence — each decision constrains the next. Every selection must trace to a named driver; if no driver justifies the more complex option, the simpler default wins.

#### 3a. Deployment Model

| Signal | Serverless | Containers/VMs |
|---|---|---|
| Traffic pattern | Variable, spiky | Predictable, sustained |
| Request duration | Short (under 15 min) | Any, including long-running |
| Cold start tolerance | Acceptable | Low latency required always |
| Ops maturity | Low — managed infra preferred | Medium–high |
| Cost model preference | Pay-per-request (cheap at low scale) | Provisioned compute (cheap at high scale) |
| Vendor lock-in tolerance | High | Low |

**Default:** containers for sustained workloads; serverless for event-driven background jobs. Most production systems blend both.

#### 3b. Deployment Topology

| Signal | Monolith | Modular Monolith | Microservices |
|---|---|---|---|
| Team size | 1–5 | 5–50 | 50+ |
| Domain clarity | Unknown or emerging | Moderately understood | Well-understood, stable bounded contexts |
| Scaling requirements | Uniform, modest | Mostly uniform | Highly variable per domain |
| Operational maturity | Low | Medium | High — mature CI/CD, observability |
| Data isolation requirement | Low | Medium | High — compliance or ownership |

**Default: modular monolith.** Move to microservices only on organisational signals: deployment coordination is a bottleneck, teams step on each other's code, or domains have dramatically differing scaling needs. Microservices are an organisational scaling pattern first — never speculative.

**Conway's Law check:** state what team structure this architecture requires; if it conflicts with known team constraints, revise the structure.

#### 3c. Internal Code Organisation

Structure inside a service or monolith — independent of deployment topology.

| Signal | Layered | Hexagonal | Clean |
|---|---|---|---|
| Project complexity | Simple–medium | Medium–complex | Complex |
| Team experience | Beginner–intermediate | Intermediate–advanced | Advanced |
| Expected lifespan | Short (MVP, prototype) | Medium–long | Long |
| Testing requirements | Light | High testability required | Maximum testability |
| External dependencies | Few, stable | Many or likely to change | Many, business logic must be isolated |
| Business logic complexity | Simple CRUD | Moderate domain logic | Rich domain model |

**Default: layered for MVPs and simple projects; hexagonal when external dependencies are many or changeable and testability matters.** Clean is hexagonal with more explicit layer naming — treat as interchangeable unless the extra structure is needed. Caution: layered degrades into a big ball of mud as complexity grows because layers are not enforced — for significant lifespan or domain complexity, choose hexagonal.

**Dependency direction rule:** state which way dependencies flow and encode it as an invariant. Hexagonal/clean: infrastructure depends on core, never the reverse. Layered: presentation → application → domain → infrastructure.

#### 3d. Communication Pattern

| Need | Request-Response | Event-Driven |
|---|---|---|
| User needs immediate result | Yes | No |
| Strong consistency required | Yes | No (needs saga/outbox pattern) |
| Background or async workflows | No | Yes |
| High fan-out (one event, many consumers) | No | Yes |
| Simple CRUD | Yes | Overkill |

**Default:** request-response. Add event-driven only for specific async workflows — it adds observability and debugging complexity.

#### 3e. Data Strategy

| Signal | Relational (SQL) | Document (NoSQL) |
|---|---|---|
| Schema | Well-defined, stable | Variable, evolving |
| Relationships | Complex — many joins | Few — denormalised |
| Consistency requirement | Strong (ACID) | Eventual acceptable |
| Query patterns | Complex, ad-hoc | Known access patterns, high write throughput |
| Domain examples | Finance, inventory, user accounts | Content, catalogues, real-time apps |

**Default: PostgreSQL.** It handles most applications at significant scale, supports JSON columns, and its ACID guarantees prevent whole categories of bugs. Add specialised stores only against a specific, measurable problem: Redis for caching/sessions, Elasticsearch for full-text search, time-series DB for high-volume telemetry.

#### 3f. Frontend Approach

| Signal | SPA | SSR | SSG | MPA |
|---|---|---|---|---|
| SEO required | No | Yes | Yes | Yes |
| Interactivity | High | Medium–high | Low | Low |
| Content update frequency | Any | Real-time or per-user | Infrequent (rebuild on change) | Any |
| Infrastructure complexity | Low — static hosting | Medium — Node server | Low — static hosting | Medium |
| Domain examples | Admin dashboards, internal tools | E-commerce, SaaS, social | Blogs, docs, marketing | Enterprise portals |

**Default: SSG for mostly-static content; SSR for SEO + interactivity + personalisation; SPA for internal tools and authenticated apps with no SEO requirement.**

### Step 4: Select Technology

Patterns first, technology second. For Simple projects, apply the simplicity defaults directly — a formal matrix is only warranted when multiple viable options carry meaningful trade-offs. For any non-obvious choice, use a weighted decision matrix:

1. **Define criteria:** technical fit, performance, ecosystem maturity, team familiarity, total cost of ownership, vendor risk, integration compatibility
2. **Weight criteria** (1–5) by project context — a solo developer weights familiarity heavily; a regulated enterprise weights vendor stability and TCO
3. **Score 2–4 candidates** against each criterion (1–5)
4. **Apply veto conditions** — failing a hard requirement (compliance certification, critical vulnerability, licence) eliminates regardless of score
5. **Validate** the top choice with a proof of concept at the highest-uncertainty integration point

**Anti-patterns:** cargo culting (Netflix's choices assume Netflix's scale and team); recency bias (new tech, immature ecosystem); CV-driven selection; premature optimisation (start with PostgreSQL, add Redis when a cache-miss problem exists; start with a container, add Kubernetes when coordination complexity requires it).

**Build vs buy:** for commodity capabilities (authentication, payments, email delivery, search), prefer a managed service or open-source solution. Build only when the capability is a direct competitive differentiator or no adequate solution exists.

### Step 5: Verify Non-Functional Coverage

Walk the checklist AI-generated architectures consistently miss and state how the architecture handles each. If a PRD requirement or driver maps to an item, the architecture must address it; if an item has no driver, record a one-line statement of why it is out of scope or deferred.

- [ ] **Security:** authentication and authorisation model defined — what is protected and how?
- [ ] **Observability:** logging, metrics, tracing — how will you know the system is healthy?
- [ ] **Failure recovery:** retry strategy, circuit breakers, graceful degradation?
- [ ] **Data backup and recovery:** frequency, retention, recovery time objective?
- [ ] **Audit logging:** are business-critical operations logged for compliance and debugging?
- [ ] **Performance budget:** response time expectations for critical user paths?
- [ ] **Data privacy:** is PII handled, and what controls apply?
- [ ] **Scalability:** do the chosen deployment and topology cover stated load expectations?

### Step 6: Produce Documentation

**ARCHITECTURE.md** — use `references/architecture-template.md`. The codemap is the most important section; start there. Write at the level of structure and intent, not implementation detail; 500–1,500 words for most projects. Optionally add a C4 Container diagram (Mermaid/PlantUML) for systems with 3+ major components. Principles:

- Name modules by searchable identifiers rather than linking — links rot, symbol search does not
- State invariants as hard rules: "The core module MUST NOT import from the infrastructure layer"
- Concrete language: "requests handled by the auth middleware in `src/middleware/auth.ts`", not "authentication is handled centrally"

**ADRs** — one per significant decision, `docs/decisions/NNNN-brief-title.md` (e.g., `0001-use-modular-monolith.md`), MADR minimal template. Significant = affects structural boundaries or data ownership, hard-to-reverse technology choice, trade-offs someone will question in six months, or directly addresses a primary driver. If nothing meets the bar, skip ADRs — a clear note in ARCHITECTURE.md suffices.

### Step 7: Validate Before Handing Off

Fix every failing item before presenting — never present architecture with known gaps or unjustified complexity.

- [ ] **Traceability:** every pattern and technology choice traces to a named driver or constraint; no component exists without a stated purpose
- [ ] **Completeness:** all template sections present; codemap locates each major capability; every primary driver addressed; Step 5 checklist complete
- [ ] **Simplicity:** each complexity addition justified by a named driver; nothing more complex than the simplest option that satisfies the drivers; Conway's Law implication stated and consistent with team constraints
- [ ] **Uncertainty:** assumptions flagged; unresolvable decisions logged as open questions for human resolution

**Output:** validated ARCHITECTURE.md, ADRs, and a brief handoff statement of what was decided and what remains open.

## Edge Cases

**No explicit quality attributes in the PRD:** default drivers are maintainability for the team size and delivery speed. Apply simplicity defaults across all dimensions. Do not invent quality attributes that are not stated or clearly implied.

**Technology specified before architecture:** record it as a constraint; still run Steps 1–3 for structure. If the mandated technology conflicts with a driver, surface the conflict and flag for human decision.

**Brownfield:** map the existing patterns first; Step 3 is constrained by them. Determine whether the extension fits existing patterns or warrants a new bounded context. Do not redesign the existing system unless the PRD requires it.

**Single-developer project:** apply simplicity defaults forcefully — monolith, layered, PostgreSQL, static hosting. Complex-pattern overhead is itself an architectural problem for one person; document simplicity as the driver.

**Irreconcilable driver conflicts** (maximum performance + minimum cost, strong consistency + horizontal scale): present both options with trade-offs, state which driver takes precedence, and flag for human decision. Never silently choose and obscure the trade-off.

## Reference Templates

- `references/architecture-template.md` — codemap-centric architecture document template
- `references/adr-template.md` — MADR minimal ADR template
