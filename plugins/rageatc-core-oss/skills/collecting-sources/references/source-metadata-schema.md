# Source Metadata Schema v1.0

Canonical YAML schema for source metadata in two-phase research. Each source file (`.txt`, `.md`, `.pdf`, `.html`) has a companion `.meta.yaml` capturing bibliographic information, RADAR reliability assessment, and provenance. Written by the source-collector agent during collection; read by synthesis agents for context and filtering; auditable by orchestrator and researchers.

Design: human-readable YAML, Dublin Core foundation, RADAR integration, extensible.

## Storage Pattern

```
work/<task-id>/
├── source_index.md
└── sources/
    ├── papers/
    │   ├── src_001.txt
    │   └── src_001.meta.yaml
    └── web/
        ├── src_003.md
        └── src_003.meta.yaml
```

## Schema Specification

### Core Fields (Always Required)

Derived from Dublin Core; required for all source types.

```yaml
source_id: string # "src_NNN" format (zero-padded)
title: string # Document title
url: string # Full URL (use "local" for offline sources)
fetch_date: string # ISO 8601 datetime "YYYY-MM-DDTHH:MM:SSZ"
authors: list[string] # ["Unknown"] if unavailable
publication_date: string # "YYYY-MM-DD", "YYYY-MM", or "YYYY"; "unknown" if unavailable
source_type: enum # "academic_paper" | "web_page" | "blog" | "documentation"
format: enum # "pdf" | "html" | "markdown" | "plaintext"
file_path: string # Relative path from workspace root; "unavailable" for paywalled sources
content_hash: string # "sha256:HEX_DIGEST" (64 hex characters); "unavailable" for paywalled sources
metadata_version: string # "1.0"
```

### Source-Type-Specific Fields

#### Academic Paper Fields

```yaml
doi: string # Optional, if available
arxiv_id: string # Optional, if applicable
pmid: string # Optional, if applicable
abstract: string # Recommended
venue: string # Conference/journal name, recommended
citation_count: integer # Optional
topics: list[string] # Recommended
retrieval_method: string # Optional — strategy that succeeded: "CORE API" | "Unpaywall MCP" | "arXiv direct" | "PubMed Central" | "WebFetch" | "metadata-only"
```

#### Web Page Fields

```yaml
description: string # Meta description or excerpt, recommended
site_name: string # Website name, recommended
topics: list[string] # Recommended
last_modified: string # "YYYY-MM-DD", optional
```

#### Blog Post Fields

```yaml
blog_name: string # Blog/publication name, recommended
description: string # Post summary, recommended
topics: list[string] # Recommended
```

#### Documentation Fields

```yaml
product_name: string # Documented product/project name, recommended
doc_version: string # Software version, recommended
section: string # Specific section/chapter, optional
topics: list[string] # Recommended
```

### RADAR Reliability Fields

`reliability_score` = **(relevance + authority + date + accuracy + rationale) / 25.0** (arithmetic mean of 1–5 scores, normalised to 0.0–1.0).

```yaml
radar_assessment:
  reliability_score: float # 0.0 to 1.0

  relevance:
    score: integer # 1-5 scale (1=tangential, 5=directly relevant)
    notes: string # Optional

  authority:
    score: integer # 1-5 scale (1=low authority, 5=high authority)
    notes: string # Optional

  date:
    score: integer # 1-5 scale (1=outdated, 5=very current)
    notes: string # Optional

  accuracy:
    score: integer # 1-5 scale (1=questionable, 5=highly accurate)
    notes: string # Optional

  rationale:
    score: integer # 1-5 scale (1=heavily biased, 5=objective)
    notes: string # Optional

  assessed_at: string # ISO 8601 datetime
  assessed_by: string # "agent-name-version" or "human:reviewer_name"
```

### Provenance Fields

```yaml
provenance:
  collected_by: string # Agent/tool that collected source
  collection_method: string # "CORE API", "Unpaywall MCP", "WebFetch", "manual-upload", etc.
  collected_at: string # ISO 8601 datetime
  task_id: string # Task workspace identifier
  notes: string # Optional collection notes (e.g. retrieval attempts for paywalled sources)
```

### Missing Data Conventions

- Strings: use `"unknown"` (lowercase)
- Lists: use `["Unknown"]` for single unknown author; empty list `[]` when absence is meaningful
- Dates: use `"unknown"` string
- Integers/floats: omit field if optional; document sentinel values if required
- Paywalled content: `file_path: "unavailable"`, `content_hash: "unavailable"`

