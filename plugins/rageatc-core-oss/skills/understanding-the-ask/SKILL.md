---
name: understanding-the-ask
description: Clarifies user intent before formalising requirements. Use when requests are vague, incomplete, or solution-focused, or when preparing to write a brief.
---

# Understanding the Ask

## Purpose

This skill guides you through structured dialogue with users to understand what they actually want before formalising requirements into briefs.

Users arrive with vague requests, incomplete specifications, or solution-focused language. Your role is to systematically explore intent, context, and constraints through structured questioning and reflective listening, producing sufficient clarity to hand off to the creating-briefs skill.

This skill operates at the start of the Preparation phase, before brief creation begins.

## When to Use

**Use this skill when:**
- User's request is vague or incomplete ("make it better", "improve the docs")
- User proposes a specific solution without explaining the underlying problem
- Context or purpose is unclear (why this, why now)
- Success criteria are unstated or ambiguous
- Multiple interpretations of the request are possible

**Skip this skill when:**
- Request is already clear and specific with stated outcomes
- User has provided comprehensive brief or requirements
- Task is trivial with obvious intent (simple file edit, straightforward clarification)

## Core Principles

**Distinguish needs from proposed solutions** — Users often state solutions, not problems; your job is discovering the underlying need.

**Create verification checkpoints** — State your understanding back to the user periodically; don't assume you've understood correctly.

**Stay in problem space before solution space** — Explore what problem exists and why it matters before discussing implementation approaches.

**Context is never obvious** — Don't assume you know why the user wants this, who will use it, or where it fits.

## Workflow

### Step 1: Capture the Initial Statement

**What you're doing:** Understanding the surface-level request and establishing basic context.

**Questions to ask:**
- "What are you looking to create/achieve?" (the what)
- "Who will use this?" (the audience)
- "Where does this fit in your current work?" (the context)

**At this stage:** You're capturing what they think they need, not yet probing why. Keep questions open-ended starting with "what" or "how" rather than "why" (which can feel defensive).

**Output:** Basic understanding of the request, audience, and immediate context.

### Step 2: Explore Intent and Motivation

**What you're doing:** Understanding the underlying need and purpose behind the request.

**Depth questioning technique:**

Don't literally ask "why" five times. Instead, use gentle framing that invites elaboration:
- "What's driving this need right now?"
- "What would having this enable you to do?"
- "Help me understand what problem this solves"
- "What happens if we don't address this?"

**When users propose specific solutions, probe for the outcome:**
- User says "I need a comprehensive API reference" → "What would having that reference enable your team to do?"
- User says "Create a new skill for X" → "What gap are you experiencing that this skill would fill?"

**Watch for premature solutioning:**

These signals indicate jumping to solutions before problem context is clear:
- Discussion of specific tools or technologies before problem is defined
- Fixation on a deliverable type without discussing what it must achieve
- "We need to implement X" without corresponding "because Y" context
- Talk of features before outcomes

**Corrective questions:**
- "Before we discuss how to do that, can we clarify what problem that solves?"
- "What outcome does this implementation need to achieve?"
- "I notice we're discussing specifics. Can we step back to the problem space?"

**Balance:** Sometimes stating a preliminary interpretation helps users clarify. Don't avoid all solution discussion—just ensure problem context exists first.

**Depth signals:**

Stop when you reach fundamental goals or constraints (typically 3-5 exchanges). You've gone deep enough when:
- User articulates a clear outcome or success state
- You understand the consequence of not solving this
- The underlying need is clear, not just the proposed solution

**Output:** Understanding of why this matters, what problem it solves, what outcome the user wants.

### Step 3: State Your Understanding

**What you're doing:** Creating a verification checkpoint by reflecting back what you've heard.

**Reflective listening templates:**

Use these phrase patterns to state understanding:
- "What I'm hearing is..."
- "My understanding: you need [X] because [underlying goal/constraint]..."

**Structure for comprehensive reflection:**

