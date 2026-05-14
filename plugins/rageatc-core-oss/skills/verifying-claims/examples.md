# Worked Examples: Verifying Claims

This file provides extended examples demonstrating complete verification workflows for different scenarios.

---

## Example 1: Verifying AI-Generated Research Summary (Retrospective Mode)

### Scenario

AI summarised a research paper and made specific claims. Verify against original paper to detect extrinsic hallucinations.

### Input

**Claim:** "The study found a 45% reduction in error rates using the new method"

**Provided source:** Original research paper (PDF)

**Verification mode:** Retrospective (sources provided)

### Complete Workflow

#### Phase 1: Claim Extraction and Categorisation

**Extracted claim:** "45% reduction in error rates"

**Categorisation:** Factual/verifiable claim (specific statistic that can be checked against source)

**Uncheckable filter:** Not uncheckable (concrete statistic, not prediction or vague assertion)

**Priority:** High (key finding, numerical claim)

#### Phase 2: Mode Selection

**Mode:** Retrospective verification - comparing AI output against provided research paper

**Rationale:** Checking for extrinsic hallucination (did AI accurately represent source?)

#### Phase 3: Source Quality Assessment

**Source:** Original peer-reviewed research paper

**RADAR assessment:**
- **Rationale:** Original research, methodology disclosed, peer-reviewed (low bias)
- **Authority:** Published in reputable journal, authors have relevant credentials
- **Date:** Recent publication (2024)
- **Accuracy:** Peer-reviewed, methodology transparent, data provided
- **Relevance:** This is the source being verified against (directly relevant)

**Tier level:** Tier 1 (Primary source - original research)

#### Phase 4: Verification Against Source

**Action:** Read original paper's results section

**Finding in source:**
- Section 3.2, Results, page 7: "Error rates decreased from 18.2% (baseline) to 10.1% (new method), p < 0.01"
- Calculation: (18.2 - 10.1) / 18.2 = 0.445 = 44.5% reduction

**Comparison:**
- AI claim: 45% reduction
- Source data: 44.5% reduction (rounded to 45%)

#### Phase 5: Triangulation

**Not applicable for retrospective verification** - checking against provided source only

**Note:** If this were proactive mode, would seek corroboration from other research

#### Phase 6: Extrinsic Hallucination Check

**Checklist application:**
- [x] Are statistics present in provided source? YES - 18.2% to 10.1% found in source
- [x] Calculation correct? YES - 44.5% rounds to 45%
- [x] Context preserved? Check if p-value and method details mentioned... AI didn't mention p < 0.01 or method specifics
- [x] Confidence calibrated? Source presents as statistically significant; AI presents as simple finding

**Assessment:**
- **Supported with minor rounding:** Claim is essentially accurate (45% vs 44.5% is acceptable rounding)
- **Context partially missing:** AI omitted statistical significance (p < 0.01) and baseline/new method comparison structure

**Severity:** Low (claim supported; missing context would be beneficial but not critical error)

#### Phase 7: Confidence Calibration

**Confidence level:** Confirmed (claim is supported by primary source with negligible rounding)

**Qualification:** Note that statistical significance and methodological context from source would strengthen the claim

#### Documentation

**Verification report:**

```
## Claim: "The study found a 45% reduction in error rates using the new method"

**Categorisation:** Factual/verifiable

**Verification Mode:** Retrospective (verified against provided research paper)

**Source Evaluated:**
1. [Author et al., 2024] Original research paper - Tier 1 primary source - High RADAR quality

**Findings:**
- Supporting evidence: Original paper (p. 7, Results section) reports error rates decreased from 18.2% to 10.1%, which equals 44.5% reduction
- AI claim of 45% represents acceptable rounding of 44.5%
- Statistical significance (p < 0.01) noted in source but omitted from AI summary
- Triangulation: N/A (retrospective verification against single provided source)

**Confidence Level:** Confirmed

**Rationale:** Claim is directly supported by primary source with negligible rounding (44.5% vs 45%). Statistical significance context omitted but factual assertion is accurate.

**Limitations:** AI summary could be strengthened by including p-value and methodological details from source.
```

