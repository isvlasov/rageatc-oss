---
name: verifying-claims
description: Systematically verifies claims and assesses source credibility using journalism standards (IFCN), the SIFT method (Stop, Investigate source, Find coverage, Trace claims), and RADAR framework (Rationale, Authority, Date, Accuracy, Relevance). Performs retrospective verification with provided sources or proactive validation by finding evidence. Applies multi-source triangulation, evidence hierarchy assessment, AI hallucination detection through extrinsic checks, and confidence calibration (Confirmed/Likely/Possible/Unverified/Disputed). Use when you need to fact-check claims, verify accuracy, validate sources, detect hallucinations, check if statements are true or accurate, perform SIFT or RADAR assessment, triangulate evidence, or when fact-checker-agent requires claim verification and confidence calibration.
---

# Verifying Claims

## Purpose

Systematically verify factual claims in both AI-generated and human-generated content using established journalism standards, academic source evaluation frameworks, and AI-specific hallucination detection methods.

This skill enables rigorous fact-checking through:
- Claim categorisation (factual/interpretive/opinion)
- Multi-source triangulation and cross-referencing
- Source quality assessment using established criteria
- AI hallucination detection (semantic entropy, extrinsic checks)
- Conflicting source resolution protocols
- Transparent confidence calibration

## When to Use This Skill

**Primary triggers:**
- User requests fact-checking, claim verification, or accuracy assessment
- Reviewing research outputs or AI-generated content for reliability
- Validating sources cited in documents or reports
- Detecting potential hallucinations in AI responses
- Resolving conflicting information across sources
- Assessing information quality before relying on it

**Integration contexts:**
- Used by researcher-agent to validate research findings
- Used by critic-agent to assess factual accuracy in artefacts
- Used by producer-agent to ensure reliable sourcing
- Used as verification gate before finalising deliverables

## Inputs Required

**Always required:**
- [ ] **Claim(s) to verify** - Specific statements requiring fact-checking
- [ ] **Verification mode** - Retrospective (sources provided) OR Proactive (find sources)

**Context-dependent:**
- [ ] **Provided sources** (for retrospective verification) - Documents, research, context materials
- [ ] **Domain context** - Field-specific considerations (medical, legal, technical, etc.)
- [ ] **Risk level** - Significance of accuracy (high-stakes decisions vs casual inquiry)
- [ ] **Time constraints** - Available time affects verification depth

## Outputs Produced

**Core verification report:**
1. **Claims extracted** - Specific factual assertions identified
2. **Categorisation** - Each claim classified (factual/interpretive/opinion/uncheckable)
3. **Sources evaluated** - Quality assessment using RADAR criteria for each source
4. **Verification findings** - Evidence for/against each claim with source attribution
5. **Confidence assessment** - Calibrated rating (confirmed/likely/possible/unverified/disputed)
6. **Audit trail** - Complete documentation of verification process

**Optional outputs:**
- Recommendations for addressing unverified or disputed claims
- Flags for claims requiring domain expert review
- Suggested corrections for identified inaccuracies

## Operating Principles

**Medium freedom with preferred patterns:**
- Follow the core workflow sequentially (claim categorisation → source mode → verification → confidence assignment)
- Apply SIFT method and triangulation protocols as standard practice
- Use RADAR criteria for source quality assessment (see `references/source-evaluation-radar.md`)
- Adapt verification depth based on claim significance and risk
- Exercise judgement on when to escalate to domain experts

**Non-negotiable standards:**
- Apply identical verification standards to all claims (non-partisanship)
- Document all sources consulted with transparent audit trail
- Use calibrated confidence language (never present uncertain claims as certain)
- Surface disagreements between authoritative sources rather than hiding them
- Prioritise primary sources over secondary sources over tertiary sources

## Core Workflow

### Phase 1: Claim Extraction and Categorisation

**Step 1: Extract specific factual claims**

Identify discrete, verifiable assertions within the content.

**Questions to guide extraction:**
- What specific statements are presented as facts?
- Which claims involve names, dates, numbers, statistics, or events?
- What causal relationships or predictions are asserted?
- Are there embedded factual claims within interpretive passages?

