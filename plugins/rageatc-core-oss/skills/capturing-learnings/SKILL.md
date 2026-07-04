---
name: capturing-learnings
description: Extracts learnings from completed work. Use when capturing lessons learned, analysing what went wrong or what went right, conducting root cause analysis, or creating improvement proposals for skills or workflows.
---

# Capturing Learnings

## Purpose

Systematically extract insights from completed work that are rooted in actual causes, actionable, and accessible. This Skill guides learner-agent through a structured process to convert iteration experiences into specific improvement proposals that prevent repeating mistakes and reinforce successes.

## When to Use

Use this Skill when:
- Producer-Critic iterations have completed or reached a checkpoint
- You need to extract learnings from work that didn't meet quality bar
- Identifying patterns across multiple iterations that suggest systemic issues
- Documenting successful approaches that should be replicated
- Creating improvement proposals for Skills, agents, or workflows
- Analysing gaps between expected and actual outcomes

Trigger phrases:
- "Extract learnings from this task"
- "What did we learn from these iterations?"
- "Document lessons from this work"
- "Create learning proposals"
- "Analyse what went wrong"
- "Identify system improvements"

## Quick Start

For rapid orientation, the core workflow is:

1. **Establish expected outcomes** - Read brief.md, note what should have happened, document standards and success criteria
2. **Document actual outcomes** - Review all artefact and review versions, objectively record what did happen, track timeline
3. **Analyse gaps and root causes** - Compare expected vs actual, apply Five Whys or Fishbone, identify systemic factors (not just symptoms)
4. **Identify actionable improvements** - Specify SMART changes (Specific, Measurable, Achievable, Relevant, Time-bound) with ownership and timelines
5. **Plan implementation and verification** - Define how to apply changes, track in backlog, specify success measures

**SMART reminder:** Every learning must specify What changes, Who implements, When deadline, How measured, Why relevant.

**Quality checkpoint:** Use the 12-point checklist (see Quality Checklist section) to verify each learning before finalising.

For detailed guidance on each step, root cause analysis methods, layered documentation, and examples, continue reading below.

## Required Knowledge About the Workflow

This Skill is for **extracting** learnings only, not applying them. Learner-agent uses this Skill to create improvement proposals that humans review and approve. Separate Skills handle applying learnings to Skills, agents, or workflows.

The Producer-Critic-Learner workflow operates in phases:
1. Producer creates artefacts (v1, v2, v3, ...)
2. Critic reviews each version and provides feedback
3. Producer iterates based on feedback
4. **Learner extracts insights** (this Skill) after iterations complete or at checkpoints
5. Human approves improvement proposals
6. Changes are implemented (separate workflow)

## Inputs Required

Before starting, verify you have:

**Always required:**
- [ ] Task directory path (e.g., `/path/to/work/<task-id>/`)
- [ ] Access to all artefact versions (`artefact_v1.md`, `artefact_v2.md`, etc.)
- [ ] Access to all review versions (`review_v1.md`, `review_v2.md`, etc.)
- [ ] Access to the brief (`brief.md`) defining original requirements

**Optional but helpful:**
- [ ] Research files if background research was conducted
- [ ] Previous learning proposals from related tasks
- [ ] Relevant Skill or agent files that may need updating

**Validation behaviour:**
If required inputs are missing, STOP and request them before proceeding.

## Outputs Produced

Save the learning report to the output path provided by the orchestrator. Default convention: `work/<task-id>/learning_proposals.md`.

The learner-agent reads project LEARNINGS.md as input (along with iteration history, orchestration logs, etc.) but does not append quick observations to it. Its output is a structured analysis report. After the report is reviewed, the orchestrator may update LEARNINGS.md with consolidated findings.

**Structure:**
1. Summary section (quick reference)
2. Detailed learnings with full analysis
3. Implementation recommendations

Each learning includes:
- What happened (gap between expected and actual)
- Root cause analysis (why it happened)
- Actionable improvement (specific change with SMART criteria)
- Ownership and timeline (who implements, when)
- Success measure (how to verify)

## Core Methodology: 5-Step Process

### Overview

This methodology adapts military After Action Review (AAR) principles validated across high-reliability industries:

1. **Establish expected outcomes** → What should have happened?
2. **Document actual outcomes** → What did happen?
3. **Analyse gaps and root causes** → Why did differences occur?
4. **Identify actionable improvements** → What specific changes will help?
5. **Plan implementation and verification** → Who, when, how to confirm?