## Complete Example

```yaml
source_id: "src_001"
title: "Attention Is All You Need"
url: "https://arxiv.org/abs/1706.03762"
fetch_date: "2026-01-21T14:30:00Z"
authors: ["Vaswani, Ashish", "Shazeer, Noam", "Parmar, Niki", "Uszkoreit, Jakob", "Jones, Llion", "Gomez, Aidan N.", "Kaiser, Łukasz", "Polosukhin, Illia"]
publication_date: "2017-06-12"
source_type: "academic_paper"
format: "pdf"
file_path: "sources/papers/src_001.pdf"
content_hash: "sha256:a3f2b8c9d1e4f7a2b5c8d9e1f4a7b2c5d8e1f4a7b2c5d8e1f4a7b2c5d8e1f4a7"
metadata_version: "1.0"

arxiv_id: "1706.03762"
abstract: "The dominant sequence transduction models are based on complex recurrent or convolutional neural networks that include an encoder and a decoder. We propose a new simple network architecture, the Transformer, based solely on attention mechanisms."
venue: "Neural Information Processing Systems (NeurIPS) 2017"
citation_count: 89234
topics: ["neural networks", "attention mechanism", "transformers", "sequence transduction"]
retrieval_method: "arXiv direct"

radar_assessment:
  reliability_score: 0.92
  relevance:
    score: 5
    notes: "Foundational paper for transformer architecture"
  authority:
    score: 5
    notes: "Peer-reviewed, highly cited, Google authors"
  date:
    score: 3
    notes: "Published 2017, foundational but not recent"
  accuracy:
    score: 5
    notes: "Results extensively replicated"
  rationale:
    score: 5
    notes: "Academic research, objective presentation"
  assessed_at: "2026-01-21T15:00:00Z"
  assessed_by: "source-collector-agent-v1.0"

provenance:
  collected_by: "source-collector-agent-v1.0"
  collection_method: "arXiv direct"
  collected_at: "2026-01-21T14:30:00Z"
  task_id: "transformer-architecture-research"
  notes: "Retrieved from arXiv"
```

## Validation Rules

### Required Field Logic

**Always required (all source types):**
`source_id`, `title`, `url`, `fetch_date`, `authors`, `publication_date`, `source_type`, `format`, `file_path`, `content_hash`, `metadata_version`, `radar_assessment` (all sub-fields), `provenance` (required sub-fields)

**Conditionally required:**

| Source Type | Required Fields |
|-------------|----------------|
| `academic_paper` | `abstract`, `venue`, `topics` (recommended); `doi`, `arxiv_id`, or `pmid` if available |
| `web_page` | `description`, `site_name`, `topics` (recommended) |
| `blog` | `blog_name`, `description`, `topics` (recommended) |
| `documentation` | `product_name`, `doc_version`, `topics` (recommended) |

### Data Type Validation

- **Strings**: Non-empty, trimmed whitespace
- **Lists**: May be empty `[]`, elements must be non-empty strings
- **Integers**: Positive integers only
- **Floats**: 0.0 to 1.0 for `reliability_score`
- **Timestamps**: ISO 8601 format `YYYY-MM-DDTHH:MM:SSZ`
- **Dates**: Partial dates allowed for `publication_date` (`YYYY`, `YYYY-MM`, `YYYY-MM-DD`)
- **Enums**: Case-sensitive exact match
- **Hashes**: Format `sha256:HEX_DIGEST` (64 hex characters)

### Consistency Rules

1. **File path consistency**: `file_path` must point to an existing file (unless `"unavailable"` for paywalled sources)
2. **Hash consistency**: `content_hash` must match SHA-256 of file at `file_path` (unless `"unavailable"`)
3. **Date consistency**: `fetch_date` >= `publication_date` (if known)
4. **Source type consistency**: Source-specific fields present when `source_type` requires them
5. **RADAR score consistency**: `reliability_score` equals `(relevance + authority + date + accuracy + rationale) / 25.0`
6. **Provenance consistency**: `provenance.collected_at` should equal or closely match `fetch_date`

## Extensibility

- **New optional fields**: add without affecting existing files. Prefix custom fields with `custom_` to avoid collision with future standard fields.
- **New source types or formats**: add enum value; define required fields for new source types.
- **Incompatible changes**: increment the major version (`1.0` → `2.0`) with a migration guide. Field semantics remain stable within a major version; required fields are only added at a major increment.
- **Parsers**: ignore unknown fields rather than erroring.
