---
name: collecting-sources
description: Collects research sources with quality evaluation. Use when gathering or finding sources, building a source library, searching for academic papers, or performing RADAR assessment.
---

# Collecting Sources

## Purpose

Enable systematic, high-quality source collection for research workflows by discovering relevant sources using domain-appropriate tools, evaluating quality using RADAR framework, storing sources locally with complete metadata, and creating human-readable source indices.

This skill supports the first phase of two-phase research workflows:
- **Phase 1 (this skill)**: Discover, evaluate, and store sources with metadata
- **Phase 2**: Synthesise findings from collected sources
- **Phase 3 (optional)**: Fact-check claims in synthesis

## When to Use This Skill

Use this skill when:
- Beginning research that requires collecting and storing sources with metadata
- User requests "collect sources", "gather sources", "find sources for research"
- Starting systematic research on unfamiliar topics requiring source quality assessment
- Building a source library with provenance tracking for reproducibility
- Conducting academic research requiring structured source management
- Working within two-phase research workflow (collection → synthesis)

**Do NOT use this skill when:**
- Conducting simple web searches for immediate answers (use WebSearch directly)
- Research requires only Claude's training knowledge
- User wants synthesis without separate collection phase
- Quick fact lookup rather than systematic research

## Required Inputs

Before beginning source collection, ensure these inputs are provided:

**Always required:**
- [ ] **Research question(s)** - Specific questions or topics to investigate
- [ ] **Task ID** - Workspace identifier (for `work/<task-id>/` directory structure)
- [ ] **Minimum source count** - Target number of sources (default: 8-15)

**Context-dependent:**
- [ ] **Domain context** - Academic vs general; if academic: biomedical/CS/physics/social sciences/general (for tool selection)
- [ ] **Quality threshold** - Minimum acceptable reliability score (default: 0.6)
- [ ] **Source type preferences** - Prioritise academic papers, blogs, documentation, etc.
- [ ] **Time constraints** - Affects search breadth and depth

If inputs are missing, ask the orchestrator before proceeding.

## Outputs Produced

This skill produces:

1. **Sources directory structure**:
   ```
   work/<task-id>/sources/
   ├── papers/          # Academic papers (PDF or plain text)
   ├── web/             # Web pages (Markdown)
   ├── blogs/           # Blog posts (Markdown)
   ├── docs/            # Documentation (Markdown/HTML)
   └── source_index.md  # Human-readable catalogue
   ```

2. **Source files**: Content stored in appropriate formats (PDF/plain text for papers, Markdown for web pages)

3. **Metadata files**: `.meta.yaml` companion files with complete metadata conforming to schema v1.0

4. **Source index**: `source_index.md` cataloguing all sources with statistics and grouped listings

5. **Collection summary**: Report with statistics, limitations, and handoff notes

## Core Workflow

### Phase 0: Setup and Input Validation

**Goal**: Prepare workspace and validate inputs

1. **Validate required inputs**:
   - Confirm research question(s) received
   - Confirm task_id received
   - Check for domain context hints in research question

2. **Create workspace structure**:
   ```bash
   mkdir -p work/<task-id>/sources/{papers,web,blogs,docs}
   ```

3. **Initialise tracking**:
   - Set source counter to 1 (for src_001, src_002, etc.)
   - Create collection log for provenance tracking
   - Check if `source_index.md` exists from previous collection (for duplicate detection)

**Checkpoint**: Workspace exists, inputs validated, ready to begin discovery.

---

### Phase 1: Domain Detection and Query Formulation

**Goal**: Identify research domain and formulate effective search queries

#### Domain Detection

Apply domain detection heuristics to research question:

**Academic domain indicators:**
- Keywords: "paper", "study", "research", "peer-reviewed", "journal", "conference"
- Biomedical: "medicine", "clinical", "disease", "drug", "genomic", "patient", "healthcare"
- CS/Physics: "algorithm", "neural network", "machine learning", "quantum", "physics", "computer science"
- Social sciences: "policy", "governance", "sociology", "political science", "economics", "education"
- Academic URLs provided: arxiv.org, doi.org, pubmed.gov, semanticscholar.org

**General web indicators:**
- Keywords: "tutorial", "guide", "how-to", "blog", "documentation", "best practices"
- No academic terminology
- Practical/applied focus

#### Query Formulation Strategy

Based on domain detection:

**For Academic Research:**

Academic paper retrieval uses a **two-step workflow**:
1. **Discovery** — Find papers via metadata APIs or web search
2. **Retrieval** — Fetch full text using multi-source strategy (detailed in Phase 3)

**Discovery queries:**

1. **Biomedical topics** → Site-specific searches + CORE API awareness
   - Example: `site:pubmed.ncbi.nlm.nih.gov clinical trial metadata`
   - Example: `clinical trial metadata standards peer-reviewed`
   - Note DOIs/titles for full-text retrieval via CORE or PubMed Central

2. **CS/Physics topics** → Site-specific searches + arXiv awareness
   - Example: `site:arxiv.org transformer architecture`
   - Example: `site:scholar.google.com neural network efficiency`
   - Note arXiv IDs for direct PDF retrieval

3. **Social sciences** → Metadata APIs + CORE fallback
   - Example: `governance NGO policy research Egypt`
   - Example: `site:scholar.google.com civil society regulation`
   - Note: Social sciences have lower OA coverage (~33% vs ~66% STEM); expect higher metadata-only rate

4. **General academic** → Multiple search strategies
   - WebSearch with academic keywords: `research paper [topic]`
   - Site-specific: `site:scholar.google.com [topic]`
   - Extract DOIs/titles for full-text retrieval