Each step builds on the previous, moving from observation to action.

### Step 1: Establish Expected Outcomes

**Goal:** Define the desired state before analysing what went wrong.

**Actions:**
1. Read `brief.md` to understand:
   - Original requirements and success criteria
   - Relevant Skills or standards that applied
   - Constraints and context
   - Quality expectations

2. Identify expected outcomes at multiple levels:
   - **Artefact quality**: What standards should it meet?
   - **Process efficiency**: How smooth should iterations be?
   - **Requirements fulfilment**: What functionality was needed?
   - **Workflow adherence**: What process was expected?

3. Document explicitly:
   - "According to the brief, the artefact should..."
   - "The relevant Skill (X) specifies..."
   - "Success criteria stated..."

**Output:** Clear statement of what ideal execution would look like.

**Common pitfall:** Don't let knowledge of actual outcomes bias this step. Document expectations as they existed at task start, not in hindsight.

### Step 2: Document Actual Outcomes

**Goal:** Objectively capture what happened without interpretation.

**Actions:**
1. Review all artefact versions chronologically:
   - Read `artefact_v1.md`, `artefact_v2.md`, etc.
   - Note what was delivered in each version
   - Track how the artefact evolved

2. Review all critique feedback:
   - Read `review_v1.md`, `review_v2.md`, etc.
   - Note gaps Critic identified
   - Track which issues persisted across versions

3. Document objectively:
   - "Artefact v1 included X but lacked Y"
   - "Review v1 identified gaps in Z"
   - "After 3 iterations, issue W remained"
   - "Process required N iterations to reach quality bar"

4. Capture timeline:
   - When were issues first detected?
   - How long did specific problems persist?
   - What was knowable at each decision point?

**Output:** Factual record of what occurred, free from interpretation or judgement.

**Key principle:** Start timeline analysis before the problem and work forward. This avoids hindsight bias by preserving the decision context that existed at each point.

### Step 3: Analyse Gaps and Root Causes

**Goal:** Understand why differences occurred between expected and actual outcomes.

#### 3a. Gap Analysis

Use the four AAR questions:

1. **What was supposed to happen?** (from Step 1)
2. **What actually happened?** (from Step 2)
3. **Why did differences occur?** (analyse next)
4. **What should we sustain or improve?** (in Step 4)

Compare actual vs expected at multiple levels:
- Artefact quality gaps
- Process efficiency gaps
- Requirements fulfilment gaps
- Workflow adherence gaps

**Document clearly:**
```
Expected: [Specific standard or requirement]
Actual: [What was delivered]
Gap: [Clear statement of difference]
```

#### 3b. Root Cause Analysis

**Critical distinction:** Symptoms vs root causes.
- **Symptom:** Observable problem (e.g., "The code had bugs")
- **Root cause:** Underlying systemic factor (e.g., "We lack automated testing")

**For routine learnings**, use Five Whys:
1. State the problem
2. Ask "Why did this occur?"
3. For each answer, ask "Why?" again
4. Repeat 5 times (or until reaching fundamental cause)
5. Final "why" reveals root cause

**Example:**
```
Problem: Brief was unclear
Why? → Missing acceptance criteria
Why? → Brief template doesn't require them
Why? → Template created before we understood their importance
Why? → No feedback loop from Critic to template improvements
Why? → Learning extraction process wasn't systematic

Root cause: Lack of systematic learning capture and application
```

**For complex or repeated issues**, add Fishbone analysis:
1. Draw "fish head" with the problem
2. Add major cause categories as "bones":
   - People (skills, knowledge, training)
   - Process (workflows, standards, procedures)
   - Equipment (tools, agents, automation)
   - Materials (inputs, references, context)
   - Environment (constraints, pressures, culture)
   - Management (oversight, governance, priorities)
3. Within each category, brainstorm potential causes
4. Apply Five Whys to promising branches

**Systems thinking questions** (for significant patterns):
- What feedback loops enabled this problem?
- What structures or incentives made this likely?
- Is this a reinforcing problem that gets worse over time?
- What unintended consequences might our solution create?
- Are there delays between cause and effect we're missing?

**Avoiding hindsight bias:**
- Focus on what was knowable at decision points, not what is obvious now
- Avoid "should have known" framing
- Ask: "What systemic factors made this likely?" not "Who made mistakes?"
- Include diverse perspectives to challenge assumptions

**Output:** Clear statement of root causes with supporting evidence.

### Step 4: Identify Actionable Improvements

**Goal:** Convert insights into specific changes that will be implemented.