**Example:**
- Content: "The UK's ageing population, which reached 67.3 million in 2021, will strain healthcare resources."
- Extracted claims:
  - Claim 1: "UK population reached 67.3 million in 2021" (factual)
  - Claim 2: "UK population is ageing" (factual, requires definition)
  - Claim 3: "Ageing population will strain healthcare resources" (interpretive/predictive)

**Step 2: Categorise each claim**

Use the three-category taxonomy to determine verification approach.

**Category 1: Factual/Verifiable Claims**
- Definition: Statements provable or disprovable using objective evidence
- Characteristics: Specific, testable, has objective truth value
- Examples: Statistics, dates, historical events, scientific findings
- Action: **Proceed with full verification**

**Category 2: Interpretive/Analytical Claims**
- Definition: Combines facts with interpretation, analysis, or prediction
- Characteristics: Requires reasoning assessment, involves judgement
- Examples: Causal claims, predictions, impact assessments
- Action: **Verify factual basis, assess reasoning quality**

**Category 3: Opinion/Non-Verifiable Statements**
- Definition: Values, beliefs, preferences, or personal experiences
- Characteristics: Subjective, no objective standard for verification
- Examples: Aesthetic judgements, moral prescriptions, preferences
- Action: **Do not attempt to fact-check; flag as opinion**

**Step 3: Filter uncheckable claims**

Identify claims that cannot be verified even if factual in nature.

**Uncheckable categories:**
- **Predictions about the future** - Cannot verify until time passes
- **Personal experiences** - No external verification possible
- **Vague claims** - "Many people believe..." (who? how many?)
- **Hypotheticals** - "If X had happened, Y would have occurred"

**Action:** Flag as uncheckable and note why verification is impossible.

**Step 4: Prioritise verification efforts**

For multiple claims, assess priority based on:
- **Significance** - Claims affecting key conclusions or decisions (highest priority)
- **Specificity** - Concrete, checkable assertions (easier to verify efficiently)
- **Risk** - High-stakes contexts require thorough verification
- **Feasibility** - Available sources and expertise

Focus resources on high-priority factual claims.

---

### Phase 2: Source Mode Selection and Discovery

**Choose verification approach based on context.**

#### Mode A: Retrospective Verification (Sources Provided)

**When to use:** Checking claims against provided context, documents, or source material. Common for detecting extrinsic hallucinations in AI-generated content.

**Protocol:**
1. **Extract claims from AI output or document**
2. **Compare systematically against provided sources**
3. **Flag contradictions** (claim conflicts with sources - severity high)
4. **Flag unsupported claims** (claim unaddressed by sources when sources should cover it - severity medium)
5. **Verify supported claims** (claim explicitly backed by provided sources - severity low/none)

**Extrinsic hallucination checklist:**
- [ ] Are statistics and numbers present in provided sources?
- [ ] Are quoted statements actually from cited sources?
- [ ] Are causal claims supported by provided research?
- [ ] Are dates, names, and specific details consistent with sources?
- [ ] Does output acknowledge limitations mentioned in sources?
- [ ] Are confidence levels calibrated to source certainty?

**Key focus:** Detecting when AI ignores or contradicts provided ground truth.

For detailed AI hallucination detection methods, see `references/hallucination-detection.md`.

#### Mode B: Proactive Validation (Find Sources)

**When to use:** No sources provided, or provided sources insufficient. Requires web search and source discovery.

**Protocol - Apply SIFT Method:**

**S - Stop**
- Pause before accepting or sharing claim
- Check your emotional reaction (strong emotions = increased checking needed)
- Assess claim plausibility (extraordinary claims require extraordinary evidence)

**I - Investigate the Source**
- Practice lateral reading: leave the source and open new tabs
- Search what trusted sources say about the original source
- Check fact-checking sites (Snopes, FactCheck.org, PolitiFact)
- Look for Wikipedia entries on organisations or publications
- Search "[source name] + bias" or "[source name] + credibility"

**F - Find Better Coverage**
- Search for other trusted sources on the same topic
- Look for consensus across multiple reputable sources
- Prioritise primary sources (original research, official data)
- Check if major news organisations (Reuters, AP, BBC) covered the story
- Seek peer-reviewed research for scientific claims

**T - Trace Claims, Quotes, and Media**
- Follow quotes back to original context
- Verify images haven't been taken out of context
- Check if statistics are cited correctly
- Look for original research papers or official documents
- Confirm claim-makers are quoted accurately

