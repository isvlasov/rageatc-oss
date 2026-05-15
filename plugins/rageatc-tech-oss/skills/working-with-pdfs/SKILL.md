---
name: working-with-pdfs
description: Handles PDF operations (reading, creating, modifying). Use when extracting text from PDFs, converting markdown to PDF, merging or splitting PDFs, compressing, rotating pages, handling metadata, or when Claude Code's native PDF reading fails.
---

# Working with PDFs

## Purpose

Enable reliable PDF operations in CLI environments by providing decision frameworks for tool selection, environment detection protocols, and graceful fallback chains across three operation categories: reading/extraction, creation from markdown, and modification/manipulation.

This skill addresses Claude Code's native PDF reading limitations (persistent "PDF too large" bug, binary file rejection) by encoding external tool selection logic rather than cataloguing options. You'll reach clear recommendations through environment-aware decision trees, not wade through tool comparisons.

## When to Use This Skill

**Primary triggers:**
- Claude Code's native Read tool fails with "PDF too large" or "cannot read binary files" errors
- Need to extract text, tables, or data from PDF files
- Converting markdown documents to PDF format
- Merging, splitting, rotating, compressing, or modifying existing PDFs
- Production workflows requiring reliable, repeatable PDF operations
- Selecting appropriate tools when multiple options exist

**Skip this skill when:**
- Task doesn't involve PDF files
- You already know which tool to use and how to install it

## Operating Principles

**Environment detection before recommendation** — Always check what's installed before recommending tools. Adapt to available resources rather than assuming specific setups.

**Decision trees, not catalogues** — Follow structured workflows to reach clear tool recommendations. This skill guides selection, not exhaustive comparison.

**Fallback chains for reliability** — Every operation category provides ordered alternatives so workflows don't fail when preferred tools are unavailable.

**Cross-platform by design** — All recommendations work on macOS, Linux (Debian/Ubuntu), and WSL2. Native Windows is out of scope.

**Licence awareness** — Some tools have licence restrictions (PyMuPDF AGPL, commercial use constraints). The skill flags these before recommendation.

## Degree of Freedom

**Medium freedom with preferred patterns:**
- Follow decision trees to select tools appropriate for your environment
- Apply environment detection before recommending installation
- Use fallback chains when preferred tools unavailable
- Adapt installation commands to specific distributions within documented platforms

**Non-negotiable standards:**
- Detect environment before tool recommendation
- Warn about licence restrictions before suggesting AGPL-licenced tools (PyMuPDF)
- Provide fallback options for each operation category
- Never recommend abandoned tools (original PDFtk, wkhtmltopdf)

## Inputs to Gather

Before entering decision trees, collect:

1. **PDF file(s)** to operate on
2. **Operation needed**: read/extract, create from markdown, or modify existing PDF
3. **Commercial use anticipated**: affects licence recommendations (PyMuPDF AGPL restriction)
4. **Platform**: macOS, Linux (Debian/Ubuntu), or WSL2
5. **Constraints**: disk space limits, available package managers, performance requirements

## Core Workflow

### Step 1: Detect Environment

Check what's installed across all categories before proceeding to operation-specific selection. This establishes a baseline and enables faster recommendations.

```bash
# Python tools
python3 -c "import pypdf" 2>/dev/null && echo "pypdf: installed" || echo "pypdf: not found"
python3 -c "import fitz" 2>/dev/null && echo "PyMuPDF: installed" || echo "PyMuPDF: not found"
python3 -c "import pdfplumber" 2>/dev/null && echo "pdfplumber: installed" || echo "pdfplumber: not found"
python3 -c "import weasyprint" 2>/dev/null && echo "WeasyPrint: installed" || echo "WeasyPrint: not found"
python3 -c "import pikepdf" 2>/dev/null && echo "pikepdf: installed" || echo "pikepdf: not found"

# CLI tools
command -v qpdf >/dev/null 2>&1 && echo "qpdf: installed" || echo "qpdf: not found"
command -v pdftotext >/dev/null 2>&1 && echo "poppler: installed" || echo "poppler: not found"
command -v pandoc >/dev/null 2>&1 && echo "Pandoc: installed" || echo "Pandoc: not found"
command -v md-to-pdf >/dev/null 2>&1 && echo "md-to-pdf: installed" || echo "md-to-pdf: not found"
```

### Step 2: Categorise the PDF Operation

Identify which operation category your task falls into. This determines the decision tree to follow.

**Reading/Extraction Operations:**
- Extract text from existing PDFs
- Parse tables from PDFs
- Extract metadata or images
- Convert PDF to plain text

**Creation Operations:**
- Convert markdown to PDF
- Generate PDFs from source documents
- Create PDFs with specific formatting requirements