**Critical distinction:**
- **Lessons identified** (observations): "Communication needs improvement"
- **Lessons learned** (specified changes): "Add daily 15-minute sync at 10am starting Monday"

Only the second is actionable.

#### Apply SMART Criteria

Every learning must be:

**Specific:** What exactly will change?
- Not: "Improve brief quality"
- But: "Add mandatory 'Acceptance Criteria' section to brief template"

**Measurable:** How will you know it worked?
- Not: "Better documentation"
- But: "Critic no longer flags missing acceptance criteria"

**Achievable:** Is this realistic given constraints?
- Consider: Available resources, agent capabilities, time required
- Avoid: Changes requiring unrealistic effort or unknown capabilities

**Relevant:** Does this address a root cause?
- Link explicitly: "This addresses [root cause] identified in Step 3"
- Explain: "This prevents [problem] by [mechanism]"

**Time-bound:** When will it be implemented?
- Set deadline: "By end of current task cycle"
- Or: "Before next artefact of this type"
- Or: "In next quarterly Skills review"

#### Format Template

Use this structure for each actionable learning:

```markdown
### Learning N: [Brief Title]

**Gap:**
- Expected: [What should have happened]
- Actual: [What did happen]
- Difference: [Clear statement of gap]

**Root Cause:**
[Explanation from Step 3, with evidence]

**Actionable Improvement:**
[Specific change] will be implemented by [owner] by [date].
Success measured by [observable outcome].

**Why This Helps:**
This addresses [root cause] and prevents [problem] by [mechanism].

**Implementation Details:**
- Owner: [Which agent, Skill, template, or human role]
- Timeline: [Specific deadline or milestone]
- Verification: [How to confirm the change was applied]
- Priority: [Critical / High / Medium / Low]

**Alternatives Considered:**
[Other approaches and why this was chosen]
```

#### Ownership Assignment

Specify clearly who implements:
- **Skill change:** "Update `writing-skills` Skill, section X"
- **Agent change:** "Modify `producer-agent.md`, add Step Y"
- **Template change:** "Update brief template in `creating-briefs` Skill"
- **Workflow change:** "Orchestrator to add checkpoint after Step Z"
- **Human process:** "User to approve all X before Y"

#### Prioritisation

Use impact and frequency:
- **Critical:** High impact, high frequency (implement immediately)
- **High:** High impact, low frequency OR low impact, high frequency
- **Medium:** Medium impact, medium frequency
- **Low:** Low impact, low frequency (consider batching)

### Step 5: Plan Implementation and Verification

**Goal:** Ensure learnings don't remain "lessons identified" but become "lessons implemented."

**For each learning:**

1. **Implementation approach:**
   - What concrete steps will apply this change?
   - What dependencies exist?
   - What risks or side effects might occur?

2. **Ownership handoff:**
   - If you're proposing changes to Skills/agents, note that human must approve
   - If human must change behaviour, make this explicit
   - If automation is needed, specify what

3. **Verification method:**
   - How will we confirm the learning was applied?
   - What observable change indicates success?
   - When will we check?

4. **Tracking:**
   - Add to `learnings/backlog.md` for human review
   - Link to source task: `work/<task-id>/`
   - Reference artefact and review versions as evidence

**Output:** Implementation plan with clear next steps.

## Thoroughness vs Accessibility: Layered Architecture

Balance comprehensive analysis with usability through three layers.

### Layer 1: Quick Reference (Always Include)

Essential information for immediate action:

```markdown
## Summary

**Task:** [Brief description]
**Outcome:** [Success/partial/blocked and why]
**Iterations:** [N versions to reach quality bar]
**Key Learnings:** [2-3 sentence summary]

### Top 3 Actionable Improvements

1. [Brief action] - Owner: [X] - By: [Date]
2. [Brief action] - Owner: [Y] - By: [Date]
3. [Brief action] - Owner: [Z] - By: [Date]
```

This layer should be readable in 30 seconds and provide enough context to decide whether to read further.

### Layer 2: Detailed Analysis (Include for Skill/Process Changes)

Full context for understanding and decision-making:

```markdown
## Detailed Learnings

[For each learning, use the format from Step 4, including:]
- Gap analysis (expected vs actual)
- Root cause reasoning with evidence
- SMART actionable improvement
- Implementation details
- Alternatives considered
- Why this addresses the root cause
```

This layer provides the evidence and reasoning needed to:
- Evaluate whether the proposed change is correct
- Understand trade-offs
- Adapt the learning to other contexts