**Recommendation:** Minor enhancement suggested - add statistical significance and method details for completeness, but no correction required.

---

## Example 2: Fact-Checking News Claim (Proactive Mode)

### Scenario

User asks to verify claim with no sources provided. Must find authoritative sources through web search.

### Input

**Claim:** "UK unemployment reached 4.2% in November 2025"

**Provided sources:** None

**Verification mode:** Proactive (find sources)

### Complete Workflow

#### Phase 1: Claim Extraction and Categorisation

**Extracted claim:** "UK unemployment reached 4.2% in November 2025"

**Categorisation:** Factual/verifiable claim (official statistic with specific date and figure)

**Uncheckable filter:** Not uncheckable (government statistics are regularly published and verifiable)

**Priority:** High (specific numerical claim that is either correct or incorrect)

#### Phase 2: SIFT Method Application

**S - Stop:**
- Assess plausibility: Unemployment statistics are routinely published by ONS
- 4.2% is within normal range for UK unemployment
- No emotional reaction triggered
- Claim appears plausible but requires verification

**I - Investigate the Source:**
- Original claim source not provided
- Need to find official authoritative source (ONS)
- Will search for ONS Labour Market statistics

**F - Find Better Coverage:**
- Target: ONS official statistics (primary source)
- Secondary: Reputable news reporting ONS data (Reuters, BBC)
- Will search: "ONS unemployment November 2025"

**T - Trace Claims to Origin:**
- Will locate ONS Labour Market Overview bulletin
- Verify this is official ONS publication, not third-party interpretation
- Check for original data tables

#### Phase 3: Source Discovery and Quality Assessment

**Sources found:**

**Source 1: ONS Labour Market Overview, November 2025**
- URL: [ons.gov.uk/labour-market/november-2025]
- Publication date: 12 December 2025

**RADAR assessment:**
- **Rationale:** Official government statistics, transparent methodology, non-partisan
- **Authority:** ONS is the UK's official statistical agency (highest credibility for UK data)
- **Date:** Published December 2025 for November 2025 data (current and relevant)
- **Accuracy:** Primary source with transparent methodology, internationally recognised standards
- **Relevance:** Directly addresses the claim (UK unemployment for specified month)

**Tier level:** Tier 1 (Primary source - original official data)

**Source 2: Bank of England Monetary Policy Report, December 2025**
- Cites ONS unemployment data

**RADAR assessment:**
- **Rationale:** Economic analysis, cites primary sources
- **Authority:** Bank of England (high credibility for economic data)
- **Date:** December 2025 (current)
- **Accuracy:** Cites ONS directly (traceable)
- **Relevance:** Relevant (reports UK economic indicators)

**Tier level:** Tier 2 (Secondary source citing primary source)

**Source 3: BBC News article, 12 December 2025**
- Reports ONS unemployment figures

**RADAR assessment:**
- **Rationale:** News reporting of official statistics
- **Authority:** BBC News (reputable journalism, fact-checked)
- **Date:** 12 December 2025 (current)
- **Accuracy:** Cites ONS directly with link
- **Relevance:** Directly relevant

**Tier level:** Tier 2 (Secondary source reporting primary source data)

#### Phase 4: Verification

**ONS source content:**
- "UK unemployment rate (aged 16+, ILO measure): 4.2% for September-November 2025 (seasonally adjusted)"
- Note: ONS reports 3-month rolling average; November 2025 is the latest month in Sep-Nov period

**Verification result:** Claim matches ONS data exactly

**Context note:** ONS uses 3-month rolling average (Sep-Nov 2025), and ILO unemployment measure (not claimant count)

#### Phase 5: Triangulation

