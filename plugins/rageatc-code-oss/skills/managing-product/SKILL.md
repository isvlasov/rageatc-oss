---
name: managing-product
description: Extracts product requirements and produces a PRD. Use when a user wants to build software and needs to define what to build before architecture or implementation, when scoping an MVP, or when translating a vague idea into a buildable specification.
---

# Managing Product

Defines *what to build* before any architecture or code: translates an understood idea into a structured, prioritised PRD that agents can execute against without ambiguity.

**Position:** understanding-the-ask (clarify problem) → solutioning (choose direction) → managing-product (define what to build) → architecting-software (design how).

**Inputs:** a clear problem statement, a chosen solution direction ("we will build software"), and the user's domain knowledge accessible through conversation.

**Output:** `PRD.md` with five essential elements — problem statement, target users, success criteria, scope (MoSCoW-prioritised plus explicit out-of-scope), and requirements as user stories with testable acceptance criteria.

**Not covered:** problem clarification or solution direction (upstream), technical architecture (architecting-software), chunk enrichment, roadmapping, sprint planning, rollout strategy.

## Workflow

### Step 1: Establish Starting Context

Check whether you already have a clear problem statement, an identified audience, and any stated constraints. If the user arrives with problem and audience clear (e.g. "I want to build a habit tracking app for myself"), confirm inline and proceed — upstream skills are not required. If either remains vague after confirmation, return to understanding-the-ask.

State what you understand so the user can correct it before extraction begins:

> "Before we define what to build, let me confirm: we're solving [problem] for [user type]. Does that match your intent?"

### Step 2: Extract Product Knowledge Through Structured Questioning

Pull out the five essential elements through focused, sequential questions — one at a time, never a form or a list of questions at once.

**A. Target users** (if not already clear):
- "Who specifically will use this? Can you describe a typical person — their situation, what they're trying to do?"
- "Is there more than one type of user with different needs, or mainly one audience?"

**B. Core problem and current alternative:**
- "What does this person do today when they have this problem? What's their workaround?"
- "What's the most important thing this software needs to do for them?"

**C. Success definition:**
- "How would you know this worked? What would be different for the user after using it?"
- Probe for measurability: "If someone used this for a month, what specific change would tell you it was successful?"

**D. Feature exploration:**
- "Walk me through what a user would do with this, step by step."
- "What would make it genuinely useful, even if it only had two or three features?"

**E. Boundaries:**
- "What are you deliberately not trying to do with this version?"
- "Are there things you could imagine adding later but don't need right now?"

**Redirect solution-focused input to outcomes.** "It needs a React frontend" → "What does the user need to be able to do? We can decide the technology once we know what it needs to accomplish." "It needs a database with relational tables" → "What information needs to be stored and retrieved? We'll leave the technical decisions to the architect."

**Pacing:** you are looking for the five essential elements, not an exhaustive feature list. A simple project needs one short conversation; a complex one (multiple user types, integrations) needs follow-ups per sub-area. Stop when you can draft a PRD — not when the user has exhausted every idea.

### Step 3: Challenge and Sharpen Acceptance Criteria

Before drafting, challenge any criterion that cannot be tested objectively:

| Vague statement | Clarifying question |
|---|---|
| "It should be easy to use" | "How would you test that? What would a new user be able to do within their first session?" |
| "It needs to be fast" | "Fast compared to what? Is there a specific action that needs to respond within a certain time?" |
| "It should be secure" | "What specifically needs to be protected? User data, transactions, access control?" |
| "It needs to scale" | "How many users are you planning for? Is scalability a day-one requirement or a future concern?" |
| "It should handle edge cases" | "Which edge cases? Let's name the ones that matter." |

The test: each acceptance criterion must be answerable with pass or fail. The outcome is not always a number — "a user who has never seen the app can complete a purchase without asking for help" is testable without being quantitative.

### Step 4: Prioritise and Scope the MVP

Apply MoSCoW to the requirements from Step 2:

- **Must have (P0):** without this, the product fails to deliver its core value. The MVP.
- **Should have (P1):** important but not the core; defer if needed.
- **Could have (P2):** nice to have; explicitly deferred.
- **Won't have:** explicitly out of scope for this version.

**Won't Have vs Non-Goals:** "Won't Have" lists specific features considered and set aside; "Non-Goals" states broader boundaries about what the product is not trying to be ("this is not a social platform"). Both are needed; they should not duplicate each other.