**For General Web Research:**
- Use WebSearch with standard queries
- Target authoritative sources: official docs, expert blogs, reputable sites
- Use site-specific searches when known: `site:docs.python.org async`

**Checkpoint**: Domain identified, search queries formulated, ready for discovery.

---

### Phase 2: Source Discovery

**Goal**: Discover relevant candidate sources and extract identifiers for full-text retrieval

#### Discovery Strategy

**For academic research:**

The goal is to find papers and extract **identifiers** (DOI, arXiv ID, PubMed ID, title) for full-text retrieval, not to fetch full text during discovery.

1. **Formulate metadata queries**:
   - Extract key terms from research question
   - Use domain-specific terminology
   - Consider alternative phrasings
   - Use site-specific searches where applicable

2. **Execute discovery searches**:
   - Run 3-5 targeted WebSearch queries
   - Use domain-specific site searches (site:arxiv.org, site:pubmed.gov, site:scholar.google.com)
   - Focus on finding paper metadata: titles, authors, DOIs, abstracts
   - Collect **identifiers** for full-text retrieval:
     - DOI (for CORE API, Unpaywall MCP)
     - arXiv ID (for arXiv direct retrieval)
     - PubMed ID (for PubMed Central)
     - Full paper title (fallback for CORE API search)

3. **Collect candidate metadata**:
   - Paper titles and DOIs
   - Authors and publication dates
   - Venue (journal/conference)
   - Abstract excerpts
   - Repository identifiers (arXiv ID, PMID, etc.)

**For general web research:**

1. **Formulate search queries**:
   - Extract key terms from research question
   - Use domain-specific terminology
   - Consider alternative phrasings

2. **Execute searches**:
   - Run 3-5 targeted WebSearch queries
   - Use site-specific searches where applicable
   - Collect URLs and metadata from search results
   - Aim for diverse source types

3. **Collect candidate metadata**:
   - URLs and titles
   - Authors and publication dates (where available)
   - Site names and descriptions

**Target**: 15-25 candidate sources from diverse source types (will filter to 8-15 based on quality)

**Checkpoint**: Candidate sources identified with identifiers (DOI/arXiv ID/title) for academic papers, URLs for web sources.

---

### Phase 3: Source Retrieval and Storage

**Goal**: Fetch content using multi-source strategy and store in appropriate formats

For each candidate source:

#### 3.1: Check for Duplicates

**Before fetching**, check if source already exists:

1. **Load existing sources** (if `source_index.md` exists from previous collection)
2. **Check URL match**: Compare candidate URL against existing source URLs
3. **Check DOI match**: For academic papers, compare candidate DOI against `doi` fields in existing `.meta.yaml` files in the sources directory
4. **If exists**: Skip fetching; log as "already collected"
5. **If differs**: Continue to fetch (content_hash comparison will catch duplicate content later)

This avoids re-fetching sources already collected in previous sessions.

#### 3.2: Fetch Content — Multi-Source Strategy

**For academic papers:**

Use a **structured fallback chain** to maximise full-text retrieval:

**Retrieval Chain:**
1. **CORE API** (largest corpus, plain text in JSON)
2. **Unpaywall MCP** (OA PDF extraction)
3. **Domain-specific repository** (arXiv, PubMed Central)
4. **WebFetch** (publisher sites, repository landing pages)
5. **Metadata-only** (last resort for paywalled content)

**Detailed retrieval strategy:**

**Step 1: CORE API** (primary for all academic papers)

CORE API provides direct access to 46M full-text papers as plain text in JSON. No PDF extraction needed.

**When to use:**
- Always try first for academic papers with DOI or title
- Covers all academic domains (STEM, social sciences, humanities)
- Returns plain text extracted from PDFs during indexing

**How to use:**
1. **Query by DOI**:
   ```
   WebFetch: https://api.core.ac.uk/v3/search/works?q=doi:[DOI]
   ```
   - Response: JSON with `fullText` field containing plain text
   - Extract `fullText` from JSON response

2. **Query by title** (if no DOI):
   ```
   WebFetch: https://api.core.ac.uk/v3/search/works?q=title:"[exact title]"
   ```
   - Review results for title match
   - Extract `fullText` from matching paper

3. **Extract plain text**:
   - If `fullText` field present and non-empty → save as `.txt` file
   - Plain text is pre-extracted via Apache PDFBox; ready to use
   - If `fullText` empty or absent → proceed to Step 2 (Unpaywall)

**Rate limits**: 1 batch request or 5 single requests per 10 seconds (free tier)

**Step 2: Unpaywall MCP** (fallback for OA papers)

If CORE API fails or returns no full text, use Unpaywall MCP tools to find and extract OA PDFs.

**MCP tools available:**
- `unpaywall_search_titles` — Search by title, returns OA status
- `unpaywall_get_fulltext_links` — Get best OA PDF URL by DOI
- `unpaywall_fetch_pdf_text` — Download PDF and extract text (configurable truncation)

**How to use:**
1. **Get OA PDF URL** (if DOI available):
   ```
   unpaywall_get_fulltext_links(doi="10.1234/example")
   ```
   - Returns `best_oa_location.url_for_pdf` if available
   - Proceed to extraction if PDF URL found

2. **Search by title** (if no DOI):
   ```
   unpaywall_search_titles(query="exact paper title")
   ```
   - Review results for title match
   - Extract DOI if found, then use `unpaywall_get_fulltext_links`

3. **Extract PDF text**:
   ```
   unpaywall_fetch_pdf_text(doi="10.1234/example", truncate_chars=50000)
   ```
   - Downloads PDF and extracts text
   - Configure `truncate_chars` to 50,000 for comprehensive coverage
   - Minimum 1,000 characters enforced
   - Average papers: 20,000-30,000 chars; surveys: 90,000-100,000 chars

