---
name: assessing-quality
description: Conducts quality reviews of non-code artefacts. Use when reviewing or critiquing Skills, agents, workflows, documentation, or written materials, assessing quality against standards, or providing structured feedback.
---

# Assessing Quality

## Purpose

This Skill enables systematic, actionable review of non-code artefacts including Skills, agents, workflows, and documentation. It combines structured assessment frameworks with root cause analysis to produce feedback that guides improvement rather than simply identifying problems. Reviews validate what meets standards whilst providing specific "where to next" guidance for identified issues.

## When to Use

Use this Skill when:
- Conducting systematic review of artefacts produced by producer-agent or other agents
- Evaluating Skills, agent definitions, workflow documentation, or technical writing
- Providing quality feedback on written materials
- Assessing artefact readiness for deployment or iteration
- Identifying root causes of quality issues rather than surface symptoms
- Creating structured review outputs (work/<task-id>/review_v1.md, v2.md, etc.)

## Inputs Required

Before beginning assessment, gather:

1. **Artefact to review**: The file(s) being assessed (typically work/<task-id>/artefact_v[N].md)
2. **Applicable standards**: Relevant Skills or guidelines (from brief.md requirements section)
3. **Artefact type**: Skill, agent, workflow, documentation, or other
4. **Review version context**: Is this v1 (initial review) or v2+ (iteration review)?
5. **Brief requirements**: The original brief.md with extracted requirements checklist (see creating-briefs Skill for template format)

## Outputs Produced

Each review generates:

**Primary output:** `work/<task-id>/review_v[N].md` containing:
- Summary assessment (2-3 sentences)
- Validation of what meets standards
- Priority-categorised issues with root causes and fix pathways
- Assessment against standards checklist
- Clear next steps

**Structure follows this template:**
```markdown
# Review: [Artefact Name] v[N]

**Reviewed:** YYYY-MM-DD
**Artefact Type:** [Skill/Agent/Workflow/Documentation]
**Applicable Standards:** [List]

## Summary
[Overall assessment in 2-3 sentences]

## What Meets Standards
[Validation of what works well - builds shared understanding]

## Priority Issues

### High Priority
[Issues with symptom, root cause, impact, specific fix]

### Medium Priority
[Issues with symptom, root cause, impact, specific fix]

### Low Priority / Recommendations
[Suggestions with rationale]

## Assessment Against Standards
[Checklist showing compliance with extracted requirements from brief.md]

## Next Steps
[Clear "where to next" guidance prioritised by impact]
```

## Workflow

### Stage 1: Preparation

**1.1 Read the artefact thoroughly**
- Load work/<task-id>/artefact_v[N].md
- Understand purpose, structure, and intended audience
- Note initial impressions but don't judge yet

**1.2 Identify applicable standards**
- Read work/<task-id>/brief.md to extract requirements
- Look for "Requirements Extracted from Standards" section (see creating-briefs Skill for template format)
- If this section is missing, identify applicable standards from the brief's context and extract requirements from those Skills directly
- Note which Skills or guidelines apply (e.g., writing-skills, assessing-quality)
- Load relevant standard documents if needed

**1.3 Extract quality criteria**
- Copy the requirements checklist from brief.md
- Identify artefact-specific assessment dimensions
- Prepare core quality framework (see Assessment Framework below)

### Stage 2: Systematic Assessment

**2.1 Evaluate against core quality dimensions**

Apply these five core dimensions applicable to all artefact types:

- **Completeness**: All required sections/components present; no critical gaps
- **Clarity**: Understandable to intended audience without ambiguity or confusion
- **Correctness**: Technically accurate, follows established patterns, internally consistent
- **Consistency**: Aligned with external standards; internal terminology and style consistent
- **Fitness for purpose**: Achieves stated objective for target audience

For each dimension, document specific observations with examples and locations.

**2.2 Apply artefact-specific criteria**

**For Skills (SKILL.md files):**
- YAML frontmatter completeness and format
- Description triggers and discoverability
- Workflow clarity and actionability
- Evaluation scenarios quality and realism
- Progressive disclosure (supporting files if needed)

**For Agent definitions:**
- Role clarity and scope boundaries
- Workflow integration points
- Input/output specifications
- Responsibility separation from other agents

**For Workflows:**
- Step sequencing and dependencies
- Decision points and branching logic
- Error handling and edge cases
- Integration with existing processes

**For Documentation:**
- Audience appropriateness
- Information architecture
- Examples and illustrations
- Accessibility and readability

**2.3 Use multi-perspective lens**

Review through these complementary lenses (order can be adapted to context):

