---
name: creating-briefs
description: Transforms unstructured requests into clear, actionable briefs. Use when writing a brief, preparing a specification, extracting requirements, or clarifying what a task needs.
---

# Creating Briefs

## Purpose

This skill teaches the craft of writing effective briefs — transforming unstructured, often vague requests into clear, bounded, actionable specifications that downstream agents can execute against.

A good brief establishes common understanding between requester and executor by:
- Capturing exactly what was intended (not what was literally said)
- Extracting concrete requirements from applicable standards
- Defining clear boundaries and measurable success criteria
- Creating a verifiable specification where the requester can read it and say "yes, this is what I meant"

This skill covers all brief types (artefact briefs, research briefs) using a consistent requirements-extraction methodology.

## Core Principles

**Outcomes, not solutions** — A brief defines WHAT we want to achieve, not HOW to execute it. State the desired outcome and let the executor determine the approach. Prescribe solutions only when there's a specific constraint that requires it.

**Context is never assumed** — Don't assume the executor knows the project history, has read previous work, or understands the bigger picture. State context explicitly. Better to over-communicate than leave critical gaps. The executor might be a different agent, a future version of yourself, or a human who wasn't present for earlier conversations.

**Fit for purpose AND fit for audience** — The brief must enable work that serves its intended purpose and is appropriate for its audience. An artefact for the orchestrator needs different structure than one for a human developer. Always specify who will use the deliverable.

## When to Use This Skill

**Use this skill when:**
- You receive an unstructured request that needs clarification before work begins
- The task must meet specific quality standards (Skills, style guides, frameworks)
- The request is non-trivial (3+ distinct steps or multiple quality dimensions)
- You need to create shared quality expectations between requester and executor
- The task has unclear boundaries or success criteria

**Skip this skill when:**
- The task is trivial (single file edit, simple clarification)
- No quality standards exist or apply
- The work is purely exploratory with undefined outcomes
- The request is already well-specified with clear requirements

## Inputs Required

1. **Unstructured request** - What the requester wants created, researched, or modified (may be vague, incomplete, or ambiguous)
2. **Applicable standards** - Which Skills, style guides, or frameworks govern quality for this type of work (e.g., writing-skills for skill creation, conducting-research for research tasks)
3. **Basic context** (if provided) - Existing files, constraints, dependencies, or background information
4. **Clarifications** (if needed) - Answers to questions that eliminate ambiguity in the request

## Outputs Produced

A brief file (typically `brief.md`) containing:
- Why this work matters (the purpose and bigger picture)
- Clear task objective (one sentence capturing intended outcome)
- Target audience (who will use the deliverable)
- Requirements extracted from applicable standards (5-12 checkboxes grouped by source)
- Constraints and boundaries (scope limits, format requirements, dependencies)
- Success criteria (measurable outcomes that define completion)
- References to relevant materials (skills, previous work, examples)
- Optional context (research findings, background decisions)

Typical length: 50-150 lines depending on task complexity.

## Workflow

### Step 1: Clarify the Request

Before writing anything, ensure you understand what's being asked AND why it matters.

**Extract from the request:**
- **Core intent** - What outcome does the requester actually want? (Look beyond literal words to underlying need)
- **Purpose** - Why does this work matter? Where does it fit in the bigger picture? What problem does it solve?
- **Scope boundaries** - What's included vs excluded? Where does this task end?
- **Success vision** - How will the requester know it's done correctly?
- **Audience** - Who will use the output? (orchestrator, specific agent, user, other humans)
- **Ambiguities** - What assumptions are you making that might be wrong?

**The WHY question is critical** — Without understanding purpose, the executor might do technically correct work that serves the wrong goal. Example: "research feedback methodologies" could mean feedback for users, for code reviews, or for critic skills. The purpose clarifies which domain matters.

**Don't assume the executor has context you possess** — They might not have read previous work, attended earlier discussions, or know the project's history. If background matters, you must state it explicitly in the brief.

**If critical information is missing, ask targeted questions:**
- "You mentioned X — does that include Y and Z, or just X specifically?"
- "When you say 'comprehensive', do you mean covering all edge cases, or just the common scenarios?"
- "Should this handle A, or can we exclude that for now?"
- "Who's the primary audience — will this be used by agents, users, or both?"
- "Where does this fit in the bigger picture? Why are we doing this now?"