**Source independence check:**
- Source 1 (ONS): Primary data collection
- Source 2 (Bank of England): Cites ONS but independent organisation
- Source 3 (BBC): Reports ONS data, independent journalism

**Assessment:** Sources 2 and 3 both cite Source 1 (ONS), so not fully independent data collection, but represent independent verification that ONS published this figure

**Consensus:** All three sources agree on 4.2% figure

**Triangulation result:** Strong consensus (primary source + 2 secondary corroborations)

#### Phase 6: Conflicting Sources

**Not applicable:** No conflicting sources found; consensus across all sources

#### Phase 7: Confidence Calibration

**Confidence level:** Confirmed (90-100%)

**Rationale:**
- Primary source (ONS) explicitly states 4.2%
- Multiple secondary sources corroborate
- No contradictory evidence
- Source is authoritative and current

**Context preserved:** Claim should note ILO measure and 3-month average for precision

#### Documentation

**Verification report:**

```
## Claim: "UK unemployment reached 4.2% in November 2025"

**Categorisation:** Factual/verifiable

**Verification Mode:** Proactive (sources discovered through search)

**Sources Evaluated:**
1. ONS Labour Market Overview (November 2025) - Primary source, Tier 1 - Excellent RADAR quality
2. Bank of England Monetary Policy Report (December 2025) - Secondary source, Tier 2 - Good RADAR quality
3. BBC News (12 December 2025) - Secondary source, Tier 2 - Good RADAR quality

**Findings:**
- Supporting evidence: ONS reports 4.2% unemployment rate for Sep-Nov 2025 (ILO measure, ages 16+, seasonally adjusted)
- Bank of England report cites same ONS figure
- BBC News reports same ONS figure with attribution
- Contradictory evidence: None
- Triangulation: Primary source with two independent secondary corroborations - strong consensus

**Confidence Level:** Confirmed

**Rationale:** Primary source (ONS) directly supports claim with exact figure. Two independent secondary sources corroborate. No contradictory evidence. Source is authoritative, current, and transparent.

**Limitations:** Claim should specify ILO unemployment measure (vs claimant count alternative) and note this is 3-month rolling average (Sep-Nov 2025) for precision. November 2025 is the most recent month in the rolling average period.
```

**Output:** "Confirmed: UK unemployment rate was 4.2% in November 2025 according to ONS Labour Market Overview (ILO unemployment measure, ages 16+, three-month average for Sep-Nov 2025, seasonally adjusted). Corroborated by Bank of England Monetary Policy Report and BBC News."

---

## Example 3: Detecting AI Hallucination (Extrinsic Check)

### Scenario

AI provided biography with specific claims. Provided source is Wikipedia entry. Check for extrinsic hallucinations.

### Input

**Claim:** "Marie Curie won three Nobel Prizes in Physics"

**Provided source:** Marie Curie Wikipedia entry

**Verification mode:** Retrospective

### Complete Workflow

#### Phase 1: Claim Extraction and Categorisation

**Extracted claims:**
1. "Marie Curie won three Nobel Prizes" (claim about total number)
2. "Nobel Prizes in Physics" (claim about field)

**Categorisation:** Both factual/verifiable (historical facts with objective truth values)

**Priority:** High (specific factual claims easily checkable)

#### Phase 2: Mode Selection

**Mode:** Retrospective verification (Wikipedia entry provided as source)

**Extrinsic hallucination focus:** Does AI claim match what Wikipedia says?

#### Phase 3: Source Quality Assessment (Wikipedia)

**RADAR assessment for Wikipedia:**
- **Rationale:** Encyclopaedic, generally neutral, but can have errors
- **Authority:** Community-edited, not authoritative alone
- **Date:** Check last updated date
- **Accuracy:** Varies; must verify citations
- **Relevance:** Directly relevant (Marie Curie biography)

**Tier level:** Tier 3 (Tertiary source - encyclopaedia)