### Layer 3: Supporting Evidence (Include for Significant Patterns)

Deep context for organisational memory:

```markdown
## Appendix: Supporting Evidence

### Timeline of Events
[Chronological sequence showing when issues appeared, decisions made, etc.]

### Related Incidents
[Links to similar issues in other tasks]

### Quantitative Data
[If applicable: how many iterations, time spent, frequency of issue]

### References
[Links to relevant Skills, standards, or external resources]

### Systemic Factors Identified
[Broader patterns that suggest organisational or process issues]
```

This layer enables:
- Future teams to understand context years later
- Identification of cross-cutting patterns
- Research into systemic improvements

### Calibration Guidance

**Choose depth based on scope and audience:**

| Type | Layers | Rationale |
|------|--------|-----------|
| Routine improvement within task | 1 | Team has shared context; focus on action |
| Skill or agent change proposal | 1 + 2 | Need rationale for human approval |
| Repeated pattern across tasks | 1 + 2 + 3 | Organisational memory and systemic analysis |
| Significant failure or breakthrough | 1 + 2 + 3 | Full documentation for learning |

**Default:** Include Layer 1 always. Add Layer 2 if proposing Skill/agent changes. Add Layer 3 if issue repeated across multiple tasks or had significant impact.

## Quality Checklist

Evaluate captured learnings against these 12 checkpoints organised into key themes:

### Root Cause Identification (3 checkpoints)
- [ ] Analysis goes beyond symptoms to underlying systemic factors
- [ ] Five Whys or equivalent RCA method applied and documented
- [ ] Systemic factors identified (not just individual errors or one-off issues)

### Gap Analysis (4 checkpoints)
- [ ] Expected outcome/standard explicitly stated (from brief or standards)
- [ ] Actual outcome objectively documented (from artefact versions and reviews)
- [ ] Comparison clearly shows specific gaps
- [ ] Analysis avoids hindsight bias (considers what was knowable at the time)

### Actionability (4 checkpoints)
- [ ] Learning specifies SMART action (Specific, Measurable, Achievable, Relevant, Time-bound)
- [ ] Clear ownership assigned (which agent, Skill, template, or human role)
- [ ] Implementation timeline specified (specific deadline or milestone)
- [ ] Success criteria defined (how to verify the learning was applied)

### Quality and Culture (1 checkpoint)
- [ ] Blame-free framing (focuses on systems and processes, not individual mistakes)

**Total: 12 checkpoints**

**Note on checklist format:** These 12 checkpoints are organised into thematic categories to improve usability whilst maintaining the precise count specified in research. The categories help learner-agent systematically evaluate each dimension of learning quality.

**How to use this checklist:**
1. Review each learning proposal against all 12 points
2. If any checkpoint fails, return to the relevant step and strengthen
3. Don't proceed to output until all critical checkpoints pass
4. Document which checkpoints required iteration (this is itself a learning)

## Common Pitfalls and Prevention

### Pitfall 1: Stopping at Symptoms

**Problem:** Identifying surface-level issues without uncovering underlying causes.

**Example:**
- Symptom: "Producer made formatting errors"
- Root cause: "Skill lacks formatting checklist" or "No validation step before output"

**Why it happens:** Surface symptoms are visible; root causes require deeper analysis and may be temporally distant from symptoms.

**Prevention:**
- Always apply Five Whys, even if answer seems obvious
- Ask: "What systemic factors made this likely?"
- Ask: "Would this prevent recurrence in different contexts?"
- If answer is "just be more careful," you haven't found the root cause

### Pitfall 2: Hindsight Bias

**Problem:** Judging past decisions based on outcome knowledge, making issues seem predictable.

**Example:**
- Biased: "Producer should have known to check X"
- Unbiased: "X wasn't in the brief or Skill guidance, so Producer reasonably missed it"

**Why it happens:** Knowing the outcome makes past events seem more predictable. "The fundamental form of hindsight bias is: I knew it all along."

**Prevention:**
- Start timeline analysis before the problem and work forward
- Document what information was available at each decision point
- Ask: "What did we know when?" not "What should we have known?"
- Focus on systemic factors: "What made this likely?" rather than individual judgement
- Include multiple perspectives to challenge assumptions

### Pitfall 3: Vague Observations Instead of Actions

**Problem:** Documenting insights without specifying how to implement changes.

**Example:**
- Vague: "Communication needs improvement"
- Actionable: "Add daily 15-minute sync at 10am Monday-Friday, facilitated by PM, using standup template in /templates/"

