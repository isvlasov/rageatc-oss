# Architecture: [Project Name]

**Date:** YYYY-MM-DD
**Status:** Draft | Current
**Version:** 1.0

---

## Overview

[2–4 sentences. What problem does this system solve? What is its architectural style (monolith, modular monolith, event-driven, etc.)? Who are the primary users?]

[Example: This is a modular monolith serving two user types — account administrators and end users — for B2B inventory management. The system is deployed as a containerised Django application backed by PostgreSQL, with event-driven email delivery via a background worker. Authentication is handled by an integrated auth service (Clerk).]

---

## Code Map

[The most important section. For each top-level directory or module, state what it does — not how it works. Answer: "where is the thing that does X?" and "what does the thing I'm looking at do?"]

[Name modules by their searchable identifiers rather than linking to file paths — paths change, symbol names are searchable.]

[The directory structure below is illustrative only — it shows a hexagonal/clean architecture pattern with TypeScript entry points. Replace it with the structure chosen in Steps 3c and 3f of the architecting-software skill. A layered Python Django project, a flat Go service, or a Next.js monorepo will look different.]

```
project-root/
├── src/
│   ├── api/          # HTTP route handlers and request validation. Entry point for all HTTP traffic.
│   ├── core/         # Business logic and domain models. MUST NOT import from infrastructure/.
│   ├── infrastructure/  # Database access, external service clients, file storage adapters.
│   ├── workers/      # Background job processors. Consumes events from the task queue.
│   └── config/       # Application configuration, environment variable loading.
├── tests/
│   ├── unit/         # Tests for core/ business logic. No database or HTTP required.
│   └── integration/  # Tests for API endpoints and external service integrations.
└── docs/
    └── decisions/    # Architecture Decision Records.
```

**Entry points:**
- HTTP API: `src/api/server.ts` — starts the HTTP server and mounts route handlers
- Background workers: `src/workers/index.ts` — starts the task queue consumers

**Key types and modules:**
- [Name the most important types, classes, or modules that appear throughout the codebase]

---

## Cross-Cutting Concerns

[Patterns that appear throughout the codebase. State them as rules, not preferences.]

**Error handling:** [How errors propagate and are surfaced. Example: "All service-layer errors are typed using the Result pattern. Route handlers translate errors to HTTP status codes — business logic never returns HTTP status codes directly."]

**Authentication:** [How requests are authenticated. Example: "All authenticated routes use the `requireAuth` middleware in `src/middleware/auth.ts`. JWT tokens are validated against the Clerk JWKS endpoint."]

**Logging:** [What is logged and at what level. Example: "Structured JSON logging via `pino`. INFO for business events, DEBUG for diagnostics. All log statements include a `traceId` for request correlation."]

**Data access:** [How the application reads and writes data. Example: "All database access goes through repository classes in `src/infrastructure/repositories/`. Route handlers and business logic MUST NOT query the database directly."]

**Validation:** [Where and how input is validated. Example: "All API inputs are validated at the route handler layer using Zod schemas. Validated data is passed to service functions as typed objects."]

---

## Architectural Invariants

[Rules that must never be violated. State as hard requirements, not guidelines.]

- The `core/` module MUST NOT import from `infrastructure/`. Dependency direction is inward: infrastructure depends on core, never the reverse.
- All external service calls (database, email, payments, storage) MUST go through the adapter interfaces in `infrastructure/`. No direct SDK calls from business logic.
- [Add invariants specific to this system's boundaries and decisions]

---

## Key Design Decisions

[Brief references to the most important choices. Full rationale is in the ADRs.]

| Decision | Outcome | Rationale summary | ADR |
|---|---|---|---|
| Internal structure | Modular monolith | Team of 8, domain not yet proven; avoids distributed systems overhead | ADR-0001 |
| Authentication | Clerk (managed service) | SOC 2 requirement makes rolling your own auth inadvisable; Clerk covers audit logging | ADR-0002 |
| [Decision] | [What was chosen] | [One-line reason] | ADR-NNNN |

---

## Important Dependencies

[External systems and services. State what they do, why they exist, and where in the codebase to find integration code.]

| Dependency | Purpose | Integration location |
|---|---|---|
| PostgreSQL | Primary data store — transactional data, user records, inventory | `src/infrastructure/db/` |
| Clerk | Authentication and user management | `src/infrastructure/auth/clerk-adapter.ts` |
| Stripe | Payment processing — subscription billing | `src/infrastructure/payments/stripe-adapter.ts` |
| [Dependency] | [What it does] | [Where to find integration code] |

---

## Open Questions

[Decisions not yet made or assumptions that need validation. Remove this section when the architecture is finalised.]

- [Question] — Owner: [who] — needs answer before [phase]
