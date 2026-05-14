# Source Metadata Schema v1.0

**Version:** 1.0
**Created:** 2026-01-21
**Purpose:** Define canonical YAML schema for source metadata in two-phase research system
**Status:** Approved for implementation

## Overview

This document specifies the YAML metadata schema for source files collected during research. Each source file (`.md`, `.pdf`, `.html`) has a companion metadata file (`.meta.yaml`) that captures bibliographic information, reliability assessment, and provenance tracking.

**Design principles:**
- Human-readable YAML format over JSON
- Dublin Core foundation for interoperability
- RADAR framework integration for credibility assessment
- Extensible structure for future fields
- Balance between completeness and practicality

**Use cases:**
- Source-collector agent writes metadata during collection
- Source-synthesiser agent reads metadata for context and filtering
- Orchestrator validates metadata completeness
- Researchers audit source credibility and provenance

## Storage Pattern

Each source file has a corresponding metadata file with `.meta.yaml` extension:

```
work/<task-id>/sources/
├── papers/
│   ├── source_001.pdf
│   └── source_001.meta.yaml
├── web/
│   ├── source_003.md
│   └── source_003.meta.yaml
└── index.json (optional catalogue)
```

## Schema Specification

### Core Fields (Always Required)

Core fields derive from Dublin Core metadata standard and are required for all source types.

```yaml
source_id: string # "src_NNN" format (zero-padded)
title: string # Document title
url: string # Full URL (use "local" for offline sources)
fetch_date: string # ISO 8601 datetime "YYYY-MM-DDTHH:MM:SSZ"
authors: list[string] # ["Unknown"] if unavailable
publication_date: string # "YYYY-MM-DD", "YYYY-MM", or "YYYY"; "unknown" if unavailable
source_type: enum # "academic_paper" | "web_page" | "blog" | "documentation"
format: enum # "pdf" | "html" | "markdown"
file_path: string # Relative path from workspace root
content_hash: string # "sha256:HEX_DIGEST" (64 hex characters)
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

RADAR framework fields for source credibility assessment. The `reliability_score` is calculated as: **(relevance + authority + date + accuracy + rationale) / 25.0** (arithmetic mean of 1-5 scores, normalised to 0.0-1.0).

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

Fields tracking collection metadata for reproducibility and audit trails.

```yaml
provenance:
  collected_by: string # Agent/tool that collected source
  collection_method: string # "WebFetch", "WebSearch", "manual-upload"
  collected_at: string # ISO 8601 datetime
  task_id: string # Task workspace identifier
  notes: string # Optional collection notes
```

### Missing Data Conventions

**Consistent handling of unknown/missing values:**
- Strings: use `"unknown"` (lowercase)
- Lists: use `["Unknown"]` for single unknown author; empty list `[]` when absence is meaningful
- Dates: use `"unknown"` string
- Integers/floats: omit field if optional; document sentinel values if required

## Complete Examples

### Example 1: Academic Paper

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

radar_assessment:
  reliability_score: 0.95
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
  collection_method: "WebFetch"
  collected_at: "2026-01-21T14:30:00Z"
  task_id: "transformer-architecture-research"
  notes: "Retrieved from arXiv"
```

### Example 2: Web Page

```yaml
source_id: "src_012"
title: "Metadata for RAG: Improve Contextual Retrieval"
url: "https://unstructured.io/insights/how-to-use-metadata-in-rag-for-better-contextual-results"
fetch_date: "2026-01-21T10:15:00Z"
authors: ["Unstructured.io Team"]
publication_date: "2025-12"
source_type: "web_page"
format: "markdown"
file_path: "sources/web/src_012.md"
content_hash: "sha256:b2c8d9e1f4a7b2c5d8e1f4a7b2c5d8e1f4a7b2c5d8e1f4a7b2c5d8e1f4a7b2c5"
metadata_version: "1.0"

description: "Comprehensive guide to metadata best practices in RAG systems"
site_name: "Unstructured.io"
topics: ["RAG", "metadata", "retrieval", "information extraction"]
last_modified: "2025-12-15"

radar_assessment:
  reliability_score: 0.80
  relevance:
    score: 5
    notes: "Directly addresses metadata for RAG"
  authority:
    score: 4
    notes: "Established company in unstructured data space"
  date:
    score: 5
    notes: "Published December 2025, very current"
  accuracy:
    score: 4
    notes: "Claims supported by examples"
  rationale:
    score: 3
    notes: "Educational with commercial interest"
  assessed_at: "2026-01-21T10:30:00Z"
  assessed_by: "source-collector-agent-v1.0"

provenance:
  collected_by: "source-collector-agent-v1.0"
  collection_method: "WebFetch"
  collected_at: "2026-01-21T10:15:00Z"
  task_id: "research-system-upgrade"
  notes: "HTML converted to Markdown"
```