4. **Save extracted text**:
   - If extraction succeeds → save as `.txt` file
   - If extraction fails (paywalled, no OA version) → proceed to Step 3

**Rate limits**: Respect Unpaywall's 100,000 calls/day limit

**Step 3: Domain-Specific Repository** (for known domains)

If CORE and Unpaywall fail, try domain-specific repositories with near-complete coverage.

**3a. arXiv** (for CS, physics, mathematics, quantitative biology):

**When to use:**
- arXiv ID detected in metadata
- CS/physics/maths keywords in research question
- Paper published in arXiv venue

**How to use:**
1. **Prefer arXiv MCP server** (if available) for metadata + text extraction
2. **Alternative — try CORE API first**: arXiv papers are often in CORE's corpus. Query CORE by arXiv ID or title to get plain text without PDF extraction
3. **Last resort — direct PDF download**:
   ```
   WebFetch: https://export.arxiv.org/pdf/[arxiv_id].pdf
   ```
   - **Note:** WebFetch cannot extract text from PDFs. This downloads the binary PDF for storage only
   - Suggested rate: 4 requests/second with 1-second sleep per burst

4. **Store PDF**:
   - Save as `.pdf` in `sources/papers/`
   - Note in metadata: `Retrieved from arXiv`

**3b. PubMed Central** (for biomedical, life sciences):

**When to use:**
- PubMed ID detected in metadata
- Biomedical keywords in research question
- Paper published in biomedical journal

**How to use:**
1. **WebFetch landing page**:
   ```
   WebFetch: https://pmc.ncbi.nlm.nih.gov/articles/PMC[PMCID]/
   ```
   - Extracts full-text HTML
   - PMC provides full articles, not just abstracts

2. **Store as HTML or Markdown**:
   - Save HTML or convert to Markdown
   - Note in metadata: `Retrieved from PubMed Central`

**Step 4: WebFetch** (general fallback for open-access content)

If all targeted strategies fail, try standard web retrieval.

**How to use:**
1. **Use WebFetch** on paper landing page URL
2. **Extract what's available**:
   - HTML metadata pages → abstract, bibliographic info
   - Open-access PDFs → download if link found
   - Repository pages → may include full text as HTML

3. **Result**:
   - If full text retrieved → store normally
   - If landing page only → record metadata, proceed to Step 5

**Step 5: Metadata-Only** (last resort for paywalled content)

If all retrieval strategies fail (paywalled, not in OA repositories):

1. **Record metadata** from abstract/landing page:
   - Title, authors, DOI, abstract, venue, publication date
   - Extract from WebFetch of landing page

2. **Attempt open-access alternatives**:
   - Search for preprint: `site:arxiv.org [title]`
   - Search for preprint: `site:biorxiv.org [title]`
   - Check author websites: `[author name] [title] pdf`

3. **If unavailable**:
   - Create metadata file with all available fields
   - Set `file_path: "unavailable"`
   - Set `content_hash: "unavailable"`
   - Note in `provenance.notes`: "Paywalled; full text unavailable via CORE, Unpaywall, domain repositories; metadata only"
   - Flag in source index: "Metadata only (paywalled)"

**Social sciences caveat:**

Social sciences have substantially lower OA coverage (~33%) compared to STEM (~66%). For social science research:
- Expect higher metadata-only rates (50-60% paywalled not uncommon)
- SSRN (1.74M social sciences preprints) lacks API access; cannot retrieve programmatically
- No domain-specific repository equivalent to arXiv/PubMed Central for social sciences
- CORE + Unpaywall are primary strategies; calibrate expectations accordingly

**For web pages/blogs/documentation:**

Use WebFetch to retrieve content:
- WebFetch converts HTML to Markdown automatically
- Store as Markdown (`.md`)
- Preserve HTML only if formatting is critical

#### 3.3: Determine Source Type

Classify source using URL and content patterns:

- `source_type: "academic_paper"` - Peer-reviewed papers, preprints, conference papers
- `source_type: "web_page"` - General web content, articles, guides
- `source_type: "blog"` - Blog posts, Substack, Medium, personal sites
- `source_type: "documentation"` - Official project docs, API references, specifications

#### 3.4: Select Storage Format

Match format to source type and retrieval method:

| Source Type | Primary Format | Use Case |
|-------------|---------------|----------|
| Academic paper (CORE API) | Plain text (`.txt`) | Pre-extracted text from CORE, ready to use |
| Academic paper (Unpaywall) | Plain text (`.txt`) | Extracted text from PDF via MCP |
| Academic paper (arXiv/direct) | PDF | Preserve original formatting, citations |
| Academic paper (metadata-only) | N/A | No file stored; `file_path: "unavailable"` |
| Web page | Markdown | Easy parsing, version control |
| Blog post | Markdown | Text-focused, easy reading |
| Documentation | Markdown or HTML | Markdown for text, HTML for complex layouts |

#### 3.5: Store Content

1. **Assign source_id**: Sequential format `src_001`, `src_002`, etc. (zero-padded to 3 digits)

2. **Determine file path**:
   - Academic papers (plain text from CORE/Unpaywall): `sources/papers/src_NNN.txt`
   - Academic papers (PDF from arXiv/direct): `sources/papers/src_NNN.pdf`
   - Academic papers (metadata-only): `file_path: "unavailable"` (no file stored)
   - Web pages: `sources/web/src_NNN.md`
   - Blogs: `sources/blogs/src_NNN.md`
   - Documentation: `sources/docs/src_NNN.md` or `.html`