**Why it happens:** Observation feels like learning; specifying action requires more effort and commitment.

**Prevention:**
- Apply SMART criteria rigorously to every learning
- If you can't answer "Who implements? When? How measured?", it's not actionable yet
- Use the format template from Step 4
- Ask: "Could someone implement this without asking clarifying questions?"

### Pitfall 4: Blame Culture

**Problem:** Fear of blame causes people to hide problems or deflect responsibility, preventing honest learning.

**Example:**
- Blame framing: "Producer failed to read the Skill properly"
- Systems framing: "Skill was 450 lines; key guidance was buried at line 380; no summary section existed"

**Why it happens:** Organisational cultures that punish mistakes create incentives to conceal failures.

**Prevention:**
- Explicitly establish psychological safety: focus on systems, not individuals
- Frame as "what can we learn?" not "who made mistakes?"
- Celebrate failures as "windows into system health" (HRO approach)
- Ask: "What made this error likely?" not "Why did they make this error?"
- Use blame-free language: "The brief lacked X" not "The brief author forgot X"

### Pitfall 5: No Follow-Through

**Problem:** Even when actionable changes are specified, organisations fail to implement them.

**Why it happens:** No ownership, no deadlines, no tracking, competing priorities, learning divorced from implementation authority.

**Prevention:**
- Assign clear ownership to specific individuals, agents, or Skills
- Set realistic deadlines tied to milestones
- Add to tracked backlog (`learnings/backlog.md`)
- Include verification method in the learning itself
- Human reviews and approves before next task begins
- Create feedback loop: next task checks if prior learnings were applied

## Examples

### Example 1: Well-Captured Learning (Meets All Quality Checkpoints)

```markdown
### Learning 1: Brief Template Missing Acceptance Criteria

**Gap:**
- Expected: Artefact should have clear, measurable acceptance criteria (per writing-skills, section "Success Criteria")
- Actual: Artefact v1 lacked acceptance criteria; review v1 flagged this; producer was unsure what constituted "done"
- Difference: No clear success measures defined upfront

**Root Cause (Five Whys):**
1. Why was acceptance criteria missing? → Producer didn't include it
2. Why not? → Brief didn't specify acceptance criteria
3. Why didn't brief specify it? → Brief template doesn't require acceptance criteria section
4. Why not? → Template was created before we understood their importance through iteration
5. Why wasn't template updated? → No systematic process for extracting learnings and updating templates

Root cause: Lack of feedback loop from task learnings back to template improvements

**Actionable Improvement:**
Update brief template in `creating-briefs` Skill to include mandatory "Acceptance Criteria" section with 3-5 measurable checkpoints. Orchestrator to implement by end of current week. Success measured by: (1) template file updated, (2) next 3 briefs include acceptance criteria, (3) critic-agent stops flagging missing criteria.

**Why This Helps:**
This addresses the root cause (missing template requirement) and prevents future artefacts from lacking clear success measures, reducing iterations spent clarifying "done" definition.

**Implementation Details:**
- Owner: Human to update `~/.claude/skills/creating-briefs/SKILL.md`, section "Template"
- Timeline: By 2026-01-17
- Verification: Check next 3 briefs created; all should include acceptance criteria section
- Priority: High (affects all future tasks)

**Alternatives Considered:**
- Train Producer to always add criteria (rejected: relies on memory, not systematic)
- Add to Critic checklist only (rejected: doesn't prevent issue, only detects it)
- Make template flexible (rejected: criteria too important to be optional)
```

**Why this example is good:**
✓ Goes beyond symptom to root cause (5 levels deep)
✓ Expected/actual/gap clearly stated
✓ SMART action (specific template change, clear owner, deadline, success measure)
✓ Blame-free framing (focuses on template, not Producer)
✓ Explains why this helps
✓ Considers alternatives
✓ Practical verification method

### Example 2: Problematic Learning (Fails Multiple Checkpoints)

```markdown
### Learning: Producer needs to be more careful

**Issue:** Producer made mistakes in v1.

**Fix:** Producer should read Skills more carefully and check work before submitting.
```

**Why this example is problematic:**
✗ Stops at symptom ("made mistakes") without identifying root cause
✗ No gap analysis (expected vs actual not stated)
✗ Not actionable (no SMART criteria: what specific change? who implements? when? how measured?)
✗ Blame framing ("needs to be more careful" implies individual fault)
✗ No systemic analysis (what made mistakes likely?)
✗ Vague (which mistakes? what type? in which artefact version?)
✗ No verification method (how to know if "being more careful" worked?)

