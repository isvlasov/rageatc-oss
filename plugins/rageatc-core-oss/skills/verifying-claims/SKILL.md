---
name: verifying-claims
description: Verifies claims and assesses source credibility. Use when fact-checking claims, verifying accuracy, validating sources, detecting hallucinations, triangulating evidence, or performing SIFT or RADAR assessment.
---

# Verifying Claims

Medium freedom: follow the phases sequentially (extract → mode → assess sources → weight → triangulate → resolve conflicts → calibrate), adapting verification depth to claim significance and risk.

Non-negotiable standards:

- Identical verification standards for all claims (non-partisanship)
- Document every source consulted — transparent audit trail
- Calibrated confidence language; never present uncertain claims as certain
- Surface disagreements between authoritative sources rather than hiding them
- Primary sources over secondary, secondary over tertiary

## Phase 1 — Extract and categorise claims

**Extract** discrete, verifiable assertions: statements presented as fact; names, dates, numbers, statistics, events; asserted causal relationships and predictions; factual claims embedded in interpretive passages.

Example: "The UK's ageing population, which reached 67.3 million in 2021, will strain healthcare resources" yields three claims — population 67.3 million in 2021 (factual), population ageing (factual, needs definition), will strain healthcare (interpretive/predictive).

**Categorise** each claim:

- **Factual/verifiable** — provable with objective evidence (statistics, dates, events, findings) → full verification
- **Interpretive/analytical** — facts plus judgement (causal claims, predictions, impact assessments) → verify the factual basis, assess the reasoning
- **Opinion** — values, beliefs, preferences, aesthetics → do not fact-check; flag as opinion

**Filter uncheckable claims** and note why: future predictions, personal experiences, vague claims ("many people believe…"), hypotheticals.

**Prioritise** by significance (affects key conclusions or decisions), specificity, risk, and feasibility.

## Phase 2 — Select verification mode

**Mode A — Retrospective (sources provided).** Check claims against provided documents; the standard mode for detecting extrinsic hallucinations in AI-generated content. Compare each claim systematically against the sources and flag:

- **Contradiction** — claim conflicts with sources (high severity)
- **Unsupported** — sources should cover it but don't (medium severity)
- **Supported** — explicitly backed by the sources (low/none)

Check: are statistics and numbers present in the sources? Are quotes actually from the cited source? Are causal claims supported? Are dates, names, and details consistent? Does the output acknowledge limitations the sources mention? Is its confidence calibrated to source certainty?

AI-specific detection methods: `references/hallucination-detection.md`.

**Mode B — Proactive (find sources).** No sources provided, or provided sources insufficient. Apply SIFT:

- **Stop** — pause before accepting; a strong emotional reaction or an extraordinary claim means more checking, not less
- **Investigate the source** — lateral reading: leave the source and search what trusted sources say about it ("[source] bias", "[source] credibility", fact-checking sites, Wikipedia entries on the organisation)
- **Find better coverage** — seek consensus across reputable sources; prioritise primary sources and official data; peer-reviewed research for scientific claims
- **Trace claims, quotes, and media** — follow quotes and statistics to their original context; confirm claim-makers are quoted accurately and images aren't decontextualised

## Phase 3 — Assess source quality (RADAR)

Apply to each source before weighting its evidence:

- **Rationale** — why was this created? Important omissions? Neutral or emotionally charged language?
- **Authority** — author credentials; affiliation with reputable institutions?
- **Date** — current enough for the field's pace?
- **Accuracy** — cites reliable sources? Key claims verifiable elsewhere?
- **Relevance** — directly addresses the question?

Full rubric with red flags and scoring: `references/source-evaluation-radar.md`. Always prefer official/primary sources over third-party interpretation.

## Phase 4 — Weight evidence by tier

- **Tier 1 — Primary** (original research papers, official statistics, historical documents, legislation, official organisational statements): 90–100% confidence when multiple primary sources agree. When they exist, cite them directly.
- **Tier 2 — Secondary** (literature reviews, meta-analyses, textbooks, reputable news reporting — Reuters, AP, BBC — expert analysis citing primary evidence): 70–89% confidence when multiple quality sources agree. Use when primary sources are inaccessible or need expert interpretation.
- **Tier 3 — Tertiary** (encyclopaedias including Wikipedia, dictionaries, almanacs): orientation only — too far from firsthand information to cite. Use to find primary and secondary sources.

Context-dependent weighting adjustments: `references/evidence-hierarchy.md`.

## Phase 5 — Triangulate

Significant factual claims require **at least three independent, high-quality sources**.