"Let me state back what I understand:
- **Problem:** [what's not working or missing]
- **Outcome:** [what success looks like]
- **Constraints:** [limitations, boundaries, must-haves]
- **Audience:** [who will use this]

Have I understood correctly? What have I missed?"

**Frequency:** Don't reflect after every statement. Use this at key moments—after exploring intent (Step 2), before moving to brief creation (Step 4), when you're uncertain about something specific.

**Output:** User confirms your understanding or corrects misinterpretations. Iterate until alignment achieved.

### Step 4: Verify Readiness to Proceed

**What you're doing:** Checking whether you have sufficient understanding to create a brief.

**Readiness checklist:**

You're ready to proceed when:
- [ ] You can state the problem in one clear sentence
- [ ] You understand the desired outcome (not just requested deliverable)
- [ ] You know what success looks like
- [ ] You understand why this matters now (urgency/context)
- [ ] You've identified who is affected and who decides
- [ ] You've stated understanding back and user confirmed
- [ ] No major ambiguities or confusion remain
- [ ] You understand boundaries (what's in/out of scope)

**5W+H coverage check:**

Have you covered:
- **Who**: Who is affected? Who needs this?
- **What**: What is the problem? What would success look like?
- **When**: When does this need to happen?
- **Where**: Where does this fit in their work?
- **Why**: Why does this matter? Why now?
- **How**: How will they know when it's solved?

**When NOT ready:**
- Core concepts still unclear or confusing
- User keeps correcting your understanding
- Significant aspects feel vague or assumed
- Haven't verified understanding back with user
- Contradictory information hasn't been resolved

**If not ready:** Return to Step 2. Probe deeper on unclear areas. State understanding again.

**If ready:** Proceed to creating-briefs skill to formalise requirements.

**Output:** Confirmed readiness or identification of gaps requiring further exploration.

## Common Traps to Avoid

**Accepting ambiguous language** — Terms like "comprehensive", "good quality", "user-friendly" mean different things to different people. Probe: "When you say comprehensive, do you mean covering all edge cases or just common scenarios?"

**Focusing on symptoms not causes** — User says "the documentation is unclear". That's a symptom. The cause might be missing examples, wrong audience level, or outdated content. Use depth questioning to go deeper.

## Handoff to Creating-Briefs

When readiness criteria are met, you have what creating-briefs needs to begin.

**What you're handing off:**
- Clear understanding of the problem and desired outcome
- Context for why this matters and where it fits
- Audience identification
- Boundaries and constraints
- Success vision (what good looks like)

**What creating-briefs does next:**
- Extracts requirements from applicable standards
- Formalises success criteria as measurable checkboxes
- Structures requirements into brief format
- Establishes quality expectations

**Clean handoff means:** You've done the exploration work so creating-briefs can move directly to formalisation without re-exploring intent.

## Evaluation Scenarios

### Scenario 1: Vague Request to Clear Understanding

**User says:** "I need better documentation for the deployment process"

**Expected outcome:**
- Explore: What problem does current documentation create? Who uses it? What would "better" mean?
- Probe outcomes: "What would good deployment docs enable your team to do?"
- Detect premature solutioning if user jumps to format discussions before problem is clear
- State understanding: "It sounds like new team members take 3 weeks to contribute because deployment docs are outdated, and you need docs that enable independent deployment in under a week. Is that right?"
- Verify readiness: Problem clear, outcome measurable, audience identified, constraints understood
- Hand off to creating-briefs with: problem (new hires can't deploy independently), outcome (deploy without help in 1 week), audience (new engineers), constraints (staging and production, not admin endpoints)

### Scenario 2: Solution-Focused Request

**User says:** "Create a new skill using the Jobs-to-be-Done framework"

**Expected outcome:**
- Recognise premature solutioning (jumped to solution before stating problem)
- Probe: "What gap are you experiencing that this skill would fill? What would having this skill enable you to do?"
- Explore context: "Why Jobs-to-be-Done specifically? What problem does it solve that other frameworks don't?"
- State understanding: "What I'm hearing is that orchestrators sometimes guess user intent rather than probing deeply, and Jobs-to-be-Done provides a framework for discovering underlying needs. You want a skill that teaches this technique. Is that right?"
- Verify outcome: "How will you know if this skill succeeds?"
- Hand off to creating-briefs with: problem (orchestrators guess intent), outcome (systematic intent discovery), audience (orchestrators), framework constraint (must include JTBD), success criteria (orchestrators can distinguish needs from proposed solutions)

### Scenario 3: Incomplete Request

**User says:** "Research progressive disclosure patterns"

**Expected outcome:**
- Establish context: "Why are you interested in progressive disclosure? What problem are you trying to solve?"
- Probe scope: "Progressive disclosure for what type of content? Which aspects matter most?"
- Explore usage: "How will you use these research findings? Who needs to understand them?"
- Check boundaries: "Should this cover interactive patterns, or just static documentation approaches?"
- State understanding: "My understanding: your skills are growing long (400+ lines), creating discoverability problems. You need proven patterns for splitting content while maintaining usability. This research will identify 3-5 patterns for your skill structure. Is that right?"
- Verify readiness: Problem clear (discoverability), outcome defined (3-5 patterns), usage specified (inform skill structure), scope bounded (CLI tools, progressive disclosure focus)
- Hand off to creating-briefs with: problem (long skills, discoverability), outcome (identify 3-5 patterns), audience (orchestrator will decide structure), scope (CLI tools, progressive disclosure focus)

## Success Indicators

This skill succeeds when:
- You move from vague request to clear understanding efficiently
- User confirms "yes, you've understood what I need" when you reflect back
- Creating-briefs can proceed without re-exploring intent
- Briefs capture actual need, not literal surface request
- Orchestrator can articulate the problem, outcome, and constraints in a way the user confirms as accurate
