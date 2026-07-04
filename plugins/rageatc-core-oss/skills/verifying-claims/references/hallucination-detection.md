# AI Hallucination Detection Methods

Three detection methods for AI-generated content, used alongside traditional fact-checking. High-confidence hallucinations are the dangerous ones — fluent, specific, well-integrated text that is wrong.

## Method 1 — Semantic entropy

**Principle:** when a model lacks knowledge, its answers become inconsistent under rephrasing. Checking consistency of *meaning* across phrasings reveals confabulation.

**Protocol:**

1. Rephrase the question 3–5 ways, preserving core meaning: "How many Nobel Prizes did Marie Curie win?" → "In how many different years did Curie receive the Nobel Prize?" → "How many times was Curie a Nobel laureate?"
2. Regenerate answers for each phrasing independently, without conversation history.
3. Compare meanings, not wording:
   - **Low entropy** — all answers convey the same fact ("two", "1903 and 1911", "twice") → stable internal representation. Still verify externally (stable ≠ correct), but deprioritise if time-constrained.
   - **High entropy** — answers contradict each other ("three", "one in Physics", "two in Chemistry") → the model is confabulating. Flag for mandatory external verification; accept none of its answers without corroboration.

**Use when** verifying AI factual claims with no provided sources — especially specific numbers, dates, names, and technical details. It prioritises what to verify first; it never replaces external verification.

## Method 2 — Extrinsic hallucination checks

**Principle:** extrinsic hallucinations conflict with or ignore provided context. Detection is systematic comparison of output against source material — the core of retrospective verification (Mode A): AI summaries against original papers, answers against provided context, syntheses against their sources.

**Protocol:**

1. **Extract every factual assertion** from the AI output: statistics and numbers, quotes and attributions, dates and timelines, causal claims, names of people/places/organisations, technical details.
2. **For each claim, ask: which part of the source material supports this?** Three outcomes:
   - **Explicitly supported** — matches source content directly; paraphrasing accurate → mark verified.
   - **Unsupported but plausible** — not addressed by the sources; may be external knowledge leaking in → medium severity; flag as unsupported, verify externally if significant.
   - **Contradicts source** — statistics differ, quotes altered or misattributed, details inconsistent → high severity; flag as hallucination, issue correction.
3. **Checklist for each output:**
   - Statistics and numbers present in the sources? Check exact figures; note any rounding or conversion.
   - Quotes actually from the cited sources? Exact wording, representative context, correct attribution.
   - Causal claims supported? The source may show only correlation — the output must not assert causation the source avoids.
   - Dates, names, spellings, and affiliations consistent with the sources?
   - Source limitations acknowledged? Tentative findings must not become definitive.
   - Confidence calibrated to source certainty? Source says "may" → output must not say "does"; preserve ranges and uncertainty.
4. **Document each discrepancy:** the claim → what the source actually says (with page/section) → type (contradiction / unsupported / misattribution) → severity (high for contradictions, medium for unsupported, low for minor detail errors).

**Common patterns:** fabricated citations (made-up papers, wrong authors or years — verify every cited source exists); factual incorrectness (wrong statistics under claimed source support, misrepresented findings); temporal inaccuracy (the source's dated information presented as current, shifted timelines); logical inconsistency (source facts combined into causal claims the sources don't support).

Example record:

```
Claim: "The study found a 45% reduction in error rates"
Source: "Error rates decreased from 18.2% to 10.1%" [p. 7, Results]
Type: calculation discrepancy (actual reduction 44.5%)
Severity: low — acceptable if rounding is noted
```

## Method 3 — Confidence vs correctness separation

**Principle:** never conflate fluent, confident tone with accuracy. Models express high certainty about incorrect information, and hallucinations sound authoritative — "Marie Curie won three Nobel Prizes in Physics" is more dangerous than a hedged error precisely because it is definite and specific.

**Protocol:**

1. Spot confidence signals: definitive verbs, specific unhedged numbers, absolutes ("always", "never") = high; hedges ("may", "possibly"), ranges, caveats = low.
2. Assess source grounding independently of tone: is the claim traceable to specific source content, and does the stated confidence match the source's certainty?
3. Prioritise verification by mismatch:
   - **High confidence + no grounding** → the dangerous pattern; verify immediately, never accept at face value.
   - **High confidence + claimed grounding** (specific citation, page numbers, statistics) → confirm the grounding is real; fabricated citations look exactly like this.
   - **Low confidence + no grounding** → speculation appropriately marked; verify only if the claim is significant.

## Combined protocol for AI-generated content

1. Assess confidence levels (Method 3) → identify high-confidence claims
2. Sources provided → check grounding against them (Method 2)
3. No sources → test consistency across phrasings (Method 1)
4. Prioritise high-confidence, low-grounding claims
5. Proceed with the standard workflow: SIFT, RADAR, triangulation, confidence calibration