**How to improve:**
1. Specify which mistakes occurred in which version
2. Identify what guidance was missing or unclear
3. Apply Five Whys to find root cause
4. Propose systemic change (update Skill, add checklist, etc.)
5. Make SMART with owner and timeline
6. Frame as systems issue, not individual failure

### Example 3: Learning with Appropriate Layer Depth

```markdown
## Summary

**Task:** Create capturing-learnings Skill
**Outcome:** Success after 2 iterations
**Iterations:** 2 versions to reach quality bar
**Key Learnings:** Research phase identified comprehensive methodology; initial structure needed minor refinements for accessibility

### Top 3 Actionable Improvements

1. Add research phase to briefing workflow for complex Skills - Owner: creating-briefs skill - By: Next briefing Skill update
2. Include layered architecture guidance in writing-skills - Owner: writing-skills maintainer - By: 2026-01-20
3. Create evaluation scenario library for common Skill types - Owner: Documentation - By: 2026-02-01

---

## Detailed Learnings

### Learning 1: Research Investment Validated

**Gap:**
- Expected: Producer would need to research best practices from multiple domains
- Actual: Research phase conducted, produced comprehensive 650-line document with cross-domain validation
- Difference: No gap; this was a success to sustain

**Root Cause:**
Not applicable (success case). Factor: the brief explicitly included research in the workflow, with a clear research brief.

**Actionable Improvement:**
Update creating-briefs guidance to include "When to commission research" decision tree. For complex Skills or unfamiliar domains, create research_brief.md before artefact brief. Owner to implement in next Skill update cycle by 2026-01-20. Success measured by: next 2 complex Skills include research phase when appropriate.

**Why This Helps:**
Formalising research decision criteria ensures consistent quality for complex artefacts whilst avoiding unnecessary research overhead for routine tasks.

**Implementation Details:**
- Owner: Human to update creating-briefs guidance, add "Research Decision Criteria" section
- Timeline: Next creating-briefs update cycle (2026-01-20)
- Verification: Review next 2 complex Skill creations; check if research phase appropriately included/excluded
- Priority: Medium (improves quality but not blocking)

**Alternatives Considered:**
- Always require research (rejected: overkill for routine tasks)
- Leave to Producer judgement (rejected: inconsistent application)
- Create separate research-commissioning Skill (deferred: may need this if decision tree becomes complex)

---

[Additional learnings follow same format]

---

## Appendix: Supporting Evidence

### Timeline of Events

**2026-01-13 morning:**
- Orchestrator created brief.md with clear requirements extracted from standards
- Brief included research_brief.md for background investigation
- Researcher invoked, produced research_v1.md (650 lines)

**2026-01-13 afternoon:**
- Producer read brief, research findings, and applicable Skills
- Producer created artefact_v1.md (first draft)
- Critic reviewed v1 (hypothetical, for this example)

### Related Incidents

- Task: creating-agents (2025-12-15) - Also benefited from research phase
- Task: writing-skills-v2 (2025-11-20) - No research phase; required more iterations

### Quantitative Data

- Iterations required: 2 (below average of 3 for complex Skills)
- Time investment: Research (2 hrs) + Production (1.5 hrs) = 3.5 hrs total
- Comparable tasks without research: Average 4.5 hrs with more iterations

### Systemic Factors Identified

- Research investment upfront reduces iteration cycles
- Clear brief structure (extracted requirements) streamlines production
- Layered architecture principle appears valuable across multiple Skill types
```

**Why this example demonstrates good layer use:**
✓ Layer 1 (Summary) provides 30-second overview
✓ Layer 2 (Detailed Learnings) provides full context for decision-making
✓ Layer 3 (Appendix) captures organisational memory and cross-task patterns
✓ Depth matches scope (significant pattern worth detailed documentation)
✓ Each layer can be read independently
✓ Supports both immediate action and long-term learning

## Edge Cases and Constraints

### When Iterations Were Successful

Not all learnings come from failures. Capture successes to reinforce good practices.

**Approach:**
- Use same 5-step process
- Gap analysis compares expected vs actual (positive gap = exceeded expectations)
- Root cause analysis: Why did this work so well?
- Actionable improvement: How do we replicate this success?

