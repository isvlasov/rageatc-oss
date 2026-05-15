# rageatc-tech-oss

Technical capability skills for Claude Code — tool selection, environment detection, and fallback chains.

## What Is This?

rageatc-tech-oss provides skills that encode practical knowledge about working with external tools in CLI environments. Each skill captures decision logic for choosing the right tool, detecting what's available, and falling back gracefully when the preferred option isn't installed.

These skills work standalone — they don't depend on rageatc-core-oss's workflow system.

## Skills

### extracting-yt-transcripts

Guides YouTube transcript extraction with:
- Video ID parsing for all YouTube URL formats
- Environment detection (checks for youtube-transcript-api, yt-dlp, Whisper)
- Decision trees for captioned, captionless, and restricted videos
- Installation guidance and troubleshooting

### working-with-pdfs

Guides PDF operations (reading, creating, modifying) with:
- Tool selection for reading (pypdf, PyMuPDF, pdfplumber), creation (Pandoc, WeasyPrint, md-to-pdf), and modification (qpdf, pypdf)
- Environment detection and platform-aware installation
- Licence awareness for tool choices
- Detailed reference material in `references/tool-installation.md`

### playwright-cli

Automates browser interactions for web testing, form filling, screenshots, and data extraction with:
- Full command reference for navigation, interaction, storage, network mocking
- Session management with named browsers and persistent profiles
- DevTools integration (console, network, tracing, video recording)
- Reference material for advanced scenarios (request mocking, test generation, custom code)

## How Skills Work

Skills use automatic discovery — Claude loads skill names and descriptions at startup, then matches your requests to relevant skills automatically.

**Manual invocation:**
- `/extracting-yt-transcripts` — invoke explicitly
- `/working-with-pdfs` — invoke explicitly
- `/playwright-cli` — invoke explicitly

**List available skills:**
- `/skills` — shows all installed skills