**Note:** Wikipedia alone insufficient for final verification, but can use to find primary sources

#### Phase 4: Verification Against Provided Source (Wikipedia)

**Action:** Read provided Wikipedia entry carefully

**Finding in Wikipedia:**
- "Marie Curie was a physicist and chemist who conducted pioneering research on radioactivity."
- "She was the first woman to win a Nobel Prize"
- "The first person to win the Nobel Prize twice"
- "The only person to win the Nobel Prize in two scientific fields"
- "Nobel Prize in Physics (1903, shared with Pierre Curie and Henri Becquerel)"
- "Nobel Prize in Chemistry (1911)"

**Comparison with AI claim:**
- AI claim: "three Nobel Prizes in Physics"
- Wikipedia content: Two Nobel Prizes total (one Physics 1903, one Chemistry 1911)

**Discrepancies identified:**
1. **Number wrong:** AI says three, Wikipedia says two
2. **Field wrong:** AI says "in Physics" (implying all three), Wikipedia says one Physics + one Chemistry

#### Phase 5: Extrinsic Hallucination Assessment

**Checklist:**
- [ ] Numbers match source? NO - AI says 3, source says 2
- [ ] Fields match source? NO - AI says all Physics, source says Physics + Chemistry
- [ ] Details consistent? NO - fundamental discrepancy

**Hallucination type:** Factual incorrectness (38% of hallucinations) - wrong numbers and fields

**Severity:** High (contradicts provided source on basic facts)

#### Phase 6: Triangulation with Additional Sources

**Even though Wikipedia provided, verify with primary source for certainty:**

**Additional source search:**

**Source: Nobel Prize Official Website**
- nobelprize.org/prizes/lists/marie-curie-facts

**RADAR:**
- **Rationale:** Official records, definitive
- **Authority:** Nobel Foundation (highest authority for Nobel Prize information)
- **Date:** Maintained current records
- **Accuracy:** Primary authoritative source
- **Relevance:** Directly addresses Nobel Prize claims

**Tier level:** Tier 1 (Primary source - official records)

**Nobel Prize website confirms:**
- 1903: Nobel Prize in Physics (shared with Pierre Curie and Henri Becquerel)
- 1911: Nobel Prize in Chemistry
- Total: Two Nobel Prizes (one Physics, one Chemistry)

**Additional source: Britannica**

**Tier:** Tier 3 (Tertiary - encyclopaedia)

**Britannica confirms:** Two Nobel Prizes (1903 Physics, 1911 Chemistry)

#### Phase 7: Confidence Calibration

**Claim verification result:** Confirmed INCORRECT

**Correct information:** Marie Curie won two Nobel Prizes: Physics (1903) and Chemistry (1911)

**Confidence in correction:** Confirmed (90-100%)
- Primary source (Nobel Foundation) confirms two prizes
- Two tertiary sources (Wikipedia, Britannica) agree
- No contradictory evidence

#### Documentation

**Verification report:**