**Output:** Mental model (or notes) capturing what's actually being requested, why it matters, and who it's for.

### Step 2: Identify Applicable Standards

Determine which quality standards govern this type of work.

**For artefact briefs:**
- If creating/updating a Skill → writing-skills applies
- If creating documentation → relevant style guide or documentation standards
- If creating code → code quality standards, architectural guidelines
- If creating workflow → workflow standards, process frameworks

**For research briefs:**
- conducting-research skill (requirements extraction methodology)
- verifying-claims skill (if fact-checking needed)
- Domain-specific research standards (if applicable)

**Multiple standards may apply** — e.g., a research brief about skill quality might reference both conducting-research and writing-skills.

**Output:** List of 1-3 applicable standards with file paths or references.

### Step 3: Write the Brief Header

Start with metadata that frames the task, explains why it matters, and identifies the audience.

**Template:**
```markdown
# Brief: [Task Name]

**Created:** YYYY-MM-DD
**Objective:** [One sentence describing the intended outcome]
**Audience:** [Who will use the deliverable]
**Applicable Standards:** [List of standards/skills that define quality]

## Why

[2-4 sentences explaining:
- Why this work matters
- Where it fits in the bigger picture
- What problem it solves or what goal it serves]
```

**Why section guidance:**
- Be concise (2-4 sentences) but establish the big picture
- Explain purpose, not mechanics (GOOD: "We're building a critic skill that needs structured feedback principles" / PROBLEMATIC: "This will help us create better documentation")
- Connect to broader goals (GOOD: "This supports the Producer-Critic-Learner workflow by enabling quality assessment" / PROBLEMATIC: "We need this for the project")
- Provide context the executor might not have (GOOD: "Previous research showed 3 patterns; we're implementing the multi-file approach" / PROBLEMATIC: "Continue the previous work")

**Objective crafting tips:**
- State the outcome, not the activity (GOOD: "Enable agents to write well-structured briefs" / PROBLEMATIC: "Create a briefing skill")
- Be specific enough to verify (GOOD: "Produce API docs QA can test without questions" / PROBLEMATIC: "Document the API")
- Use verifiable language (enable, produce, achieve) not aspirational language (improve, enhance, support)

**Audience specification:**
- Be specific (GOOD: "producer-agent" / PROBLEMATIC: "agents")
- Consider how audience affects requirements (documentation for users needs different clarity than documentation for orchestrators)
- State audience explicitly even if it seems obvious — what's obvious to you may not be to the executor

**Output:** Brief header that captures intent, purpose, and audience clearly.

### Step 4: Extract Requirements from Standards (Core Step)

This is the most critical step — it creates shared quality expectations and prevents compliance gaps.

**For each applicable standard:**

1. **Read the standard's quality checklist** (or Evaluation Scenarios section if no explicit checklist exists)
2. **Select 5-12 relevant requirements** that directly apply to this specific task
3. **Ignore irrelevant criteria** — if the standard has 20 requirements but only 8 apply to this task, extract only those 8
4. **Rephrase for clarity** if needed, but preserve the substance of the requirement
5. **Structure as checkboxes grouped by source:**

**Template:**
```markdown
## Requirements Extracted from Standards

**From [standard-name-1]:**
- [ ] Requirement 1 (specific, verifiable)
- [ ] Requirement 2 (specific, verifiable)
- [ ] Requirement 3 (specific, verifiable)

**From [standard-name-2]:**
- [ ] Requirement 4 (specific, verifiable)
- [ ] Requirement 5 (specific, verifiable)
```

**Why this matters:**
- Executor references requirements during creation → higher first-draft compliance (research shows 87-90% when standards explicit vs ~60% when implied)
- Reviewer uses same requirements as rubric → consistent evaluation
- Both parties share quality expectations → faster convergence, fewer iteration cycles
- Requirements become objective checklist, not subjective judgement

**Common mistakes:**
- Extracting ALL requirements from standard when only subset applies (creates noise)
- Writing vague requirements ("must be good quality" vs "must include 3+ realistic examples")
- Mixing requirements with context or background (keep requirements actionable)
- Forgetting to group by source (makes validation harder)

**Output:** 5-12 checkbox requirements extracted from standards, grouped by source.

### Step 5: Define Constraints and Boundaries

Add specific limits that clarify scope.

