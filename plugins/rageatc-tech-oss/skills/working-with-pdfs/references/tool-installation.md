# Tool Installation, Troubleshooting, and Usage

Contents: [Reading/extraction](#readingextraction-tools) (pypdf, PyMuPDF, pdfplumber, poppler) · [Creation](#creation-tools) (md-to-pdf, WeasyPrint, Pandoc+LaTeX, Pandoc+Typst) · [Modification](#modification-tools) (qpdf, pypdf, pikepdf, pdftk-java) · [Docker fallback](#docker-fallback)

Commands cover macOS (Homebrew) and Debian/Ubuntu (apt). **WSL2 uses the Debian/Ubuntu commands unchanged** — no WSL-specific issues for these tools.

## Reading/Extraction Tools

### pypdf

```bash
pip install pypdf
pip install pillow   # only needed for image extraction
# Verify:
python3 -c "import pypdf; print(pypdf.__version__)"
```

- `ModuleNotFoundError: No module named 'PIL'` when extracting images → `pip install pillow`

```python
from pypdf import PdfReader

reader = PdfReader("document.pdf")
for page in reader.pages:
    print(page.extract_text())
```

### PyMuPDF (fitz)

AGPL v3.0 — flag before recommending for commercial use (see SKILL.md Licences).

```bash
pip install PyMuPDF
# Verify:
python3 -c "import fitz; print(fitz.__version__)"
```

- Build failures on Apple Silicon → `pip install --upgrade PyMuPDF`; if it persists, fall back to pypdf
- `ModuleNotFoundError` after install → ensure C/C++ toolchain present (`xcode-select --install` / `sudo apt-get install build-essential`)

```python
import fitz  # PyMuPDF

doc = fitz.open("document.pdf")
for page in doc:
    print(page.get_text())
```

### pdfplumber

```bash
pip install pdfplumber
# Verify:
python3 -c "import pdfplumber; print(pdfplumber.__version__)"
```

```python
import pdfplumber

with pdfplumber.open("document.pdf") as pdf:
    for page in pdf.pages:
        for table in page.extract_tables():
            print(table)
```

### poppler (pdftotext)

```bash
brew install poppler            # macOS
sudo apt-get install poppler-utils   # Debian/Ubuntu
# Verify:
pdftotext -v
```

```bash
pdftotext document.pdf output.txt
```

## Creation Tools

### md-to-pdf

Requires Node.js (`brew install node` / `sudo apt-get install nodejs npm`).

```bash
npm install -g md-to-pdf
# Verify:
md-to-pdf --version
```

- Install downloads ~170MB Chromium (Puppeteer dependency) — expected
- Permission errors on global install → configure npm's global prefix for the user, or `sudo npm install -g md-to-pdf`

```bash
md-to-pdf document.md   # → document.pdf
```

### WeasyPrint

Install the system libraries **before** pip, or the import fails.

```bash
# macOS
brew install python pango libffi
pip install weasyprint

# Debian/Ubuntu
sudo apt-get install libpango-1.0-0 libpangoft2-1.0-0 libharfbuzz-subset0
pip install weasyprint

# Verify:
python3 -c "import weasyprint; print(weasyprint.__version__)"
```

- `OSError: cannot load library 'gobject-2.0-0'` → system libraries were missing at install time: `pip uninstall weasyprint`, install the libraries above, `pip install weasyprint`
- Works locally but fails in production/containers → system dependencies don't travel with pip; use a Docker image with them pre-installed, or switch to md-to-pdf

```bash
# WeasyPrint takes HTML input — convert Markdown first
pandoc document.md -o document.html
weasyprint document.html document.pdf
```

### Pandoc + LaTeX

```bash
# macOS
brew install pandoc
brew install --cask basictex        # ~1GB; full TeX Live: --cask mactex (~6GB)
eval "$(/usr/libexec/path_helper)"  # required after BasicTeX install

# Debian/Ubuntu
sudo apt-get install pandoc
sudo apt-get install texlive-latex-recommended   # ~1GB; texlive-full ~6GB

# Verify:
pandoc --version
pdflatex --version
```

- `pdflatex not found` → LaTeX missing or not in PATH; on macOS run the `path_helper` line above
- Cryptic LaTeX errors mid-generation → minimal installs lack packages; `sudo tlmgr install <package>` (BasicTeX) or install texlive-full
- Homebrew compiles Pandoc from source on macOS versions >3 releases old → wait it out or use the `pandoc/extra` Docker image

```bash
pandoc document.md -o document.pdf --pdf-engine=xelatex

# Merging multiple Markdown files:
pandoc intro.md chapter1.md chapter2.md -o combined.pdf
```

### Pandoc + Typst

```bash
brew install pandoc typst    # macOS
# Debian/Ubuntu: install pandoc via apt; Typst via GitHub binary releases
# Verify:
pandoc --version
typst --version
```

- Typst support in Pandoc is experimental — test output; fall back to LaTeX on rendering issues

```bash
pandoc document.md -o document.pdf --to=typst --pdf-engine=typst
```

## Modification Tools

### qpdf

```bash
brew install qpdf              # macOS
sudo apt-get install qpdf      # Debian/Ubuntu
sudo dnf install qpdf          # Fedora
sudo yum install epel-release && sudo yum install qpdf   # RHEL/CentOS
# Verify:
qpdf --version
```

Clean cross-platform installs; no recurring issues.

```bash
# Merge
qpdf --empty --pages first.pdf second.pdf third.pdf -- combined.pdf

# Split into files of n pages each
qpdf --split-pages=n input.pdf output_%d.pdf

# Extract page range
qpdf input.pdf --pages . 1-5 -- pages1-5.pdf

# Rotate (pages 2,4,6 by 90°; pages 7-8 by 180°)
qpdf --rotate=90:2,4,6 --rotate=180:7-8 input.pdf output.pdf

# Compress
qpdf --compress-streams=y input.pdf output.pdf
qpdf --recompress-flate --compression-level=9 input.pdf output.pdf
```

### pypdf (modification)

Install as in the reading section.

```python
# Merge
from pypdf import PdfWriter

writer = PdfWriter()
writer.append("first.pdf")
writer.append("second.pdf")
writer.write("combined.pdf")
writer.close()
```

```python
# Split — extract pages 1-5 (0-indexed)
from pypdf import PdfReader, PdfWriter

reader = PdfReader("input.pdf")
writer = PdfWriter()
for page_num in range(0, 5):
    writer.add_page(reader.pages[page_num])
with open("output.pdf", "wb") as output_file:
    writer.write(output_file)
```

### pikepdf

```bash
pip install pikepdf
# Verify:
python3 -c "import pikepdf; print(pikepdf.__version__)"
```

- Build failures (C++ backend) → `xcode-select --install` (macOS) / `sudo apt-get install build-essential` (Linux)

```python
import pikepdf

pdf = pikepdf.new()
with pikepdf.open("first.pdf") as src:
    pdf.pages.extend(src.pages)
with pikepdf.open("second.pdf") as src:
    pdf.pages.extend(src.pages)
pdf.save("combined.pdf")
```

### pdftk-java

Only for PDFtk migration (see SKILL.md). Requires a JRE (`brew install openjdk` / `sudo apt-get install default-jre`).

```bash
brew install pdftk-java             # macOS
sudo apt-get install pdftk-java     # Debian/Ubuntu
# Verify:
pdftk --version
```

## Docker Fallback

When local installation repeatedly fails or nothing is installable — most valuable for Pandoc + LaTeX (saves the ~1-6GB local install; image bundles Pandoc, LaTeX, the Eisvogel template, filters, and fonts):

```bash
docker pull pandoc/extra
docker run --rm -v $(pwd):/data pandoc/extra document.md -o document.pdf
```