- **Standards compliance**: Meets extracted requirements from brief
- **Usability**: Can intended user successfully apply the artefact?
- **Technical accuracy**: Facts, processes, and references correct
- **Editorial quality**: Structure, clarity, tone, consistency

**2.4 Document findings with specificity**

For each identified issue, record:
- **Location**: Specific section, line, or component
- **Observation**: What you see (objective, concrete)
- **Example**: Quote or paraphrase the problematic content
- **Context**: Why this matters for the artefact's purpose

### Stage 3: Root Cause Investigation

For each identified issue, distinguish symptom from root cause.

**3.1 Apply iterative "why" questioning**

Start with the symptom and ask "Why did this happen?" repeatedly until you reach an actionable root cause.

**Example:**
- Symptom: "Section 3 uses undefined terminology"
- Why? → Writer didn't define terms
- Why? → No glossary or inline definitions
- Why? → Brief didn't specify audience's domain knowledge level
- Root cause: Missing audience definition in brief led to incorrect assumptions

**Stop when you reach:**
- An actionable cause the producer can address (e.g., "Producer can fix this in the current artefact"), OR
- A constraint outside the producer's control (e.g., "This requires changing the brief" - note as constraint), OR
- A systemic issue affecting broader system (e.g., "This is a systemic issue affecting all Skills" - note for Learner)

**3.2 Distinguish isolated vs systemic issues**

- **Isolated**: Single occurrence, specific to one location
- **Systemic**: Pattern repeating across multiple locations, indicating underlying problem

Systemic issues signal deeper root causes requiring structural fixes rather than local edits.

**3.3 Validate root cause hypotheses**

Check your root cause analysis:
- Does fixing this root cause prevent recurrence?
- Are there other issues with the same root cause?
- Is this truly a cause or still a symptom of something deeper?

### Stage 4: Feedback Structuring

**4.1 Prioritise issues by impact and severity**

**High Priority:**
- Prevents artefact from achieving core purpose
- Standards violation with clear fix required
- Systemic issue affecting multiple areas
- Blocks deployment or next iteration

**Medium Priority:**
- Reduces effectiveness but doesn't prevent core function
- Affects subset of use cases or users
- Improvement opportunity with measurable benefit
- Isolated issue with moderate impact

**Low Priority / Recommendations:**
- Refinement that enhances but isn't essential
- Style preference within acceptable range
- Future consideration beyond current scope
- Suggestion when multiple valid approaches exist

**4.2 Structure each issue with complete information**

For every issue, provide:

1. **Symptom**: Observable manifestation (specific location/example)
2. **Root cause**: Underlying reason (from Stage 3 investigation)
3. **Impact**: Why this matters (effect on purpose/audience/standards)
4. **Fix pathway**: Specific "where to next" guidance

**Format:**
```markdown
### [Priority Level]

**[Issue Title]**
- Symptom: [Specific observation with location]
- Root cause: [Underlying reason identified through investigation]
- Impact: [Effect on artefact purpose, audience, or standards]
- Where to next: [Specific, actionable fix guidance]
```

**4.3 Calibrate prescriptiveness to context**

**Be prescriptive when:**
- Standards violation with clear correct solution
- Compliance requirement (formatting, required sections)
- Technical error with known fix
- Established pattern exists and should be followed

**Be suggestive when:**
- Multiple valid approaches exist
- Design choice with trade-offs
- Producer may have context reviewer lacks
- Creative or innovative solutions valued

**Make the distinction explicit:**
- Prescriptive: "Fix [X] by [specific action]"
- Suggestive: "Consider [suggestion] to address [issue]. Other approaches may work depending on [context factor]."

**4.4 Validate what meets standards**

Before listing issues, explicitly validate what works well:
- Which requirements from brief.md are met?
- What demonstrates good practice?
- Where does the artefact exceed expectations?

This builds shared understanding of quality standards and provides concrete examples of success.

### Stage 5: Output Generation

**5.1 Draft the review document**

Create work/<task-id>/review_v[N].md following the template structure:

1. **Header metadata**: Date, artefact type, applicable standards
2. **Summary**: 2-3 sentence overall assessment
3. **What Meets Standards**: Validation section
4. **Priority Issues**: High/Medium/Low sections with structured feedback
5. **Assessment Against Standards**: Checklist from brief.md with status
6. **Next Steps**: Prioritised action list

**5.2 Apply quality checks to your own review**

Validate your review meets these criteria:

- [ ] Every issue has specific location/example (no vague "this section" references)
- [ ] Root causes identified, not just symptoms described
- [ ] Priority rationale clear (why High vs Medium vs Low)
- [ ] "Where to next" guidance specific and actionable
- [ ] Validation section present (not only criticism)
- [ ] Tone constructive, objective, professional
- [ ] Standards checklist accurately reflects assessment
- [ ] Next steps prioritised by impact

**5.3 Save and reference**

- Write review to work/<task-id>/review_v[N].md
- For v2+ reviews, reference previous review to show progress
- Note any new issues emerging after previous fixes

## Assessment Framework Reference

### Core Quality Dimensions (All Artefacts)

| Dimension | Definition | Observable Indicators |
|-----------|------------|----------------------|
| **Completeness** | All required components present | All sections from brief.md requirements exist; requirements checklist items addressed; no "TODO" or "[placeholder]" markers remain |
| **Clarity** | Understandable without ambiguity | Terms defined at first use OR glossary provided; paragraph length under 5 sentences on average; examples present for abstract concepts; section headers descriptive |
| **Correctness** | Technically accurate and consistent | Facts verified against source materials; processes follow established patterns; no internal contradictions; references valid |
| **Consistency** | Internal and external alignment | Same term used throughout (no synonyms for same concept); formatting patterns repeated (headings, lists, code blocks); aligned with cited standards |
| **Fitness for purpose** | Achieves stated objective | Target audience specified in brief can apply artefact successfully; stated goals from brief.md met; scope appropriate (neither too narrow nor too broad) |

### Specificity Requirements

**Avoid vague language:**
- NOT: "This section needs work"
- YES: "Section 3.2 (lines 45-52) uses undefined terminology ('constitutional critique') without explanation"

**Avoid generic judgements:**
- NOT: "The quality could be better"
- YES: "Workflow steps 4-6 lack success criteria, making it unclear when to proceed to next step"

**Avoid assumption-heavy statements:**
- NOT: "The audience won't understand this"
- YES: "Given the brief specifies novice audience (brief.md line 23), the assumption that readers know design patterns (Section 2) creates a knowledge gap"

### Root Cause Analysis Guide

**Quick reference for distinguishing symptoms from causes:**

- **Symptom**: Unclear passage, missing information, inconsistent terminology, confusing structure
- **Surface cause**: Writer didn't explain, forgot section, changed terms midway, poor organisation
- **Deeper cause**: No audience definition, incomplete brief, missing examples in standard, no template
- **Root cause**: Process gap, standard ambiguity, missing constraint, incorrect assumption

**Stop investigation when you reach:**
- Actionable cause within producer's scope to fix
- Clear process or standard improvement to propose
- Constraint requiring stakeholder decision

## Evaluation Scenarios

Test this Skill against these realistic review tasks. Each scenario includes actual artefact excerpts, expected review outputs, and examples of problematic review approaches to avoid.

### Scenario 1: Reviewing a Skill with Missing Requirements

**Context:** First draft of a new Skill submitted for review. The brief required evaluation scenarios and trigger keywords in description.

**Input artefact excerpt:**
```markdown
---
name: example-skill
description: Helps with various tasks and workflows when needed.
---

## Purpose
This skill assists users in completing common tasks efficiently.

## Workflow
1. Read the input
2. Process the information
3. Generate the output

## Success Indicators
- Task completed successfully
- User satisfied with result
```

**Expected review output (excerpt from Priority Issues section):**

```markdown
### High Priority

**Missing evaluation scenarios (completeness violation)**
- Symptom: No "Evaluation Scenarios" section present; skill ends at "Success Indicators"
- Root cause: Brief requirement for "at least 3 evaluation scenarios" (brief.md line 16) not addressed during writing
- Impact: Cannot validate skill effectiveness; users lack concrete examples of application; violates writing-skills standard
- Where to next: Add "Evaluation Scenarios" section after Success Indicators with 3 scenarios showing realistic use cases, including example inputs and expected outputs

**Description lacks trigger keywords (discoverability problem)**
- Symptom: Description "Helps with various tasks and workflows when needed" contains no specific trigger keywords
- Root cause: Description written generically without consulting brief requirement for trigger keywords (brief.md line 13)
- Impact: Claude Code will not discover this skill when users need it; reduced usability across repositories
- Where to next: Rewrite description to specify what tasks (replace "various tasks" with specific actions), include trigger phrases users will say (e.g., "organising", "structuring", "planning")

### Medium Priority

**Success indicators are outcome-focused rather than observable**
- Symptom: Indicators "Task completed successfully" and "User satisfied with result" measure outcomes, not process adherence
- Root cause: Success criteria focused on end results rather than observable application of the skill
- Impact: Difficult to verify skill was actually used vs task completed through other means
- Where to next: Add process-based indicators: "Followed workflow steps 1-3 in sequence", "Generated output matches template format", "All input requirements gathered before processing"
```

