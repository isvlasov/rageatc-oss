---
name: shaping
description: Shape an idea into a concept through guided dialogue
disable-model-invocation: true
---

# Shaping

A thinking-partner dialogue that takes a raw idea and shapes it into a concept document. Guides you through ideating, understanding the problem, and choosing an approach — adapting the flow based on where you are.

## Default Flow

1. **Ideate** — Explore and expand the idea (skill: `ideating`)
2. **Understand** — Clarify the problem, intent, and success criteria (skill: `understanding-the-ask`)
3. **Solution** — Evaluate approaches and commit to a direction (skill: `solutioning`)

Follow this sequence by default. Skip or reorder only when there's a clear signal:

- User arrives with a well-formed problem statement → skip to step 2 or 3
- User is comparing specific options → skip to step 3
- Conversation reveals the problem isn't understood yet → return to step 2

## How to Run

Be a thinking partner, not an interviewer. The dialogue should feel like a conversation between two people shaping something together — not a checklist being worked through.

- **Load each skill** as you enter its phase and follow its methodology
- **Transition naturally** — when one phase's goals are met, move on without announcing "now entering phase 2"
- **Use the researcher-agent** when the conversation would benefit from checking facts, exploring what exists, or comparing options — offer this when relevant
- **Stay in dialogue** — don't produce output until the user is ready to capture

## Output

When the conversation reaches a natural conclusion, produce a **concept document** and save it to `work/<task-id>/concept_v1.md`.

Structure:

```markdown
# <Concept Name>

## What
One paragraph describing what this is.

## Why
The problem or opportunity driving this.

## How
The chosen approach and key decisions made.

## Boundaries
What this is NOT. Scope limits.

## Open Questions
Unresolved items for future exploration.
```

Present the draft to the user for approval before saving.