### Example 3: Blog Post

```yaml
source_id: "src_024"
title: "Best Practices in Retrieval Augmented Generation"
url: "https://gradientflow.substack.com/p/best-practices-in-retrieval-augmented"
fetch_date: "2026-01-21T11:45:00Z"
authors: ["Goldbloom, Anthony"]
publication_date: "2024-03-12"
source_type: "blog"
format: "markdown"
file_path: "sources/blogs/src_024.md"
content_hash: "sha256:c5d8e1f4a7b2c5d8e1f4a7b2c5d8e1f4a7b2c5d8e1f4a7b2c5d8e1f4a7b2c5d8"
metadata_version: "1.0"

blog_name: "Gradient Flow"
description: "Analysis of production RAG system design patterns"
topics: ["RAG", "best practices", "production systems", "AI engineering"]

radar_assessment:
  reliability_score: 0.75
  relevance:
    score: 4
    notes: "Relevant to RAG generally"
  authority:
    score: 4
    notes: "Recognised AI practitioner"
  date:
    score: 3
    notes: "Published March 2024, reasonably current"
  accuracy:
    score: 4
    notes: "Practical advice based on experience"
  rationale:
    score: 4
    notes: "Educational, minor commercial bias"
  assessed_at: "2026-01-21T12:00:00Z"
  assessed_by: "source-collector-agent-v1.0"

provenance:
  collected_by: "source-collector-agent-v1.0"
  collection_method: "WebFetch"
  collected_at: "2026-01-21T11:45:00Z"
  task_id: "research-system-upgrade"
  notes: "Substack post converted to Markdown"
```

### Example 4: Documentation

```yaml
source_id: "src_037"
title: "Dublin Core Metadata Element Set"
url: "https://www.dublincore.org/specifications/dublin-core/dces/"
fetch_date: "2026-01-21T13:20:00Z"
authors: ["Dublin Core Metadata Initiative"]
publication_date: "2012-06-14"
source_type: "documentation"
format: "html"
file_path: "sources/docs/src_037.html"
content_hash: "sha256:d8e1f4a7b2c5d8e1f4a7b2c5d8e1f4a7b2c5d8e1f4a7b2c5d8e1f4a7b2c5d8e1"
metadata_version: "1.0"

product_name: "Dublin Core Metadata Initiative"
doc_version: "1.1"
section: "Specifications"
topics: ["metadata standards", "dublin core", "information architecture"]

radar_assessment:
  reliability_score: 0.95
  relevance:
    score: 5
    notes: "Canonical Dublin Core specification"
  authority:
    score: 5
    notes: "Official standards body (DCMI)"
  date:
    score: 3
    notes: "Published 2012, stable standard"
  accuracy:
    score: 5
    notes: "Authoritative specification"
  rationale:
    score: 5
    notes: "Standards documentation, objective"
  assessed_at: "2026-01-21T13:30:00Z"
  assessed_by: "source-collector-agent-v1.0"

provenance:
  collected_by: "source-collector-agent-v1.0"
  collection_method: "WebFetch"
  collected_at: "2026-01-21T13:20:00Z"
  task_id: "research-system-upgrade"
  notes: "Preserved as HTML for formatting"
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

1. **File path consistency**: `file_path` must point to existing file
2. **Hash consistency**: `content_hash` must match SHA-256 of file at `file_path`
3. **Date consistency**: `fetch_date` >= `publication_date` (if known)
4. **Source type consistency**: Source-specific fields present when `source_type` requires them
5. **RADAR score consistency**: `reliability_score` equals `(relevance + authority + date + accuracy + rationale) / 25.0`
6. **Provenance consistency**: `provenance.collected_at` should equal or closely match `fetch_date`

## Extensibility

### Adding New Fields

1. **New optional fields**: Add without affecting existing files
2. **New source types**: Add enum value, define required fields
3. **New formats**: Add enum value as needed
4. **Custom fields**: Prefix with `custom_` to avoid collision with future standard fields

**Example custom field:**
```yaml
custom_internal_project_code: "PROJ-2026-042"
```

### Schema Versioning

When incompatible changes are required:
1. Increment `metadata_version` major number (`1.0` → `2.0`)
2. Update specification with migration guide
3. Maintain backward compatibility during transition
4. Provide migration tools

**Future-proofing:**
- Parsers should ignore unknown fields rather than error
- Required fields only added with major version increment
- Field semantics remain stable within major version

---

**Schema version:** 1.0
**Specification status:** Ready for implementation