```
## Claim: "Marie Curie won three Nobel Prizes in Physics"

**Categorisation:** Factual/verifiable (historical fact)

**Verification Mode:** Retrospective (verified against provided Wikipedia entry) + Proactive triangulation with primary source

**Sources Evaluated:**
1. Marie Curie Wikipedia entry (provided) - Tertiary source, Tier 3
2. Nobel Prize Official Website - Primary source, Tier 1 - Excellent RADAR quality
3. Encyclopaedia Britannica - Tertiary source, Tier 3

**Findings:**
- AI claim: "Marie Curie won three Nobel Prizes in Physics"
- Wikipedia (provided source): States Marie Curie won two Nobel Prizes (Physics 1903, Chemistry 1911)
- Nobel Prize Official Records (primary source): Confirms 1903 Physics, 1911 Chemistry (two total)
- Britannica: Confirms two Nobel Prizes

**Extrinsic Hallucination Detected:**
1. **Number incorrect:** AI claims three Nobel Prizes; all sources confirm two
2. **Field incorrect:** AI claims all in Physics; sources confirm one Physics (1903) + one Chemistry (1911)
3. **Contradicts provided source:** AI output conflicts with provided Wikipedia entry

**Hallucination type:** Factual incorrectness (wrong numbers and fields)

**Severity:** High (fundamental factual errors contradicting provided and primary sources)

**Confidence Level:** Confirmed incorrect

**Rationale:** AI claim contradicts both provided source (Wikipedia) and primary authoritative source (Nobel Prize official records). All sources agree Marie Curie won exactly two Nobel Prizes (not three), in two different fields (Physics and Chemistry, not all in Physics).

**Correction Required:**
"Marie Curie won two Nobel Prizes: the Nobel Prize in Physics (1903, shared with Pierre Curie and Henri Becquerel) and the Nobel Prize in Chemistry (1911). She was the first person to win Nobel Prizes in two different scientific fields."
```

**Output:** "Hallucination detected: Claim states Marie Curie won three Nobel Prizes in Physics. Provided source (Wikipedia) and primary source (Nobel Prize official records) confirm she won two Nobel Prizes: Physics (1903) and Chemistry (1911). Claim is incorrect in both number (three vs two) and fields (all Physics vs Physics + Chemistry)."

---

## Example 4: Handling Conflicting Sources

### Scenario

Two authoritative sources provide different statistics for the same metric. Resolve using conflict resolution protocol.

### Input

**Claim:** "Global AI market size in 2025"

**Source A (Gartner):** "$200 billion"

**Source B (IDC):** "$184 billion"

**Verification mode:** Retrospective (sources provided) with conflict resolution

### Complete Workflow

#### Phase 1: Categorisation

**Claim type:** Factual/verifiable (market statistics)

**Priority:** High (specific numerical claim with conflicting sources)

#### Phase 2: Source Quality Assessment

**Source A: Gartner Market Analysis Report 2025**

**RADAR:**
- **Rationale:** Market research firm, commercial but reputable
- **Authority:** Established market research firm with industry recognition
- **Date:** Published 2025 (current)
- **Accuracy:** Methodology documented, track record of market estimates
- **Relevance:** Directly addresses global AI market size

**Tier:** Tier 2 (Secondary source - analysis of market data, not original transaction data)

**Source B: IDC Market Forecast 2025**

**RADAR:**
- **Rationale:** Market research firm, commercial but reputable
- **Authority:** Established market research firm, competitor to Gartner
- **Date:** Published 2025 (current)
- **Accuracy:** Methodology documented, reputable in industry
- **Relevance:** Directly addresses global AI market size

**Tier:** Tier 2 (Secondary source - market analysis)

**Assessment:** Both sources have similar quality and authority

#### Phase 3: Conflict Identification (Phase 6, Step 1)

**Specific disagreement:** Market size figure differs by $16 billion ($200B vs $184B)

**Questions:**
- Is this about the same market? (need to check definitions)
- Same time period? (both claim "2025")
- Same geographic scope? (both claim "global")
- Different methodologies or definitions?

#### Phase 4: Methodology Analysis (Phase 6, Step 2)

**Gartner methodology investigation:**
- Scope: "AI software, hardware, and services"
- Includes: AI chips, cloud AI services, AI software platforms, professional services
- Geographic: Worldwide
- Timeframe: Calendar year 2025

**IDC methodology investigation:**
- Scope: "AI software and services"
- Includes: AI software platforms, AI applications, professional services
- **Excludes:** AI-specific hardware (chips, specialized processors)
- Geographic: Worldwide
- Timeframe: Calendar year 2025

**Root cause identified:** Definitional disagreement
- Gartner includes AI hardware; IDC excludes it
- This explains the $16B difference (likely represents hardware market component)

#### Phase 5: Source Quality Weighting (Phase 6, Step 3)

