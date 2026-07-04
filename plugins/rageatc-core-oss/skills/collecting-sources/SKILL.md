---
name: collecting-sources
description: Collects research sources with quality evaluation. Use when gathering or finding sources, building a source library, searching for academic papers, or performing RADAR assessment.
---

# Collecting Sources

Phase 1 of two-phase research: discover, evaluate, and store sources with metadata. Synthesis (Phase 2) and fact-checking (Phase 3) are separate phases — this skill ends at handoff.

Everything lands in the task workspace:

```
work/<task-id>/
├── source_index.md      # human-readable catalogue
└── sources/
    ├── papers/          # academic papers (.txt from CORE/Unpaywall, .pdf from arXiv)
    ├── web/             # web pages (Markdown)
    ├── blogs/           # blog posts (Markdown)
    └── docs/            # documentation (Markdown/HTML)
```

Every source file has a `.meta.yaml` companion conforming to schema v1.0 — fields, missing-data conventions, and a complete example in `references/source-metadata-schema.md`.

## 1 — Setup

- `mkdir -p work/<task-id>/sources/{papers,web,blogs,docs}`
- Source IDs are sequential and zero-padded: `src_001`, `src_002`, …
- If `source_index.md` exists from a previous collection, load it for duplicate detection.

## 2 — Discovery

**Detect the domain** from the research question:

- **Academic**: "paper", "study", "peer-reviewed", "journal"; biomedical (clinical, drug, patient), CS/physics (algorithm, neural network, quantum), social sciences (policy, governance, economics); academic URLs given (arxiv.org, doi.org, pubmed.gov)
- **General web**: "tutorial", "guide", "how-to", documentation focus, no academic terminology

**Academic research** — discovery finds papers and extracts **identifiers** (DOI, arXiv ID, PubMed ID, exact title) for the retrieval chain; do not fetch full text during discovery. Run 3–5 targeted WebSearch queries mixing plain and site-specific forms:

- Biomedical: `site:pubmed.ncbi.nlm.nih.gov [topic]`
- CS/physics: `site:arxiv.org [topic]`
- Any domain: `site:scholar.google.com [topic]`, `[topic] research paper peer-reviewed`

Collect candidate metadata: title, authors, publication date, venue, abstract excerpt, identifiers.

**General web research** — run 3–5 targeted WebSearch queries with alternative phrasings; target authoritative sources (official docs, expert blogs, reputable sites); use site-specific searches when the site is known (`site:docs.python.org async`). Collect URLs, titles, authors, dates.

**Target: 15–25 candidates** from diverse source types, to be filtered to 8–15 on quality.

## 3 — Retrieval

Before fetching each candidate, check for duplicates: URL match against existing sources, DOI match against `doi` fields in existing `.meta.yaml` files. If already collected, skip and log.

### Academic papers — fallback chain

Try in order; record which step succeeded as `retrieval_method`:

**1. CORE API** — always first; 46M full texts as plain text, all domains:
- WebFetch `https://api.core.ac.uk/v3/search/works?q=doi:[DOI]` — or `q=title:"[exact title]"` if no DOI
- If the JSON `fullText` field is non-empty, save it as `.txt` — done. Otherwise continue.
- Rate limit (free tier): 1 batch or 5 single requests per 10 seconds.

**2. Unpaywall MCP** — open-access PDF discovery and extraction:
- `unpaywall_get_fulltext_links(doi=...)` → `best_oa_location.url_for_pdf`; without a DOI, find one via `unpaywall_search_titles(query="exact title")`
- `unpaywall_fetch_pdf_text(doi=..., truncate_chars=50000)` → save as `.txt` (typical papers run 20,000–30,000 chars; surveys 90,000–100,000)
- Rate limit: 100,000 calls/day. If no OA version exists, continue.

**3. Domain repository:**
- **arXiv** (CS, physics, maths): prefer the arXiv MCP server if available; else query CORE by arXiv ID or title; last resort WebFetch `https://export.arxiv.org/pdf/[arxiv_id].pdf` — this stores the binary PDF only (WebFetch cannot extract PDF text). Max ~4 requests/second.
- **PubMed Central** (biomedical): WebFetch `https://pmc.ncbi.nlm.nih.gov/articles/PMC[PMCID]/` — full-article HTML, store as Markdown or HTML.

**4. WebFetch the landing page** — occasionally yields full text as HTML; at minimum, abstract and bibliographic metadata.

**5. Metadata-only** (paywalled, last resort):
- First search for open-access alternatives: `site:arxiv.org [title]`, `site:biorxiv.org [title]`, `[author] [title] pdf`.
- If unavailable: record all metadata from the landing page; set `file_path: "unavailable"` and `content_hash: "unavailable"`; list the attempted strategies in `provenance.notes`; flag "Metadata only (paywalled)" in the index.