---

### Phase 3: Source Quality Assessment

**Evaluate every source using RADAR criteria.**

Apply systematically to each source before weighting its evidence. For detailed RADAR framework with red flags and scoring guidance, see `references/source-evaluation-radar.md`.

**Quick RADAR summary:**

- **R - Rationale (Purpose and Bias)**: Why was this created? Are important facts omitted? Is language neutral or emotionally charged?
- **A - Authority (Credibility)**: What are the author's credentials? Is the author affiliated with reputable institutions?
- **D - Date (Currency)**: When was this published? Is this information still current for the field?
- **A - Accuracy (Verification)**: Does this cite reliable sources? Can you verify key claims elsewhere?
- **R - Relevance (Applicability)**: Does this directly address your research question?

**Priority:** Always prefer official/primary sources over third-party interpretations.

---

### Phase 4: Evidence Hierarchy and Weighting

**Apply systematic source weighting using the primary/secondary/tertiary framework.**

#### Tier 1: Primary Sources (Highest Weight)

**Definition:** Original documents of events, discoveries, or research.

**Examples:** Original research papers, official statistics (ONS, census), historical documents, legislation, patents, official organisational statements

**Weight:** 90-100% confidence when multiple primary sources agree

**Standard:** "Always prefer primary sources over secondary sources." When primary sources exist, cite them directly.

#### Tier 2: Secondary Sources (High Weight)

**Definition:** Analysis, reviews, or summaries of primary sources providing context and interpretation.

**Examples:** Literature reviews and meta-analyses, academic textbooks, reputable news reporting (Reuters, AP, BBC), systematic reviews, expert analysis citing primary evidence

**Weight:** 70-89% confidence when multiple quality secondary sources agree

**Use cases:** When primary sources are inaccessible or require expert interpretation.

#### Tier 3: Tertiary Sources (Low Weight)

**Definition:** Indexes or consolidations of primary and secondary sources without new analysis.

**Examples:** Encyclopaedias (including Wikipedia), dictionaries, handbooks, fact books and almanacs

**Weight:** Useful for orientation only; insufficient for citation

**Standard:** "Tertiary sources are usually not acceptable as cited sources in research because they are so far from firsthand information."

**Appropriate use:** Initial orientation, finding primary/secondary sources, quick fact checks requiring verification.

For context-dependent adjustments and detailed weighting guidance, see `references/evidence-hierarchy.md`.

---

### Phase 5: Multi-Source Triangulation

**Verify significant factual claims with at least three independent, high-quality sources.**

#### Triangulation Protocol

**Step 1: Ensure source independence**

Verify sources are truly independent:
- Not citing each other directly
- Different organisations/institutions
- Different methodologies or data sources
- Different perspectives or contexts

**Red flag:** Three sources all citing the same original claim without independent verification provides weak triangulation.

**Step 2: Apply data triangulation**

Check claims across:
- Different time periods (temporal consistency)
- Different geographic locations (spatial consistency)
- Different groups or populations (demographic consistency)

**Step 3: Seek consensus**

**Strong consensus (3+ high-quality sources agree):**
- Confidence: Confirmed
- Action: Accept as established fact with attribution

**Weak consensus (2 sources agree, 1 disagrees):**
- Confidence: Likely
- Action: Investigate outlier, weight by source quality, note disagreement

**No consensus (sources contradict):**
- Confidence: Disputed
- Action: Proceed to conflicting source resolution protocol (Phase 6)

**Step 4: Document triangulation**

Record for audit trail:
- Which sources consulted
- Points of agreement and disagreement
- Quality assessment for each source
- Rationale for final confidence rating

---

### Phase 6: Handling Conflicting Sources

**Five-step resolution protocol:**

**1. Identify disagreement:** Pinpoint exactly what sources disagree about (facts vs interpretation? same question? different contexts? Example: Different unemployment figures may reflect different dates or methodologies)

**2. Analyse methodologies:** Examine how each source arrived at their conclusion (methods used, assumptions, data access, limitations, could methodology explain discrepancy?)

**3. Assess source quality:** Apply RADAR to each. Weight by: primary vs secondary, expertise in domain, track record, recency (context-dependent), independence