**The one-page heuristic:** if the MVP requirements don't fit on a page, the scope is too large (split into phases) or the problem is not yet clear (return to Step 2). Diagnostic, not rigid rule.

**Split into phases when** the P0 list exceeds 8–10 requirements, different user types have substantially different workflows, or deliverable value exists in a subset (ship that first). Split only on real sequencing logic, never just to shorten the document; produce a separate PRD per phase.

**Common mistakes to catch:** everything is P0 ("If you could only ship one feature, which would it be?"); scope creep during definition (log new ideas as P2/Won't have, don't expand P0); technical gold-plating ("must use microservices" belongs in Constraints, not Requirements).

**Explicit non-goals are as important as explicit goals.** For AI-assisted development, anything not explicitly excluded is fair game for the implementing agent. Name what you are NOT building.

### Step 5: Produce the PRD

Write the PRD from the template below. Fill all sections — mark genuine unknowns as open questions rather than omitting them. For a simple project, skip "Should Have"/"Could Have" only if they would be empty.

Validation before presenting:

- [ ] All five essential elements present and non-empty
- [ ] Every P0 requirement has a testable acceptance criterion
- [ ] Non-Goals names at least one explicit exclusion
- [ ] No requirement specifies implementation detail (that belongs in Constraints)
- [ ] Open questions logged, not silently omitted

Then read back the key decisions:

> "Here's what I've captured: the MVP will do [X, Y, Z] for [user type], with success defined as [criteria]. It will not include [explicit non-goals]. Does this match your intent?"

Adjust on feedback, then save as `PRD.md` in the project directory.

## PRD Template

```markdown
# [Product Name]

**Status:** Draft
**Date:** YYYY-MM-DD
**Version:** 1.0

---

## Problem

[2–4 sentences. What specific problem are we solving? Who has it? Why does it matter?
What do they do today instead, and why is that insufficient?]

## Target Users

[Who is this for? Describe the primary user in concrete terms: their situation,
goal, and what they currently do. One or two sentences per user type. Max two types for an MVP.]

## Success Criteria

How we will know this worked:

- [Specific, testable criterion — e.g. "A first-time user can complete [core action]
  without asking for help"]
- [Measurable outcome — e.g. "Users report that [X problem] no longer requires
  a workaround"]
- [At least one criterion per primary user type]

## Requirements

### Must Have (P0 — MVP)

- As a [user], I want to [capability] so that [outcome]
  - Acceptance: [specific, testable condition]

[Repeat for each P0 requirement. 3–7 for a focused MVP.]

### Should Have (P1 — next iteration)

- [Requirement] — [one-line rationale for deferral]

### Could Have (P2 — future consideration)

- [Requirement] — [one-line rationale for deferral]

### Won't Have (this version)

- [Requirement] — [brief reason or "outside product scope"]

## Non-Goals

This version will NOT:

- [Explicit boundary 1 — broader product direction, not a specific feature]
- [Explicit boundary 2]
- [Add as many as needed. When in doubt, name it explicitly.]

## Constraints

- **Platform / environment:** [Web app, mobile, CLI, API — or "TBD for architect"]
- **Tech stack:** [If specified by user; otherwise "TBD for architect"]
- **Existing system:** [What already exists, if extending. "Greenfield" if new.]
- **Performance:** [Any specific requirements, or "none specified"]
- **Security / data:** [Any specific requirements, or "none specified"]

## Open Questions

- [Question] — Owner: [who] — needs answer before [phase]
```

## Edge Cases

**User conflates "what" with "how":** keeps specifying schema or framework choices. Redirect to actions and outcomes; record genuine technical constraints (must use existing infrastructure) in Constraints, not Requirements.

**User cannot describe success criteria:** offer prompts — "Imagine a user coming back after a week. What would they tell you about it?" If still blocked, draft a criterion and ask them to confirm or correct.

**Scope inflation during conversation:** do not suppress ideas — log them as P2 or Won't have immediately and continue; confirm the P0 boundary still holds afterwards.

**Overlap with understanding-the-ask:** that skill clarifies *intent and context*; this one extracts *product-specific detail* (features, users, success, exclusions). If you are still clarifying intent, step back to understanding-the-ask.