**Example:**
```markdown
**Gap:**
- Expected: 3-4 iterations to reach quality bar (typical for complex Skills)
- Actual: 2 iterations sufficient
- Difference: Exceeded expectations (positive gap)

**Root Cause:**
Research phase provided comprehensive methodology before production started. Producer had clear framework to apply, reducing trial-and-error.

**Actionable Improvement:**
Formalise research phase for complex/unfamiliar artefact types in creating-briefs guidance.
```

### When No Clear Root Cause Emerges

If Five Whys doesn't reveal systemic factors:

**Options:**
1. Try Fishbone to explore multiple cause categories
2. Use systems thinking questions to identify feedback loops
3. Gather more data (may be insufficient evidence)
4. Accept proximate cause but flag for monitoring (if pattern repeats, revisit)

**Document honestly:**
```markdown
**Root Cause:**
Five Whys analysis reached "Producer oversight" without identifying systemic factor. Possible causes explored: unclear guidance (no evidence), tool limitations (no evidence), time pressure (no evidence).

**Recommendation:**
Monitor next 3 similar tasks. If pattern repeats, conduct deeper investigation. For now, treat as one-off incident.
```

### When Learnings Conflict

If multiple iterations suggest contradictory improvements:

**Approach:**
1. Document both perspectives
2. Identify the differing contexts (what made each approach appropriate in its context?)
3. Propose context-dependent guidance rather than universal rule
4. Or: Propose experiment to test which approach is better

**Example:**
```markdown
**Conflict:**
- Task A learning: "Add more examples to Skills for clarity"
- Task B learning: "Reduce Skill length; too much content overwhelming"

**Resolution:**
Context difference: Task A involved unfamiliar domain (examples needed). Task B involved familiar domain (redundant examples).

**Actionable Improvement:**
Update writing-skills to include "Context Calibration" guidance: add examples for unfamiliar domains, keep concise for familiar domains. Use progressive disclosure (link to examples.md) for complex cases.
```

### When Improvement Requires Resources Outside Your Control

If learning depends on human behaviour change, external tools, or major system redesign:

**Approach:**
1. Document the learning with full SMART criteria anyway
2. Flag as "Requires Human Decision" or "Requires External Resources"
3. Escalate to human with clear options and trade-offs
4. Propose interim workarounds if possible

**Example:**
```markdown
**Actionable Improvement:**
Implement automated validation script that checks artefact against brief requirements before Producer submits. Requires Python script development and integration with agent workflow.

**Status:** Requires human decision on whether to invest in automation.

**Interim Workaround:**
Add manual checklist to producer-agent: "Before submitting, verify each brief requirement addressed."

**Trade-offs:**
- Automation: High upfront cost, consistent long-term benefit
- Manual checklist: Low cost, relies on memory, less consistent
```

## Integration with Producer-Critic-Learner Workflow

### When to Extract Learnings

**Recommended checkpoints:**

1. **After task completion:** Always extract learnings when quality bar met
2. **After 3+ iterations:** If iterations exceed expected, extract learnings mid-task to identify blockers
3. **After significant failure:** If task abandoned or delayed, extract learnings immediately
4. **Periodic reviews:** Monthly or quarterly, review all tasks for patterns

**Default:** Extract learnings upon task completion. Add checkpoint if iterations exceed 3.

### How Learnings Feed Forward

```
work/<task-id>/learning_proposals.md
              ↓
learnings/backlog.md (human review queue)
              ↓
Human approval decision
              ↓
Implementation (update Skill, agent, template, or workflow)
              ↓
Verification (check next task)
              ↓
Success → reinforce / Failure → iterate learning
```

### Relationship to Other Skills

- **workflow** (`skills/designing-workflow/SKILL.md`, File Naming and Versioning section): Defines file structure and versioning that enables learning extraction
- **assessing-quality**: Critic uses this to identify gaps; Learner uses reviews as input
- **analysing-root-cause**: Deeper Skill for complex RCA; this Skill provides basic RCA guidance
- **proposing-improvements**: Separate Skill for applying learnings to Skills/agents (future)
- **writing-skills**: Defines structure for Skill artefacts; learnings may propose updates
- **creating-briefs**: Learner may propose improved brief templates based on learnings

## Success Indicators

This Skill is working well when:

1. **Learnings are rooted in evidence:** Every proposal cites specific artefact versions and review feedback
2. **Root causes are systemic:** Analysis goes beyond "be more careful" to identify structural factors
3. **Proposals are actionable:** Reader can implement without asking clarifying questions
4. **Follow-through improves:** Learnings are actually implemented, not just documented
5. **Patterns emerge:** Cross-task analysis reveals systemic improvements
6. **Iterations decrease:** As learnings are applied, future tasks require fewer iterations
7. **Quality improves:** Metrics show better artefact quality on first submission
8. **Time savings:** Effort spent on learning extraction is offset by reduced iteration time