**Assessment:**
- Both Tier 2 sources
- Both highly authoritative in market research
- Both current (2025 publications)
- Both have transparent methodologies
- Neither has obvious bias or conflicts

**Conclusion:** Sources are of equal quality; disagreement is definitional, not about accuracy

#### Phase 6: Seek Additional Sources (Phase 6, Step 4)

**Search for third source:**

**Source C: McKinsey Global Institute Report 2025**

**Finding:** "Global AI market estimated at $190-210 billion in 2025, depending on hardware inclusion"

**Methodology:** Acknowledges definitional variation; provides range based on scope

**Assessment:** Third source confirms the definitional issue and suggests both Gartner and IDC are within reasonable bounds of their respective definitions

#### Phase 7: Resolution (Phase 6, Step 5)

**Conflict type:** Definitional disagreement, not factual disagreement

**Resolution:** Both sources are correct within their own scope definitions

**Confidence assignment:**
- Gartner figure ($200B including hardware): Likely (within McKinsey range, methodology sound)
- IDC figure ($184B excluding hardware): Likely (within McKinsey range, methodology sound)

**Appropriate presentation:** Surface the definitional difference transparently

#### Documentation

**Verification report:**

```
## Claim: "Global AI market size in 2025"

**Categorisation:** Factual/verifiable

**Verification Mode:** Retrospective (conflicting sources provided, required resolution)

**Sources Evaluated:**
1. Gartner Market Analysis Report 2025 - Secondary source, Tier 2 - Good RADAR quality
2. IDC Market Forecast 2025 - Secondary source, Tier 2 - Good RADAR quality
3. McKinsey Global Institute Report 2025 - Secondary source, Tier 2 - Good RADAR quality

**Conflict Identified:**
- Gartner: $200 billion
- IDC: $184 billion
- Difference: $16 billion (8%)

**Conflict Resolution Analysis:**

**Step 1 - Specific disagreement:** Market size figures differ by $16B

**Step 2 - Methodology analysis:**
- Gartner scope: AI software + hardware + services
- IDC scope: AI software + services (excludes hardware)
- Root cause: Definitional difference (hardware inclusion/exclusion)

**Step 3 - Source quality:** Both sources equally authoritative and reputable

**Step 4 - Additional sources:** McKinsey provides range of $190-210B, noting definitional variation

**Step 5 - Resolution:** Definitional disagreement, not factual disagreement

**Findings:**
- Gartner ($200B) includes AI hardware; IDC ($184B) excludes AI hardware
- Difference ($16B) approximately represents hardware market component
- McKinsey range ($190-210B) encompasses both estimates
- Both figures are likely correct within their stated scopes

**Confidence Level:** Both figures are "Likely" correct (within scope definitions)

**Category:** Disputed (definitional) - not factually disputed, but definitionally different

**Rationale:** Sources disagree on market size due to different scope definitions, not due to factual errors or methodological flaws. Both estimates fall within range suggested by third authoritative source.

**Limitations:** Global AI market size varies significantly based on scope definition (hardware inclusion is major variable). No single "correct" figure exists without specifying scope.
```

**Output:** "Disputed (definitional): Global AI market size estimates vary by scope definition. Gartner reports $200 billion (including AI software, hardware, and services). IDC reports $184 billion (including AI software and services, excluding hardware). McKinsey estimates $190-210 billion range, noting definitional variations. Discrepancy stems from different market scope definitions (hardware inclusion/exclusion), not from factual disagreement. Both figures are likely correct within their respective scopes."

---

## Example 5: Mixed Factual-Opinion Statement

### Scenario

Statement contains both factual and opinion components. Must separate and verify appropriately.

### Input

**Claim:** "The UK's poorly managed healthcare system treated 1.2 million patients in November 2025"

### Complete Workflow

#### Phase 1: Claim Extraction and Categorisation

**Separation of components:**

