---

## Platform-Specific Installation Commands and Troubleshooting

This reference provides detailed installation guidance, troubleshooting steps, full code examples, and cross-platform gotchas for all tools mentioned in the main skill.

### Reading/Extraction Tools

#### pypdf

**macOS:**
```bash
pip install pypdf
# Optional: For image extraction
pip install pillow
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get update
sudo apt-get install python3-pip
pip install pypdf
pip install pillow  # Optional, for image extraction
```

**WSL2:**
WSL2 runs a full Linux kernel and package manager, so Linux installation commands apply directly. Same as Linux (Debian/Ubuntu) commands above.

**Verification:**
```bash
python3 -c "import pypdf; print(pypdf.__version__)"
```

**Common issues:**
- **ModuleNotFoundError: No module named 'PIL'** when extracting images
  - **Solution:** `pip install pillow`
- **Import errors on older macOS M1 systems** (largely resolved)
  - **Solution:** Update to latest pypdf version: `pip install --upgrade pypdf`

**Usage example (text extraction):**
```python
from pypdf import PdfReader

reader = PdfReader("document.pdf")
for page in reader.pages:
    text = page.extract_text()
    print(text)
```

---

#### PyMuPDF (fitz)

**CRITICAL WARNING:** AGPL v3.0 licence. Commercial use requires AGPL compliance OR purchasing commercial licence from Artifex Software.

**macOS:**
```bash
pip install PyMuPDF
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get update
sudo apt-get install python3-pip
pip install PyMuPDF
```

**WSL2:**
Same as Linux commands.

**Verification:**
```bash
python3 -c "import fitz; print(fitz.__version__)"
```

**Common issues:**
- **Compilation errors on Apple M1 Macs**
  - **Symptom:** Build failures during pip install
  - **Solution:** Update to latest version: `pip install --upgrade PyMuPDF`
  - **Fallback:** Use pypdf instead
- **ModuleNotFoundError on import**
  - **Solution:** Ensure C/C++ development tools installed (Xcode Command Line Tools on macOS, build-essential on Linux)

**Usage example:**
```python
import fitz  # PyMuPDF

doc = fitz.open("document.pdf")
for page in doc:
    text = page.get_text()
    print(text)
```

---

#### pdfplumber

**macOS:**
```bash
pip install pdfplumber
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get update
sudo apt-get install python3-pip
pip install pdfplumber
```

**WSL2:**
Same as Linux commands.

**Verification:**
```bash
python3 -c "import pdfplumber; print(pdfplumber.__version__)"
```

**Common issues:**
- **No OCR support** (not an installation issue, but functional limitation)
  - **Symptom:** Poor results on scanned PDFs
  - **Solution:** Use PyMuPDF or pypdf for scanned documents; pdfplumber only works on machine-generated PDFs

**Usage example (table extraction):**
```python
import pdfplumber

with pdfplumber.open("document.pdf") as pdf:
    for page in pdf.pages:
        tables = page.extract_tables()
        for table in tables:
            print(table)
```

---

#### poppler (pdftotext)

**macOS:**
```bash
brew install poppler
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get update
sudo apt-get install poppler-utils
```

**WSL2:**
Same as Linux commands.

**Verification:**
```bash
pdftotext -v
```

**Common issues:**
- **Command not found**
  - **Solution:** Ensure poppler-utils installed (Linux) or poppler (macOS)
- **No layout preservation**
  - **Not an issue:** This is expected behaviour; pdftotext extracts plain text without layout

**Usage example:**
```bash
pdftotext document.pdf output.txt
```

---

### Creation Tools

#### md-to-pdf (npm)

**Requires Node.js and npm:**
```bash
# Check if npm installed
command -v npm >/dev/null 2>&1 && echo "npm installed" || echo "npm not found"

# Install Node.js if needed
# macOS:
brew install node

# Linux (Debian/Ubuntu):
sudo apt-get update
sudo apt-get install nodejs npm
```

**Install md-to-pdf globally:**
```bash
npm install -g md-to-pdf
```

**WSL2:**
Same as Linux commands.

**Verification:**
```bash
md-to-pdf --version
```

**Common issues:**
- **Chromium download (~170MB) during installation**
  - **Not an issue:** This is expected (Puppeteer dependency)