**4. Seek additional sources:** Find third/fourth sources to break tie (search for primary sources, consult experts, check authoritative bodies, systematic reviews, fact-checking organisations). When multiple high-quality sources agree, outliers receive less weight.

**5. Transparent attribution:** Present disagreement with caveats. **Core principle:** "Surface the conflict rather than quietly averaging it away." Use patterns like "Source A argues X, while Source B maintains Y" or "Most experts agree X, though [Source Y] argues Z" or "Evidence insufficient; experts divided." Assign "Disputed" when authoritative sources disagree and resolution unclear.

---

### Phase 7: Confidence Calibration and Documentation

**Assign calibrated confidence levels and create transparent audit trail.**

#### Confidence Level Definitions

**Confirmed (90-100% confidence)**
- Multiple high-quality independent sources agree
- Primary sources available and consistent
- No credible contradictory evidence
- Language: "Confirmed," "Established fact," "Verified"

**Likely (70-89% confidence)**
- Strong support from quality sources
- Majority of sources agree
- Minor uncertainties or gaps remain
- Language: "Likely," "Probably," "Strong evidence suggests"

**Possible (50-69% confidence)**
- Some credible support
- Limited independent verification
- Significant uncertainties remain
- Language: "Possible," "May be," "Some evidence suggests"

**Unverified (30-49% confidence)**
- Insufficient evidence to confirm
- Single-source claims without corroboration
- Unable to find authoritative sources
- Language: "Unverified," "Cannot confirm," "Insufficient evidence"

**Disputed (varies)**
- Authoritative sources explicitly disagree
- Methodological conflicts unresolved
- Expert opinion divided
- Language: "Disputed," "Experts disagree," "Conflicting evidence"

**Note:** Confidence percentages are indicative ranges based on source quality and triangulation strength, not calculated scores. Use the qualitative criteria (multiple sources agree, etc.) as primary guidance.

#### Documentation Requirements

**Create complete audit trail:** Claims extracted, categorisation rationale, sources consulted (with RADAR), search strategies, verification findings, triangulation results, conflict resolution, confidence assignment rationale, limitations acknowledged.

**Transparency standard:** Enable readers to reproduce your verification process.

#### Correction Protocols

**When verification reveals errors:**

1. **Document clearly:** Specify incorrect claim vs corrected information, cite sources, note severity
2. **Communicate transparently:** Make corrections prominent, explain what was wrong, acknowledge openly
3. **Maintain audit trail:** Record date, who identified error, verification process, preserve original context
4. **Proportionality:** Minor errors (brief note), significant errors (detailed correction), critical errors (flag for review/retraction)

**Example:** "Correction [Date]: Original claim stated 'Marie Curie won three Nobel Prizes in Physics.' Verification confirms two Nobel Prizes: Physics (1903) and Chemistry (1911). Claim incorrect in number and field(s)."

#### Final Verification Report Format

```
## Claim: [Specific factual assertion]
**Categorisation:** Factual/Interpretive/Opinion/Uncheckable
**Mode:** Retrospective/Proactive
**Sources:** [List with tier + RADAR summary]
**Findings:** [Evidence for/against with attribution + triangulation]
**Confidence:** Confirmed/Likely/Possible/Unverified/Disputed
**Rationale:** [Why this confidence level]
**Limitations:** [Uncertainties/scope boundaries]
```

---

## Edge Cases and Constraints