3. **Write content file**:
   ```bash
   # Write fetched content to file path
   ```

4. **Generate content hash**:
   ```bash
   shasum -a 256 work/<task-id>/sources/papers/src_001.txt
   # Extract hex digest for metadata
   ```

5. **Check for duplicate content** (optional but recommended):
   - Compare content_hash against existing sources
   - If duplicate found: Note in provenance; consider excluding or flagging

**Checkpoint**: All sources fetched and stored with content hashes generated.

---

### Phase 4: Metadata Extraction and RADAR Assessment

**Goal**: Generate complete metadata conforming to schema v1.0 with quality assessment

For each source:

#### 4.1: Extract Core Metadata

Extract or infer required schema fields:

**Always required:**
- `source_id`: Assigned in Phase 3 (e.g., "src_001")
- `title`: From paper metadata, page title, or heading
- `url`: Original source URL (use "local" for offline sources)
- `fetch_date`: ISO 8601 timestamp of retrieval (e.g., "2026-01-21T14:30:00Z")
- `authors`: List of authors (use `["Unknown"]` if unavailable)
- `publication_date`: "YYYY-MM-DD", "YYYY-MM", or "YYYY"; "unknown" if unavailable
- `source_type`: Classification from Phase 3.3
- `format`: "pdf", "markdown", "html", or "plaintext" (for CORE/Unpaywall `.txt` files)
- `file_path`: Relative path from workspace root (e.g., "sources/papers/src_001.txt"); "unavailable" for paywalled sources
- `content_hash`: SHA-256 hash in format `"sha256:HEX_DIGEST"`; "unavailable" for paywalled sources
- `metadata_version`: "1.0"

#### 4.2: Extract Source-Type-Specific Metadata

**For academic papers** (source_type: "academic_paper"):
- `doi`: DOI identifier (if available)
- `arxiv_id`: arXiv identifier (if applicable)
- `pmid`: PubMed ID (if applicable)
- `abstract`: Paper abstract (recommended)
- `venue`: Conference/journal name (recommended)
- `citation_count`: Number of citations (optional)
- `topics`: List of topic keywords (recommended)
- `retrieval_method`: Note which strategy succeeded ("CORE API", "Unpaywall MCP", "arXiv direct", "PubMed Central", "WebFetch", "metadata-only"). Note: This is an extension field introduced by this update; it should be added to `references/source-metadata-schema.md` in a future schema revision.

**For web pages** (source_type: "web_page"):
- `description`: Meta description or excerpt (recommended)
- `site_name`: Website name (recommended)
- `topics`: List of topic keywords (recommended)
- `last_modified`: Last modified date if available (optional)

**For blog posts** (source_type: "blog"):
- `blog_name`: Blog/publication name (recommended)
- `description`: Post summary (recommended)
- `topics`: List of topic keywords (recommended)

**For documentation** (source_type: "documentation"):
- `product_name`: Documented product/project name (recommended)
- `doc_version`: Software version (recommended)
- `section`: Specific section/chapter (optional)
- `topics`: List of topic keywords (recommended)

#### 4.3: Apply RADAR Framework

Assess source quality using five dimensions (1-5 scale each):

**Relevance (R)** - How directly does this source address the research question?
- **5**: Directly answers research question with specific, applicable information
- **4**: Highly relevant with minor context differences
- **3**: Moderately relevant, provides useful background
- **2**: Tangentially related, limited direct applicability
- **1**: Minimally relevant, mostly off-topic

**Authority (A)** - How credible is the author/publisher?
- **5**: Peer-reviewed academic source, official documentation, government statistics
- **4**: Reputable news agencies, established experts, professional organisations
- **3**: Specialist publications, individual experts with credentials
- **2**: Blogs by recognised practitioners, trade publications
- **1**: Anonymous sources, unverified claims, self-published without credentials

**Date (D)** - How current is the information?
- **5**: Very recent (last 6-12 months for current topics)
- **4**: Recent enough (last 1-3 years for most topics)
- **3**: Somewhat dated but still relevant (3-5 years for stable fields)
- **2**: Dated with potential superseding research (5-10 years)
- **1**: Outdated for fast-moving fields, likely superseded

**Accuracy (A)** - How verifiable and reliable are the claims?
- **5**: Thoroughly cited, peer-reviewed, claims verified across multiple sources
- **4**: Well-cited, editorial review, mostly verifiable
- **3**: Some citations, generally accurate with minor gaps
- **2**: Limited citations, some unverifiable claims
- **1**: No citations, conflicts with reliable sources, obvious errors

**Rationale (R)** - What is the purpose and potential bias?
- **5**: Objective academic research, neutral documentation, transparent methodology
- **4**: Mostly objective with minor editorial perspective
- **3**: Some bias but factual basis maintained, educational intent
- **2**: Noticeable bias, commercial interest disclosed
- **1**: Heavily biased, hidden agenda, promotional content

**Detailed RADAR criteria**: See `skills/verifying-claims/references/source-evaluation-radar.md`

#### 4.4: Calculate Reliability Score

```
reliability_score = (Relevance + Authority + Date + Accuracy + Rationale) / 25.0
```

Result is normalised to 0.0-1.0 scale.

**Example:**
- Relevance: 5, Authority: 5, Date: 3, Accuracy: 5, Rationale: 5
- Sum: 23
- Reliability score: 23 / 25.0 = 0.92

#### 4.5: Record Provenance

Document collection metadata:

