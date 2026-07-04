---
name: ideating
description: Generates and explores ideas. Use when capturing fleeting thoughts, brainstorming, exploring a problem space before committing to a direction, or reviewing stored ideas to decide what to pursue.
---

# Ideating

Three activities with very different footprints: quick capture (zero friction), dialogue-driven ideation (expand thinking), and idea review (decide what to pursue). Match the activity to what the user brings — and keep capture frictionless above all.

Skip this skill when the user already knows what they want (`understanding-the-ask`) or is evaluating a specific solution (`solutioning`).

## Activity 1 — Quick capture

The user has a thought and wants it preserved before it vanishes.

1. Accept whatever is given — a phrase, a sentence, a question.
2. Append to the project's `ideas.md` with the date and a one-line summary (format below).
3. Confirm saved, move on.

No forced formality: if the user says "quick idea: versioned skills", write exactly that. Don't expand, structure, or ask clarifying questions unless the user wants dialogue.

## Activity 2 — Dialogue-driven ideation

Frame the exploration first — "What are we exploring? Starting fresh, or building on something?" A rough focus is enough; it doesn't need to be a problem statement.

Pick facilitation techniques to fit, and use them naturally without naming them ("What if we looked at this from a purely emotional perspective?", not "Now we're using Red Hat thinking"):

- **Expansive exploration** — SCAMPER prompts (substitute? combine? adapt?), analogies from other domains, random connections
- **Perspective-shifting** — Six Thinking Hats lenses, stakeholder viewpoints, "How might we" questions
- **Assumption-surfacing** — "What are we assuming must be true?", reverse an assumption and explore what becomes possible

Your highest value is introducing new dimensions, not elaborating what's already there:

- "What domain completely unrelated to this solves a similar challenge?"
- "What would someone with opposite expertise notice that we're missing?"
- "What becomes possible if we reverse [key constraint]?"

Keep divergence and convergence separate, and signal transitions explicitly: "we're generating possibilities now — no evaluation yet" → "let's shift to the critical lens". Complete divergence fully before converging (look for patterns, identify strongest directions, apply constraints, premortem).

Watch for: premature filtering ("let's capture that even if it seems wild"), anchoring to the first idea ("what would option B look like?"), surface-level responses ("and one level deeper on that?").

Capture without disrupting flow: brief in-session notes ("I'm noting: [idea]") while the user keeps talking, then offer to structure into the ideas file afterwards.

## Activity 3 — Idea review

1. Read `ideas.md` (or wherever ideas live in the current project).
2. Summarise what exists: group by theme, note recency, highlight ideas that reference each other.
3. Facilitate selection: "Which still feels energising? Which solves the most important problem right now? Which could you prototype in a day?"
4. When the user commits to one, hand off to `understanding-the-ask` to clarify it into an actionable task.

## Idea storage format

`ideas.md` in project root; chronological, append-only; human-readable and Claude-parseable. Low structure at capture, optional enrichment later.

```markdown
## 2026-02-07 — Brief idea description

[Any context]

---
```

After an ideation session, enrich entries if the user wants: context, core concept, key insights, related ideas, optional status (Captured | Exploring | Committed | Parked).

## When the user is stuck

- **"I don't know what I don't know"** — map stakeholders with different viewpoints, role-play each, ask what each would notice
- **"I'm stuck on one approach"** — "if we couldn't do that, what would we try?", reverse key constraints, analogies from distant domains
- **"Everything seems possible"** — must-haves vs nice-to-haves, premortem, simplest thing that could work, what could be tested in a day
- **"This feels too safe"** — "what would the opposite approach look like?", unlimited resource / no resource, "what assumption, if wrong, changes everything?"
