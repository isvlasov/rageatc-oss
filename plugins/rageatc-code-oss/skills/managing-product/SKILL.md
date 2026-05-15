---
name: managing-product
description: Extracts product requirements and produces a PRD. Use when a user wants to build software and needs to define what to build before architecture or implementation, when scoping an MVP, or when translating a vague idea into a buildable specification.
---

# Managing Product

## Purpose

This skill guides the orchestrator through defining *what to build* before any architecture or code is written. It sits between upstream clarification (understanding-the-ask, solutioning) and downstream technical design (architecting-software) and encodes the product management discipline needed to translate an understood idea into a structured, prioritised PRD that agents can execute against without ambiguity.

Use this skill when the user wants to build software and the solution direction is chosen but the product definition is not yet clear.

## Scope and Constraints

**This skill covers:**
- Extracting product requirements from a non-technical user via structured conversation
- Scoping an MVP using MoSCoW prioritisation
- Writing user stories and testable acceptance criteria
- Producing a structured Markdown PRD

**This skill does NOT cover:**
- Initial problem clarification or solution direction (use understanding-the-ask and solutioning first)
- Technical architecture or system design (that is architecting-software's job)
- Implementation chunk enrichment (use enriching-roadmap after decomposition)
- Roadmapping, sprint planning, stakeholder management, or rollout strategy
- Teaching programming concepts or framework selection

**Handoff position:**

```
understanding-the-ask  →  solutioning  →  managing-product  →  architecting-software
(clarify problem)          (choose direction)  (define what to build)    (design how to build it)
```

Receive from upstream: a clearly defined problem and a chosen solution direction ("we will build software that does X").

Hand off downstream: a PRD with problem statement, target users, success criteria, scoped requirements, and explicit non-goals — ready for an architect to begin system design.

## Inputs Required

Before starting, confirm you have:
- A clear problem statement (from understanding-the-ask or stated directly)
- A chosen solution direction ("we will build software") — not an architectural decision, just the type of solution
- The user's domain knowledge accessible through conversation

## Outputs Produced

A `PRD.md` file (or equivalent) containing the five essential elements:

1. **Problem statement** — what specific user problem is being solved, for whom, and why now
2. **Target users** — who the software is for and what their current situation is
3. **Success criteria** — measurable outcomes that define whether the product worked
4. **Scope** — explicit in-scope requirements (MoSCoW-prioritised) and explicit out-of-scope statements
5. **Requirements** — user stories with testable acceptance criteria

Format: structured Markdown designed to be placed in the project as `PRD.md` and referenced by Claude Code.

## Workflow

### Step 1: Establish Starting Context

**What you're doing:** Confirming what you know from upstream and identifying gaps before questioning begins.

Check whether you already have:
- [ ] A clear problem statement
- [ ] An identified user or audience for the software
- [ ] Any constraints the user mentioned (timeline, platform, technology preferences)

If the user arrives directly with a clear problem and audience (e.g. "I want to build a habit tracking app for myself"), confirm your understanding inline and proceed — invoking upstream skills is not required when all checklist items are satisfied by the initial statement. If problem or audience remains vague after confirmation, return to understanding-the-ask before proceeding.

State what you understand so the user can correct it before you invest time in extraction:

> "Before we define what to build, let me confirm: we're solving [problem] for [user type]. Does that match your intent?"

**Output:** Confirmed problem and audience, or identification that upstream work is needed.

### Step 2: Extract Product Knowledge Through Structured Questioning

**What you're doing:** Pulling out the five essential PRD elements from the user's knowledge through focused, sequential questions. Ask one question at a time. Do not present a form or list all questions at once.

**Extraction sequence:**

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
- "What are the most important things it must be able to do?"
- "What would make it genuinely useful, even if it only had two or three features?"

**E. Boundaries:**
- "What are you deliberately not trying to do with this version?"
- "Are there things you could imagine adding later but don't need right now?"

**Redirecting solution-focused input:**

Users often describe implementation rather than requirements. When this happens, redirect to outcomes:

- User says "It needs a React frontend" → "What does the user need to be able to do? We can decide the technology once we know what it needs to accomplish."
- User says "It needs a database with relational tables" → "What information needs to be stored and retrieved? We'll leave the technical decisions to the architect."

**Managing the conversation:**

Keep questioning focused. You are looking for the five essential elements, not an exhaustive feature list. For a simple project (personal tool, weekend build), a single short conversation of 5 to 10 minutes is typically sufficient. For a complex project (production system, multiple user types, external integrations), each sub-area may require follow-up and several exchanges. Stop when you have enough to draft a PRD — not when the user has exhausted every idea.

**Output:** Raw understanding of users, core problem, success criteria, key capabilities, and boundaries. Ready to draft.

### Step 3: Challenge and Sharpen Acceptance Criteria

**What you're doing:** Converting vague requirements into testable statements before writing the PRD.

Before drafting, challenge any criteria that cannot be tested objectively:

| Vague statement | Clarifying question |
|---|---|
| "It should be easy to use" | "How would you test that? What would a new user be able to do within their first session?" |
| "It needs to be fast" | "Fast compared to what? Is there a specific action that needs to respond within a certain time?" |
| "It should be secure" | "What specifically needs to be protected? User data, transactions, access control?" |
| "It needs to scale" | "How many users are you planning for? Is scalability a day-one requirement or a future concern?" |
| "It should handle edge cases" | "Which edge cases? Let's name the ones that matter." |

The test: each acceptance criterion should be answerable with pass or fail. If you cannot imagine a specific test for it, it needs refinement.

**The outcome is not always a number.** Testable criteria can be functional: "A user who has never seen the app can complete a purchase without asking for help" is testable without being quantitative.

**Output:** Sharpened acceptance criteria ready for the PRD.

### Step 4: Prioritise and Scope the MVP

**What you're doing:** Drawing a clear line between what is in this version and what is not.

Apply MoSCoW to the requirements surfaced in Step 2:

- **Must have (P0)**: Without this, the product fails to deliver its core value. Include in MVP.
- **Should have (P1)**: Important but not the core. Include if time permits; defer if needed.
- **Could have (P2)**: Nice to have. Explicitly deferred to a future iteration.
- **Won't have**: Explicitly out of scope for this version — includes both deferred P2 items that have been decided against and features outside the product's scope entirely.

**The Won't Have / Non-Goals distinction:** "Won't Have" lists specific features considered and set aside during requirements extraction. "Non-Goals" states broader boundaries about what the product is not trying to be (e.g. "this is not a social platform"). Both sections are necessary and should not duplicate each other.

**The one-page heuristic:** If you cannot summarise the MVP requirements on a single page, either the scope is too large (split into phases) or the problem is not yet clear enough (return to Step 2). This is a diagnostic tool, not a rigid rule.

**When to split into phases:**

Split when:
- The P0 list exceeds 8 to 10 requirements
- Different user types have substantially different workflows
- Deliverable value exists in a subset of features (ship that first)

Do not split just to keep the document short. Split only when there is real sequencing logic. When you split, produce a separate PRD for each phase.

**Common mistakes to catch:**

- Everything is P0: Push back. "If you could only ship one feature, which would it be? Start there."
- Scope creep during definition: Log new ideas as P2 or "Won't have" rather than expanding P0.
- Technical gold-plating: Requirements that specify implementation ("must use microservices") belong in the architecture phase, not the PRD.

**Explicit non-goals are as important as explicit goals.** For AI-assisted development, anything not explicitly excluded is fair game for the implementing agent. Name what you are NOT building.

**Output:** A prioritised feature list with clear in/out-of-scope boundary.

### Step 5: Produce the PRD

**What you're doing:** Writing the structured Markdown PRD from the knowledge extracted in Steps 2 through 4, validating it, then confirming with the user.

Use the PRD template below. Fill all sections. Leave no section empty — if something is genuinely unknown, mark it as an open question rather than omitting it. For a simple project, skip the "Could Have" and "Should Have" sections only if they would be empty; do not force structure onto a one-feature MVP.

**Before presenting the PRD to the user, run this validation checklist:**

- [ ] All five essential elements present and non-empty (problem, target users, success criteria, scope, requirements)
- [ ] Every P0 requirement has a testable acceptance criterion
- [ ] Non-Goals section names at least one explicit exclusion
- [ ] No requirement specifies implementation detail (those belong in Constraints)
- [ ] Open questions are logged rather than silently omitted

If any item fails, fix it before proceeding.

After drafting, read back the key decisions to the user for confirmation:

> "Here's what I've captured: the MVP will do [X, Y, Z] for [user type], with success defined as [criteria]. It will not include [explicit non-goals]. Does this match your intent?"

Adjust based on feedback, then save the final version as `PRD.md` in the project directory.

**Output:** Confirmed PRD saved as `PRD.md`.

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

**User conflates "what" with "how":**
The user keeps specifying technical implementation (database schema, framework choice). Redirect: "The technical decisions belong with the architect — what matters here is what the user needs to be able to do. Can you describe that in terms of actions and outcomes?" If the user has genuine technical constraints (must use existing infrastructure), record those in the Constraints section, not the Requirements section.

**User cannot describe success criteria:**
Some users genuinely do not know what success looks like beyond "it works." In this case, offer prompts: "Imagine a user coming back after a week. What would they tell you about it?" or "What problem would they no longer have?" This often unlocks the answer. If still blocked, write a draft criterion and ask the user to confirm or correct it.

**Scope inflation during conversation:**
Ideas keep expanding during conversation. Do not suppress ideas — log them as P2 or "Won't have" immediately and continue. Return to the P0 set after the conversation to confirm the boundary holds.

**Overlap with understanding-the-ask:**
Both skills involve questioning the user. The difference: understanding-the-ask clarifies *intent and context* (what problem, why it matters, is this the right thing to do). Managing-product extracts *product-specific detail* (which features, which users, what constitutes success, what is explicitly excluded). If you find yourself still clarifying intent, step back to understanding-the-ask before proceeding.

## Evaluation Scenarios

### Scenario 1: Simple Personal Project

**Context:** User says "I want to build a habit tracking app."

**Expected outcome:**
- Step 1: Confirm problem (users forget habits, want accountability) and audience (themselves primarily). User arrived directly, no upstream skills needed.
- Step 2: Extract in a single short conversation: track daily habits, mark completion, see streaks; no complex analytics needed
- Step 3: Challenge "easy to see at a glance" → "what does a user need to see in under 10 seconds to feel on track?"
- Step 4: P0 = add habit, mark complete, view streak; P2 = reminders, charts, sharing; Won't have = social features, habit templates
- Step 5: Validation checklist passes; PRD fits on one page; success criterion is "user can add a habit and mark it complete within 2 minutes of first use"; confirm with user before saving

### Scenario 2: Production Tool with Multiple User Types

**Context:** User says "I want to build a tool to manage our small agency's client projects."

**Expected outcome:**
- Step 1: Confirm problem and two user types (project managers, clients)
- Step 2: Two separate workflows extracted across multiple exchanges; scope quickly grows
- Step 3: "Clients can see progress" — challenged to "client can view current status without logging into our internal tools"
- Step 4: P0 scoped tightly (project status, task list, file uploads); P1 = time tracking; P2 = invoicing; Won't have = CRM features, resource planning. One-page heuristic triggers: suggest splitting Phase 1 (PM dashboard) and Phase 2 (client portal). Two separate PRDs produced.
- Step 5: Open questions surfaced and logged: "Does the client portal require login or public links?" — Owner: product owner — needs answer before Phase 2

### Scenario 3: User Leads with Technical Solution

**Context:** User says "I want to build a REST API with PostgreSQL for my inventory system."

**Expected outcome:**
- Recognise technical specification without product context
- Redirect: "Before we get into the technical design, can you tell me what problem this inventory system is solving? Who uses it and what do they need to do?"
- Extract: small retail business, currently uses spreadsheets, needs stock tracking and reorder alerts
- Return to product definition: who are the users, what must it do, what is success
- Record user's technical preferences (REST API, PostgreSQL) in Constraints section, not Requirements
- PRD focuses on product capabilities (track stock levels, trigger reorder alerts, generate stock reports), not technical implementation
- Hand off to architecting-software with both the PRD and the user's technical constraints noted

## Success Indicators

This skill succeeds when:
- An architect agent can begin system design from the PRD alone, without asking for clarification on what to build
- The user reads the PRD and confirms it matches their intent
- The non-goals section explicitly names what is not being built