- `provenance.collected_by`: Agent name and version (e.g., "source-collector-agent-v1.0")
- `provenance.collection_method`: Tool used (e.g., "CORE API", "Unpaywall MCP", "WebFetch", "arXiv direct")
- `provenance.collected_at`: ISO 8601 timestamp (same as fetch_date)
- `provenance.task_id`: Workspace task identifier
- `provenance.notes`: Optional notes (e.g., "Retrieved from CORE API as plain text", "Paywalled; metadata only; tried CORE, Unpaywall, arXiv")

#### 4.6: Write Metadata File

Create `.meta.yaml` companion file:

**File path**: Same as source file with `.meta.yaml` extension
- Source: `sources/papers/src_001.txt`
- Metadata: `sources/papers/src_001.meta.yaml`

**Format**: YAML conforming to schema v1.0 (see `references/source-metadata-schema.md`)

**Example structure**:
```yaml
source_id: "src_001"
title: "Paper Title"
url: "https://example.com"
fetch_date: "2026-01-21T14:30:00Z"
authors: ["Author One", "Author Two"]
publication_date: "2025-12-15"
source_type: "academic_paper"
format: "plaintext"
file_path: "sources/papers/src_001.txt"
content_hash: "sha256:abc123..."
metadata_version: "1.0"

# Source-type-specific fields
abstract: "..."
venue: "Conference Name"
topics: ["topic1", "topic2"]
retrieval_method: "CORE API"

# RADAR assessment
radar_assessment:
  reliability_score: 0.92
  relevance:
    score: 5
    notes: "Directly addresses research question"
  authority:
    score: 5
    notes: "Peer-reviewed, highly cited"
  date:
    score: 3
    notes: "Published 2 years ago, foundational"
  accuracy:
    score: 5
    notes: "Well-cited, claims verified"
  rationale:
    score: 5
    notes: "Academic research, objective"
  assessed_at: "2026-01-21T15:00:00Z"
  assessed_by: "source-collector-agent-v1.0"

# Provenance
provenance:
  collected_by: "source-collector-agent-v1.0"
  collection_method: "CORE API"
  collected_at: "2026-01-21T14:30:00Z"
  task_id: "research-task-id"
  notes: "Retrieved from CORE API as plain text"
```

**Checkpoint**: All sources have complete metadata files conforming to schema v1.0.

---

### Phase 5: Quality Filtering

**Goal**: Filter sources to meet quality threshold

#### 5.1: Review Reliability Scores

1. **List all sources** with reliability scores
2. **Sort by score** (descending)
3. **Identify threshold**: Default minimum 0.6; adjust based on requirements

#### 5.2: Filter Low-Quality Sources

**Action for sources below threshold:**

- **If reliability < 0.5**: Exclude from collection (delete files and metadata)
- **If reliability 0.5-0.6**: Flag for review; include only if source count insufficient
- **If reliability ≥ 0.6**: Include in final collection

**Document exclusions**:
- Note which sources were excluded and why
- Include in provenance notes

#### 5.3: Ensure Minimum Source Count

**Target**: Minimum 8 high-quality sources (reliability ≥ 0.6) per research question

**If insufficient sources:**
1. Conduct additional searches (broaden query, try alternative tools)
2. Lower quality threshold slightly (minimum 0.5) if necessary
3. Document limitation in collection summary

**If excess sources:**
- Retain all sources above threshold (more sources = better coverage)
- Prioritise highest reliability scores for synthesis phase

**Checkpoint**: Final source set meets quality threshold and count requirements.

---

### Phase 6: Source Index Creation

**Goal**: Create human-readable catalogue of collected sources

#### 6.1: Generate Summary Statistics

Calculate:
- Total source count
- Breakdown by source type (academic papers, web pages, blogs, docs)
- Breakdown by retrieval method (CORE API, Unpaywall MCP, arXiv, metadata-only, etc.)
- Average reliability score
- Reliability score distribution (excellent: ≥0.8, good: 0.7-0.79, acceptable: 0.6-0.69)
- Full-text vs metadata-only ratio for academic papers

#### 6.2: Create Source Index File

**File path**: `work/<task-id>/source_index.md`

**Structure**:

```markdown
# Source Index

**Task**: [task-id]
**Research Question(s)**: [research questions]
**Collection Date**: [YYYY-MM-DD]
**Total Sources**: [count]

## Summary Statistics

- **Total sources**: [count]
- **Academic papers**: [count]
  - Full-text: [count]
  - Metadata-only: [count]
- **Web pages**: [count]
- **Blog posts**: [count]
- **Documentation**: [count]
- **Average reliability**: [score]
- **Reliability distribution**:
  - Excellent (≥0.8): [count]
  - Good (0.7-0.79): [count]
  - Acceptable (0.6-0.69): [count]

## Retrieval Methods (Academic Papers)

- **CORE API**: [count]
- **Unpaywall MCP**: [count]
- **arXiv direct**: [count]
- **PubMed Central**: [count]
- **WebFetch**: [count]
- **Metadata-only (paywalled)**: [count]

## Sources by Topic

### [Topic/Theme 1]

**src_001** - [Title]
- **URL**: [url]
- **Type**: [source_type]
- **Reliability**: [score]
- **Retrieval**: [retrieval_method] (for academic papers)
- **Summary**: [brief description or abstract excerpt]
- **Metadata**: `sources/[subdirectory]/src_001.meta.yaml`

**src_002** - [Title]
- **URL**: [url]
- **Type**: [source_type]
- **Reliability**: [score]
- **Retrieval**: [retrieval_method] (for academic papers)
- **Summary**: [brief description or abstract excerpt]
- **Metadata**: `sources/[subdirectory]/src_002.meta.yaml`

### [Topic/Theme 2]

[Additional sources grouped by topic]

## Collection Notes

- **Tools used**: [CORE API, Unpaywall MCP, arXiv MCP, WebSearch, WebFetch]
- **Limitations**: [paywalled sources, missing content, domain coverage]
- **Quality threshold**: [minimum reliability score applied]
- **Domain notes**: [e.g., "Social sciences research; OA coverage ~33%; higher metadata-only rate expected"]

## Next Steps

This source collection is ready for Phase 2: Source Synthesis.
```

