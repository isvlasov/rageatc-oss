---
name: reviewing-code
description: Reviews code. Use when reviewing code implementations, assessing code quality, running a security review, checking spec or design system compliance, or conducting an end-of-build whole-project review against PRD success criteria.
---

# Reviewing Code

## Purpose

Structured methodology for reviewing code implementations. Produces consistent, severity-based, actionable feedback that a developer can act on without ambiguity.

The orchestrator selects which **perspective references** to load for each review based on the workflow tier and chunk characteristics. The core process, finding format, and decision criteria remain the same regardless of which perspectives are active.

## Scope and Constraints

This skill defines the **review process** — how to conduct a review, format findings, and make decisions. The **what to look for** lives in perspective reference files that the orchestrator loads selectively.

**This skill does NOT cover:**
- Non-code artefacts (use assessing-quality from rageatc-core-oss)
- Architecture design review (that's the critic's job during architecture approval)

## Perspective Model

Perspectives are reference files under `references/` that define what to examine during review. The orchestrator tells the reviewer-agent which perspectives to load.

**Available perspectives:**

| Reference | Focus | Typical use |
|-----------|-------|-------------|
| `references/spec-compliance.md` | Does code match the brief and acceptance criteria? | All tiers — always loaded |
| `references/code-quality.md` | Correctness, simplicity, readability, test quality | Standard + Thorough |
| `references/security.md` | Input validation, injection, auth, data exposure | Thorough, or when chunk handles user input |
| `references/whole-project.md` | Full codebase against PRD success criteria | End of Standard/Thorough build only |
| `references/design-compliance.md` | UI matches system.md tokens, depth, patterns | Standard + Thorough, when project has system.md and chunk touches UI |

**Tier defaults:**

| Tier | Perspectives loaded |
|------|--------------------|
| Quick | spec-compliance (covers correctness against brief) |
| Standard | spec-compliance → code-quality → design-compliance (if system.md exists and chunk touches UI) |
| Thorough | spec-compliance → code-quality → design-compliance (if system.md exists and chunk touches UI) → security (as needed) |
| End-of-build | whole-project (standalone, against PRD not brief) |

The orchestrator may override defaults based on chunk characteristics (e.g., load security for a Quick auth fix).

## Inputs Required

- **Enriched roadmap chunk** — acceptance criteria, file set, chunk purpose (the enriched roadmap IS the brief in rageatc-code v2)
- **ARCHITECTURE.md** — patterns, conventions, component boundaries
- **Codebase access** — the code to review
- **Changed files list** — what the developer created or modified
- **Test results** — or ability to run the test suite
- **Perspective references** — loaded by orchestrator (see Perspective Model above)
- For re-reviews: **previous review** and the developer's changes

## Output

A structured review document:

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

### Step 1: Understand intent before reading code

Read the development brief or enriched roadmap chunk completely. Internalise:
- The acceptance criteria (your primary checklist)
- Which files were supposed to change
- What this chunk contributes to the broader system

Do not open code files until you understand what was supposed to be built.

### Step 2: Run tests

Run the test suite. Record which tests pass and fail. This is factual input — do not form conclusions yet.

### Step 3: Review against loaded perspectives

Examine the code through each perspective the orchestrator loaded. Work through them in order: spec-compliance first (always), then others.

Not every concern in a perspective applies to every chunk — use judgement. Spend time proportional to risk.

**Trap: reviewing beyond scope.** Review this chunk, not the entire codebase. Broader issues go in observations, separate from findings.

**Trap: style preferences over standards.** Review against the project's patterns (ARCHITECTURE.md), not personal preferences.

### Step 4: Structure findings

For each issue, write a finding using the Finding Format below. Assign honest severity.

**Trap: nitpicking on accept.** If heading towards acceptance, limit minor findings to the 3-5 most valuable.

### Step 5: Step back

Does this code, as a whole, solve the problem the brief describes? A review that catches every style issue but misses that the core logic is wrong has failed.

### Step 6: Decide

Apply the decision criteria. State your decision clearly with rationale.

## Re-review Protocol

When reviewing a second or subsequent iteration:

1. Read your previous review first
2. Verify each previously raised finding is addressed
3. Do not re-raise findings that were adequately resolved
4. Check that fixes have not introduced new issues
5. Carry forward unresolved minor findings only if they remain relevant
6. Apply the same decision criteria — a re-review is not a lower bar

## Finding Format

```
**[SEVERITY]** file:line (or component)

_Finding:_ What the issue is.

_Impact:_ Why it matters.

_Suggestion:_ How to fix it.
```

### Severity Levels

| Level | Meaning | Examples |
|-------|---------|----------|
| **Critical** | Blocks acceptance. Must fix. | Acceptance criterion not met, security vulnerability, data loss risk, tests broken |
| **Major** | Degrades quality significantly. Should fix. | Unhandled error causing user-facing failure, missing test for core logic, architectural pattern violation |
| **Minor** | Improves quality. Desirable but does not block. | Naming could be clearer, minor duplication, missing edge case test for non-critical path |
| **Note** | Observation only. No action required. | Worth knowing for future work, pattern that could become a problem at scale |

**Severity honesty:** Do not inflate. A naming improvement is not critical. Inflation erodes trust and wastes developer cycles.

## Decision Criteria

### Accept

All of:
- Zero critical findings
- Zero major findings
- All acceptance criteria from the brief are satisfied
- Tests pass

Minor findings and notes are included but do not block acceptance.

### Revise

Any of:
- One or more critical findings
- One or more major findings
- An acceptance criterion is not satisfied
- Tests fail (unless explained by an intentional, brief-sanctioned change)

The review must list the specific issues requiring revision.

## Evaluation Scenarios

### Scenario 1: Quick tier — spec-compliance only

Developer implements a bug fix. Orchestrator loads spec-compliance perspective only. Code satisfies acceptance criteria, tests pass.

**Expected:** Accept. Review is short — only spec-compliance checked. No code-quality or security commentary.

### Scenario 2: Standard tier — spec-compliance + code-quality

Developer implements a feature chunk. Code works but uses an abstract factory pattern for a simple validator. Tests pass, acceptance criteria met.

**Expected:** Revise with one major finding from code-quality perspective. Example finding:

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

Spec-compliance perspective passes (acceptance criteria are met).

### Scenario 3: Thorough tier with security concern

Developer implements a search endpoint. Input passed directly to database query without sanitisation. All acceptance criteria met. Tests pass.

**Expected:** Revise with one critical finding from security perspective (injection vulnerability). Even though spec-compliance passes, security vulnerabilities are always critical.

### Scenario 4: End-of-build whole-project review

All chunks complete. Orchestrator loads whole-project perspective against PRD.

**Expected:** Review assesses the entire codebase against PRD success criteria, not individual chunks. Findings reference PRD requirements, not chunk briefs.
