---
name: working-with-pdfs
description: Handles PDF operations (reading, creating, modifying). Use when extracting text from PDFs, converting markdown to PDF, merging or splitting PDFs, compressing, rotating pages, handling metadata, or when Claude Code's native PDF reading fails.
---

# Working with PDFs

Select the tool by operation category, detect what's installed before recommending anything, and keep a fallback ready. Covers macOS, Linux (Debian/Ubuntu), and WSL2; native Windows is out of scope.

## Step 1 — Detect environment

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

## Step 2 — Categorise the operation

- **Reading/extraction** — text, tables, metadata, images, PDF to plain text → Step 3A
- **Creation** — markdown to PDF, generated documents → Step 3B
- **Modification** — merge, split, rotate, compress, encrypt/decrypt, metadata, repair → Step 3C

## Step 3A — Reading/extraction

**Table extraction from clean, machine-generated PDFs** → **pdfplumber** (`pip install pdfplumber`). Best table accuracy, visual debugging tool. No OCR — useless on scans.

**Python, commercial use anticipated** → **pypdf** (`pip install pypdf`) — the default recommendation. Pure Python, BSD licence, actively maintained. 10–20× slower than PyMuPDF at scale.

**Highest performance, AGPL-compatible project** → **PyMuPDF** (`pip install PyMuPDF`). Fastest extraction (~0.1s/document), full-featured. AGPL v3.0 — commercial use requires AGPL compliance or a commercial licence from Artifex; always flag this before recommending.

**Simple text extraction in shell scripts** → **poppler/pdftotext** (`brew install poppler` / `sudo apt install poppler-utils`). Fast; does not preserve layout.

**Simple PDF (under ~20 pages, plain text), not a production workflow** → try Claude Code's native Read tool first. See Known Claude Code issues below if it errors.

**Scanned documents needing OCR** → out of scope; investigate Tesseract or OCRmyPDF separately.

**Fallbacks:** pypdf ↔ PyMuPDF (licence permitting) cover each other; pdfplumber unavailable → PyMuPDF/pypdf for text and parse tables manually; no Python tools at all → poppler/pdftotext.

## Step 3B — Creation (markdown to PDF)

**Node.js ecosystem or minimal dependencies** → **md-to-pdf** (`npm install -g md-to-pdf`). Lightest option, no LaTeX; renders via Puppeteer (~170MB Chromium). Single file input only — cannot merge files.

**CSS-based styling, comfortable with system dependencies** → **WeasyPrint**. Python, BSD licence, strong CSS control, no JavaScript execution. Requires system libraries (Pango, GObject) that cause installation friction — see `references/tool-installation.md`.

**Advanced Markdown features or publication-quality typesetting** → **Pandoc + BasicTeX**. Tables, footnotes, citations, maths; merges multiple files. Requires LaTeX (~1GB BasicTeX, ~6GB full TeX Live).

**Frequent compilation, control over output format** → **Pandoc + Typst** (experimental). 27× faster than XeLaTeX, cleaner syntax. Good for internal documents; not for journal submissions.

**Avoid wkhtmltopdf** — unmaintained, cannot compile with modern toolchains.

**Fallbacks:** no npm → WeasyPrint or Pandoc; WeasyPrint dependencies fail → md-to-pdf or Pandoc; LaTeX too large → md-to-pdf; nothing installable → Docker approach in `references/tool-installation.md`.

## Step 3C — Modification

**CLI automation or comprehensive manipulation** → **qpdf** (`brew install qpdf` / `sudo apt-get install qpdf`) — the primary recommendation. Merge, split, rotate, compress, encrypt, repair; Apache licence; clean cross-platform installs.

**Python workflow, basic operations** → **pypdf**. Split, merge, crop, transform, basic metadata; pure Python, BSD. Cannot create linearised PDFs.

**Python workflow, advanced features** → **pikepdf** (`pip install pikepdf`). qpdf C++ bindings: linearised PDFs, XMP metadata, better validation, faster. Cannot extract text; needs C++ compilation.

**Avoid original PDFtk** — abandoned (GCJ-based, uncompilable since GCC 7). **pdftk-java** only when migrating from PDFtk; otherwise prefer qpdf.

**Fallbacks:** qpdf ↔ pypdf ↔ pikepdf cover each other; if none installable, flag it as an environment issue.

## Step 4 — Install and execute

`references/tool-installation.md` has platform-specific installation commands, verification, troubleshooting, Docker alternatives, and working code examples for every tool above.

## Known Claude Code issues

- **"PDF too large" error that then blocks ALL subsequent PDF reads** — known bug (#13518): the error state persists across requests regardless of file size. Restart the session; use external tools for production workflows.
- **"This tool cannot read binary files"** — missing pypdf in the environment: `pip install pypdf`. Older workarounds reference PyPDF2, which is deprecated — use pypdf.

## Licences

Permissive: pypdf (BSD), qpdf (Apache), WeasyPrint (BSD). poppler and Pandoc are GPL, but invoking a GPL CLI tool from a script has no licence impact on the calling code or documents. The one restrictive licence is **PyMuPDF (AGPL v3.0)** — commercial use requires open-sourcing under AGPL or buying a licence from Artifex.

## Out of scope

OCR workflows (Tesseract, OCRmyPDF), PDF/A archival compliance, accessible-PDF standards, digital signatures, advanced encryption, native Windows.
