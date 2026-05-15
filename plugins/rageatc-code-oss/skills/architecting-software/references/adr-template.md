# ADR-[NNNN]: [Short title describing the decision, e.g., "Use modular monolith for initial structure"]

**Status:** Proposed | Accepted | Rejected | Deprecated | Superseded by ADR-[NNNN]
**Date:** YYYY-MM-DD

---

## Context and Problem Statement

[One paragraph. What situation led to this decision? What problem were you trying to solve? Include the architectural driver(s) from the PRD that made this decision necessary.]

[Example: The PRD requires SOC 2 Type II compliance, which mandates audit logging for all data access events and user permission changes. The team of 8 needs to build authentication without specialist security expertise. We needed to choose between implementing authentication in-house versus using a managed authentication service.]

---

## Decision Drivers

- [Driver 1 — name the PRD driver or constraint this decision responds to]
- [Driver 2]
- [Add as many as apply. Every driver should trace to the PRD.]

---

## Considered Options

- [Option A — name it concisely]
- [Option B]
- [Option C if applicable]

---

## Decision Outcome

Chosen option: **[Option A]**, because [one-sentence justification connecting the choice to the decision drivers].

### Positive Consequences

- [Outcome 1 — what becomes easier as a result of this decision]
- [Outcome 2]

### Negative Consequences

- [Outcome 1 — what becomes harder, more expensive, or creates constraints]
- [Outcome 2]

---

## Pros and Cons of the Options

[Include this section for complex decisions with 3+ options or when the trade-offs need detailed documentation. Omit for straightforward choices where the Decision Outcome section captures the reasoning adequately.]

### [Option A]

- Good, because [reason tied to a driver]
- Good, because [reason]
- Bad, because [trade-off or limitation]

### [Option B]

- Good, because [reason]
- Bad, because [reason tied to why it was not chosen]
- Bad, because [reason]

### [Option C, if applicable]

- Good, because [reason]
- Bad, because [reason]