**Constraints typically include:**
- **Format** - File type, structure, template (e.g., "Single Markdown file", "JSON schema", "Multi-file package")
- **Length** - Target size or limits (e.g., "200-250 lines", "Under 5 pages", "3-5 examples minimum")
- **Dependencies** - What must exist or be referenced (e.g., "Must reference existing authentication module")
- **Exclusions** - What's explicitly out of scope (e.g., "Does not cover error handling")
- **Technical constraints** - Tools, languages, platforms (e.g., "Python 3.10+", "Must work offline")

**Template:**
```markdown
## Constraints

- Format: [Specific format requirement]
- Length: [Target or range]
- Dependencies: [What must exist or be used]
- Out of scope: [What's explicitly excluded]
```

**Keep this minimal** — typically 3-6 constraints. If you have more, the scope may be unclear or too broad.

**Focus on WHAT is required, not HOW to achieve it** — Unless there's a specific constraint (e.g., "must use existing authentication library"), let the executor determine the approach.

**Output:** Clear scope boundaries that prevent misunderstandings.

### Step 6: Define Measurable Success Criteria

State how to verify the brief is satisfied.

**Good success criteria are:**
- **Measurable** - Can be checked objectively (GOOD: "QA can test all endpoints without questions" / PROBLEMATIC: "Documentation is comprehensive")
- **Outcome-focused** - State what's achieved, not how (GOOD: "Developer can integrate in under 30 minutes" / PROBLEMATIC: "Guide includes step-by-step instructions")
- **Verifiable by requester** - The person who asked can check it (GOOD: "All requirements from standards met" / PROBLEMATIC: "Code follows best practices")

**Remember the outcomes principle** — Success criteria should describe the achieved state, not the implementation method. Let the executor determine the path.

**Template:**
```markdown
## Success Criteria

The deliverable is complete when:
1. [Specific, measurable outcome]
2. [Another measurable outcome]
3. All requirements from standards are met (always include this as final criterion)
```

**Typically 2-4 criteria** — one covering the core outcome, one covering compliance, optionally 1-2 covering specific concerns.

**Output:** 2-4 verifiable success statements.

### Step 7: Include References and Add Context

Provide references to materials the executor needs, then add any additional context.

**References are mandatory when provided** — If the orchestrator gave you relevant skills, previous research, existing artefacts, or examples, you MUST include them. They're not optional nice-to-haves; they're inputs the executor needs.

**Template:**
```markdown
## References

**Skills:** [Path to skill files that inform this work]
**Previous work:** [Path to research files, earlier versions, related artefacts]
**Examples:** [Path to reference implementations or templates]
**Background materials:** [Any other relevant resources]

## Context

**Research findings:** [Link to research file if relevant]
**Background decisions:** [Choices already made that constrain the approach]
**Known risks:** [Issues or challenges the executor should anticipate]
```

**Context guidance:**
- Include background information the executor needs but might not have
- Don't assume they've read previous work — summarise key points or link to files
- State decisions already made that affect the approach
- Highlight risks or challenges to anticipate
- Apply "Just Barely Good Enough" principle — include what's needed, omit speculation

**What NOT to include:**
- Speculation ("the user might want...")
- Obvious information ("code should be readable")
- Disguised requirements (put those in requirements section)
- "Nice to know" information — only "need to know"

**Output:** References section with mandatory materials; Context section with 2-5 bullet points of directly relevant background, or omit Context entirely if none exists.

### Step 8: Establish Common Understanding (Validation)

Before considering the brief complete, validate it creates shared understanding.

**Self-review questions:**
- If the requester reads this brief, will they recognise it as capturing their intent?
- If the executor reads this brief, can they start work without clarification questions?
- Does the WHY section explain purpose clearly enough that the executor understands the bigger picture?
- Is the audience specified so the executor knows who they're creating for?
- Are success criteria measurable by someone other than the executor?
- Are requirements specific enough to be checkboxes (not interpretive guidelines)?
- Are constraints realistic and necessary (not aspirational or nice-to-haves)?
- Are references included for all materials the orchestrator provided?
- Is context sufficient that the executor doesn't need to assume background knowledge?

**If validation reveals gaps:**
- Ambiguous requirements → Clarify with requester or make reasonable assumptions (document them)
- Unmeasurable success criteria → Rephrase to be objective and verifiable
- Unclear scope → Add explicit boundary constraints
- Missing purpose → Add or strengthen WHY section
- Missing context → Add background the executor needs
- Solution prescribed unnecessarily → Rephrase to focus on outcome