**Component 1:** "poorly managed healthcare system"
- **Categorisation:** Opinion/subjective judgement
- **Rationale:** "Poorly managed" is value judgement without objective standard
- **Action:** Do not attempt to fact-check; note as opinion

**Component 2:** "treated 1.2 million patients in November 2025"
- **Categorisation:** Factual/verifiable (specific statistic with timeframe)
- **Rationale:** Objective claim that can be verified with NHS data
- **Action:** Proceed with full verification

**Documentation note:** Mixed statement separated into factual and opinion components before verification

#### Phase 2: Factual Component Verification (Mode B - Proactive)

**SIFT Application:**

**S - Stop:** Assess plausibility - NHS treats millions monthly, 1.2M is plausible range

**I - Investigate source:** Need official NHS statistics

**F - Find better coverage:** Search for NHS England official statistics

**T - Trace to origin:** Locate NHS statistical publication

#### Phase 3: Source Discovery

**Source found: NHS England Monthly Statistics, November 2025**

**RADAR:**
- **Rationale:** Official NHS statistics, transparent methodology
- **Authority:** NHS England (official health service data)
- **Date:** December 2025 publication (current)
- **Accuracy:** Primary official data
- **Relevance:** Directly addresses patient treatment figures

**Tier:** Tier 1 (Primary source - official statistics)

#### Phase 4: Verification

**NHS source content:** "NHS England hospitals treated 1.18 million inpatients and day cases in November 2025"

**Comparison:**
- Claim: 1.2 million
- Source: 1.18 million

**Assessment:** Minor rounding difference (1.18M rounded to 1.2M)

#### Phase 5: Confidence Calibration

**Factual component confidence:** Confirmed (with minor rounding noted)

**Opinion component:** Not verified (appropriately categorised as subjective)

#### Documentation

**Verification report:**

```
## Claim: "The UK's poorly managed healthcare system treated 1.2 million patients in November 2025"

**Categorisation:** Mixed (factual + opinion components)

**Component separation:**

**Component 1: "poorly managed healthcare system"**
- Category: Opinion/subjective judgement
- Action: Not fact-checked (value judgement without objective verification standard)
- Note: This reflects subjective assessment, not verifiable fact

**Component 2: "treated 1.2 million patients in November 2025"**
- Category: Factual/verifiable
- Action: Verified against NHS official statistics

**Verification Mode:** Proactive (factual component)

**Sources Evaluated:**
1. NHS England Monthly Statistics (November 2025) - Primary source, Tier 1 - Excellent RADAR quality

**Findings:**
- NHS England reports 1.18 million inpatients and day cases treated in November 2025
- Claim states 1.2 million (represents minor rounding of 1.18M)
- Triangulation: NHS is primary authoritative source; no additional triangulation required for official statistics

**Confidence Level (factual component only):** Confirmed

**Rationale:** Primary official source supports claim with minor rounding (1.18M vs 1.2M). Opinion component correctly excluded from verification.

**Limitations:** "Poorly managed" is subjective opinion and was not fact-checked. Only the patient treatment figure was verified.
```

**Output:** "Mixed statement separated: FACTUAL COMPONENT - Confirmed: NHS England treated 1.18 million patients (inpatients and day cases) in November 2025 according to NHS England Monthly Statistics, which rounds to the claimed 1.2 million. OPINION COMPONENT - 'Poorly managed' is subjective value judgement and was not fact-checked."

---

## Quick Reference: Example Selection Guide

**Use Example 1 when:** Verifying AI summaries against provided sources (extrinsic hallucination detection)

**Use Example 2 when:** No sources provided; must find authoritative sources through search (SIFT method application)

**Use Example 3 when:** Detecting specific AI hallucinations; demonstrates triangulation with primary sources

**Use Example 4 when:** Authoritative sources conflict; demonstrates conflict resolution protocol

**Use Example 5 when:** Statement mixes facts and opinions; demonstrates component separation