**Modification Operations:**
- Merge multiple PDFs
- Split PDFs into separate files or page ranges
- Rotate pages
- Compress file size
- Encrypt or decrypt
- Edit metadata
- Repair malformed PDFs

Proceed to the relevant decision tree (Step 3A, 3B, or 3C).

---

### Step 3A: Reading/Extraction Decision Tree

**If need is table extraction from clean, machine-generated PDFs:**
→ Use **pdfplumber**
- Best table extraction accuracy (96% on clean PDFs)
- Visual debugging tool for refinement
- Installation: `pip install pdfplumber`
- Limitation: No OCR support (doesn't work on scanned documents)

**Else if working in Python AND commercial use anticipated:**
→ Use **pypdf** (default recommendation)
- Pure Python, no compilation needed
- BSD licence (permissive, no commercial restrictions)
- Actively maintained (rapid release cycle 2024-2025)
- Installation: `pip install pypdf`
- Limitation: 10-20× slower than PyMuPDF for large-scale processing

**Else if need highest performance AND open-source project (AGPL compatible):**
→ Use **PyMuPDF** (fitz)
- Fastest text extraction (0.1s average per document)
- Comprehensive features (text, images, metadata, OCR)
- **CRITICAL WARNING:** AGPL v3.0 licence — commercial use requires either making your application AGPL-compliant OR purchasing commercial licence from Artifex
- Installation: `pip install PyMuPDF`
- Occasional M1 Mac compilation issues (mostly resolved)

**Else if need simple text extraction in shell scripts:**
→ Use **poppler/pdftotext**
- Lightweight CLI tool
- Fast conversion to plain text
- Installation: `brew install poppler` (macOS) or `sudo apt install poppler-utils` (Linux)
- Limitation: Does not preserve layout formatting

**Else if PDF is simple (under 20 pages, plain text only) AND not production workflow:**
→ Try **Claude Code's native Read tool**
- Built-in capability, no installation
- **CRITICAL WARNING:** Persistent bug causes "PDF too large" error that blocks ALL subsequent PDF reading until session restart
- If error occurs, restart session and use external tool instead
- Not recommended for production workflows

**If scanned documents requiring OCR:**
This skill does not cover OCR-specific workflows. Investigate Tesseract or OCRmyPDF separately.

**Fallback chain if preferred tool unavailable:**
1. pypdf unavailable → Try PyMuPDF (if AGPL acceptable) or poppler
2. PyMuPDF unavailable → Use pypdf (slower but reliable)
3. pdfplumber unavailable → Use PyMuPDF or pypdf for text, manual table parsing
4. All Python tools unavailable → Use poppler/pdftotext (CLI fallback)

---

### Step 3B: Creation (Markdown to PDF) Decision Tree

**If working in Node.js ecosystem OR want minimal dependencies:**
→ Use **md-to-pdf** (npm)
- Lightest option (no LaTeX required)
- Uses Puppeteer (headless Chrome) for rendering
- Syntax highlighting via highlight.js
- Installation: `npm install -g md-to-pdf`
- Limitation: Cannot merge multiple files; single file input only
- Disk space: ~170MB (Chromium download)

**Else if need CSS-based styling AND comfortable with system dependencies:**
→ Use **WeasyPrint**
- Better CSS control than older alternatives
- Python-based, BSD licence
- No JavaScript execution (security benefit)
- Lighter weight than LaTeX
- **CRITICAL WARNING:** Requires system libraries (Pango, GObject) that cause installation friction
- Installation: See `references/tool-installation.md` for platform-specific commands

**Else if need advanced Markdown features OR highest quality typesetting:**
→ Use **Pandoc + BasicTeX**
- Most capable tool for enhanced Markdown (tables, footnotes, citations, maths)
- Can merge multiple Markdown files
- Academic/publication-quality output
- **CRITICAL WARNING:** Requires LaTeX installation (~1GB for BasicTeX, ~6GB for full TeX Live)
- Installation: See `references/tool-installation.md` for detailed steps

**Else if compiling frequently AND control output format:**
→ Consider **Pandoc + Typst** (experimental)
- 27× faster than XeLaTeX in benchmarks
- Modern typesetting system (Rust-based)
- Cleaner syntax than LaTeX
- Pandoc support is experimental (not yet stable for all use cases)
- Best for: internal documents, reports, presentations
- Not suitable for: academic journal submissions (journals require LaTeX)

**Avoid:**
- **wkhtmltopdf** — Unmaintained since GCC 7 dropped GCJ; cannot compile with modern tools

**Fallback chain if preferred tool unavailable:**
1. md-to-pdf unavailable (no npm) → Try WeasyPrint or Pandoc
2. WeasyPrint system dependencies fail → Use md-to-pdf (if npm available) or Pandoc
3. Pandoc unavailable or LaTeX too large → Use md-to-pdf (simplest alternative)
4. All tools unavailable → Consider Docker approach (see `references/tool-installation.md`)

---

### Step 3C: Modification Decision Tree

**If CLI automation OR need comprehensive manipulation features:**
→ Use **qpdf** (primary recommendation)
- C++ based, actively maintained
- Comprehensive operations: merge, split, rotate, compress, encrypt, repair
- Apache Licence (permissive)
- Cross-platform reliability (clean installation via package managers)
- Installation: `brew install qpdf` (macOS) or `sudo apt-get install qpdf` (Linux)

**Else if Python workflow AND basic operations sufficient:**
→ Use **pypdf**
- Pure Python (no system dependencies)
- Splitting, merging, cropping, transforming, basic metadata
- BSD licence (permissive)
- Actively maintained (rapid release cycle 2024-2025)
- Installation: `pip install pypdf`
- Limitation: Cannot create linearised PDFs; lower test coverage than pikepdf

**Else if Python workflow AND need advanced features:**
→ Use **pikepdf**
- Python bindings to qpdf C++ library
- Creates linearised PDFs
- Better validation and test coverage than pypdf
- PDF XMP metadata editing support
- Faster (C++ backend)
- Installation: `pip install pikepdf`
- Limitation: Cannot extract text (not a reading library); requires C++ compilation

**Avoid:**
- **Original PDFtk** — Abandoned; written in C++ using GCJ (GNU Compiler for Java), which GCC dropped since version 7. Cannot compile with modern development tools.

**Conditional:**
- **pdftk-java** — Maintained Java port of PDFtk. Only use if migrating from original PDFtk. Otherwise, prefer qpdf (broader support, more commonly recommended).

**Fallback chain if preferred tool unavailable:**
1. qpdf unavailable → Use pypdf (Python fallback for basic operations)
2. pypdf unavailable → Use pikepdf (if C++ compilation supported) or qpdf
3. pikepdf unavailable → Use pypdf (pure Python alternative)
4. All tools unavailable → Flag as environment issue; check package manager access

---

### Step 4: Install Selected Tool

See `references/tool-installation.md` for:
- Platform-specific installation commands (macOS, Linux, WSL2)
- System dependency requirements
- Verification commands
- Troubleshooting guidance
- Docker alternatives

**Quick installation reference for recommended defaults:**
- pypdf: `pip install pypdf`
- qpdf: `brew install qpdf` (macOS) or `sudo apt-get install qpdf` (Linux)
- md-to-pdf: `npm install -g md-to-pdf`

---

### Step 5: Execute Operation

See `references/tool-installation.md` for complete code examples covering:
- pypdf text extraction and PDF manipulation
- PyMuPDF text extraction
- pdfplumber table extraction
- poppler CLI text conversion
- md-to-pdf document creation
- WeasyPrint styling workflow
- Pandoc conversion with LaTeX and Typst
- qpdf merge, split, rotate, compress operations
- pypdf and pikepdf Python manipulation

---

### Step 6: Handle Common Issues

**Issue: "PDF too large" error with Claude Code Read tool**
- **Symptom:** Error persists for ALL subsequent PDF reads regardless of file size
- **Cause:** Known bug (#13518) where error state persists across requests
- **Solution:** Restart Claude Code session; use external tools for production workflows

**Issue: "This tool cannot read binary files" error**
- **Symptom:** Claude Code rejects PDF as binary file
- **Cause:** Missing pypdf in environment
- **Solution:** `pip install pypdf` (installs PDF parsing capability that Claude Code depends on). Note: older workarounds reference PyPDF2, which is deprecated — use pypdf instead.

**For all other installation and runtime issues:** See `references/tool-installation.md` troubleshooting section.

---

## Edge Cases and Constraints

**Out of scope for this skill:**
- OCR-specific workflows (Tesseract, OCRmyPDF)
- PDF/A archival compliance
- Accessible PDF creation (WCAG standards)
- Digital signatures
- Advanced encryption beyond basic password protection
- Native Windows (non-WSL) — this skill covers macOS, Linux, WSL2

**Large PDF handling:**
- Claude Code: 25,000 token limit (~20 pages guideline, varies by content)
- External tools: Most handle large PDFs; performance degrades with file size
- For very large files (>1000 pages), consider streaming approaches or splitting first

**Security:**
- WeasyPrint does not execute JavaScript (security benefit)
- Encryption/decryption: qpdf and pypdf support basic password operations
- For advanced security requirements, consult tool documentation

---

## Licence Considerations

**Permissive licences (commercial use allowed):**
- pypdf: BSD licence
- qpdf: Apache Licence
- WeasyPrint: BSD licence
- poppler: GPL (calling a GPL CLI tool from your script does not make your script GPL — this applies to external program invocations)
- Pandoc: GPL (same principle — invoking Pandoc as an external command has no licence impact on your documents or calling code)

**Restrictive licences (check before commercial use):**
- **PyMuPDF: AGPL v3.0** — If using in commercial software, you must either:
  - Make your application free and open-source (AGPL-compliant), OR
  - Purchase commercial licence from Artifex Software
- This is a significant constraint; always flag before recommending PyMuPDF

---

## Quality Checklist

Before finalising tool selection and execution, confirm:

- [ ] Operation category identified (reading, creation, modification)
- [ ] Environment detection performed (checked installed tools)
- [ ] Requirements clarified (commercial use, performance needs, complexity)
- [ ] Decision tree followed to reach clear recommendation
- [ ] Licence restrictions checked (AGPL warning for PyMuPDF if applicable)
- [ ] Installation friction assessed (disk space, system dependencies)
- [ ] Fallback options documented in case preferred tool unavailable
- [ ] Platform-specific commands verified for your environment (macOS, Linux, WSL2)
- [ ] Common issues addressed if encountered
- [ ] Abandoned tools avoided (original PDFtk, wkhtmltopdf)

---

## Supporting Files

This skill uses progressive disclosure. Core decision trees and workflows are in this file; detailed reference material is in supporting files:

- **`references/tool-installation.md`** - Platform-specific installation commands, verification, troubleshooting, full code examples, comparison tables, and detailed cross-platform gotchas

---

## Evaluation Scenarios

### Scenario 1: Extract Text from PDF for Analysis

**Task:** User needs to extract text from a 50-page research report for analysis. Commercial project.

**Expected process:**
- Detect environment: Check for Python tools
- Categorise: Reading/extraction operation
- Requirements: Commercial use → eliminates PyMuPDF
- Decision: Recommend pypdf (pure Python, BSD licence, adequate performance)
- Installation: `pip install pypdf`
- Execute: Provide extraction code example
- Fallback: If pypdf unavailable, suggest poppler/pdftotext

**Success criteria:** Selects appropriate tool considering licence restrictions, provides installation and usage guidance, documents fallback option.

### Scenario 2: Convert Markdown to PDF with Minimal Setup

**Task:** User wants to convert project README.md to PDF quickly. Disk space constrained.

**Expected process:**
- Detect environment: Check for npm, Pandoc, LaTeX
- Categorise: Creation operation
- Requirements: Minimal dependencies, quick setup
- Decision: Recommend md-to-pdf (lightest option, no LaTeX)
- Installation: `npm install -g md-to-pdf`
- Execute: `md-to-pdf README.md`
- Fallback: If npm unavailable, try WeasyPrint (if system dependencies manageable) or flag LaTeX disk space requirement for Pandoc

**Success criteria:** Prioritises minimal installation friction, warns about disk space, provides fallback chain, avoids recommending Pandoc + LaTeX given constraint.

### Scenario 3: Merge Three PDFs in Shell Script

**Task:** Automated workflow needs to merge three PDF reports weekly.

**Expected process:**
- Detect environment: Check for qpdf
- Categorise: Modification operation
- Requirements: CLI automation, reliability
- Decision: Recommend qpdf (primary tool for CLI automation)
- Installation: `brew install qpdf` or `sudo apt-get install qpdf`
- Execute: `qpdf --empty --pages report1.pdf report2.pdf report3.pdf -- merged.pdf`
- Fallback: If qpdf unavailable, provide pypdf Python alternative

**Success criteria:** Selects CLI-appropriate tool, provides exact command syntax, documents Python fallback for environments without qpdf.

### Scenario 4: Handle "PDF Too Large" Error

**Task:** User encounters persistent "PDF too large" error with Claude Code Read tool.

**Expected process:**
- Recognise symptom: Known bug (#13518) where error persists for all PDFs
- Explain cause: Error state persists across requests until session restart
- Provide immediate solution: Restart Claude Code session
- Recommend long-term approach: Use external tools (pypdf, PyMuPDF, poppler) for production workflows
- Guide to tool selection: Follow reading/extraction decision tree

**Success criteria:** Identifies bug, explains persistence, provides restart workaround, transitions to external tool recommendation via decision tree.

---

## Success Indicators

This skill succeeds when:
- Users reach clear tool recommendations within one decision tree traversal
- Tool selection accounts for licence restrictions, disk space, installation friction
- Fallback chains prevent workflow failures when preferred tools unavailable
- Environment detection happens before recommendation (not after installation fails)
- Abandoned tools (PDFtk, wkhtmltopdf) are never recommended
- Cross-platform reliability maintained (works on macOS, Linux, WSL2)
- Users complete PDF tasks without external guidance beyond this skill

---

---
