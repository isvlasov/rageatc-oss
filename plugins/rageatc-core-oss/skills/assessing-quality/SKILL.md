---
name: assessing-quality
description: Conducts quality reviews of non-code artefacts. Use when reviewing or critiquing Skills, agents, workflows, documentation, or written materials, assessing quality against standards, or providing structured feedback.
---

# Assessing Quality

Produce reviews that guide improvement, not just identify problems: validate what meets standards, categorise issues by priority with root causes, and give specific "where to next" guidance for every issue.

## Output format

Save to `work/<task-id>/review_v[N].md`:

```markdown
# Review: [Artefact Name] v[N]

**Reviewed:** YYYY-MM-DD
**Artefact Type:** [Skill/Agent/Workflow/Documentation]
**Applicable Standards:** [List]

## Summary
[Overall assessment in 2-3 sentences]

## What Meets Standards
[Validation of what works well — builds shared understanding]

## Priority Issues

### High Priority
**[Issue Title]**
- Symptom: [specific observation with location]
- Root cause: [underlying reason]
- Impact: [effect on purpose, audience, or standards]
- Where to next: [specific, actionable fix guidance]

### Medium Priority
[Same structure]

### Low Priority / Recommendations
[Suggestions with rationale]

## Assessment Against Standards
[Checklist from brief.md: [x] met, [~] partially met (specify gap), [ ] not met]

## Next Steps
[Prioritised by impact]
```

## Workflow

### Stage 1 — Prepare

1. Read the artefact fully. Note initial impressions; don't judge yet.
2. Read `work/<task-id>/brief.md` and extract its requirements checklist (the "Requirements Extracted from Standards" section). If that section is missing, identify applicable standards from the brief's context and extract requirements from those skills directly.
3. Note the artefact type and whether this is a v1 review or a v2+ iteration review.

### Stage 2 — Assess

Evaluate against six core dimensions, documenting specific observations with locations:

- **Completeness** — required components present; checklist items addressed; no placeholders remain
- **Clarity** — understandable to the intended audience; terms defined at first use; examples for abstract concepts
- **Correctness** — factually accurate; internally consistent; references valid
- **Consistency** — one term per concept throughout; formatting patterns repeated; aligned with cited standards
- **Fitness for purpose** — the brief's target audience can apply it successfully; stated goals met; scope neither too narrow nor too broad
- **Signal-to-noise** — every passage changes something for the intended reader (their understanding, decision, or action); flag text that doesn't: filler, internal repetition, ceremony, explaining what the reader already knows. Noise is a quality defect, not a style preference — it buries the signal and costs the reader attention. Detail needed only conditionally belongs in references or appendices, not the body. Noise repeating across the artefact is systemic (Stage 4)

Then apply artefact-specific criteria:

- **Skills** — frontmatter format; description discoverability (trigger keywords, without summarising the workflow); body lean and imperative per writing-skills (no Purpose restating the description, no when-to-use or evaluation scenarios in the body, no piled-up MUST/ALWAYS emphasis); progressive disclosure one level deep
- **Agents** — role clarity and scope boundaries; input/output specifications; responsibility separation from other agents
- **Workflows** — step sequencing and dependencies; decision points and branching; error handling; integration with existing processes
- **Documentation** — audience appropriateness; information architecture; examples; readability

For each issue record: location, objective observation, a quote or paraphrase, and why it matters for the artefact's purpose. Specificity is non-negotiable:

- NOT "this section needs work" → YES "Section 3.2 (lines 45–52) uses undefined terminology ('constitutional critique') without explanation"
- NOT "the audience won't understand this" → YES "the brief specifies a novice audience (brief.md line 23); Section 2 assumes design-pattern knowledge, creating a gap"

### Stage 3 — Find root causes

For each issue, ask "why" repeatedly until you reach one of:

- an **actionable cause** the producer can fix in the artefact
- a **constraint** outside the producer's control (e.g. requires changing the brief) — note as constraint
- a **systemic issue** affecting the broader system — flag it for capture to `LEARNINGS.md`

Example chain: "Section 3 uses undefined terminology" → writer didn't define terms → no glossary → brief didn't specify the audience's knowledge level → root cause: missing audience definition in the brief.

Distinguish **isolated** (single occurrence) from **systemic** (pattern repeating across locations — needs a structural fix, not local edits). Validate the hypothesis: would fixing this root cause prevent recurrence? Do other issues share it?

### Stage 4 — Structure feedback

Prioritise by impact:

- **High** — prevents the artefact achieving its core purpose; clear standards violation; systemic; blocks deployment or the next iteration
- **Medium** — reduces effectiveness without preventing core function; affects a subset of uses; isolated with moderate impact
- **Low / recommendation** — enhancement that isn't essential; style preference; beyond current scope

Calibrate prescriptiveness, and make the mode explicit:

- **Prescriptive** ("Fix X by [specific action]") — standards violations, compliance requirements, technical errors with a known fix
- **Suggestive** ("Consider X to address Y; other approaches may work depending on Z") — multiple valid approaches, design choices with trade-offs, or where the producer may have context you lack

Before listing issues, validate what works: which requirements are met, what demonstrates good practice, where the artefact exceeds expectations.

### Stage 5 — Write the review

Fill the output template. For v2+ reviews: track each previous issue as resolved, partially addressed, or remaining; distinguish new issues from carried-over ones; acknowledge progress explicitly.

## Edge cases

- **Partially met requirements** — mark [~] in the checklist with what's missing; treat as Medium priority with completion guidance.
- **Multiple valid approaches** — note the trade-offs, mark as recommendation not required fix, respect the producer's judgement.
- **Root cause outside producer's control** — name the limiting factor, recommend the process fix or stakeholder consultation, give the best available fix within the constraint.
- **Your own uncertainty** — be transparent: note where you lack domain expertise and mark as "needs validation" rather than definitive judgement.

## Scope

Assess systematically, identify root causes, give actionable feedback. Do not rewrite the artefact, make the producer's decisions, or judge the producer's capability.

## Final checklist

- [ ] All six dimensions and artefact-specific criteria assessed
- [ ] Every issue has symptom, root cause, impact, and where-to-next
- [ ] Every issue cites a specific location and example
- [ ] Priorities carry clear rationale; prescriptive vs suggestive made explicit
- [ ] Validation section present (not only criticism)
- [ ] Standards checklist from brief.md included and accurate
- [ ] v2+ only: previous issues tracked, progress acknowledged
- [ ] Tone constructive, objective, professional
