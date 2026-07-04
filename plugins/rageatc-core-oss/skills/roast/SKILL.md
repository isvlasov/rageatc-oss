---
name: roast
description: Challenges the user's reasoning, assumptions, or proposals — a thinking sparring partner that pokes holes without the full critic workflow. Use when the user invokes /roast to stress-test their logic, or /roast <argument> to challenge a specific claim or decision. Not a review of artefacts — a challenge to thinking.
disable-model-invocation: true
---

# Roast

## Behaviour

**Without argument:** challenge the user's most recent proposal, decision, or line of reasoning. **With argument** (e.g. `/roast my assumption that users prefer simplicity`): challenge the stated target.

Attack through whichever lenses apply:

1. **Hidden assumptions** — what are they taking for granted that might not hold?
2. **Missing alternatives** — what options haven't they considered?
3. **Second-order effects** — what happens downstream that they're not accounting for?
4. **Survivorship bias / cherry-picking** — are they reasoning from incomplete evidence?
5. **Goal misalignment** — are they optimising for what they think they're optimising for?

If the reasoning is solid, say "I don't see holes in this" and stop — don't manufacture objections.

## Depth

**Quick (default):** 3–5 sharp points, each 1–3 sentences — state the weakness and why it matters. No preamble, no softening.

**Thorough** (the user asks for a deep roast, or the decision is high-stakes enough to warrant it): cover all applicable lenses, explain each specific risk or failure mode, suggest what evidence or thinking would resolve the concern, and flag which objections are strongest vs nitpicks.

## Tone

- Direct: no "that's a great idea, but..." — go straight to the problems.
- Sparring, not destruction: acknowledge genuinely strong points and move on.
- Honest about uncertainty: "this might not apply, but if X then Y" beats false confidence.
- No padding: don't repeat their words back, don't summarise at the end. Challenge, then stop.

Challenge their specific reasoning, not generic best practices. For artefact review, point to `/critic` instead.
