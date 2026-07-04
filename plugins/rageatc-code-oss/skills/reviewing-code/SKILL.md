---
name: reviewing-code
description: Reviews code. Use when reviewing code implementations, assessing code quality, running a security review, checking spec or design system compliance, or conducting an end-of-build whole-project review against PRD success criteria.
---

# Reviewing Code

Structured review methodology producing consistent, severity-based, actionable feedback. This skill defines the **review process** — how to conduct a review, format findings, and decide; the **what to look for** lives in perspective reference files the orchestrator loads selectively. Non-code artefacts use assessing-quality (rageatc-core-oss); architecture design review is the critic's job at architecture approval.

## Perspective Model

Perspectives are reference files under `references/` defining what to examine. The orchestrator tells the reviewer-agent which to load.

| Reference | Focus | Typical use |
|-----------|-------|-------------|
| `references/spec-compliance.md` | Does code match the brief and acceptance criteria? | All tiers — always loaded |
| `references/code-quality.md` | Correctness, simplicity, readability, test quality | Standard + Thorough |
| `references/security.md` | Input validation, injection, auth, data exposure | Thorough, or when chunk handles user input |
| `references/whole-project.md` | Full codebase against PRD success criteria | End of Standard/Thorough build only |
| `references/design-compliance.md` | UI matches system.md tokens, depth, patterns | Standard + Thorough, when project has system.md and chunk touches UI |

**Tier defaults** (orchestrator may override — e.g., security for a Quick auth fix):

| Tier | Perspectives loaded |
|------|--------------------|
| Quick | spec-compliance |
| Standard | spec-compliance → code-quality → design-compliance (if system.md exists and chunk touches UI) |
| Thorough | spec-compliance → code-quality → design-compliance (if applicable) → security (as needed) |
| End-of-build | whole-project (standalone, against PRD not brief) |

## Inputs Required

- **Enriched roadmap chunk** — acceptance criteria, file set, purpose (the enriched roadmap IS the brief)
- **ARCHITECTURE.md** — patterns, conventions, component boundaries
- **Codebase access** and **changed files list**
- **Test results** — or the ability to run the suite
- **Perspective references** — loaded by orchestrator
- For re-reviews: **previous review** and the developer's changes

## Output

```
# Code Review: [chunk name/ID]

**Brief:** [reference to development brief or roadmap chunk]
**Perspectives:** [which perspectives were applied]
**Decision:** Accept / Revise
**Findings:** [count by severity]

## Findings

[Findings grouped by severity: critical first, then major, minor, notes]

## What Works Well

[Brief acknowledgement of what meets standards]

## Decision

[Accept or Revise with rationale]

## Observations

[Anything relevant to the broader project but outside this chunk's scope]
```

## Review Process

1. **Understand intent before reading code.** Read the enriched roadmap chunk completely: acceptance criteria (your primary checklist), which files were supposed to change, what the chunk contributes to the system. Do not open code files first.
2. **Run tests.** Record pass/fail as factual input — no conclusions yet.
3. **Review against loaded perspectives**, spec-compliance first. Not every concern applies to every chunk — spend time proportional to risk. Traps: reviewing beyond scope (review this chunk; broader issues go in Observations) and style preferences over standards (review against ARCHITECTURE.md patterns, not taste).
4. **Structure findings** per the Finding Format, with honest severity. Trap: nitpicking on accept — if heading towards acceptance, limit minor findings to the 3-5 most valuable.
5. **Step back.** Does this code, as a whole, solve the problem the brief describes? A review that catches every style issue but misses that the core logic is wrong has failed.
6. **Decide** per the criteria below, stating the rationale.

## Re-review Protocol

1. Read your previous review first
2. Verify each previously raised finding is addressed
3. Do not re-raise findings that were adequately resolved
4. Check that fixes have not introduced new issues
5. Carry forward unresolved minor findings only if still relevant
6. Apply the same decision criteria — a re-review is not a lower bar

## Finding Format

```
**[SEVERITY]** file:line (or component)

_Finding:_ What the issue is.

_Impact:_ Why it matters.

_Suggestion:_ How to fix it.
```

Example:

```
**[MAJOR]** src/validators/email-validator.ts:1-45

_Finding:_ Email validation uses an abstract factory pattern with three
interfaces and a plugin system. The actual validation is 4 lines of code
wrapped in 40 lines of abstraction.

_Impact:_ Maintenance burden disproportionate to the problem. Future
developers must understand the factory pattern to modify a simple check.
Violates simplicity principle.

_Suggestion:_ Replace with a direct validation function. If additional
validators are needed later, extract a pattern then — not before.
```

### Severity Levels

| Level | Meaning | Examples |
|-------|---------|----------|
| **Critical** | Blocks acceptance. Must fix. | Acceptance criterion not met, security vulnerability, data loss risk, tests broken |
| **Major** | Degrades quality significantly. Should fix. | Unhandled error causing user-facing failure, missing test for core logic, architectural pattern violation |
| **Minor** | Improves quality. Desirable but does not block. | Naming could be clearer, minor duplication, missing edge case test for non-critical path |
| **Note** | Observation only. No action required. | Worth knowing for future work, pattern that could become a problem at scale |

**Severity honesty:** do not inflate. A naming improvement is not critical; inflation erodes trust and wastes developer cycles. Security findings are never below Major — exploitable vulnerabilities are Critical — even when spec-compliance passes (calibration table in `references/security.md`).

## Decision Criteria

**Accept** — all of: zero critical findings, zero major findings, all acceptance criteria satisfied, tests pass. Minor findings and notes are included but do not block.

**Revise** — any of: a critical or major finding, an unsatisfied acceptance criterion, failing tests (unless explained by an intentional, brief-sanctioned change). List the specific issues requiring revision.
