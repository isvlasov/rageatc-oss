# AI Hallucination Detection Methods

This file provides detailed AI-specific hallucination detection protocols for verifying AI-generated content.

## Overview

AI hallucinations occur when models generate plausible-sounding but incorrect or unsupported information. Detection requires specialised methods beyond traditional fact-checking. This guide covers three primary detection approaches.

---

## The Confidence Problem

**Core insight:** High-confidence hallucinations are particularly dangerous.

### Why Confidence ≠ Accuracy

- **Fluency bias**: AI models generate fluent, grammatically correct text regardless of factual accuracy
- **Confidence calibration failure**: Models often express high certainty about incorrect information
- **Semantic coherence**: Hallucinations fit contextually even when factually wrong
- **Surface plausibility**: Made-up details sound reasonable and well-integrated

### Implications for Verification

**Priority rule:** High-confidence claims lacking source grounding require the most scrutiny.

**Detection strategy:**
1. Identify confident assertions (definitive language, specific details, no hedging)
2. Check for explicit source grounding (can you trace to provided context?)
3. If confident but ungrounded → flag for mandatory verification
4. If tentative and ungrounded → note as speculation

**Example:**
- High-confidence hallucination: "Marie Curie won three Nobel Prizes in Physics" (stated definitively, specific numbers)
- Appropriate tentativeness: "Marie Curie may have won multiple Nobel Prizes" (hedged, less specific)

Both may be wrong, but the first is more dangerous because it appears authoritative.

---

## Detection Method 1: Semantic Entropy

### Principle

Detect hallucinations by checking consistency of meanings across multiple phrasings. When models lack knowledge, responses become inconsistent when questions are rephrased.

### Protocol

**Step 1: Generate multiple phrasings**

Rephrase the question in 3-5 different ways whilst maintaining core meaning.

**Example:**
- Original: "How many Nobel Prizes did Marie Curie win?"
- Rephrase 1: "What is the total count of Nobel Prizes awarded to Marie Curie?"
- Rephrase 2: "In how many different years did Marie Curie receive the Nobel Prize?"
- Rephrase 3: "How many times was Marie Curie a Nobel laureate?"

**Step 2: Regenerate answers**

Get AI responses for each phrasing independently (without conversation history).

**Step 3: Check semantic consistency**

**Question:** Do answers mean the same thing, or do meanings differ?

**Low semantic entropy (consistent meanings):**
- All answers convey equivalent information
- Details may vary but core meaning identical
- Example: "Two Nobel Prizes," "Nobel Prizes in 1903 and 1911," "She won the Nobel Prize twice"
- Interpretation: Model has stable knowledge representation

**High semantic entropy (inconsistent meanings):**
- Answers contradict each other fundamentally
- Different numbers, dates, or facts across phrasings
- Example: "Three Nobel Prizes," "One Nobel Prize in Physics," "Two Nobel Prizes in Chemistry"
- Interpretation: Model lacks grounded knowledge, confabulating

**Step 4: Flag inconsistencies**

**Action for high semantic entropy:**
- Flag claim for mandatory external source verification
- Do not accept model's answer without corroboration
- Note: "AI responses show high semantic entropy; external verification required"

**Action for low semantic entropy:**
- Moderate confidence (stable internal representation)
- Still verify against external sources (stable ≠ correct)
- Deprioritise if time-constrained (focus on high-entropy claims first)

### Application Guidance

**When to use:**
- Verifying AI-generated factual claims without provided sources
- Uncertain about AI's knowledge grounding
- Claims about specific numbers, dates, names, or technical details

**Limitations:**
- Does not replace external verification (only prioritises what to verify)
- Requires multiple AI queries (time cost)
- Low entropy can still be confidently wrong (rare but possible)

**Integration with broader workflow:**
- Use semantic entropy for prioritisation within Phase 1 (Claim Extraction)
- High-entropy claims move to front of verification queue
- Still proceed with Phase 2 onwards (source discovery and verification)

---

## Detection Method 2: Extrinsic Hallucination Checks

### Principle

Extrinsic hallucinations occur when AI output conflicts with or ignores provided context. Detection requires systematic comparison between generated content and source material.

### Use Case

**Primary scenario:** Retrospective verification (Mode A) - checking AI summaries, analyses, or responses against provided documents, research papers, or context.

**Example tasks:**
- AI summarised a research paper → verify summary against original paper
- AI answered question using provided context → verify answer matches context
- AI synthesised information from multiple sources → verify synthesis is grounded

### Protocol

**Step 1: Systematic claim extraction**

Extract all factual assertions from AI output.

**Focus on:**
- Statistics and numbers
- Quotes and attributions
- Dates and timelines
- Causal claims and relationships
- Names of people, places, organisations
- Technical details and specifications

