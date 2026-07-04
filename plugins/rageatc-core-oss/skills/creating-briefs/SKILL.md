---
name: creating-briefs
description: Transforms unstructured requests into clear, actionable briefs. Use when writing a brief, preparing a specification, extracting requirements, or clarifying what a task needs.
---

# Creating Briefs

A brief transforms an unstructured request into a bounded, verifiable specification that the executing agent can work from without clarification questions — and that the requester can read and say "yes, this is what I meant". Briefing is orchestrator-owned: it depends on the full conversation context, so write the brief yourself rather than delegating it.

Skip when the task is trivial, already well-specified, or purely exploratory with undefined outcomes.

## Principles

- **Outcomes, not solutions** — define WHAT to achieve, let the executor determine HOW. Prescribe method only when a real constraint requires it.
- **Context is never assumed** — the executor hasn't read the conversation, previous work, or project history. If background matters, state it in the brief.
- **Fit for purpose AND audience** — name who will use the deliverable; it shapes requirements and tone.

## Workflow

### 1. Clarify the request

Extract: core intent (the outcome behind the literal words), purpose (WHY it matters — without it the executor can do technically correct work that serves the wrong goal), scope boundaries, audience, and any assumptions you're making. If critical information is missing, ask targeted questions — don't guess.

### 2. Identify applicable standards

The 1–3 skills or guides that govern quality for this artefact type: `writing-skills` for skills, `conducting-research` for research, style guides for documents. Multiple standards can apply to one brief.

### 3. Extract requirements

The core step — it creates the shared quality expectations that the executor works to and the critic reviews against. From each standard, select the 5–12 requirements that apply to *this* task (not all of them), rephrase for clarity if needed, and structure as verifiable checkboxes grouped by source standard. Vague aspirations ("must be good quality") are not requirements.

### 4. Set constraints

3–6 scope limits: format, length, dependencies, explicit exclusions. More than that suggests the scope itself is unclear.

### 5. Define success criteria

2–4 measurable, outcome-focused statements the requester can verify ("QA can test all endpoints without questions", not "documentation is comprehensive"). The final criterion is always "all requirements from standards are met".

### 6. Add references and context

Any materials provided for the task — skills, previous work, examples — MUST appear in References; they are inputs, not nice-to-haves. In Context, summarise background the executor needs in 2–5 bullets: decisions already made, known risks. Need-to-know only — no speculation, no disguised requirements. Omit the section if there's nothing.

### 7. Validate

Before handing off: would the requester recognise this as their intent? Can the executor start without questions? Are requirements checkable, success criteria measurable by a third party, and all provided materials referenced? Fix gaps before use — a technically perfect brief that doesn't match the request is a failure.

## Template

```markdown
# Brief: [Task Name]

**Created:** YYYY-MM-DD
**Objective:** [One sentence outcome that's verifiable]
**Audience:** [Who will use the deliverable]
**Applicable Standards:** [Standards/skills that define quality]

## Why

[2–4 sentences: why this work matters, where it fits in the bigger picture,
what problem it solves]

## Requirements Extracted from Standards

**From [standard-name-1]:**
- [ ] Requirement 1 (specific, verifiable)
- [ ] Requirement 2 (specific, verifiable)

**From [standard-name-2]:**
- [ ] Requirement 3 (specific, verifiable)

## Constraints

- Format: [Specific requirement]
- Length: [Target or range]
- Dependencies: [What must exist]
- Out of scope: [Explicit exclusions]

## Success Criteria

The deliverable is complete when:
1. [Measurable outcome 1]
2. [Measurable outcome 2]
3. All requirements from standards are met

## References

**Skills:** [Path to skill files]
**Previous work:** [Path to research or related artefacts]
**Examples:** [Path to reference materials]

## Context

**Background decisions:** [Constraints from previous work]
**Known risks:** [Challenges to anticipate]
```

Typical length: 50–150 lines depending on task complexity.

## Edge cases

- **Conflicting standards** — note the conflict in Context, propose a resolution based on artefact type and audience, ask the requester if unclear.
- **No formal standards** — derive checkboxes from best practice for the artefact type and label the section "Quality Expectations" to signal they're derived, not extracted.
- **Prior research exists** — include it in References and summarise the key findings in 2–4 Context bullets; extract any quality criteria the research surfaced into requirements.
- **Iterating on an existing artefact (vN → vN+1)** — reference the previous version and its review, add a "Changes from vN" section listing what the iteration addresses, keep still-applicable requirements, and add a success criterion about preserving what worked.
- **Vague request** — ask targeted questions; document confirmed assumptions in Context.