**Common understanding principle:** A technically perfect brief that doesn't match what was requested is a failure. The brief succeeds when both requester and executor recognise it as correct.

**Output:** Validated brief ready for handoff to executor.

## Template

Use this structure for most briefs (adapt as needed):

```markdown
# Brief: [Task Name]

**Created:** YYYY-MM-DD
**Objective:** [One sentence outcome that's verifiable]
**Audience:** [Who will use the deliverable]
**Applicable Standards:** [Standards/skills that define quality]

## Why

[2-4 sentences explaining why this work matters, where it fits in the bigger picture, and what problem it solves or goal it serves]

## Requirements Extracted from Standards

**From [standard-name-1]:**
- [ ] Requirement 1 (specific, verifiable)
- [ ] Requirement 2 (specific, verifiable)
- [ ] Requirement 3 (specific, verifiable)

**From [standard-name-2]:**
- [ ] Requirement 4 (specific, verifiable)
- [ ] Requirement 5 (specific, verifiable)

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

**Research findings:** [Link if applicable]
**Background decisions:** [Constraints from previous work]
**Known risks:** [Challenges to anticipate]
```

## Examples

### Example 1: Problematic Brief (Lacks Requirements Extraction and Context)

```markdown
# Brief: API Documentation

**Created:** 2026-02-04
**Objective:** Create API documentation for the authentication service
**Applicable Standards:** writing-skills, api-style-guide

## Requirements

- Must be comprehensive
- Include examples
- Follow best practices
- Be easy to understand

## Constraints

- Cover all endpoints
- Include authentication details

## Success Criteria

The documentation is complete when it meets professional standards.
```

**What's wrong:**
- No WHY section — executor doesn't know why this matters or where it fits
- No Audience specified — unclear who will use the documentation
- Requirements are vague aspirations ("comprehensive", "best practices") not extracted from standards
- No checkbox format → can't be verified objectively
- Success criteria is unmeasurable ("professional standards")
- Constraints are vague ("all endpoints" — how many? which ones?)
- No references provided even though applicable standards exist
- Assumes executor knows background context
- Requester and executor will have different interpretations of "comprehensive"

**Impact:** Executor guesses what quality means, reviewer has no shared rubric, iteration never converges. Executor might build technically correct documentation for the wrong purpose or audience.

### Example 2: Effective Brief (Requirements Extracted, Purpose Clear)

```markdown
# Brief: Authentication API Documentation

**Created:** 2026-02-04
**Objective:** Produce API documentation for authentication service that enables QA to test all endpoints without clarification questions
**Audience:** QA team (will use for testing)
**Applicable Standards:** writing-skills, api-style-guide

## Why

Our QA team currently tests authentication endpoints using informal Slack documentation, leading to repeated clarification questions and test gaps. This documentation will provide a single source of truth that enables independent testing, reducing developer interruptions and improving test coverage. This is part of our initiative to formalise all API documentation ahead of the v2.0 release.

## Requirements Extracted from Standards

**From api-style-guide:**
- [ ] Each endpoint documented with HTTP method, path, and one-sentence description
- [ ] Request/response examples use realistic data (no foo/bar placeholders)
- [ ] Authentication requirements stated explicitly for each endpoint
- [ ] All error codes documented with example responses
- [ ] Rate limiting behaviour explained with specific limits

**From writing-skills:**
- [ ] Clear headings organise content hierarchically
- [ ] Examples precede abstractions (show code before explaining theory)
- [ ] Technical terms defined on first use
- [ ] Both success and error scenarios covered in examples

## Constraints

- Format: Single Markdown file
- Scope: 4 endpoints only (login, logout, refresh-token, validate-session)
- Length: 300-400 lines target
- Out of scope: Admin endpoints, password reset flow (separate documentation)

## Success Criteria

The deliverable is complete when:
1. QA can test all 4 endpoints using only the documentation (no verbal questions)
2. All error scenarios have concrete examples (not just error code lists)
3. All requirements from standards are met

## References

**Skills:** /path/to/writing-skills/SKILL.md, /path/to/api-style-guide.md
**Examples:** /internal-docs/billing-api-docs.md (follows our style)

## Context

**Background:** This replaces informal Slack documentation currently used by QA. Previous attempt was too technical for QA's needs (written for developers).
**Known risks:** Authentication flow has edge cases around token expiry that need clear examples.
```

