---
name: solutioning
description: Guides orchestrators through structured dialogue to explore solution options when the problem is defined but the approach is unclear. Use when evaluating approaches, comparing alternatives, exploring solution direction, or choosing between options. Helps ask the right questions, apply simplicity principles, recognise decision types, and produce lightweight decision records that hand off to creating-briefs. Complements understanding-the-ask skill.
---

# Solutioning

## Purpose

This skill guides you through structured dialogue with users to evaluate solution options when the problem is clear but the approach is not obvious.

Users arrive having defined the problem (via understanding-the-ask or direct specification) but face genuine uncertainty about which solution direction to pursue. Your role is to facilitate systematic exploration through the right questions, simplicity filters, and lightweight comparison techniques, producing a decision record that captures reasoning and hands off cleanly to creating-briefs.

This skill operates in the optional Preparation phase, after problem clarification but before requirements formalisation.

## When to Use

**Use this skill when:**
- Problem is defined but multiple solution approaches exist
- User asks "which option should we choose?" or "what's the best approach?"
- Solution direction is genuinely unclear (not just unexplored)
- Trade-offs exist between competing options
- Risk of over-engineering or premature commitment is high

**Skip this skill when:**
- Only one viable solution exists
- User has already committed to an approach (just needs execution)
- Solution is obvious from requirements
- The choice is purely preferential (no objective criteria)
- Problem definition is still unclear (use understanding-the-ask first)

## Core Principles

**Simplicity wins unless complexity is justified** — Default to the simplest thing that could possibly work; require clear justification for complexity based on current needs, not anticipated futures.

**Match analysis depth to decision type** — Reversible decisions need quick commitment at 70% certainty; irreversible decisions need thorough exploration before committing.

## Workflow

### Step 1: Classify the Decision Type

**What you're doing:** Understanding whether this requires fast commitment or careful deliberation.

**Ask:**
- "How expensive would it be to reverse this decision later?"
- "If we try this and it doesn't work, can we go back?"

**Decision types:**

**Reversible (Two-Way Door):**
- Can change later without major cost (e.g., file structure, naming convention, process experiment)
- **Approach:** Decide quickly at 70% certainty, course-correct as you learn
- Watch for: Analysis paralysis (deliberating when you should be trying)

**Irreversible (One-Way Door):**
- Expensive or impossible to reverse (e.g., core architecture, database selection, major dependency)
- **Approach:** Invest time understanding options before committing
- Watch for: Premature commitment (deciding before understanding trade-offs)

**Output:** Classification of decision type that determines evaluation depth.

### Step 2: Establish Simplicity Baseline

**What you're doing:** Creating a default filter against over-engineering.

**Ask:**
- "What's the simplest thing that could possibly work?"
- "Do we need this now, or are we anticipating future needs?"
- "What's the minimum that solves the current problem?"

**Simplicity principles as filters:**