- **Verify independence**: not citing each other, different organisations, different methodologies or data. Three sources repeating one original claim is weak triangulation.
- Check consistency across time periods, locations, and populations.
- **Strong consensus** (3+ quality sources agree) → Confirmed. **Weak consensus** (2 agree, 1 disagrees) → Likely; investigate the outlier and weight by quality. **No consensus** → Phase 6.
- Record sources consulted, points of agreement and disagreement, quality assessments, and the rationale for the final rating.

## Phase 6 — Resolve conflicting sources

1. **Identify the disagreement precisely** — facts or interpretation? Same question? Different contexts (dates, definitions, methodologies)?
2. **Analyse methodologies** — could method, assumptions, or data access explain the discrepancy?
3. **Assess source quality** — RADAR each; weight by primary vs secondary, domain expertise, track record, recency, independence
4. **Seek additional sources to break the tie** — primary sources, authoritative bodies, systematic reviews, fact-checking organisations
5. **Attribute transparently** — surface the conflict rather than quietly averaging it away: "Source A argues X, while Source B maintains Y". Assign Disputed when authoritative sources disagree and resolution is unclear.

## Phase 7 — Calibrate confidence and document

| Level | Criteria | Language |
|-------|----------|----------|
| **Confirmed** (90–100%) | Multiple high-quality independent sources agree; primary sources consistent; no credible contradiction | "Confirmed", "Verified" |
| **Likely** (70–89%) | Majority of quality sources agree; minor gaps remain | "Likely", "Strong evidence suggests" |
| **Possible** (50–69%) | Some credible support; limited independent verification | "Possible", "Some evidence suggests" |
| **Unverified** (30–49%) | Single-source claim or no authoritative corroboration found | "Unverified", "Cannot confirm" |
| **Disputed** | Authoritative sources explicitly disagree; expert opinion divided | "Disputed", "Experts disagree" |

Percentages are indicative ranges, not calculated scores — the qualitative criteria govern.

**Audit trail** — claims, categorisation rationale, sources with RADAR summaries, search strategies, findings, triangulation results, conflict resolution, confidence rationale, limitations. Standard: a reader can reproduce the verification.

**Corrections** when verification reveals errors: state the incorrect claim against the corrected information with sources; make the correction prominent; record the date, who identified it, and the process; scale to severity (brief note → detailed correction → flag for retraction).

**Per-claim report block:**

```
## Claim: [specific factual assertion]
**Categorisation:** Factual/Interpretive/Opinion/Uncheckable
**Mode:** Retrospective/Proactive
**Sources:** [list with tier + RADAR summary]
**Findings:** [evidence for/against with attribution + triangulation]
**Confidence:** Confirmed/Likely/Possible/Unverified/Disputed
**Rationale:** [why this confidence level]
**Limitations:** [uncertainties/scope boundaries]
```

## Edge cases

- **Mixed factual-opinion** — verify the factual component, flag the opinion: "terrible Prime Minister" (opinion) vs "resigned in 2022" (factual)
- **Scientific consensus** — verify as a statement of expert consensus (check IPCC, scientific bodies for the level of agreement), not as absolute truth; distinguish consensus from individual expert opinion
- **Temporal changes** — disagreeing sources may both be right at different times; note publication dates: "As of [date], X; previously Y"
- **Definitional disagreements** — sources may define terms differently (e.g. "unemployment": ILO vs claimant count); clarify and present both
- **Escalate to domain experts** — specialised technical claims, high-stakes medical/legal claims, divided expert opinion within a field, novel research, complex methodological disputes

More edge cases, time-constrained protocols, and common pitfalls: `references/edge-cases-and-pitfalls.md`.

## Final checklist

- [ ] Every claim extracted and categorised; uncheckables flagged with reasons
- [ ] Three independent sources for significant claims; independence verified, not assumed
- [ ] RADAR applied to all significant sources; primary sources preferred
- [ ] Conflicts surfaced transparently, never averaged away
- [ ] Confidence language matches the assigned level
- [ ] Audit trail complete enough to reproduce the verification
- [ ] Limitations acknowledged; expert review flagged where needed

## References

- `references/source-evaluation-radar.md` — RADAR rubric, red flags, scoring guidance
- `references/hallucination-detection.md` — AI-specific detection (semantic entropy, extrinsic checks, confidence vs correctness)
- `references/evidence-hierarchy.md` — tier detail and context-dependent weighting
- `references/edge-cases-and-pitfalls.md` — additional edge cases, time-constrained protocols, pitfalls