#### 6.3: Group Sources by Topic

Organise sources into thematic groups:
- Identify common topics/themes across sources (extract from abstracts/descriptions and research question keywords)
- Group sources addressing similar aspects of research question
- Note sources relevant to multiple topics

**Checkpoint**: Source index created, statistics calculated, sources organised by topic.

---

### Phase 7: Handoff and Completion

**Goal**: Report completion to orchestrator with summary

#### 7.1: Generate Collection Summary

Create summary report including:

**Collection statistics:**
- Total sources collected
- Breakdown by type
- Breakdown by retrieval method (for academic papers)
- Full-text vs metadata-only ratio
- Average reliability score
- Tools used

**Quality assessment:**
- Sources meeting quality threshold
- Sources excluded and why
- Highest/lowest reliability scores

**Limitations and notes:**
- Paywalled sources (metadata only)
- Missing metadata fields
- Domain coverage gaps
- Social sciences caveat if applicable

**Deliverables:**
- Path to source index: `work/<task-id>/source_index.md`
- Path to sources directory: `work/<task-id>/sources/`
- Total files: [count source files + count metadata files]

#### 7.2: Handoff Message

Report to orchestrator:

```
Source collection complete for [task-id].

Statistics:
- [N] sources collected ([X] full-text, [Y] metadata-only)
- Average reliability: [score]
- Sources by type: [breakdown]
- Retrieval methods (academic papers): [breakdown]

Deliverables:
- Source index: work/<task-id>/sources/source_index.md
- Sources directory: work/<task-id>/sources/

Limitations:
- [Any paywalled sources, missing content, or quality concerns]
- [Domain-specific notes, e.g., "Social sciences domain; 60% paywalled due to lower OA coverage"]

Ready for Phase 2: Source Synthesis.
```

**Checkpoint**: Collection complete, orchestrator notified, ready for synthesis phase.

---

## Examples

### Example 1: Academic Research (General)

**Research question**: "What are best practices for metadata in RAG systems?"

**Domain detection**: General academic (no biomedical/CS-specific keywords)

**Query formulation**:
- `site:arxiv.org metadata retrieval augmented generation`
- `site:scholar.google.com RAG system metadata`
- `"RAG metadata" best practices research`

**Discovery**:
- Execute site-specific searches for academic papers
- Execute general searches for web articles
- Collect 20 candidates (mix of academic papers and web articles)
- Extract DOIs and titles from paper metadata

**Retrieval (academic papers)**:
1. **CORE API**: Query 12 papers by DOI → 7 return full text as plain text
2. **Unpaywall MCP**: Remaining 5 papers → 3 retrieve OA PDFs, extract text
3. **WebFetch**: Remaining 2 papers → 1 retrieves landing page HTML, 1 fully paywalled
4. **Metadata-only**: 1 paper paywalled; record metadata from abstract page

**Retrieval (web articles)**:
- Use WebFetch to retrieve 8 web articles → Markdown storage in `sources/web/`

**RADAR assessment example** (academic paper from CORE):
- Relevance: 5 (directly addresses RAG metadata)
- Authority: 4 (conference paper, peer-reviewed)
- Date: 5 (published 2025)
- Accuracy: 5 (well-cited, claims verified)
- Rationale: 5 (academic research, objective)
- **Reliability: 0.96**

**Result**: 19 sources collected (11 papers full-text, 1 paper metadata-only, 7 web articles), average reliability 0.84

**Retrieval breakdown**:
- CORE API: 7
- Unpaywall MCP: 3
- WebFetch: 1
- Metadata-only: 1

---

### Example 2: General Web Research (Technical Documentation)

**Research question**: "How do I configure OAuth 2.1 in the MCP specification?"

**Domain detection**: General web (documentation focus, not academic)

**Tool selection**:
- Primary: WebSearch + WebFetch
- Target: Official MCP docs, OAuth specs, implementation guides

**Discovery**:
- WebSearch: "MCP specification OAuth 2.1"
- WebSearch: "Model Context Protocol authentication"
- Collect 15 candidates (official docs, blog posts, GitHub discussions)

**Retrieval**:
- Official docs → Markdown storage in `sources/docs/`
- Blog posts → Markdown storage in `sources/blogs/`
- GitHub discussions → Markdown storage in `sources/web/`

**RADAR assessment example** (official documentation):
- Relevance: 5 (MCP spec directly addresses OAuth)
- Authority: 5 (official specification)
- Date: 5 (updated 2025)
- Accuracy: 5 (authoritative source)
- Rationale: 5 (technical documentation, objective)
- **Reliability: 1.00**

**Result**: 10 sources collected (3 official docs, 4 blog posts, 3 web articles), average reliability 0.86

---

### Example 3: Handling Paywalled Content (Multi-Source Retrieval)

**Scenario**: Academic paper found but behind paywall; demonstrate full retrieval chain

**Paper**: "Clinical Trial Metadata Standards: A Systematic Review"
- DOI: 10.1234/paywalled-example
- Domain: Biomedical

**Retrieval process**:

**Step 1: CORE API**
```
Query: https://api.core.ac.uk/v3/search/works?q=doi:10.1234/paywalled-example
Result: Paper found, but fullText field empty (not in CORE's 46M corpus)
Action: Proceed to Step 2
```