- **Permission errors during global install**
  - **Solution:** Use sudo: `sudo npm install -g md-to-pdf`
  - **Better solution:** Configure npm to install globally without sudo (see npm documentation)

**Usage example:**
```bash
md-to-pdf document.md
# Output: document.pdf
```

---

#### WeasyPrint

**CRITICAL WARNING:** High installation friction due to system library dependencies.

**macOS:**
```bash
# Install system libraries FIRST
brew install python pango libffi

# Then install WeasyPrint
pip install weasyprint
```

**Linux (Debian/Ubuntu):**
```bash
# Install system libraries FIRST
sudo apt-get update
sudo apt-get install libpango-1.0-0 libpangoft2-1.0-0 libharfbuzz-subset0

# Then install WeasyPrint
pip install weasyprint
```

**WSL2:**
Same as Linux commands.

**Verification:**
```bash
python3 -c "import weasyprint; print(weasyprint.__version__)"
```

**Common issues:**

**Issue 1: "OSError: cannot load library 'gobject-2.0-0'"**
- **Cause:** System libraries not installed before pip install
- **Solution:**
  1. Uninstall WeasyPrint: `pip uninstall weasyprint`
  2. Install system libraries (see commands above)
  3. Reinstall WeasyPrint: `pip install weasyprint`

**Issue 2: PATH issues (Windows/WSL)**
- **Cause:** GTK+ lib not in system PATH
- **Solution:**
  1. Add GTK+ lib directory to PATH
  2. Restart IDE/terminal

**Issue 3: Deployment complexity**
- **Symptom:** Works on development machine but fails in production/containers
- **Cause:** System dependencies harder to package than pure Python libraries
- **Solution:** Use Docker image with dependencies pre-installed, or consider md-to-pdf alternative

**Usage example:**
```bash
# First convert Markdown to HTML (using Pandoc or Python markdown library)
pandoc document.md -o document.html
weasyprint document.html document.pdf
```

---

#### Pandoc + LaTeX

**macOS:**
```bash
# Install Pandoc
brew install pandoc

# Option 1: BasicTeX (recommended, ~1GB)
brew install --cask basictex

# Option 2: Full TeX Live (~6GB, all features)
brew install --cask mactex

# After installing BasicTeX, update PATH
eval "$(/usr/libexec/path_helper)"
```

**Linux (Debian/Ubuntu):**
```bash
# Install Pandoc
sudo apt-get update
sudo apt-get install pandoc

# Option 1: Minimal LaTeX (~1GB)
sudo apt-get install texlive-latex-recommended

# Option 2: Full LaTeX (~6GB)
sudo apt-get install texlive-full
```

**WSL2:**
Same as Linux commands. Note: Large downloads may take significant time.

**Verification:**
```bash
pandoc --version
pdflatex --version
```

**Common issues:**

**Issue 1: "pdflatex not found"**
- **Cause:** LaTeX not installed or not in PATH
- **Solution:**
  - macOS: Ensure BasicTeX installed and PATH updated (run `eval "$(/usr/libexec/path_helper)"` after install)
  - Linux: Install texlive-latex-recommended or texlive-full

**Issue 2: Missing LaTeX packages**
- **Symptom:** Cryptic LaTeX errors during PDF generation
- **Cause:** Minimal LaTeX installations missing specific packages
- **Solution:**
  - macOS with BasicTeX: `sudo tlmgr install <package-name>`
  - Linux: Install texlive-full for comprehensive package coverage
  - Alternative: Use TinyTeX (minimal LaTeX distribution designed for Pandoc)

**Issue 3: Pandoc compilation from source on older macOS**
- **Symptom:** Homebrew compiles Pandoc from source (slow, requires GHC compiler)
- **Cause:** macOS version >3 releases old, no pre-built binary available
- **Solution:** Wait for compilation, or use Docker image (pandoc/extra)

**Issue 4: Disk space constraints**
- **Impact:** BasicTeX ~1GB, full TeX Live ~6GB
- **Solution:** If disk space critical, use md-to-pdf or WeasyPrint instead

**Usage example:**
```bash
pandoc document.md -o document.pdf --pdf-engine=xelatex
```

