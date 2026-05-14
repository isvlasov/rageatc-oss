---
name: ideating
description: Facilitates idea generation and exploration through quick capture, dialogue-driven ideation sessions, and idea review. Use when capturing fleeting thoughts, brainstorming solutions, exploring problem spaces before committing to direction, or reviewing stored ideas to decide what to pursue. Relevant when starting new projects, generating options, or thinking creatively.
---

# Ideating

## Purpose

This skill guides you through three distinct ideation activities with users: effortless capture of fleeting thoughts, facilitated dialogue sessions that expand creative thinking, and review of stored ideas to decide what to pursue next.

Users arrive either with a spark they want to preserve before it vanishes, a problem space they want to explore before committing to direction, or a question about what ideas they've already captured. Your role is to provide the right level of structure for each activity whilst keeping friction at absolute minimum.

This skill operates at the optional start of the Preparation phase, before understanding-the-ask. When a user finishes ideating and wants to commit to a specific direction, hand off to understanding-the-ask to clarify the task.

## When to Use

**Use this skill when:**
- User says "I have an idea" or "quick note" (capture mode)
- User wants to brainstorm, explore possibilities, or think creatively about a topic (ideation mode)
- User asks "what ideas do I have?" or wants to review captured ideas (review mode)
- Problem space is unclear or multiple directions exist
- User wants to surface blind spots or challenge assumptions

**Skip this skill when:**
- User already knows what they want to do (use understanding-the-ask directly)
- Task is execution-focused, not exploration-focused
- User wants to evaluate a specific solution (use solutioning instead)

## Core Principles

**Capture first, structure later** — Raw thoughts must flow with zero friction; organisation happens separately, never during capture.

**Dialogue over procedure** — This is co-creative exploration, not form-filling. Match the user's energy and openness.

**Expand, don't just elaborate** — Introduce new dimensions and perspectives; help users see what they can't see alone.

**Ideas live in project repos** — Storage happens where the work happens, in formats Claude can read and reason about.

## Three Ideation Activities

### Activity 1: Quick Capture

**What it is:** Minimal-friction recording of fleeting thoughts, no structure required.

**When:** User has a thought and wants to preserve it before it vanishes.

**How:**
1. Accept whatever the user provides (a phrase, a sentence, a question)
2. Store in project's `ideas.md` using minimal format (see Idea Storage Format below)
3. Add lightweight metadata only: date and one-line summary
4. Confirm saved, move on

**Key principle:** No forced formality. If user says "quick idea: versioned skills", write exactly that. Don't expand, don't structure, don't ask clarifying questions unless user wants dialogue.

### Activity 2: Dialogue-Driven Ideation

**What it is:** Facilitated sessions where you expand user's thinking through systematic exploration.

**When:** User wants to explore problem space, generate options, or think creatively before committing to direction.

**Flow:**

#### 2.1 Frame the Exploration

**Ask:**
- "What are we exploring?"
- "What's the challenge or opportunity you're thinking about?"
- "Are you starting fresh, or building on something specific?"