**Step 2: Unpaywall MCP**
```
Tool: unpaywall_get_fulltext_links(doi="10.1234/paywalled-example")
Result: No OA version detected (is_oa: false)
Action: Proceed to Step 3
```

**Step 3: PubMed Central** (biomedical domain)
```
Query: WebFetch https://pmc.ncbi.nlm.nih.gov/articles/PMC[ID]/
Result: Not available in PMC (journal doesn't participate in PMC deposit)
Action: Proceed to Step 4
```

**Step 4: WebFetch** (publisher site)
```
Query: WebFetch https://doi.org/10.1234/paywalled-example
Result: Landing page with abstract, metadata, paywall notice
Content extracted: Title, authors, abstract, venue, publication date
Action: Proceed to Step 5
```

**Step 5: Open-access alternatives**
```
Search: site:biorxiv.org "Clinical Trial Metadata Standards: A Systematic Review"
Search: site:arxiv.org "Clinical Trial Metadata Standards: A Systematic Review"
Result: No preprint versions found
Action: Record metadata only
```

**Final outcome: Metadata-only**

**Metadata created**:
```yaml
source_id: "src_008"
title: "Clinical Trial Metadata Standards: A Systematic Review"
url: "https://doi.org/10.1234/paywalled-example"
fetch_date: "2026-02-11T14:30:00Z"
authors: ["Smith, Jane", "Doe, John", "Lee, Sarah"]
publication_date: "2025-10-15"
source_type: "academic_paper"
format: "unavailable"
file_path: "unavailable"
content_hash: "unavailable"
metadata_version: "1.0"

doi: "10.1234/paywalled-example"
abstract: "Abstract text extracted from landing page..."
venue: "Journal of Clinical Research Methods"
retrieval_method: "metadata-only"

radar_assessment:
  reliability_score: 0.80
  relevance:
    score: 5
    notes: "Directly addresses clinical trial metadata standards"
  authority:
    score: 5
    notes: "Peer-reviewed journal, reputable authors"
  date:
    score: 4
    notes: "Published October 2025, very current"
  accuracy:
    score: 4
    notes: "Abstract indicates systematic review methodology"
  rationale:
    score: 5
    notes: "Academic research, objective"
  assessed_at: "2026-02-11T15:00:00Z"
  assessed_by: "source-collector-agent-v1.0"

provenance:
  collected_by: "source-collector-agent-v1.0"
  collection_method: "metadata-only"
  collected_at: "2026-02-11T14:30:00Z"
  task_id: "clinical-metadata-research"
  notes: "Paywalled; full text unavailable via CORE API, Unpaywall MCP, PubMed Central, or open-access alternatives; metadata and abstract extracted from publisher landing page"
```

**Source index entry**:
```markdown
**src_008** - Clinical Trial Metadata Standards: A Systematic Review
- **URL**: https://doi.org/10.1234/paywalled-example
- **Type**: academic_paper
- **Reliability**: 0.80
- **Retrieval**: Metadata-only (paywalled)
- **Summary**: Systematic review of metadata standards in clinical trials. Full text unavailable (paywalled). Tried: CORE API, Unpaywall MCP, PubMed Central, preprint repositories.
- **Metadata**: `sources/papers/src_008.meta.yaml`
```

---

## Constraints and Limitations

### Metadata Schema Compliance

**MUST follow**:
- All metadata MUST conform to schema v1.0 at `references/source-metadata-schema.md`
- Every source MUST have `metadata_version: "1.0"`
- Every source MUST be assessed using RADAR framework (all five dimensions)
- Every source MUST include provenance tracking (collected_by, collection_method, collected_at, task_id)
- Every source file MUST have SHA-256 content hash in metadata (except paywalled sources with `file_path: "unavailable"`)

### Missing Data Conventions

When metadata is unavailable, use schema conventions:
- Missing strings: `"unknown"`
- Missing authors: `["Unknown"]`
- Missing dates: `"unknown"`
- Paywalled content: `file_path: "unavailable"`, `content_hash: "unavailable"`

### Technical Constraints

- Working directory resets between Bash calls → Use absolute paths
- No custom Python scripts for v1 → Bash-only for hashing and file operations
- Content hash generation requires file existence → Skip for paywalled sources
- CORE API rate limits: 1 batch request or 5 single requests per 10 seconds (free tier)
- Unpaywall MCP rate limits: 100,000 calls/day

### Scope Boundaries

**In scope**:
- Source discovery, quality assessment, storage, metadata generation, indexing
- Multi-source academic paper retrieval (CORE, Unpaywall, domain-specific, WebFetch)

**Out of scope**:
- Source synthesis or analysis (Phase 2: source-synthesiser agent)
- Fact-checking claims (Phase 3: fact-checker agent)
- Research question formulation (orchestrator or researcher-agent)
- Custom MCP installation or configuration
- Automated reliability scoring algorithms (manual RADAR assessment required)
- Source update monitoring or version tracking
- Paywalled content access (no institutional credentials)

---

## Evaluation Scenarios

### Scenario 1: Academic Research

**Context**: User requests research on "transformer architecture innovations"

**Expected process**:
1. Detect academic domain (CS/ML keywords)
2. Formulate discovery queries: WebSearch with `site:arxiv.org transformer architecture innovations`
3. Execute WebSearch to find papers, extract DOIs/arXiv IDs
4. Collect 15-20 candidate papers with identifiers
5. **Multi-source retrieval**:
   - Try CORE API for each paper (query by DOI/title)
   - Fall back to Unpaywall MCP if CORE returns no full text
   - Fall back to arXiv direct PDF (if arXiv ID present)
   - Record metadata-only if all fail