**Step 2: Token-level attribution tracking**

For each extracted claim, ask: **"Which part of the provided source material supports this?"**

**Possible outcomes:**

**Explicitly supported:**
- Claim matches source content directly
- Statistics, quotes, dates found in source
- Paraphrasing is accurate
- Severity: None (correct usage)
- Action: Mark as verified

**Unsupported but plausible:**
- Claim not addressed by provided sources
- Could be true but lacks grounding in provided context
- AI may have used external knowledge when should use only provided sources
- Severity: Medium
- Action: Flag as unsupported; verify externally if claim is significant

**Contradicts source:**
- Claim conflicts with provided source material
- Statistics differ from source
- Quotes misattributed or altered
- Dates, names, or details inconsistent with source
- Severity: High
- Action: Flag as hallucination; issue correction

**Step 3: Apply extrinsic hallucination checklist**

- [ ] Are statistics and numbers present in provided sources?
  - Check exact figures, not just approximate
  - Note any rounding or conversion (e.g., percentages calculated from raw numbers)

- [ ] Are quoted statements actually from cited sources?
  - Verify exact wording
  - Check surrounding context (is quote representative or cherry-picked?)
  - Confirm attribution (correct author, publication, date)

- [ ] Are causal claims supported by provided research?
  - Check if source establishes causation or merely correlation
  - Verify strength of claim matches source's confidence level
  - Note if source explicitly avoids causal language whilst AI asserts it

- [ ] Are dates, names, and specific details consistent with sources?
  - Verify spellings
  - Check dates and timelines
  - Confirm organisational names and affiliations

- [ ] Does output acknowledge limitations mentioned in sources?
  - Check if source notes uncertainties or caveats
  - Verify AI doesn't present tentative findings as definitive
  - Confirm confidence calibration matches source

- [ ] Are confidence levels calibrated to source certainty?
  - Source says "may" → AI should not say "does"
  - Source says "preliminary findings" → AI should not say "proven"
  - Source gives ranges or uncertainty → AI should preserve that

**Step 4: Document discrepancies**

For each contradiction or unsupported claim, record:
- **Claim:** What the AI stated
- **Source content:** What the source actually says (with page/section reference)
- **Discrepancy type:** Contradiction, unsupported, misattribution
- **Severity:** High (contradiction), Medium (unsupported), Low (minor detail error)

**Step 5: Comparison-based detection (optional advanced check)**

**Method:**
1. Generate AI response WITH provided context
2. Generate AI response WITHOUT provided context
3. Compare outputs

**What to look for:**
- If outputs are very similar despite distinctive context → AI may be ignoring provided sources
- If context-free response includes claims from provided context → external knowledge contamination
- If with-context response has contradictions that without-context does not → context-processing error

**Interpretation:**
- High similarity suggests context-ignoring behaviour
- Flag claims appearing in both as potentially ungrounded
- Verify these claims are actually in provided sources

### Common Extrinsic Hallucination Patterns

**Pattern 1: Fabricated citations (15% of hallucinations)**
- Made-up source names
- Non-existent papers or articles
- Incorrect publication years or authors

**Detection:** Verify every cited source exists and is correctly attributed

**Pattern 2: Factual incorrectness (38% of hallucinations)**
- Wrong statistics whilst claiming source support
- Misrepresented findings
- Incorrect technical details

**Detection:** Compare every factual assertion against source

**Pattern 3: Temporal inaccuracy (8% of hallucinations)**
- Outdated information from source presented as current
- Dates shifted or confused
- Event timelines wrong

**Detection:** Check all temporal claims against source dates

**Pattern 4: Logical inconsistency (7% of hallucinations)**
- AI combines information from sources in contradictory ways
- Self-contradictory statements within output
- Causal claims not supported by sources' logic

**Detection:** Check logical coherence and causal reasoning against source structure

### Integration with Core Workflow

**Use extrinsic hallucination checks during:**
- **Phase 2, Mode A (Retrospective Verification):** Primary application
- **Phase 1, Step 1:** Extract claims systematically from AI output
- **Phase 7:** Document extrinsic hallucinations as part of verification report

**Output format:**
```
**Extrinsic Hallucination Detected**

Claim: "The study found a 45% reduction in error rates using the new method"
Source content: "Error rates decreased from 18.2% to 10.1% (p < 0.01)" [Page 7, Results section]
Discrepancy: Minor calculation difference (claim states 45%, actual reduction is 44.5%)
Severity: Low (rounding acceptable if noted)
Action: Verify rounding is appropriate; note precise figure in report
```

---

## Detection Method 3: Confidence vs Correctness Separation

### Principle