**Why this works:**
- WHY section establishes purpose (replace Slack docs, support v2.0 release) and context (QA needs, not developer needs)
- Audience explicitly specified (QA team) which informs requirements and tone
- Requirements extracted from standards create objective checklist (9 specific checkboxes)
- Success criterion #1 is measurable (QA tests independently)
- Scope explicitly bounded (4 endpoints, exclusions stated)
- Objective is verifiable (enables QA testing without questions)
- References provided to both skills and examples
- Context explains background (previous attempt failed, why) and risks
- Requester can read this and verify it captures intent
- Executor can start immediately with clear quality target and no assumed context

**Impact:** Research shows 87-90% first-draft compliance when requirements explicit vs ~60% when implied. Fewer iteration cycles, faster convergence. Executor understands purpose and builds for correct audience.

### Example 3: Research Brief (Same Methodology, Clear Purpose)

```markdown
# Brief: Progressive Disclosure Patterns Research

**Created:** 2026-02-04
**Objective:** Investigate how other CLI tools structure help documentation to inform our skill progressive disclosure design
**Audience:** Orchestrator (will use findings to decide skill structure approach)
**Applicable Standards:** conducting-research

## Why

Our skills are growing long (400+ lines) which creates discoverability problems — agents and users can't quickly find relevant sections. We need proven patterns for splitting content while maintaining usability. This research will identify 3-5 concrete patterns we can evaluate for our skill structure, supporting our Q1 goal of improving skill ergonomics.

## Requirements Extracted from Standards

**From conducting-research:**
- [ ] Research question stated clearly (appears in Research Question section)
- [ ] Success criteria defined before research begins
- [ ] At least 5 diverse sources examined (mix of documentation, tools, articles)
- [ ] Findings backed by evidence (quotes, screenshots, examples)
- [ ] Patterns synthesised across sources (not just list of findings)
- [ ] Actionable recommendations with specific application to our context
- [ ] Sources documented with titles and URLs

## Constraints

- Scope: CLI documentation tools only (not web documentation systems)
- Focus: Progressive disclosure patterns (not general help design)
- Time limit: 2-3 hours maximum research time
- Out of scope: GUI help systems, chatbot documentation

## Success Criteria

The research is complete when:
1. At least 3 distinct progressive disclosure patterns identified with concrete examples
2. Each pattern has evidence from multiple tools (not single-source patterns)
3. Recommendations specify which pattern applies to our skill structure and why

## References

**Skills:** /path/to/conducting-research/SKILL.md
**Current state:** /path/to/writing-skills/SKILL.md (the 400-line skill we're improving)

## Context

**Background:** Current skills use single-file structure. User feedback shows difficulty finding specific guidance. We tried table of contents but it didn't solve discoverability.
**Known risks:** CLI tools may use interactive patterns we can't implement in static Markdown.
```