6. Apply RADAR framework (expect high authority/accuracy for peer-reviewed papers)
7. Filter to 10-12 high-reliability sources (≥0.8)
8. Generate metadata files conforming to schema v1.0
9. Create source index with retrieval method breakdown (CORE: 6, Unpaywall: 3, arXiv: 2, metadata-only: 1)
10. Report completion with statistics

**Quality markers**:
- Uses site-specific searches for discovery (site:arxiv.org)
- Extracts DOIs and arXiv IDs during discovery
- Attempts multi-source retrieval chain (CORE → Unpaywall → arXiv)
- RADAR scores reflect peer-review quality (high authority, accuracy)
- Metadata includes retrieval_method field tracking which strategy succeeded
- Content hashes generated for all full-text files
- Provenance tracks retrieval method used
- Source index shows retrieval breakdown

---

### Scenario 2: General Web Research

**Context**: User requests research on "Python async best practices"

**Expected process**:
1. Detect general web domain (practical/applied focus)
2. Select WebSearch + WebFetch as tools
3. Execute searches: "Python asyncio best practices", "Python async tutorial", "async await Python guide"
4. Collect 15 candidates (official docs, expert blogs, tutorials)
5. Fetch content as Markdown using WebFetch
6. Apply RADAR framework (official docs score high authority; blogs vary)
7. Filter to 8-10 sources (mix of official docs and reputable blogs)
8. Generate metadata with site names, descriptions, topics
9. Create source index grouped by aspect (patterns, performance, error handling)
10. Report completion

**Quality markers**:
- Uses WebSearch appropriately with targeted queries
- RADAR scores distinguish official docs (high authority) from blogs (moderate authority)
- Metadata includes site names and descriptions
- Content stored as Markdown
- Provenance tracks WebFetch usage
- No multi-source retrieval needed (not academic domain)

---

### Scenario 3: Handling Paywalled Sources (Social Sciences)

**Context**: User requests research on "civil society governance in Egypt"; social sciences domain

**Expected process**:
1. Detect social sciences domain (governance, civil society keywords)
2. Formulate discovery queries: `governance civil society Egypt research`, `site:scholar.google.com NGO regulation Egypt`
3. Execute WebSearch to find papers, extract DOIs/titles
4. Collect 18 candidates (mix of accessible and paywalled)
5. **Multi-source retrieval**:
   - Try CORE API for each paper → 4 return full text
   - Try Unpaywall MCP for remaining → 2 retrieve OA PDFs
   - Try WebFetch for remaining → 5 retrieve landing pages (abstracts)
   - Record 7 as metadata-only (paywalled, no OA versions)
6. Apply RADAR framework (can assess based on abstract/metadata even without full text)
7. Include all sources above quality threshold (6 full-text, 7 metadata-only)
8. Note limitation in collection summary: "Social sciences domain; 54% paywalled due to lower OA coverage (~33% vs ~66% STEM); tried CORE, Unpaywall, preprint repositories"
9. Filter to 13 sources total (6 full-text, 7 metadata-only)
10. Report completion with caveat about domain coverage

**Quality markers**:
- Attempts multi-source retrieval chain for all papers
- Records comprehensive metadata for paywalled sources
- Flags paywalled sources clearly in index with retrieval method
- Notes social sciences caveat in collection summary
- RADAR assessment based on available information (abstract, venue, authors)
- Provenance notes detail all retrieval attempts
- Source index shows retrieval breakdown with high metadata-only ratio

---

## References

**Metadata schema specification**: `references/source-metadata-schema.md` (schema v1.0)

**RADAR framework details**: `skills/verifying-claims/references/source-evaluation-radar.md` (scoring rubrics and criteria)

**Academic repositories and APIs**:
- **CORE API**: [core.ac.uk/services/api](https://core.ac.uk/services/api) — 46M full texts as plain text in JSON
- **Unpaywall API**: [unpaywall.org/products/api](https://unpaywall.org/products/api) — OA detection and PDF URLs
- **arXiv**: [arxiv.org](https://arxiv.org) — 2.4M papers, direct PDF access
- **PubMed Central**: [pmc.ncbi.nlm.nih.gov](https://pmc.ncbi.nlm.nih.gov) — Biomedical full texts
- **Semantic Scholar**: [semanticscholar.org](https://www.semanticscholar.org) — 214M papers metadata
- **Google Scholar**: [scholar.google.com](https://scholar.google.com) — Academic search

**MCP tools**:
- **Unpaywall MCP**: `unpaywall_search_titles`, `unpaywall_get_fulltext_links`, `unpaywall_fetch_pdf_text`
- **arXiv MCP**: Domain-specific paper search and retrieval (if available)

---

## Success Indicators

This skill is working well when:
- Sources are discovered using domain-appropriate tools (metadata APIs for academic research)
- Academic papers use multi-source retrieval chain (CORE → Unpaywall → domain-specific → WebFetch → metadata-only)
- Retrieval method is tracked in metadata and source index
- RADAR assessment is systematic and documented for all sources
- Metadata files conform to schema v1.0 specification
- Source index provides clear catalogue with statistics and retrieval breakdown
- Provenance tracking enables audit trail of retrieval attempts
- Quality threshold is maintained (average reliability ≥ 0.7)
- Source count meets requirements (8-15 per research question)
- Full-text vs metadata-only ratio is appropriate for domain (expect ~66% full-text for STEM, ~33% for social sciences)
- Limitations are transparently documented (domain coverage, paywalled sources)
- Handoff to synthesis phase is clear and complete