**YAGNI (You Aren't Gonna Need It):**
- Challenge: "We might need X later"
- Response: "Do we need X now? If not, we can add it when we do."

**KISS (Keep It Simple, Stupid):**
- Challenge: "Option A is more capable but complex"
- Response: "Does simpler option B solve the current problem? If yes, complexity needs justification."

**Occam's Razor:**
- Challenge: "We could build a comprehensive framework"
- Response: "What's the solution making fewest assumptions about the future?"

**Output:** Simplest viable option identified as baseline for comparison.

### Step 3: Generate and Explore Options

**What you're doing:** Ensuring you've considered alternatives before anchoring to the first idea.

**Avoid anchoring bias** — The first option presented becomes the implicit default. Deliberately challenge it:
- "We've discussed option A. What would option B look like?"
- "If we couldn't do [first option], what would we try instead?"

**Stop when:** You have 2-4 viable options, additional options aren't meaningfully different, or user says "I think we've covered the main approaches."

**Output:** 2-4 distinct solution options with basic understanding of each.

### Step 4: Compare Options Against Criteria

**What you're doing:** Making trade-offs explicit through lightweight structured comparison.

**For quick comparison (reversible decision):**

Use relative comparison to baseline: Better (+), Worse (−), or Same (S) to simplest option from Step 2.

Example: "For implementation speed, is [option B] better, worse, or about the same as [baseline]? For maintainability?"

**For deeper comparison (irreversible decision):**

Discuss explicit pros and cons for each option, focusing on current needs, concrete impacts, and real constraints.

**Common traps to avoid:**
- **Confirmation bias:** Seeking only supporting evidence for preferred option
  - Counter: "What could prove this option wrong?"
- **Analysis paralysis:** Continuously gathering information without deciding
  - Counter: "Do we have enough to make a 70% confident decision?"
- **Ambiguous language:** Terms like "scalable", "flexible", "robust" without definition
  - Counter: "When you say scalable, do you mean 10x users or 1000x? What specifically?"

**Output:** Clear understanding of trade-offs between options.

### Step 5: Make and Record the Decision

**What you're doing:** Committing to a direction and capturing the reasoning.

**Decision criteria:**

For reversible decisions: Can we decide with 70% confidence? If this doesn't work, can we reverse it? If yes → commit and move forward.

For irreversible decisions: Do we understand the key trade-offs? Have we challenged our assumptions? Are we choosing for current needs, not anticipated futures? If yes → commit; if no → what's missing?

**Record the decision:**

Use lightweight ADR format:

```markdown
# Decision: [Short Title]

**Date:** YYYY-MM-DD
**Status:** Committed

## Context

[2-3 sentences: What problem were we solving? Why did this decision matter?]

## Options Considered

1. **[Option name]** — [one-line description]
2. **[Option name]** — [one-line description]
3. **[Option name]** — [one-line description]

## Decision

We chose [option name] because [primary reason].

Key trade-offs:
- We gain: [main benefits]
- We accept: [costs or limitations]
- We assume: [assumptions made]

## Consequences

- [What this enables going forward]
- [What this constrains or rules out]
- [What we'll monitor or revisit]

## Next Steps

[Hand off to creating-briefs to formalise requirements for chosen approach]
```

**Keep it conversational** — 1-2 paragraphs per section, plain language.

**Output:** Decision record saved to work directory for handoff.

### Step 6: Hand Off to Creating-Briefs

**What you're doing:** Transitioning from solution selection to requirements formalisation.

**Verify handoff readiness:** Decision made and recorded, chosen approach clear, key trade-offs understood, simplicity justified (if complex option chosen), user committed to direction.

**What you're handing off:**
- Decision record with context and reasoning (serves as "Basic context" input to creating-briefs)
- Chosen solution approach
- Known constraints from decision (what we accept/assume)
- Next step clarity (what needs to be built/created)

**What creating-briefs does next:**
- Extracts requirements for chosen approach
- Formalises constraints from decision record
- Structures into actionable brief
- Establishes quality criteria

**Clean handoff means:** You've explored options and committed to direction, so creating-briefs can focus on specifying requirements without re-exploring alternatives.

**Complete chain:**
1. understanding-the-ask → clarifies the problem
2. solutioning → chooses the approach (optional, when direction unclear)
3. creating-briefs → formalises requirements for chosen approach
4. Producer-Critic cycle → executes and refines

## Evaluation Scenarios

### Scenario 1: Quick Decision for Reversible Choice

**Context:** User asks whether to structure skill content as single file or multi-file package.

**Expected outcome:**
- Classify as reversible (file structure can change later)
- Establish simplicity baseline (single file)
- Quick pros/cons comparison (single = easier to read; multi = better for long skills)
- 70% rule: "Current skill is 150 lines → single file wins; can split later if grows"
- Record decision with reasoning (brief context, chosen option, trade-off accepted)
- Hand off: "Now let's write brief for single-file skill creation"

### Scenario 2: Thorough Exploration for Irreversible Choice

**Context:** User choosing between PostgreSQL and MongoDB for core data store.

**Expected outcome:**
- Classify as irreversible (database migration is expensive)
- Challenge first option presented (explore both, don't anchor)
- Detailed pros/cons for each (query patterns, scaling, team expertise)
- Check assumptions ("We assume relational model fits our data — is that true?")
- Decision requires understanding trade-offs, not just 70% confidence
- Record decision with detailed consequences (what this enables/constrains)
- Hand off: "Now let's write brief for PostgreSQL implementation"

### Scenario 3: Recognising and Preventing Over-Engineering

**Context:** User proposes building comprehensive plugin framework for simple task.

**Expected outcome:**
- Simplicity baseline: "What's the simplest thing that solves current need?"
- YAGNI challenge: "Do we need plugins now, or are we anticipating future use cases?"
- Comparison: Hardcoded approach vs plugin framework
- Trade-offs: Simple now vs "might need later"
- Decision: Choose simple unless current requirements justify complexity
- Record with clear reasoning (YAGNI principle applied, can refactor if needs emerge)
- Hand off: "Now let's write brief for simple implementation"

## Success Indicators

This skill succeeds when:
- Decision record captures reasoning that makes sense if read 3 months later
- Creating-briefs can proceed without re-exploring solution options
- User confirms "yes, this is the right approach" when decision recorded