**Problematic review approach to avoid:**
```markdown
The skill needs work. The description is too vague and there are some missing sections. Please improve the workflow and add better examples.
```
**Why this fails:** No specific locations, no root cause analysis, vague language ("needs work", "too vague", "better examples"), no prioritisation, no "where to next" guidance.

### Scenario 2: Reviewing Documentation with Audience Mismatch

**Context:** Technical documentation submitted for novice users, but writer assumed expert knowledge.

**Input artefact excerpt:**
```markdown
## Installation

To install the package, configure your dependency injection container to register the singleton pattern for the service locator, then bootstrap the application context using the factory method.

## Configuration

The configuration leverages the observer pattern to propagate changes through the event bus. Ensure your handlers implement the IObserver interface and register with the subject via the attach() method.
```

**Brief excerpt:**
```markdown
**Target audience:** Novice developers with basic JavaScript knowledge but no design pattern experience
```

**Expected review output (excerpt from Priority Issues section):**

```markdown
### High Priority

**Knowledge gap between assumed and actual audience (systemic)**
- Symptom: Installation section (lines 3-5) uses unexplained technical terms: "dependency injection container", "singleton pattern", "service locator", "factory method"
- Root cause: Target audience specification "novice developers with basic JavaScript knowledge but no design pattern experience" (brief.md line 18) not applied during writing; writer assumed expert knowledge
- Impact: Target audience cannot follow installation instructions without external research; documentation fails fitness for purpose criterion
- Where to next: For each design pattern term (dependency injection, singleton, service locator, factory, observer), either:
  1. Add brief inline definition at first use: "singleton pattern (ensuring only one instance exists)"
  2. Provide "Assumed Knowledge" section upfront listing prerequisites
  3. Simplify to avoid patterns: "To install, run `npm install` then `npm start`"
  Option 3 recommended given novice audience.

**Pattern continues in Configuration section**
- Symptom: Configuration section (lines 7-9) references "observer pattern", "event bus", "IObserver interface", "subject", "attach() method"
- Root cause: Same as Installation section - audience definition from brief not applied
- Impact: Compounds accessibility problem; systemic issue affecting entire document
- Where to next: Apply same fix strategy across all sections; consider restructuring to introduce concepts progressively rather than assuming expertise upfront
```

**What meets standards:**
```markdown
- Document structure is logical (Installation → Configuration follows natural sequence)
- Section headings are descriptive and follow hierarchy
- Technically accurate (the design patterns are correctly described)
```

**Problematic review approach to avoid:**
```markdown
This documentation assumes too much knowledge. The audience is novice users, so you need to simplify the language and explain things better.
```
**Why this fails:** No specific examples of problematic terms, no locations cited, doesn't distinguish isolated vs systemic issue, no concrete fix pathways, root cause not investigated beyond surface observation.

### Scenario 3: Iterative Review (v2 After Fixes Applied)

**Context:** Producer addressed v1 review feedback and submitted v2 for re-review.

**Review v1 identified:**
- High priority: Missing YAML frontmatter
- Medium priority: Workflow steps lack success criteria
- Low priority: Consider adding examples section

**Artefact v2 changes:**
- Added YAML frontmatter
- Added success criteria to workflow steps 1-3, but not steps 4-5
- Did not add examples section (low priority item)

**Expected review output (v2):**

```markdown
## Summary

Artefact v2 shows meaningful progress from v1. High priority issue (missing YAML frontmatter) fully resolved. Medium priority issue (workflow success criteria) partially addressed but incomplete. New minor issue identified in frontmatter description field. Ready for final iteration to address remaining gaps.

## What Meets Standards

**Improvements from v1:**
- YAML frontmatter now present with name and description fields (resolves review_v1.md High Priority issue 1)
- Workflow steps 1-3 now include success criteria (partially addresses review_v1.md Medium Priority issue 2)
- Structure and formatting improved overall

**Maintained quality:**
- Purpose section remains clear and well-articulated
- Workflow sequence logical and easy to follow
- Tone professional and appropriate

## Priority Issues

### High Priority

**Frontmatter description field missing trigger keywords (new issue)**
- Symptom: Description reads "A skill for task completion" with no trigger keywords
- Root cause: Frontmatter added to resolve v1 issue but description field not crafted for discoverability
- Impact: Skill won't be discovered by Claude Code when users need it
- Where to next: Revise description to include trigger keywords from brief.md (e.g., "organising", "planning", "structuring")

### Medium Priority

**Workflow success criteria incomplete (partially addressed from v1)**
- Symptom: Steps 1-3 now have success criteria, but steps 4-5 still lack them
- Root cause: Partial implementation of v1 feedback - producer added criteria to early steps but not later ones
- Impact: Inconsistent guidance; users uncertain when to proceed from steps 4-5
- Where to next: Add success criteria to steps 4-5 following same pattern as steps 1-3: observable indicators of completion

### Low Priority / Recommendations

**Examples section not yet added (carried over from v1)**
- Observation: v1 review recommended adding examples section (Low Priority)
- Status: Not yet implemented (acceptable given low priority)
- Suggestion: Consider adding after addressing High and Medium priority issues above
```