**Merging multiple Markdown files (Pandoc only):**
```bash
pandoc intro.md chapter1.md chapter2.md -o combined.pdf
```

---

#### Pandoc + Typst

**macOS:**
```bash
# Install Pandoc
brew install pandoc

# Install Typst
brew install typst
```

**Linux (Debian/Ubuntu):**
```bash
# Install Pandoc
sudo apt-get update
sudo apt-get install pandoc

# Install Typst (see official Typst documentation for latest method)
# As of 2026, binary releases available on GitHub
```

**WSL2:**
Same as Linux approach.

**Verification:**
```bash
pandoc --version
typst --version
```

**Common issues:**
- **Experimental Pandoc support**
  - **Symptom:** Unexpected rendering issues or errors
  - **Cause:** Typst support in Pandoc is experimental (not yet stable for all cases)
  - **Solution:** Test thoroughly; fall back to LaTeX if issues arise
- **Not suitable for journal submissions**
  - **Context:** Academic journals typically require LaTeX source
  - **Use case:** Typst best for internal documents, reports, presentations

**Usage example:**
```bash
pandoc document.md -o document.pdf --to=typst --pdf-engine=typst
```

---

### Modification Tools

#### qpdf

**macOS:**
```bash
brew install qpdf
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get update
sudo apt-get install qpdf
```

**Linux (Fedora):**
```bash
sudo dnf install qpdf
```

**Linux (RHEL/CentOS - requires EPEL):**
```bash
sudo yum install epel-release
sudo yum install qpdf
```

**WSL2:**
Same as Linux (Debian/Ubuntu) commands.

**Verification:**
```bash
qpdf --version
```

**Common issues:**
- **Command not found**
  - **Solution:** Install via package manager (see commands above)
- **Very few issues reported** — qpdf has clean cross-platform installation

**Usage examples:**

**Merge PDFs:**
```bash
qpdf --empty --pages first.pdf second.pdf third.pdf -- combined.pdf
```

**Split PDF:**
```bash
# Split into separate files (n pages each)
qpdf --split-pages=n input.pdf output_%d.pdf

# Extract specific page range
qpdf input.pdf --pages . 1-5 -- pages1-5.pdf
```

**Rotate pages:**
```bash
# Rotate pages 2, 4, 6 by 90 degrees; pages 7-8 by 180 degrees
qpdf --rotate=90:2,4,6 --rotate=180:7-8 input.pdf output.pdf
```

**Compress:**
```bash
# Compress currently-uncompressed streams
qpdf --compress-streams input.pdf output.pdf

# Better compression (recompress with higher level)
qpdf --recompress-flate --compression-level=9 input.pdf output.pdf
```

---

#### pypdf (for modification)

Same installation as reading/extraction section above.

**Usage examples:**

**Merge PDFs (current API):**
```python
from pypdf import PdfWriter

writer = PdfWriter()
writer.append("first.pdf")
writer.append("second.pdf")
writer.write("combined.pdf")
writer.close()
```

**Split PDF:**
```python
from pypdf import PdfReader, PdfWriter

reader = PdfReader("input.pdf")
writer = PdfWriter()

# Extract pages 1-5 (0-indexed)
for page_num in range(0, 5):
    writer.add_page(reader.pages[page_num])

with open("output.pdf", "wb") as output_file:
    writer.write(output_file)
```

---

#### pikepdf

**macOS:**
```bash
pip install pikepdf
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get update
sudo apt-get install python3-pip
pip install pikepdf
```

**WSL2:**
Same as Linux commands.

**Verification:**
```bash
python3 -c "import pikepdf; print(pikepdf.__version__)"
```

**Common issues:**
- **Compilation requirements** (C++ backend)
  - **Symptom:** Build failures during pip install
  - **Solution:** Ensure C++ development tools installed:
    - macOS: `xcode-select --install`
    - Linux: `sudo apt-get install build-essential`
- **Cannot extract text**
  - **Not an issue:** This is by design; pikepdf is for manipulation, not reading. Use pypdf or PyMuPDF for text extraction.

**Usage example (merge PDFs):**
```python
import pikepdf

pdf = pikepdf.new()
with pikepdf.open("first.pdf") as src:
    pdf.pages.extend(src.pages)
with pikepdf.open("second.pdf") as src:
    pdf.pages.extend(src.pages)

pdf.save("combined.pdf")
```