Never conflate fluent, confident tone with factual accuracy. AI models can hallucinate with high apparent confidence.

### Protocol

**Step 1: Identify confidence signals in AI output**

**High-confidence language:**
- Definitive statements ("is", "does", "will")
- Specific numbers without hedging
- Absolute terms ("always", "never", "all")
- No uncertainty markers

**Low-confidence language:**
- Hedging ("may", "might", "possibly")
- Uncertainty markers ("unclear", "unknown")
- Ranges instead of specific numbers
- Caveats and qualifications

**Step 2: Assess source grounding independently**

**For each confident assertion, ask:**
1. Is this explicitly supported by provided sources?
2. Can I trace this claim to specific source content?
3. Is the confidence level appropriate to source certainty?

**Step 3: Flag confidence-correctness mismatches**

**Dangerous pattern: High confidence + No source grounding**
- AI states something definitively without source support
- Appears authoritative but may be fabricated
- Priority: Verify immediately; do not accept at face value

**Acceptable pattern: Low confidence + No source grounding**
- AI hedges or notes uncertainty
- Speculative or exploratory language
- Priority: Lower urgency; verify if claim is significant

**Ideal pattern: Calibrated confidence + Source grounding**
- Confidence level matches source certainty
- Definitive when sources are definitive
- Tentative when sources are tentative
- Priority: Verify source grounding is accurate

**Step 4: Apply verification priority**

**Priority 1 (verify first):** High-confidence unsupported claims
**Priority 2 (verify next):** High-confidence supported claims (confirm source grounding)
**Priority 3 (verify if time permits):** Low-confidence claims

### Example Application

**Scenario:** AI generates research summary

**AI output 1:** "The study conclusively proves that X causes Y with a 78% effect size."

**Analysis:**
- Confidence: Very high ("conclusively proves", specific percentage)
- Check source: Does study use "proves" language? Does it claim 78% effect size?
- If source is tentative or uses different numbers → High-priority hallucination flag

**AI output 2:** "The study suggests a possible relationship between X and Y, though effect size is uncertain."

**Analysis:**
- Confidence: Low ("suggests", "possible", "uncertain")
- Check source: Is this accurate hedging or over-cautious?
- Lower priority for verification (appropriate uncertainty noted)

**AI output 3:** "According to the study (p. 15), X was associated with Y (r = 0.78, p < 0.01)."

**Analysis:**
- Confidence: High (specific citation, statistics)
- Source grounding: Claims specific page and statistics
- Action: Verify page 15 contains these statistics; confirm interpretation
- If verified → Correctly grounded high-confidence claim
- If not verified → Fabricated citation (high-severity hallucination)

---

## Integration Summary

### When to Use Each Method

**Semantic Entropy:**
- No sources provided (proactive verification mode)
- Prioritising which claims to verify first
- Uncertain about model's knowledge on topic

**Extrinsic Hallucination Checks:**
- Sources provided (retrospective verification mode)
- Verifying AI summaries, analyses, or syntheses
- Checking AI adherence to provided context

**Confidence vs Correctness:**
- All AI-generated content (universal application)
- Prioritising verification effort
- Calibrating output confidence levels

### Combined Protocol for AI-Generated Content

1. **Assess confidence levels** (Method 3) → Identify high-confidence claims
2. **Check source grounding** (Method 2 if sources provided) → Verify claims against sources
3. **Apply semantic entropy** (Method 1 if no sources) → Test consistency across phrasings
4. **Prioritise verification** → Focus on high-confidence, low-grounding claims
5. **Proceed with standard workflow** → SIFT, RADAR, triangulation, confidence calibration

---

## Key Principles

1. **Fluency ≠ accuracy**: Confident, well-written AI output can be entirely fabricated
2. **Always verify high-confidence claims**: These are most dangerous when wrong
3. **Source grounding is mandatory**: Trace every significant claim to evidence
4. **Semantic consistency indicates stability**: But stable doesn't mean correct
5. **Use AI-specific checks alongside traditional fact-checking**: Both are necessary

---

## Quick Reference

### Extrinsic Hallucination Red Flags

- Statistics not in provided sources
- Quotes that don't appear in cited sources
- Causal claims when source only shows correlation
- Definitive language when source is tentative
- Missing source limitations or caveats
- Fabricated citations or references
- Details inconsistent with source content

### Verification Priority

**Verify immediately:**
- High confidence + no source grounding
- Contradicts provided sources
- High semantic entropy across phrasings

**Verify thoroughly:**
- High confidence + claimed source grounding (confirm grounding)
- Key statistics and numbers
- Causal and interpretive claims

**Verify if time permits:**
- Low confidence + appropriate hedging
- Background claims not central to argument
- Low semantic entropy with source support