**Output:** Clear exploration focus (doesn't need to be a perfect problem statement, just enough direction).

#### 2.2 Choose Your Facilitation Mode

Match technique to what the user needs:

**Expansive exploration** — SCAMPER prompts (substitute? combine? adapt?), analogies from other domains, random connections

**Perspective-shifting or reframing** — Six Thinking Hats (emotional, critical, optimistic lenses), stakeholder viewpoints, How Might We questions

**Assumption-surfacing** — "What are we assuming must be true?", reverse assumptions and explore what becomes possible

**You don't need to name these techniques** — just use them naturally in dialogue. Say "What if we looked at this from a purely emotional perspective?" rather than "Now we're using Red Hat thinking."

#### 2.3 Facilitate with Active Expansion

Your highest value is **introducing new dimensions**, not just elaborating what's already there.

**Ask questions that expand:**
- "What domain completely unrelated to this solves a similar challenge?"
- "If this approach is right, what assumptions must be true?"
- "What would someone with opposite expertise notice that we're missing?"
- "What becomes possible if we reverse [key constraint]?"

**Signal mode transitions explicitly:**
- "We're generating possibilities now — no evaluation yet"
- "Let's shift to critical lens — what could go wrong?"

**Watch for:**
- Premature filtering (user dismissing ideas before exploring) — Counter: "Let's capture that even if it seems wild"
- Anchoring to first idea (treating it as default) — Counter: "We've explored option A; what would option B look like?"
- Surface-level responses (stopping at obvious answers) — Counter: "And if we go one level deeper on that?"

#### 2.4 Capture Key Ideas Without Disrupting Flow

Don't interrupt dialogue to write perfect notes. Quick captures during session, then offer to structure afterward:

**During session:**
- "I'm noting: [key idea in brief form]"
- User can continue talking

**After session:**
- "We generated [N] distinct directions. Should I add these to your ideas file with today's session context?"

#### 2.5 Separate Divergence and Convergence

**Divergent phase:** Emphasise quantity and variety, defer all judgement, encourage wild ideas, build on everything

**Convergent phase:** Look for patterns, identify strongest directions, apply constraints, use premortem (imagine failure, work backward)

**Never mix these modes.** Complete divergence fully before shifting to convergence.

### Activity 3: Idea Review

**What it is:** Reading stored ideas, helping user decide what to pursue.

**When:** User asks "what ideas do I have?" or wants to pick next thing to work on.

**How:**

1. **Read the ideas file** (`ideas.md` or wherever ideas live in current project)

2. **Summarise what exists:**
   - Group by theme if patterns emerge
   - Note date ranges (recent vs older ideas)
   - Highlight any that reference each other

3. **Facilitate selection dialogue:**
   - "Which of these still feels energising?"
   - "Which solves the most important problem right now?"
   - "Which could you prototype in a day to test viability?"

4. **Hand off when ready:**
   - Once user commits to one, hand off to understanding-the-ask to clarify it into actionable task

## Idea Storage Format

**Default location:** `ideas.md` in project root

**Format principles:**
- Human-readable, Claude-parseable
- Low structure during capture, optional enrichment later
- Chronological by default (most recent at bottom for append-only flow)

**Minimal format (quick capture):**
```markdown
## 2026-02-07 — Brief idea description

[Any context]

---
```

**Enriched format (after ideation session):**
```markdown
## 2026-02-07 — Idea title or summary

**Context:** [What prompted this]

**Core concept:** [The main idea]

**Key insights:**
- [Insight 1]
- [Insight 2]

**Related to:** [Links to other ideas, if any]

**Status:** Captured | Exploring | Committed | Parked

---
```

**Status field is optional** — use only if helpful for user's workflow.

## Common Facilitation Patterns

**For "I don't know what I don't know"** — Map stakeholders with different viewpoints, role-play each perspective, ask what each would notice that user might miss

**For "I'm stuck on one approach"** — "If we couldn't do [current approach], what would we try?", random word technique, reverse key constraints, analogies from distant domains

**For "Everything seems possible"** — Identify must-haves vs nice-to-haves, premortem (imagine failure, identify risks), simplest thing that could work, what could you test in one day?

**For "This feels too safe/obvious"** — "What would the opposite approach look like?", "What if we had unlimited [resource]? What if we had none?", "What assumption, if wrong, would change everything?"

## Handoff to Understanding-the-Ask

When user decides to pursue a specific idea, transition cleanly:

**You've done:** Helped generate and capture ideas, facilitated exploration, supported selection

**What understanding-the-ask does next:** Clarifies the chosen idea into well-defined task with clear scope and success criteria

**Handoff trigger phrases:**
- "Let's work on this one"
- "I want to pursue [specific idea]"
- "This feels like the right direction"

**Clean handoff means:** You've helped user identify what they want to explore; understanding-the-ask will help them define it precisely.

## Evaluation Scenarios

### Scenario 1: Quick Capture

**Input:** User says "Quick idea: skills that preload context from previous sessions"

**Expected outcome:**
- Recognise capture mode (no elaboration requested)
- Add to ideas.md with date and exact phrasing
- Minimal format, zero ceremony
- Confirm saved, ready for next

### Scenario 2: Dialogue-Driven Ideation

**Input:** User says "I want to brainstorm how agents could learn from failures"

**Expected outcome:**
- Frame exploration ("We're exploring agent learning from failures")
- Choose techniques that fit (SCAMPER for systematic exploration, perspective-shifting to see from different agent roles)
- Actively expand thinking (introduce new dimensions like "What if failures were shared across agent types?")
- Explicitly separate divergent (generating ideas) from convergent (evaluating them)
- Capture key ideas during session
- Offer to structure into ideas file afterward

### Scenario 3: Idea Review and Selection

**Input:** User says "What ideas do I have about improving the workflow?"

**Expected outcome:**
- Read ideas.md (or relevant file)
- Summarise ideas with thematic grouping if patterns exist
- Facilitate selection dialogue ("Which feels most urgent? Which could you test quickly?")
- When user chooses one, hand off: "Great, let's use understanding-the-ask to clarify this into a specific task"

## Success Indicators

This skill succeeds when:
- User captures fleeting thoughts in under 30 seconds
- Ideation sessions generate ideas user wouldn't have reached alone
- User says "I hadn't thought of that" at least once per dialogue session
- Ideas file grows steadily without becoming overwhelming
- Handoff to understanding-the-ask happens cleanly when user commits to direction
