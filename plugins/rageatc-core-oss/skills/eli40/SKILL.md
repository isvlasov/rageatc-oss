---
name: eli40
description: Re-explains concepts at a "knows the basics" level — strips jargon, uses analogies, and assumes broad general knowledge without domain expertise. Use when the user invokes /eli40 to request a simpler explanation of the previous message, or /eli40 <topic> to get an accessible explanation of a specific topic. Like ELI5 but calibrated for an adult generalist.
---

# ELI40

## Purpose

The user has asked you to explain something more simply. They are an intelligent adult with broad general knowledge across many domains, but they lack expert depth in the specific area being discussed. Your job is to re-explain clearly without assuming specialist knowledge.

## Behaviour

### Without argument

Re-explain your most recent message or suggestion. Cover the same ground but:

1. **Replace jargon** with plain language, or define it inline on first use
2. **Use analogies** to familiar concepts where they genuinely clarify
3. **Explain the "why"** — don't just state facts, connect them to reasons
4. **Keep structure** — use the same logical flow, just at a more accessible level
5. **Be honest about simplification** — if you're glossing over important nuance, say so briefly

### With argument (e.g. `/eli40 HTMX frontend`)

Explain the given topic from scratch at the same accessible level. Follow the same principles above.

## Calibration

**Do:**
- Assume they understand: variables, APIs, databases, git, basic networking, how the web works, general programming concepts
- Assume they do NOT know: framework-specific internals, protocol details, academic CS terminology, niche architectural patterns
- Use concrete examples over abstract definitions
- Keep it concise — simpler doesn't mean longer

**Don't:**
- Patronise or over-simplify ("so basically, a computer is like a brain...")
- Add unnecessary caveats or hedging
- Turn it into a lecture — match the length of the original explanation roughly
- Use "basically" or "simply put" as crutches