**Problematic review approach to avoid:**
```markdown
You fixed some things from v1 but there are still problems. The workflow still needs work and the description isn't good enough.
```
**Why this fails:** No acknowledgement of progress made, vague language ("some things", "still problems", "needs work", "isn't good enough"), no tracking of which v1 issues were addressed vs remain, no distinction between new issues and carried-over issues.

## Edge Cases and Constraints

### When Artefact Partially Meets Requirements

Use assessment checklist to show partial completion:
- [x] Requirement fully met
- [~] Requirement partially met (specify what's missing)
- [ ] Requirement not met

In feedback, address partial completion as Medium priority with specific guidance on completing.

### When Multiple Valid Approaches Exist

Acknowledge design choice explicitly:
- Note the trade-offs of chosen approach
- Suggest alternative if it has clear advantages
- Mark as recommendation rather than required fix
- Respect producer's judgement when context may differ

### When Root Cause Is Outside Producer's Control

Note constraint in feedback:
- Identify the limiting factor (missing standard, unclear brief, external dependency)
- Recommend process improvement or stakeholder consultation
- Provide best available fix within constraints

### When Review Itself Is Uncertain

Be transparent about uncertainty:
- Note where you lack domain expertise
- Suggest verification by subject matter expert
- Mark as "needs validation" rather than definitive judgement

## Common Reviewer Mistakes to Avoid

1. **Treating symptoms rather than root causes**: Always investigate why, not just what
2. **Vague or judgmental language**: Use specific examples and objective observations
3. **Inconsistent standards application**: Apply same criteria uniformly across artefact
4. **Overemphasis on minor issues**: Prioritise ruthlessly; focus on impact
5. **Lack of prioritisation**: Always categorise High/Medium/Low with clear rationale
6. **Pure criticism without validation**: Include "What Meets Standards" section
7. **Prescriptive where suggestive appropriate**: Distinguish standards violations from design choices
8. **Generic feedback**: Every piece of feedback must include location and example

## Integration with Producer-Critic-Learner Workflow

This Skill operates within the broader workflow:

1. **Producer creates** work/<task-id>/artefact_v1.md using brief and standards
2. **Critic reviews** using this Skill → work/<task-id>/review_v1.md
3. **Producer revises** based on review → work/<task-id>/artefact_v2.md
4. **Critic re-reviews** using this Skill → work/<task-id>/review_v2.md
5. **Iterate** until artefact meets standards
6. **Learner extracts** patterns from review history for system improvement

**Critic's role**: Systematic assessment, root cause identification, actionable feedback
**Not critic's role**: Rewriting the artefact, making producer's decisions, judging producer capability

## Success Indicators

A review is successful when:

- Producer can immediately act on feedback without clarification questions
- High priority issues have clear fix pathways
- Root causes identified enable prevention of similar issues
- Next iteration shows measurable improvement in identified areas
- Review provides learning value beyond this single artefact
- Standards compliance status is unambiguous
- Both strengths and gaps are explicitly documented

## Review Quality Checklist

Before finalising any review produced using this Skill, verify:

- [ ] All five core quality dimensions assessed
- [ ] Artefact-specific criteria applied
- [ ] Every issue has: symptom, root cause, impact, fix pathway
- [ ] Priority categorisation includes rationale
- [ ] Specificity achieved (locations, examples, concrete observations)
- [ ] Root causes distinguished from symptoms
- [ ] Validation section completed (what meets standards)
- [ ] Standards checklist from brief.md included
- [ ] "Where to next" guidance specific and actionable
- [ ] Tone constructive, objective, professional
- [ ] Prescriptive vs suggestive appropriately calibrated
- [ ] Review file saved to correct location (work/<task-id>/review_v[N].md)