**Why this works:**
- WHY section explains the problem (400-line skills, discoverability issues), context (Q1 goal), and purpose (evaluate patterns for skill structure)
- Audience specified (orchestrator will make decisions based on findings)
- Same requirements-extraction methodology applied to research task
- Scope bounded (CLI only, progressive disclosure focus)
- Success criteria are measurable (3 patterns, multiple sources per pattern)
- Research question is verifiable (can check if answered)
- References include both the research skill AND the current skill being improved
- Context provides background (tried TOC, didn't work) and risks (interactive patterns may not apply)
- No assumed context — executor knows the full picture

**Key insight:** Briefing craft is consistent across artefact and research types — extract requirements from applicable standard, establish measurable success, provide purpose and audience clarity, don't assume context.

## Edge Cases and Variations

### Multiple Conflicting Standards

If standards conflict (e.g., one requires examples-first, another requires theory-first):

1. **Note the conflict in Context section:**
   ```markdown
   **Standards conflict:** writing-skills requires examples-first, but domain-guide
   requires conceptual overview first.
   ```

2. **Propose resolution based on artefact type and audience:**
   ```markdown
   **Resolution:** Use examples-first for this brief because audience is practitioners
   learning by doing (aligns with writing-skills principle).
   ```

3. **Request clarification if resolution unclear:**
   "Standards X and Y conflict on ordering. Should we prioritise practitioner learning (examples-first) or conceptual foundation (theory-first)?"

### No Formal Standards Exist

If no Skills or style guides apply:

1. **State explicitly in Applicable Standards:**
   ```markdown
   **Applicable Standards:** None (no formal standards exist for this artefact type)
   ```

2. **Create quality expectations based on best practices:**
   ```markdown
   ## Quality Expectations (No Formal Standards)

   Based on general best practices for [artefact type]:
   - [ ] Clear structure with logical flow
   - [ ] Concrete examples for each abstract concept
   - [ ] Consistent formatting and terminology
   - [ ] Accessible to target audience (define audience)
   ```

3. **Label them "Quality Expectations" not "Requirements"** to signal they're derived, not extracted.

### Research Already Conducted

If research file exists before briefing:

1. **Include in References section:**
   ```markdown
   ## References

   **Previous work:** /path/to/research_v1.md
   ```

2. **Summarise key findings in Context:**
   ```markdown
   **Research findings:** research_v1.md identified 3 distinct patterns (single-file,
   multi-file with TOC, multi-file with index). Recommendation is multi-file with
   index for our use case.
   ```

3. **Extract quality requirements if research identified them:**
   If research revealed quality criteria (e.g., "surveyed tools all include X feature"), add to requirements.

4. **Keep summary to 2-4 bullet points** — link to research file for full details.

### Iterating on Existing Artefact

If updating artefact_v2.md → v3.md based on review_v2.md:

1. **Update WHY section if purpose has evolved:**
   Explain why the iteration is happening and how it serves the original goal.

2. **Include review in References:**
   ```markdown
   ## References

   **Previous version:** /path/to/artefact_v2.md
   **Review:** /path/to/review_v2.md
   ```

3. **Add "Changes from Previous Version" section:**
   ```markdown
   ## Changes from v2

   Based on review_v2.md feedback:
   - Add 2 missing evaluation scenarios (critique identified gap)
   - Clarify Step 3 workflow (was ambiguous about ordering)
   - Fix 3 examples that used foo/bar placeholders
   ```

4. **Keep original requirements; add new ones if standards evolved:**
   Don't remove requirements that still apply. Add new requirements if review revealed missing standards compliance.

5. **Update success criteria to reflect iteration goal:**
   ```markdown
   ## Success Criteria

   The deliverable is complete when:
   1. All 5 priority fixes from review_v2 addressed
   2. All requirements from standards met (including newly added ones)
   3. Previous strengths preserved (don't break what worked)
   ```

### Vague or Incomplete Request

If request lacks critical information:

1. **Don't guess — ask targeted questions:**
   - "You mentioned 'documentation' — does that mean user-facing guides, API reference, or internal developer docs?"
   - "What's the primary audience — beginners or experienced users?"
   - "Should this cover error handling, or can we exclude that?"
   - "Why are we doing this now? Where does this fit in the broader project?"

2. **Make reasonable assumptions explicit:**
   ```markdown
   ## Context

   **Assumptions:** (confirmed with requester)
   - Target audience: intermediate developers (not beginners)
   - Format: Markdown (not HTML or PDF)
   - Maintenance: Will be updated quarterly (not static)
   ```

3. **Validate assumptions in brief validation step** (Step 8) — requester reviews and confirms.

## Evaluation Scenarios

### Scenario 1: Transforming Vague Request into Actionable Brief

**Trigger:** Requester says "I need better documentation for the deployment process"

**Expected outcome:**
- Brief includes WHY section explaining why documentation is needed and what problem it solves
- Audience specified (developers? ops team? new hires?)
- Objective clarifies what "better" means by extracting requirements from documentation standards
- Scope defines which deployment (staging, production, or both)
- Success criteria are measurable (e.g., "New team member can deploy without help")
- Constraints specify format, length, tone
- References include relevant documentation standards and examples
- Context provides background (e.g., "current docs outdated, causing failed deploys")
- Requester reads brief and confirms it captures intent

**Good vs Problematic:**
- GOOD: WHY section establishes purpose and context; audience specified; brief transforms vague "better" into 8 specific checkboxes extracted from standards; scope explicitly bounded; measurable success; references provided
- PROBLEMATIC: No WHY or audience; brief repeats vague request ("create better docs"); no requirements extraction; unmeasurable success criteria; assumes reader knows context

### Scenario 2: Handling Multi-Standard Artefact

**Trigger:** Requester says "Create a workflow guide for onboarding engineers"

**Expected outcome:**
- WHY section explains why onboarding workflow needed (e.g., "new hires take 3 weeks to contribute, need to reduce to 1 week")
- Audience specified (new engineers? hiring managers?)
- Brief identifies multiple applicable standards (writing-skills for structure, onboarding-standards if exists, workflow for versioning)
- Requirements extracted from EACH standard, grouped separately
- No duplicate requirements across standards
- If standards conflict, conflict noted with proposed resolution
- All requirements checkbox format for objective verification
- References section includes all applicable standards
- Context explains current state and why it's insufficient

**Good vs Problematic:**
- GOOD: WHY and audience clear; requirements clearly grouped by source (From writing-skills: [...], From onboarding-standards: [...]); conflicts addressed explicitly; references complete; no assumed context
- PROBLEMATIC: No WHY or audience; requirements mixed without attribution; vague "follow all standards" without extraction; no conflict handling; assumes reader knows onboarding problems

### Scenario 3: Creating Research Brief with Clear Boundaries

**Trigger:** Requester says "Research how other tools handle this"

**Expected outcome:**
- Brief clarifies what "this" means specifically (progressive disclosure, error handling, etc.)
- WHY section explains why research is needed and how findings will be used
- Audience specified (who will use the research findings?)
- Research question stated clearly
- Scope bounded (which tools, which aspects, time limit)
- Success criteria measurable (e.g., "At least 3 patterns identified with examples from 2+ tools each")
- Requirements extracted from conducting-research skill
- References include research skill and any existing context
- Context provides background (e.g., "tried approach X, didn't work, need alternatives")

**Good vs Problematic:**
- GOOD: WHY explains purpose and usage of findings; audience specified; specific research question; bounded scope (CLI tools, progressive disclosure focus); measurable success (3 patterns, multiple sources); references complete; background context provided
- PROBLEMATIC: No WHY or audience; vague research goal ("see what others do"); no scope boundaries; unmeasurable success ("comprehensive understanding"); no references; assumes reader knows what problem we're solving

### Scenario 4: Iterating Based on Review Feedback

**Trigger:** Requester says "Update the creating-briefs skill based on the critique — it was written for the wrong audience"

**Expected outcome:**
- WHY section explains the iteration purpose (audience mismatch needs correction, supports agent orchestration workflow)
- Audience explicitly stated (was orchestrator, should be briefer-agent)
- Brief captures the core issue (audience mismatch)
- Scope defines what to preserve (requirements extraction methodology, examples) vs what to reframe (remove orchestrator concerns)
- Success criteria verifiable (orchestrator reads it and confirms it's for briefer agent now)
- Constraints specify what NOT to change (length target, structure, evaluation scenarios)
- References include both previous version AND the review
- Context explains why audience mismatch occurred and what led to the iteration

**Good vs Problematic:**
- GOOD: WHY explains iteration purpose; audience shift explicit; clear scope (reframe audience, preserve core content); explicit preservation constraints; measurable success (orchestrator validates audience correct); references complete; context provided
- PROBLEMATIC: No WHY for iteration; audience ambiguous; full rewrite without preservation guidance; vague "make it better"; no validation criteria; missing references; assumes reader knows review findings

## Success Indicators

A brief created with this skill succeeds when:

1. **Common understanding achieved** - Requester reads brief and confirms "yes, this captures my intent"
2. **Purpose is clear** - Executor understands why the work matters and where it fits in the bigger picture
3. **Audience is specified** - Executor knows who they're creating for and can tailor appropriately
4. **Executor can start immediately** - No clarification questions needed before beginning work
5. **First draft compliance is high** - Executor delivers 85%+ standards compliance on v1 (research shows 87-90% when requirements explicit)
6. **Review focuses on refinement** - Reviewer addresses gaps and polish, not fundamental rework
7. **Iteration converges quickly** - Task completes within 2-3 cycles (not indefinite back-and-forth)
8. **Success criteria are measurable** - Third party can verify completion objectively
9. **Requirements become shared rubric** - Both executor and reviewer reference same checklist
10. **No context is assumed** - Executor can complete work without background knowledge

Track these indicators to validate briefing quality and identify skill improvement opportunities.

The briefing craft is not about producing lengthy specifications — it's about creating just enough clarity to enable shared understanding and successful execution, while explicitly stating purpose, audience, and context that might otherwise be assumed.