**Social sciences caveat**: OA coverage is ~33% vs ~66% for STEM, and SSRN (1.74M preprints) has no API. Expect 50–60% metadata-only rates and say so in the collection summary.

### Web pages, blogs, documentation

WebFetch (converts HTML to Markdown). Preserve HTML only when formatting is critical.

### Storage

Classify `source_type` (`academic_paper`, `web_page`, `blog`, `documentation`) and store:

| Source | Path | Format |
|--------|------|--------|
| Paper via CORE/Unpaywall | `sources/papers/src_NNN.txt` | plaintext |
| Paper via arXiv direct | `sources/papers/src_NNN.pdf` | pdf |
| Paper, metadata-only | no file — `file_path: "unavailable"` | — |
| Web page / blog / documentation | `sources/{web,blogs,docs}/src_NNN.md` | markdown (or html) |

Generate the content hash — `shasum -a 256 <file>` → `content_hash: "sha256:HEX"` — and compare against existing hashes to catch duplicate content fetched from different URLs.

## 4 — Metadata and RADAR

Write `src_NNN.meta.yaml` beside each source file, conforming to `references/source-metadata-schema.md`: core fields, source-type-specific fields, provenance (collected_by, collection_method, collected_at, task_id, notes), and `retrieval_method` for academic papers.

Assess every source on five RADAR dimensions, scored 1–5 with brief notes:

- **Relevance** — how directly it addresses the research question
- **Authority** — credibility of the author/publisher
- **Date** — currency relative to the field's pace
- **Accuracy** — verifiability and citation quality
- **Rationale** — purpose and potential bias

```
reliability_score = (Relevance + Authority + Date + Accuracy + Rationale) / 25.0
```

Full scoring rubric: `skills/verifying-claims/references/source-evaluation-radar.md`. Paywalled sources are assessed on abstract, venue, and authors.

## 5 — Quality filtering

- reliability < 0.5 — exclude (delete files and metadata); document exclusions and reasons
- 0.5–0.6 — flag for review; include only if the source count falls short
- ≥ 0.6 (or the requested threshold) — include

Minimum 8 high-quality sources per research question. If short: broaden queries, try alternative tools, lower the floor to 0.5 if necessary, and document the limitation. Retain everything above threshold — more coverage helps synthesis; prioritise the highest scores there.

## 6 — Source index

Write `work/<task-id>/source_index.md`:

```markdown
# Source Index

**Task**: [task-id] · **Research question(s)**: […] · **Collection date**: [YYYY-MM-DD]

## Summary Statistics
- Total sources: [N] — [breakdown by type]; papers: [X] full-text / [Y] metadata-only
- Retrieval methods (papers): CORE [n] · Unpaywall [n] · arXiv [n] · PMC [n] · WebFetch [n] · metadata-only [n]
- Average reliability: [score]; distribution: excellent ≥0.8 [n] · good 0.7–0.79 [n] · acceptable 0.6–0.69 [n]

## Sources by Topic

### [Topic/theme]

**src_NNN** — [Title]
- **URL**: […] · **Type**: […] · **Reliability**: […] · **Retrieval**: […]
- **Summary**: [one or two lines]
- **Metadata**: `sources/<subdir>/src_NNN.meta.yaml`

## Collection Notes
- Tools used; quality threshold applied
- Limitations: [paywalled count, coverage gaps, domain caveats]
```

Group sources by themes extracted from abstracts/descriptions and the research question; note sources relevant to multiple topics.

## 7 — Handoff

Report to the orchestrator: total sources (full-text vs metadata-only), breakdown by type and retrieval method, average reliability, paths to `source_index.md` and the sources directory, exclusions and limitations (including domain caveats), and whether the collection is ready for synthesis or needs additional searches.

## Constraints

- Working directory resets between Bash calls — use absolute paths.
- Bash only for hashing and file operations; no custom scripts.
- Out of scope: synthesis and analysis, fact-checking, research question formulation, MCP installation, paywall circumvention (no institutional credentials).

## Reference APIs

- **CORE API** — [core.ac.uk/services/api](https://core.ac.uk/services/api) — 46M full texts as plain text in JSON
- **Unpaywall** — [unpaywall.org/products/api](https://unpaywall.org/products/api) — OA detection and PDF URLs
- **arXiv** — [arxiv.org](https://arxiv.org) — 2.4M papers, direct PDF access
- **PubMed Central** — [pmc.ncbi.nlm.nih.gov](https://pmc.ncbi.nlm.nih.gov) — biomedical full texts
- **Semantic Scholar** — [semanticscholar.org](https://www.semanticscholar.org) — 214M papers, metadata only
- **Google Scholar** — [scholar.google.com](https://scholar.google.com) — academic search
