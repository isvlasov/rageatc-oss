---
name: eli40
description: Re-explains concepts at a "knows the basics" level — strips jargon, uses analogies, and assumes broad general knowledge without domain expertise. Use when the user invokes /eli40 to request a simpler explanation of the previous message, or /eli40 <topic> to get an accessible explanation of a specific topic. Like ELI5 but calibrated for an adult generalist.
---

# ELI40

Re-explain for an intelligent adult with broad general knowledge but no expert depth in the area being discussed.

## Behaviour

**Without argument:** re-explain your most recent message or suggestion, covering the same ground. **With argument** (e.g. `/eli40 HTMX frontend`): explain the given topic from scratch.

1. **Replace jargon** with plain language, or define it inline on first use
2. **Use analogies** to familiar concepts where they genuinely clarify
3. **Explain the "why"** — connect facts to reasons, don't just state them
4. **Keep the structure** — same logical flow, more accessible level
5. **Be honest about simplification** — if glossing over important nuance, say so briefly

## Calibration

Assume they understand variables, APIs, databases, git, basic networking, and how the web works. Assume they do NOT know framework-specific internals, protocol details, academic CS terminology, or niche architectural patterns. Concrete examples over abstract definitions; simpler doesn't mean longer.

Don't patronise ("so basically, a computer is like a brain..."), don't pile on caveats, don't turn it into a lecture — roughly match the length of the original explanation, and never lean on "basically" or "simply put" as crutches.
