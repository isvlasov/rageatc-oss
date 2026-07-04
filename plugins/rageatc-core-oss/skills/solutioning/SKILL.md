---
name: solutioning
description: Explores solution options when the problem is defined but the approach is unclear. Use when evaluating approaches, comparing alternatives, or choosing between options.
---

# Solutioning

Facilitate choosing an approach when the problem is defined but the direction isn't. Explore options with the user, filter through simplicity, and record the decision for handoff to `creating-briefs`.

Skip when only one viable option exists, the user has already committed to an approach, the choice is purely preferential, or the problem itself is still unclear (`understanding-the-ask` first).

## Workflow

### Step 1 — Classify the decision

Ask: "How expensive would this be to reverse? If we try it and it doesn't work, can we go back?"

- **Reversible (two-way door)** — file structure, naming, process experiments. Decide quickly at 70% confidence and course-correct as you learn. Watch for analysis paralysis.
- **Irreversible (one-way door)** — core architecture, database selection, major dependency. Invest in understanding trade-offs before committing. Watch for premature commitment.

The classification sets the evaluation depth for everything below.

### Step 2 — Establish the simplicity baseline

"What's the simplest thing that could possibly work? Do we need this now, or are we anticipating future needs?" The simplest viable option becomes the baseline every other option must beat.

- **YAGNI** — "we might need X later" → "do we need X now? If not, add it when we do."
- **KISS** — "option A is more capable but complex" → "does simpler option B solve the current problem? Then complexity needs justification."
- **Occam's Razor** — prefer the option making the fewest assumptions about the future.

### Step 3 — Generate options

The first option presented becomes the implicit default — challenge it deliberately: "We've discussed option A; what would option B look like?" "If we couldn't do that, what would we try instead?"

Stop at 2–4 meaningfully distinct options, or when the user confirms the main approaches are covered.

### Step 4 — Compare

- **Reversible:** relative comparison to the baseline — better (+), worse (−), or same (S) per criterion. "For implementation speed, is option B better, worse, or the same as the baseline? For maintainability?"
- **Irreversible:** explicit pros and cons per option, grounded in current needs, concrete impacts, and real constraints.

Traps:

- **Confirmation bias** — "what could prove this option wrong?"
- **Analysis paralysis** — "do we have enough for a 70% confident decision?"
- **Undefined words** — "scalable", "flexible", "robust": "10x users or 1000x? What specifically?"

### Step 5 — Decide and record

Commit when: (reversible) 70% confident and genuinely reversible; (irreversible) trade-offs understood, assumptions challenged, and the choice serves current needs rather than anticipated futures.

Record the decision — lightweight ADR, 1–2 plain-language paragraphs per section, saved to the work directory:

```markdown
# Decision: [Short Title]

**Date:** YYYY-MM-DD
**Status:** Committed

## Context

[2–3 sentences: what problem were we solving? Why did this decision matter?]

## Options Considered

1. **[Option]** — [one line]
2. **[Option]** — [one line]

## Decision

We chose [option] because [primary reason].

- We gain: [main benefits]
- We accept: [costs or limitations]
- We assume: [assumptions made]

## Consequences

- [What this enables]
- [What this constrains or rules out]
- [What we'll monitor or revisit]
```

### Step 6 — Hand off

Pass the decision record to `creating-briefs`: the chosen approach, accepted trade-offs and assumptions, and what needs to be created. Done well, the brief can be written without re-exploring alternatives.