**Measurement approach:**
- Track iterations required per task type over time (should trend down)
- Monitor implementation rate of learnings (target: >70% implemented within timeline)
- Review Critic feedback themes (repeated issues should decrease)
- Survey human satisfaction with learning quality and actionability

## Evaluation Scenarios

Test this Skill with these scenarios:

### Scenario 1: Routine Task with Minor Issues

**Context:** Producer created 3-page report, took 2 iterations (expected 1-2), minor formatting issues in v1.

**Expected behaviour:**
- Layer 1 summary (quick reference)
- Layer 2 for 1-2 key learnings
- Root cause identifies missing formatting checklist in relevant Skill
- SMART action to add checklist
- Appropriate priority (Low-Medium)
- No over-analysis of minor issue

**Problematic approach to avoid:**
- Over-analysis: Conducting 3-page root cause investigation with Fishbone diagram for a typo or spacing issue that requires a one-line checklist item
- Under-analysis: "Fixed formatting" with no mention of why formatting was wrong or what prevents recurrence
- Treating minor issue as crisis: Flagging as Critical priority, demanding immediate Skill rewrite and agent retraining

### Scenario 2: Complex Task with Significant Gaps

**Context:** Producer created Skill, took 5 iterations (expected 2-3), multiple sections failed quality bar repeatedly, Critic identified lack of clear workflow structure.

**Expected behaviour:**
- Layer 1 summary showing high iteration count
- Layer 2 for 3-5 priority learnings
- Layer 3 with timeline showing when issues first appeared and persisted
- Five Whys identifies root cause (e.g., unclear Skill structure guidance)
- SMART actions for systemic fixes (update writing-skills, add workflow template)
- High priority assignments
- Blame-free framing focused on systemic factors

**Problematic approach to avoid:**
- Blame-focused: "Producer kept making the same mistakes; needs to be more careful and read guidelines properly"
- Symptom-only: "Skill had structural issues" without identifying why (missing guidance, unclear standards, etc.)
- Vague action: "Improve Skill creation process" without specifying what changes to which files by whom by when
- Individual focus: "Producer lacked attention to detail" rather than systemic analysis of what made errors likely

### Scenario 3: Successful Task Exceeding Expectations

**Context:** Producer created documentation, took 1 iteration (expected 2-3), exceeded quality bar, Critic noted excellent structure and clarity, research phase provided strong foundation.

**Expected behaviour:**
- Layer 1 summary highlighting success
- Layer 2 for 1-2 learnings capturing what worked well
- Root cause analysis of success (research investment, clear brief)
- Actionable improvement to replicate success (formalise research phase)
- Appropriate priority for positive reinforcement
- Avoids "over-learning" from single success

**Problematic approach to avoid:**
- Ignoring success: Only documenting failures, missing opportunity to reinforce effective practices
- Over-generalising: "Always require research for every task" based on one successful complex task
- Attribution error: "Producer was particularly skilled" rather than identifying replicable systemic factors
- No action: Noting success but not proposing how to replicate it systematically

## Appendix: Research Foundation

This Skill is grounded in research across multiple domains:

**High-reliability organisations (HROs):** Aviation (NTSB), military (US Army AAR), healthcare (M&M conferences), nuclear operations. Common themes: immediate capture, blame-free culture, systems focus, multi-perspective inclusion, follow-through mechanisms.

**Root cause analysis methods:** Five Whys (Toyota), Fishbone/Ishikawa diagrams, TAPRooT, bow tie analysis, systems thinking (Senge, Meadows). Principle: distinguish symptoms from underlying systemic causes.

**Gap analysis frameworks:** Standard 5-step process (identify current state, define desired state, analyse gap, determine causes, develop action plan). Military AAR four-question framework. Mitigation strategies for hindsight bias.

**Actionability criteria:** SMART framework (Doran, 1981). Distinction between "lessons identified" (observations) and "lessons learned" (implemented changes). Actionable Change framework emphasising immediate implementation.


**Key insight:** Effective learning requires three stages:
1. Identification (observing what happened)
2. Learning (understanding why and planning change)
3. Implementation (institutionalised behaviour change)

This Skill focuses on stages 1-2; separate workflows handle stage 3.