---

#### pdftk-java (conditional)

**Only use if migrating from original PDFtk. Otherwise, prefer qpdf.**

**macOS:**
```bash
brew install pdftk-java
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get update
sudo apt-get install pdftk-java
```

**Requires Java Runtime Environment (JRE):**
```bash
# macOS
brew install openjdk

# Linux (Debian/Ubuntu)
sudo apt-get install default-jre
```

**Verification:**
```bash
pdftk --version
```

**Common issues:**
- **Java dependency**
  - **Solution:** Install JRE (see commands above)
- **Lower community adoption**
  - **Recommendation:** Use qpdf for new projects (broader support)

---

### Docker Approach (All Tools)

**When to use Docker:**
- Avoid local installation complexity (especially for Pandoc + LaTeX)
- Ensure consistent environment across development and production
- System does not allow installing dependencies

**Example: Pandoc with LaTeX via Docker:**
```bash
docker pull pandoc/extra

# Convert Markdown to PDF using Docker container
docker run --rm -v $(pwd):/data pandoc/extra document.md -o document.pdf
```

**Pandoc Docker image includes:**
- Pandoc
- LaTeX
- Eisvogel template
- Common filters
- Fonts

**Advantages:**
- No local LaTeX installation (~6GB saved)
- Reproducible environment
- Easy deployment

**Disadvantages:**
- Requires Docker installed
- Slight performance overhead (container startup)
- Volume mounting required for file access

---

### Cross-Platform Installation Friction Rankings

**Least to most installation friction:**

1. **No friction:** pypdf (pure Python, pip only)
2. **Minimal friction:** qpdf, poppler (package managers handle dependencies)
3. **Moderate friction:** PyMuPDF (usually clean, occasional M1 issues), md-to-pdf (npm + ~170MB Chromium)
4. **High friction:** WeasyPrint (system libraries before pip), pikepdf (C++ compilation)
5. **Very high friction:** Pandoc + LaTeX (1-6GB downloads, dependency management)

**Platform-specific gotchas:**

**macOS:**
- qpdf, poppler, pypdf: Clean installation via Homebrew/pip
- PyMuPDF: Generally works; some M1 Mac reports of issues (mostly resolved)
- WeasyPrint: Requires `brew install pango libffi` before pip
- LaTeX: BasicTeX recommended (~1GB); full TeX Live (~6GB)
- Older macOS versions (>3 releases old) may trigger Pandoc source compilation

**Linux (Debian/Ubuntu):**
- qpdf, poppler, pypdf: Clean installation via apt/pip
- WeasyPrint: Requires libpango, GObject system libraries before pip (most common friction point)
- LaTeX: texlive-latex-recommended (~1GB) or texlive-full (~6GB) trade-off
- Package manager differences (apt vs dnf vs yum) — commands provided for major distributions

**WSL2:**
WSL2 runs a full Linux kernel and package manager, so Linux installation commands apply directly. Most Linux instructions work under WSL2 without modification. No significant WSL-specific issues reported for these tools in 2024-2025. Large downloads (LaTeX) may take significant time depending on network.

---

### Troubleshooting Decision Tree

**If installation fails:**

1. **Check prerequisites**
   - Python tools: Python 3.9+ installed? pip available?
   - Node tools: Node.js and npm installed?
   - System tools: Package manager functional? (brew, apt, dnf)

2. **Read error messages carefully**
   - "Command not found" → Tool not installed or not in PATH
   - "ModuleNotFoundError" → Python dependency missing
   - "Cannot load library" → System library missing (common with WeasyPrint)
   - "Build failed" → Compilation issue (C++ tools needed)

3. **Check platform-specific notes**
   - Consult platform-specific sections above
   - Verify you're using correct commands for your OS

4. **Try fallback tools**
   - Reading: pypdf → PyMuPDF → poppler
   - Creation: md-to-pdf → WeasyPrint → Pandoc
   - Modification: qpdf → pypdf → pikepdf

5. **Consider Docker approach**
   - If local installation repeatedly fails
   - If deployment consistency needed