**Mixed Factual-Opinion:** Separate factual components (verify) from opinions (flag as subjective, don't verify). Example: "terrible Prime Minister" (opinion) vs "resigned in 2022" (factual).

**Scientific Consensus:** Verify as statement of expert consensus (check IPCC, scientific bodies for level of agreement), not as absolute truth. Distinguish consensus from individual expert opinions.

**Temporal Changes:** When sources disagree on facts, check if facts changed over time. Note publication dates; present: "As of [date], X; previously it was Y"

**Definitional Disagreements:** Sources may use different definitions (e.g., "unemployment": ILO vs claimant count). Clarify definitions; present both: "By definition A, X; by definition B, Y"

**Expert Review Escalation:** Flag for domain experts when encountering: technical claims requiring specialised knowledge, medical/legal high-stakes claims, conflicting expert opinions within specialist field, novel research, complex methodological disputes.

For additional edge cases and common pitfalls, see `references/edge-cases-and-pitfalls.md`.

---

## Integration with Other Skills

### Conducting Research (`conducting-research`)

**Integration point:** Phase 2 (Source Identification and Evaluation)

**Enhancement:** This skill's RADAR framework and evidence hierarchy can strengthen source evaluation in research workflows.

**Workflow:** Use `conducting-research` for comprehensive topic investigation; use `verifying-claims` for targeted fact-checking of specific assertions.

### Assessing Quality (`assessing-quality`)

**Integration point:** Factual accuracy is one dimension of quality assessment.

**Workflow:** Quality assessment may invoke claim verification for factual claims in artefacts under review.

### Workflow (`skills/designing-workflow/SKILL.md`, File Naming and Versioning section)

**Integration point:** Verification serves as quality gate before finalising deliverables.

**Workflow:** Producer should fact-check claims before submitting artefacts; critic should verify factual accuracy during review.

---

## Evaluation Scenarios

### Scenario 1: Verifying Factual Claim with Primary Source

**Task:** Verify "The IFCN Code of Principles requires signatories to meet 31 criteria"

**Expected process:** Categorise as factual → Proactive mode → Apply SIFT (find IFCN.org official documentation) → RADAR assessment (primary source, high authority) → Count criteria in official code → Triangulate with secondary sources if available → Assign confidence (Confirmed if matches, or issue correction if differs)

**Success criteria:** Locates primary source, counts correctly, assigns appropriate confidence, provides attribution, issues correction if needed.

### Scenario 2: Detecting AI Hallucination (Extrinsic)

**Task:** AI summarises provided research paper. Check if claims match source.

**Expected process:** Extract claims from AI summary → Compare against original paper (retrospective mode) → Apply extrinsic hallucination checklist → Flag contradictions (high severity) and unsupported claims (medium severity) → Document with source references

**Success criteria:** Identifies contradictions vs unsupported claims, provides specific source attribution, recommends corrections.

### Scenario 3: Resolving Conflicting Authoritative Sources

**Task:** Three reputable sources provide different dates for the same event

**Expected process:** Identify disagreement point → Analyse methodologies (timezone/definition differences?) → RADAR assessment → Seek primary source → Determine if definitional or factual → Present transparently if unresolvable → Assign appropriate confidence

**Success criteria:** Investigates root cause, seeks primary source, presents disagreement transparently, does not arbitrarily choose, uses appropriate confidence language.

For additional worked examples, see `examples.md`.

---

## Quality Checklist

Before finalising verification report, confirm:

- [ ] All factual claims extracted and categorised (factual/interpretive/opinion)
- [ ] Uncheckable claims filtered and flagged appropriately
- [ ] Appropriate verification mode selected (retrospective/proactive)
- [ ] SIFT method applied for proactive verification
- [ ] RADAR criteria assessed for all significant sources
- [ ] Evidence hierarchy applied (primary > secondary > tertiary)
- [ ] Minimum three independent sources for significant claims (triangulation)
- [ ] AI-specific checks applied where relevant (semantic entropy, extrinsic hallucinations)
- [ ] Conflicting sources resolved or disagreement surfaced transparently
- [ ] Confidence levels calibrated and language appropriate
- [ ] Complete audit trail documented (sources, methods, reasoning)
- [ ] Limitations acknowledged explicitly
- [ ] Expert review flagged where needed
- [ ] Non-partisan approach maintained (identical standards for all claims)
- [ ] Corrections documented and communicated transparently if errors discovered

---

## Supporting Files

This skill uses progressive disclosure. Core workflow is in this file; detailed reference material is in supporting files:

- **`references/source-evaluation-radar.md`** - Detailed RADAR criteria with red flags, scoring guidance, and context-dependent standards
- **`references/hallucination-detection.md`** - AI-specific detection methods (semantic entropy, HaluGate, extrinsic hallucination checks, confidence vs correctness)
- **`references/evidence-hierarchy.md`** - Detailed evidence tier definitions and context-dependent weighting adjustments
- **`references/edge-cases-and-pitfalls.md`** - Additional edge cases, time-constrained verification protocols, and common pitfalls to avoid
- **`examples.md`** - Extended worked examples demonstrating complete verification workflows