6. **Check versions**
   - Update package managers: `brew update`, `sudo apt-get update`
   - Update Python/pip: `pip install --upgrade pip`
   - Update tool itself: `pip install --upgrade <package>`

---

### Tool Comparison Tables

#### Reading/Extraction Tools Comparison

| Tool | Licence | Performance | Installation Friction | Best For |
|------|---------|-------------|----------------------|----------|
| **pypdf** | BSD (permissive) | Adequate (10-20× slower than PyMuPDF) | Very Low (pure Python) | Default choice, commercial use |
| **PyMuPDF** | AGPL (restrictive) | Fastest (0.1s avg) | Low (occasional M1 issues) | High performance, open-source projects |
| **pdfplumber** | MIT (permissive) | Medium | Low | Table extraction from clean PDFs |
| **poppler** | GPL | Fast | Low | Quick CLI text extraction |
| **Claude Code Read** | N/A | N/A | None (built-in) | Simple PDFs under 20 pages (unreliable) |

---

#### Creation Tools Comparison

| Tool | Dependencies | Disk Space | Installation Friction | Best For |
|------|--------------|------------|----------------------|----------|
| **md-to-pdf** | Node.js, npm | ~170MB (Chromium) | Low | Simple documents, minimal setup |
| **WeasyPrint** | Python, Pango, GObject | ~50MB | High (system libs) | CSS-based styling |
| **Pandoc + BasicTeX** | LaTeX | ~1GB | High (LaTeX install) | Advanced Markdown, quality output |
| **Pandoc + Typst** | Typst | ~50MB | Medium (experimental) | Fast compilation, modern syntax |
| **Pandoc + Full TeX** | LaTeX | ~6GB | Very High | Full LaTeX features, academic |

---

#### Modification Tools Comparison

| Tool | Licence | Language | Installation Friction | Best For |
|------|---------|----------|----------------------|----------|
| **qpdf** | Apache (permissive) | C++ | Very Low | CLI automation, comprehensive features |
| **pypdf** | BSD (permissive) | Python | Very Low | Python workflows, basic operations |
| **pikepdf** | MPL-2.0 (permissive) | Python (C++ backend) | Medium (compilation) | Python workflows, advanced features |
| **pdftk-java** | GPL | Java | Medium (Java required) | PDFtk migration only |

---

### Maintenance Status Reference

**Actively maintained (2024-2025 releases):**
- qpdf (v12.3.2, February 2026)
- pypdf (5+ releases in 2025)
- PyMuPDF (v1.25.2, January 2025)
- WeasyPrint (v68.1, February 2026)
- Pandoc (consistent releases)
- poppler (v26.02.0, February 2026)

**Abandoned (do not recommend):**
- Original PDFtk (cannot compile with GCC 7+)
- wkhtmltopdf (GCC dropped GCJ dependency)

**Maintained forks:**
- pdftk-java (v3.3.3, 2024) — use only for PDFtk migration

---

### Quick Reference Commands

**Check what's installed:**
```bash
# Python tools
python3 -c "import pypdf" 2>/dev/null && echo "pypdf: installed"
python3 -c "import fitz" 2>/dev/null && echo "PyMuPDF: installed"
python3 -c "import pdfplumber" 2>/dev/null && echo "pdfplumber: installed"
python3 -c "import weasyprint" 2>/dev/null && echo "WeasyPrint: installed"
python3 -c "import pikepdf" 2>/dev/null && echo "pikepdf: installed"

# CLI tools
command -v qpdf >/dev/null 2>&1 && echo "qpdf: installed"
command -v pdftotext >/dev/null 2>&1 && echo "poppler: installed"
command -v pandoc >/dev/null 2>&1 && echo "Pandoc: installed"
command -v pdflatex >/dev/null 2>&1 && echo "LaTeX: installed"
command -v typst >/dev/null 2>&1 && echo "Typst: installed"
command -v md-to-pdf >/dev/null 2>&1 && echo "md-to-pdf: installed"
```

**Install recommended defaults:**
```bash
# Reading (Python)
pip install pypdf pillow

# Modification (CLI)
brew install qpdf  # macOS
sudo apt-get install qpdf  # Linux

# Creation (minimal dependencies)
npm install -g md-to-pdf
```

---

