---
name: extracting-yt-transcripts
description: Extracts YouTube transcripts in CLI environments. Use when fetching YouTube transcripts, converting video captions to text, extracting subtitles or closed captions, or selecting between youtube-transcript-api, yt-dlp, and Whisper.
---

# Extracting YouTube Transcripts

## Purpose

Enable reliable YouTube transcript extraction in CLI environments by providing decision frameworks for tool selection, video ID parsing, and graceful fallback chains across three transcript availability scenarios: manual captions, auto-generated captions, and captionless videos.

This skill addresses YouTube transcript extraction by encoding external tool selection logic rather than cataloguing options. You'll reach clear recommendations through environment-aware decision trees, not wade through tool comparisons.

Outputs produced: formatted HTML (default), plain text markdown, JSON, SRT, VTT, or WebVTT.

## When to Use This Skill

**Primary triggers:**
- Need to extract transcripts from YouTube videos
- Converting video captions to plain text
- Fetching auto-generated or manual subtitles
- Processing YouTube content for analysis
- Working with video URLs and needing text output
- Selecting appropriate tools when multiple options exist

**Skip this skill when:**
- Task doesn't involve YouTube videos
- You already know which tool to use and how to install it
- Working with non-YouTube video platforms

## Operating Principles

**Environment detection before recommendation** — Always check what's installed before recommending tools. Adapt to available resources rather than assuming specific setups.

**Decision trees, not catalogues** — Follow structured workflows to reach clear tool recommendations. This skill guides selection, not exhaustive comparison.

**Fallback chains for reliability** — Every transcript scenario provides ordered alternatives so workflows don't fail when preferred tools are unavailable.

**Cross-platform by design** — All recommendations work on macOS, Linux (Debian/Ubuntu), and WSL2. Native Windows is out of scope.

**Proxy when needed** — YouTube blocks transcript requests from non-residential IPs (cloud providers, VPNs, and increasingly some ISPs). If you hit blocks, configure a rotating residential proxy via `~/.config/rageatc/.env` — see Step 1B. No YouTube API keys required.

## Degree of Freedom

**Medium freedom with preferred patterns:**
- Follow decision trees to select tools appropriate for your environment
- Apply environment detection before recommending installation
- Use fallback chains when preferred tools unavailable
- Adapt installation commands to specific distributions within documented platforms

**Non-negotiable standards:**
- Detect environment before tool recommendation
- Parse video ID from various URL formats before attempting extraction
- When proxy credentials are configured, use them for all youtube-transcript-api calls
- Provide fallback options for each transcript scenario
- Flag Whisper as optional heavy dependency (large models, significant compute)

## Default Output Format: Formatted HTML

Unless the user specifies a different format, **always produce a formatted HTML file** and open it in the browser. This is the preferred reading experience for transcripts.

### File Naming Convention

Use the pattern: `YYYY-MM-DD_channel-name_slugified-title.html`

- **Date:** Video publish date (fetched via `yt-dlp --print upload_date`, format YYYYMMDD → reformat to YYYY-MM-DD)
- **Channel name:** Lowercase, hyphens for spaces, strip special characters
- **Title:** Lowercase, hyphens for spaces, strip special characters, truncate to ~60 chars if needed

Examples:
- `2026-03-16_indydevdan_the-library-meta-skill.html`
- `2026-02-19_cole-medin_how-to-build-ai-agents.html`

### Content Rules

**The body text MUST be the speaker's original words.** This is a transcript, not an editorial summary or rewrite. Do NOT paraphrase, restructure the speaker's arguments into your own prose, or add editorial commentary (e.g. "Dan opens with...", "He is emphatic that..."). Present what was said, in the order it was said, using the speaker's own language.

You MAY:
- Clean up filler words, false starts, and verbal tics for readability
- Break continuous speech into paragraphs at natural pause points
- Group related passages under `<h2>` section headings based on topic shifts
- Use formatting (callouts, highlights, lists) to surface structure already present in the speech

You MUST NOT:
- Rewrite or paraphrase what the speaker said
- Add your own analysis, transitions, or commentary
- Invent section content that the speaker didn't say
- Summarise passages instead of presenting them

### AI Summary Block

Immediately after the hero header, include a brief **AI Summary** section:
- Styled as a distinct block (e.g. background colour, border) clearly labelled "AI Summary"
- Contains a 2-4 sentence TLDR of the video's key messages
- Followed by a short bullet list (3-7 items) of what's covered in the video
- This is the ONLY place where AI-generated editorial content belongs — everything below it is the speaker's words

### HTML Structure

The HTML output should:
- Use a clean, readable article layout (max-width ~680px, serif body font)
- Support both light and dark mode via `prefers-color-scheme`
- Include a hero header with video title, channel name, duration, and YouTube link
- Include the AI Summary block (see above) immediately after the header
- Break the raw transcript into logical **sections with `<h2>` headings** based on topic shifts
- Use **callout boxes** (left-bordered, italic) for key quotes or striking statements
- Use **highlight spans** for the most important phrases
- Use **card grids** where structured comparisons or lists benefit from visual grouping (e.g., multiple approaches, tier definitions)
- Use numbered grid patterns for sequential processes
- Apply `<strong>` for emphasis throughout, matching the speaker's rhetorical stress
- Use `<hr>` to separate major thematic shifts
- Include `<ul>` / `<ol>` where the speaker lists items
- Fetch video metadata (title, channel, duration, publish date) via `yt-dlp --print title --print channel --print duration_string --print upload_date`

**When to use other formats:** Only if the user explicitly asks for markdown, plain text, JSON, SRT, VTT, or WebVTT. In those cases, skip the HTML step.

## Inputs to Gather

Before entering decision trees, collect:

1. **YouTube URL or video ID** to extract transcript from
2. **Preferred language** (if multilingual captions available)
3. **Output format needed**: formatted HTML (default), plain text, JSON, SRT, VTT, WebVTT
4. **Platform**: macOS, Linux (Debian/Ubuntu), or WSL2
5. **Environment context**: running in cloud (AWS, GCP, Azure) vs local, proxy availability
6. **Constraints**: disk space limits (relevant for Whisper), compute availability

## Core Workflow

### Step 1: Detect Environment

Check what's installed across all tool categories before proceeding to transcript-specific selection. This establishes a baseline and enables faster recommendations.

```bash
# Python tools — check system Python first
python3 -c "import youtube_transcript_api" 2>/dev/null && echo "youtube-transcript-api: system python" || echo "youtube-transcript-api: not in system python"
python3 -c "import whisper" 2>/dev/null && echo "Whisper: installed" || echo "Whisper: not found"

# CLI tools
command -v yt-dlp >/dev/null 2>&1 && echo "yt-dlp: installed" || echo "yt-dlp: not found"
command -v youtube_transcript_api >/dev/null 2>&1 && echo "youtube-transcript-api CLI: installed" || echo "youtube-transcript-api CLI: not found"

# pipx venv detection — CRITICAL on macOS where pipx is the standard install method
# When installed via pipx, the CLI works but `import` from system Python fails.
# The pipx venv Python IS the correct interpreter for the Python API (including proxy support).
PIPX_YTT_PYTHON="$HOME/.local/pipx/venvs/youtube-transcript-api/bin/python3"
if [ -x "$PIPX_YTT_PYTHON" ]; then
    echo "youtube-transcript-api: pipx venv (use $PIPX_YTT_PYTHON for Python API)"
else
    echo "youtube-transcript-api: no pipx venv found"
fi

# Python environment type (determines installation method)
command -v pipx >/dev/null 2>&1 && echo "pipx: available" || echo "pipx: not found"
python3 -c "import sys; print('venv active' if (hasattr(sys, 'real_prefix') or sys.base_prefix != sys.prefix) else 'system python')" 2>/dev/null
```

**Interpreter resolution priority:**
1. **Active venv** — use `python3` (package importable directly)
2. **pipx venv detected** — use `$PIPX_YTT_PYTHON` for Python API calls (proxy support, programmatic access)
3. **System Python with package importable** — use `python3`
4. **CLI only** — use `youtube_transcript_api` command (no proxy support — see Step 1B)

### Step 1B: Configure Proxy (Optional)

YouTube blocks transcript requests from non-residential IPs — cloud providers, VPNs, and increasingly some ISP connections. If you hit blocks (HTTP 403, empty responses, or `NoTranscriptFound` on videos that clearly have captions), configure a rotating residential proxy.

**Skip this step if requests work directly** — youtube-transcript-api succeeds from most residential IPs without a proxy.

**Provider note:** Webshare is the most accessible option (free tier, supported natively by `youtube-transcript-api` via `WebshareProxyConfig`) and is used in the worked example below. Any rotating residential proxy works — adapt the env var names and the proxy config call if you use a different one.

Store credentials in `~/.config/rageatc/.env` (chmod 600, owner-only access):

```
WEBSHARE_PROXY_USER=<username>
WEBSHARE_PROXY_PASSWORD=<password>
```

**Load credentials:**
```python
from pathlib import Path

def load_proxy_credentials():
    """Load Webshare proxy credentials from ~/.config/rageatc/.env."""
    env_path = Path.home() / ".config" / "rageatc" / ".env"
    if not env_path.exists():
        return None, None

    creds = {}
    for line in env_path.read_text().splitlines():
        line = line.strip()
        if line and not line.startswith("#") and "=" in line:
            key, _, value = line.partition("=")
            creds[key.strip()] = value.strip()

    return creds.get("WEBSHARE_PROXY_USER"), creds.get("WEBSHARE_PROXY_PASSWORD")
```

**Create a proxy-configured YouTubeTranscriptApi instance:**
```python
from youtube_transcript_api import YouTubeTranscriptApi

def create_ytt_api():
    """Create YouTubeTranscriptApi with proxy if credentials available."""
    user, password = load_proxy_credentials()
    if user and password:
        from youtube_transcript_api.proxies import WebshareProxyConfig
        proxy_config = WebshareProxyConfig(
            proxy_username=user,
            proxy_password=password,
        )
        return YouTubeTranscriptApi(proxy_config=proxy_config)
    return YouTubeTranscriptApi()

ytt_api = create_ytt_api()
```

**Running with the correct Python interpreter:**

The `create_ytt_api()` helper requires `youtube_transcript_api` to be importable. Which Python interpreter to use depends on how the package is installed:

- **pipx installation (standard on macOS):** Use the pipx venv Python detected in Step 1:
  ```bash
  ~/.local/pipx/venvs/youtube-transcript-api/bin/python3 -c "
  <your script using create_ytt_api() and extraction code>
  "
  ```
  System `python3` cannot import pipx-installed packages — this is by design. The pipx venv Python already has `youtube-transcript-api` and `requests` (needed for proxy) available.

- **Active venv or system Python with package installed:** Use `python3` directly.

**IMPORTANT:** The CLI command (`youtube_transcript_api VIDEO_ID`) does NOT support proxy configuration. If proxy credentials are available (the standard case), always use the Python API with the correct interpreter — never fall back to the CLI just because `import` fails on system Python. Check for the pipx venv first.

**If credentials file is missing:** Fall back to unproxied youtube-transcript-api (may work on residential IPs) or yt-dlp (generally less affected by blocking).

**To set up credentials (Webshare example):** Sign up for a rotating residential proxy plan at https://www.webshare.io/ (free tier available), create `~/.config/rageatc/.env` with the credentials, then run `chmod 600 ~/.config/rageatc/.env`. If using a different provider, adapt the env var names and replace `WebshareProxyConfig` in `create_ytt_api()` with your provider's equivalent (or use the generic HTTP proxy mechanism your library supports).

---

### Step 2: Extract Video ID

YouTube URLs come in multiple formats. Parse the video ID before attempting transcript extraction.

**Common URL formats:**
- Standard: `https://www.youtube.com/watch?v=VIDEO_ID`
- Shortened: `https://youtu.be/VIDEO_ID`
- Mobile: `https://m.youtube.com/watch?v=VIDEO_ID`
- Embedded: `https://www.youtube.com/embed/VIDEO_ID`
- With timestamp: `https://www.youtube.com/watch?v=VIDEO_ID&t=123s`
- With playlist: `https://www.youtube.com/watch?v=VIDEO_ID&list=PLAYLIST_ID`

**Video ID characteristics:**
- 11 characters long
- Alphanumeric plus hyphens and underscores
- Case-sensitive

**Parsing approaches:**

**Python (manual extraction):**
```python
import re
from urllib.parse import urlparse, parse_qs

def extract_video_id(url):
    # Handle shortened URLs
    if 'youtu.be' in url:
        return url.split('/')[-1].split('?')[0]

    # Handle standard URLs
    parsed = urlparse(url)
    if parsed.hostname in ('www.youtube.com', 'youtube.com', 'm.youtube.com'):
        if parsed.path == '/watch':
            return parse_qs(parsed.query)['v'][0]
        elif parsed.path.startswith('/embed/'):
            return parsed.path.split('/')[2]

    # Assume it's already a video ID
    return url

# Extract ID before passing to youtube-transcript-api
video_id = extract_video_id(url)
```

**Note:** youtube-transcript-api requires video IDs only, NOT full URLs. Always extract the ID first using the function above.

**Bash (for yt-dlp or other CLI tools):**
```bash
# yt-dlp accepts full URLs directly, but if you need the ID:
video_id=$(echo "$url" | sed -n 's/.*[?&]v=\([^&]*\).*/\1/p')
# Or for youtu.be format:
video_id=$(echo "$url" | sed -n 's/.*youtu\.be\/\([^?]*\).*/\1/p')
```

### Step 3: Determine Transcript Availability

Before selecting a tool, understand what captions exist for the video.

**Check available transcripts (youtube-transcript-api):**
```python
from youtube_transcript_api import NoTranscriptFound

# Use create_ytt_api() from Step 1B (includes proxy)
ytt_api = create_ytt_api()
transcript_list = ytt_api.list(video_id)

# Check for manually created captions
try:
    manual = transcript_list.find_manually_created_transcript(['en'])
    print(f"Manual transcript available: {manual.language}")
except NoTranscriptFound:
    print("No manual transcript found")

# Check for auto-generated captions
try:
    generated = transcript_list.find_generated_transcript(['en'])
    print(f"Auto-generated transcript available: {generated.language}")
except NoTranscriptFound:
    print("No auto-generated transcript found")

# List all available languages
for transcript in transcript_list:
    print(f"{transcript.language} ({'manual' if not transcript.is_generated else 'auto'})")
```

**Check available transcripts (yt-dlp):**
```bash
yt-dlp --list-subs "https://www.youtube.com/watch?v=VIDEO_ID"
```

This will show both manual and auto-generated subtitles with language codes.

Proceed to the relevant decision tree (Step 4A, 4B, or 4C) based on availability.

---

### Step 4A: Captions Available (Manual or Auto-Generated)

**If working in Python environment OR want cleanest output:**
→ Use **youtube-transcript-api** (primary recommendation)
- Purpose-built for YouTube transcripts
- No API key required
- MIT licence (permissive)
- Actively maintained (latest version available on PyPI)
- Direct access to YouTube's internal transcript API
- Installation: `pip install youtube-transcript-api`
- Clean output: returns FetchedTranscript object containing Snippet objects with .text, .start, .duration attributes
- Built-in formatters: JSON, text, SRT, VTT, WebVTT
- Language selection with fallback: `languages=['de', 'en']`
- Translation support: `transcript.translate('de')`
- **IMPORTANT:** Always use proxy credentials from Step 1B. YouTube blocks cloud IPs and increasingly throttles residential IPs too
- Limitation: Cannot handle age-restricted videos (authentication currently unavailable)
- Best practice: Store the instance (`ytt_api = YouTubeTranscriptApi()`) to share the HTTP session across calls

**Else if yt-dlp already installed OR prefer CLI workflow:**
→ Use **yt-dlp**
- General-purpose video/audio downloader with subtitle extraction
- Unlicense (permissive)
- More widely installed than Python-specific tools
- Installation: `brew install yt-dlp` (macOS) or `sudo apt install yt-dlp` (Linux) or `pip install yt-dlp`
- Outputs VTT/SRT files (requires post-processing for clean text)
- Can specify language: `--sub-lang en`
- Can convert format: `--convert-subs srt`
- Limitation: Output needs parsing to strip timestamps and metadata

**Proxy handling (all environments):**
YouTube blocks transcript requests from cloud IPs and increasingly throttles other IPs too. The proxy credentials loaded in Step 1B handle this automatically. If using the `create_ytt_api()` helper from Step 1B, proxy is already configured.

If proxy credentials are unavailable, fall back to **yt-dlp** (generally less affected by blocking).

**Fallback chain if preferred tool unavailable:**
1. `import` fails on system Python → Check pipx venv (Step 1) before falling back — the package is likely installed there
2. youtube-transcript-api genuinely unavailable → Use yt-dlp
3. youtube-transcript-api blocked (cloud IP) → Use yt-dlp OR configure proxy
4. yt-dlp unavailable → Install youtube-transcript-api via pipx
5. Both unavailable → Install yt-dlp (lighter dependency than Python tools)

---

### Step 4B: No Captions Available (Captionless Video)

**If video has NO captions AND local environment with sufficient resources:**
→ Use **Whisper** (optional heavy dependency)
- OpenAI's speech recognition model
- Transcribes audio locally (no API calls)
- MIT licence (permissive)
- High accuracy across languages
- **CRITICAL WARNING:** Heavy dependency with significant resource requirements
- Installation: `pip install openai-whisper`
- Model selection: `tiny`, `base`, `small`, `medium`, `large`, `turbo` (accuracy vs speed trade-off)
- Requires ffmpeg: `brew install ffmpeg` (macOS) or `sudo apt install ffmpeg` (Linux)

**Whisper model sizes and requirements:**

| Model  | Parameters | Download Size | VRAM Required | Relative Speed |
|--------|-----------|--------------|---------------|----------------|
| tiny   | 39M       | ~75 MB       | ~1 GB         | ~10x          |
| base   | 74M       | ~140 MB      | ~1 GB         | ~7x           |
| small  | 244M      | ~460 MB      | ~2 GB         | ~4x           |
| medium | 769M      | ~1.5 GB      | ~5 GB         | ~2x           |
| large  | 1550M     | ~3 GB        | ~10 GB        | 1x            |
| turbo  | 809M      | ~1.5 GB      | ~6 GB         | ~8x           |

**If cloud environment OR resource-constrained:**
→ Inform user that transcription not possible without:
- Installing Whisper with sufficient compute resources, OR
- Using external transcription service (YouTube auto-captioning, Rev.com, etc.)

**Decision criteria for Whisper:**
- **Use if:** Video is critical, no captions exist, have disk space and compute time
- **Skip if:** Resource-constrained, cloud environment without GPU, tight deadline
- **Alternative:** Ask video creator to enable YouTube auto-captions (often available within hours of upload)

**Fallback:**
If Whisper too heavy, recommend manual alternatives:
- Enable YouTube auto-captions (video owner action)
- Use external transcription service
- Wait 24-48 hours for YouTube to generate auto-captions (if recently uploaded)

---

### Step 4C: Age-Restricted or Private Videos

**Limitation:** Current tools cannot handle age-restricted videos without authentication, which is not reliably available.

**Workarounds:**
- If you own the video: Make it public temporarily
- If you don't own the video: Download video using yt-dlp (may work with cookies), then use Whisper for transcription
- For private videos: No programmatic access possible

**yt-dlp with cookies approach (experimental):**
```bash
# Export cookies from browser (requires browser extension)
# Then:
yt-dlp --cookies cookies.txt --write-auto-sub --skip-download "URL"
```

This may work for age-restricted content if logged into YouTube in browser, but reliability varies.

---

### Step 5: Install Selected Tool

Installation method depends on your Python environment (detected in Step 1).

**youtube-transcript-api:**
```bash
# If pipx available (recommended for CLI usage on macOS/system Python):
pipx install youtube-transcript-api

# If inside a virtual environment:
pip install youtube-transcript-api

# If neither pipx nor venv — create a temporary venv:
python3 -m venv /tmp/yt-transcript-venv
source /tmp/yt-transcript-venv/bin/activate
pip install youtube-transcript-api
```

**yt-dlp:**
```bash
# macOS
brew install yt-dlp

# Linux (Debian/Ubuntu)
sudo apt install yt-dlp

# Via pipx (if system Python):
pipx install yt-dlp

# Inside a virtual environment:
pip install yt-dlp
```

**Whisper (optional, if needed):**
```bash
# Whisper requires a virtual environment or pipx — it has many dependencies
python3 -m venv /tmp/whisper-venv
source /tmp/whisper-venv/bin/activate
pip install openai-whisper

# Install ffmpeg dependency
# macOS
brew install ffmpeg

# Linux (Debian/Ubuntu)
sudo apt install ffmpeg
```

**Note:** On macOS with Homebrew Python (and most modern Linux distributions), bare `pip install` to system Python will fail with `externally-managed-environment` (PEP 668). Always use pipx for CLI tools or create a virtual environment. See Step 7 for troubleshooting if you encounter this error.

---

### Step 6: Execute Extraction

**youtube-transcript-api CLI (quickest for one-off extraction):**

If installed via pipx or available on PATH, the CLI is the fastest way to get a transcript:

```bash
# Plain text output (most common)
youtube_transcript_api VIDEO_ID --format text

# JSON output (with timestamps, start/duration per segment)
youtube_transcript_api VIDEO_ID --format json

# Other formats: pretty, srt, webvtt
youtube_transcript_api VIDEO_ID --format srt

# Specify language preference
youtube_transcript_api VIDEO_ID --languages en de

# List available transcripts for a video
youtube_transcript_api VIDEO_ID --list-transcripts

# Exclude auto-generated (manual only)
youtube_transcript_api VIDEO_ID --format text --exclude-generated

# Translate to another language
youtube_transcript_api VIDEO_ID --format text --translate de

# Save to file
youtube_transcript_api VIDEO_ID --format text > transcript.txt
```

**Note:** The CLI command uses an underscore (`youtube_transcript_api`), not a hyphen. The package name uses hyphens (`youtube-transcript-api`) but the CLI binary uses underscores.

---

**youtube-transcript-api Python API (for programmatic usage):**

Use the Python API when you need proxy support (the standard case), need to integrate transcript extraction into scripts, process multiple videos, or need fine-grained control over the output.

**Interpreter note:** If installed via pipx, run all Python API code with the pipx venv Python (`~/.local/pipx/venvs/youtube-transcript-api/bin/python3`), not system `python3`. See Step 1B for details.

**youtube-transcript-api (basic text extraction):**
```python
# Use create_ytt_api() from Step 1B (includes proxy if credentials available)
ytt_api = create_ytt_api()

# Fetch transcript (returns FetchedTranscript object)
transcript = ytt_api.fetch(video_id)

# Extract just the text (iterate over Snippet objects)
text_only = ' '.join([snippet.text for snippet in transcript])
print(text_only)

# With timestamps preserved
for snippet in transcript:
    print(f"[{snippet.start:.2f}s] {snippet.text}")
```

**youtube-transcript-api (language selection):**
```python
ytt_api = create_ytt_api()

# Try German first, fall back to English
transcript = ytt_api.fetch(
    video_id,
    languages=['de', 'en']
)
```

**youtube-transcript-api (translation):**
```python
ytt_api = create_ytt_api()
transcript_list = ytt_api.list(video_id)

# Get English transcript and translate to German
transcript = transcript_list.find_transcript(['en'])
translated = transcript.translate('de')
fetched = translated.fetch()
```

**youtube-transcript-api (formatted output):**
```python
from youtube_transcript_api.formatters import TextFormatter, JSONFormatter, SRTFormatter, WebVTTFormatter

ytt_api = create_ytt_api()
transcript = ytt_api.fetch(video_id)

# Plain text
formatter = TextFormatter()
text = formatter.format_transcript(transcript)
print(text)

# JSON with indentation
formatter = JSONFormatter()
json_output = formatter.format_transcript(transcript, indent=2)

# SRT subtitles
formatter = SRTFormatter()
srt = formatter.format_transcript(transcript)

# WebVTT
formatter = WebVTTFormatter()
vtt = formatter.format_transcript(transcript)
```

**youtube-transcript-api (preserve formatting):**
```python
ytt_api = create_ytt_api()
transcript = ytt_api.fetch(video_id, preserve_formatting=True)
```

**yt-dlp (download subtitles):**
```bash
# Download manual subtitles only (if available)
yt-dlp --write-sub --skip-download -o "output" "https://www.youtube.com/watch?v=VIDEO_ID"

# Download auto-generated subtitles
yt-dlp --write-auto-sub --skip-download -o "output" "https://www.youtube.com/watch?v=VIDEO_ID"

# Download both (prefers manual if available)
yt-dlp --write-sub --write-auto-sub --skip-download -o "output" "https://www.youtube.com/watch?v=VIDEO_ID"

# Specify language
yt-dlp --write-sub --sub-lang en --skip-download -o "output" "URL"

# Convert to SRT format
yt-dlp --write-sub --convert-subs srt --skip-download -o "output" "URL"
```

**yt-dlp output parsing (VTT to clean text):**
```python
import re

def clean_vtt(vtt_path):
    """Parse VTT file to extract clean text without timestamps."""
    with open(vtt_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Remove VTT header
    content = re.sub(r'^WEBVTT\n.*?\n\n', '', content, flags=re.DOTALL)

    # Remove timestamp lines
    content = re.sub(r'^\d{2}:\d{2}:\d{2}\.\d{3} --> \d{2}:\d{2}:\d{2}\.\d{3}.*\n', '', content, flags=re.MULTILINE)

    # Remove cue identifiers
    content = re.sub(r'^\d+\n', '', content, flags=re.MULTILINE)

    # Remove duplicate lines (VTT often repeats for overlays)
    lines = content.split('\n')
    unique_lines = []
    prev_line = None
    for line in lines:
        line = line.strip()
        if line and line != prev_line:
            unique_lines.append(line)
        prev_line = line

    return ' '.join(unique_lines)

# Usage
text = clean_vtt('output.en.vtt')
print(text)
```

**Whisper (captionless videos):**
```python
import whisper

# Load model (tiny, base, small, medium, large, turbo)
# See model table in Step 4B for size/performance characteristics
model = whisper.load_model("base")

# Transcribe audio from video
# Whisper auto-extracts audio if given video file
result = model.transcribe("video.mp4")

# Get plain text
print(result["text"])

# Get transcript with timestamps
for segment in result["segments"]:
    print(f"[{segment['start']:.2f}s - {segment['end']:.2f}s] {segment['text']}")
```

**Whisper with yt-dlp (download video first):**
```bash
# Download video
yt-dlp -o "video.mp4" "https://www.youtube.com/watch?v=VIDEO_ID"

# Then transcribe with Whisper
python3 << EOF
import whisper
model = whisper.load_model("base")
result = model.transcribe("video.mp4")
print(result["text"])
EOF
```

---

### Step 7: Handle Common Issues

**Issue: youtube-transcript-api blocked (IP blocking)**
- **Symptom:** NoTranscriptFound or HTTP 403 errors, or empty responses
- **Cause:** YouTube blocks cloud provider IPs and increasingly throttles residential IPs
- **Solution:** Configure a rotating residential proxy via `~/.config/rageatc/.env` (see Step 1B) if you haven't already. Fallback: switch to yt-dlp, which is generally less affected by IP blocking.

**Issue: NoTranscriptFound error but video has captions**
- **Symptom:** youtube-transcript-api raises NoTranscriptFound exception
- **Cause:** Transcript not available in requested language OR video is age-restricted
- **Solution:** List available transcripts first using `ytt_api.list(video_id)`, then fetch available language

**Issue: yt-dlp downloads VTT with duplicate lines**
- **Symptom:** Repeated text in output
- **Cause:** VTT format uses overlapping cues for smooth display
- **Solution:** Use VTT parsing code (see Step 6) to deduplicate

**Issue: Whisper transcription too slow**
- **Symptom:** Processing takes hours
- **Cause:** Using large model on CPU OR very long video
- **Solution:** Use smaller model (`tiny` or `base`) OR run on GPU if available

**Issue: Video ID extraction fails**
- **Symptom:** Tool doesn't recognise URL format
- **Cause:** Non-standard URL format or playlist URL
- **Solution:** Use URL parsing code (Step 2) OR extract video ID manually from URL

**Issue: Age-restricted video cannot be accessed**
- **Symptom:** Authentication required error
- **Cause:** Video requires login to view
- **Solution:** Try yt-dlp with cookies (experimental, see Step 4C) OR download video manually and use Whisper

**Issue: pip install fails with "externally-managed-environment" error**
- **Symptom:** `error: externally-managed-environment` when running `pip install`
- **Cause:** Python installed via Homebrew (macOS) or system package manager (Linux) enforces PEP 668, which prevents direct pip installs to the system Python to avoid breaking the package manager
- **Solution:** Use a virtual environment:
  ```bash
  python3 -m venv /tmp/yt-transcript-venv
  source /tmp/yt-transcript-venv/bin/activate
  pip install youtube-transcript-api
  ```
  Alternatively, use `pipx` for CLI tools: `brew install pipx && pipx install youtube-transcript-api` (or `pipx install yt-dlp`). Passing `--break-system-packages` is not recommended as it risks breaking your Python installation. See Step 5 for environment-aware installation guidance.

---

## Edge Cases and Constraints

**Out of scope for this skill:**
- Live stream transcripts (require different approach)
- Non-YouTube video platforms (Vimeo, Dailymotion, etc.)
- Real-time transcription during streaming
- Native Windows (non-WSL) — this skill covers macOS, Linux, WSL2

**Multilingual handling:**
- youtube-transcript-api: Specify language preference list with fallback
- Translation: Available via youtube-transcript-api's `.translate()` method
- yt-dlp: Use `--sub-lang` for specific language or `--all-subs` for all available

**Long videos:**
- youtube-transcript-api: No practical length limit for captioned videos
- Whisper: Processing time scales linearly with video length; consider smaller models for long content

**Playlist handling:**
- Extract individual video IDs from playlist URL
- Process each video separately
- Neither tool has native playlist transcript extraction

---

## Quality Checklist

Before finalising tool selection and execution, confirm:

- [ ] Video ID successfully extracted from URL (required for youtube-transcript-api)
- [ ] Environment detection performed (checked installed tools)
- [ ] Transcript availability checked (manual, auto-generated, or none)
- [ ] Requirements clarified (output format, language preference, environment constraints)
- [ ] Decision tree followed to reach clear recommendation
- [ ] If experiencing blocks: proxy credentials configured in `~/.config/rageatc/.env` (Step 1B)
- [ ] Whisper flagged as heavy dependency if suggesting for captionless videos
- [ ] Fallback options documented in case preferred tool unavailable
- [ ] Platform-specific commands verified for your environment (macOS, Linux, WSL2)
- [ ] Output format specified (formatted HTML default, or user-requested alternative)
- [ ] If HTML: filename follows `YYYY-MM-DD_channel-name_slugified-title.html` convention
- [ ] If HTML: body text is the speaker's original words, not a rewrite or summary
- [ ] If HTML: AI Summary block present after header (TLDR + bullet list of contents)
- [ ] If HTML: sections created from topic shifts, callouts for key quotes, dark mode supported
- [ ] If HTML: opened in browser after creation

---

## Evaluation Scenarios

### Scenario 1: Quick One-Off Transcript Extraction

**Task:** User pastes a YouTube URL and asks for the transcript. Local macOS environment, no tools currently installed.

**Expected process:**
- Parse video ID from URL
- Detect environment: No transcript tools installed, system Python (Homebrew), pipx available
- Decision: Recommend youtube-transcript-api CLI via pipx (fastest path for one-off extraction)
- Installation: `pipx install youtube-transcript-api`
- Execute: `youtube_transcript_api VIDEO_ID --format text`
- NOT: Write a Python script for a one-off extraction task

**Success criteria:** Selects CLI over Python API for one-off task, uses pipx (not bare pip) on macOS, completes extraction in minimal steps without trial-and-error.

### Scenario 2: Extract Transcript from Educational Video

**Task:** User needs to extract English transcript from a 30-minute educational YouTube video for note-taking. Local macOS environment.

**Expected process:**
- Parse video ID from URL
- Detect environment: Check for Python tools
- Check transcript availability: Confirm captions exist
- Decision: Recommend youtube-transcript-api (cleanest output, purpose-built)
- Installation: `pip install youtube-transcript-api`
- Execute: Provide extraction code example for plain text output
- Fallback: If python unavailable, suggest yt-dlp with VTT parsing

**Success criteria:** Selects appropriate tool considering environment, provides installation and usage guidance, outputs clean plain text, documents fallback option.

### Scenario 2: Extract Transcript in Cloud Environment

**Task:** User running on AWS Lambda needs to extract YouTube transcripts. Python environment available.

**Expected process:**
- Detect environment: Cloud (AWS) detected
- Warning: youtube-transcript-api will be blocked on cloud provider IPs
- Decision: Recommend yt-dlp (not blocked) OR youtube-transcript-api with proxy configuration
- If proxy available: Provide proxy configuration example
- If no proxy: Use yt-dlp with VTT parsing code
- Execute: Provide complete yt-dlp workflow with parsing

**Success criteria:** Recognises cloud environment constraint, provides two viable paths (proxy vs yt-dlp), includes complete working code for chosen approach.

### Scenario 3: Handle Video Without Captions

**Task:** User needs transcript from interview video that has no captions. Local environment with sufficient resources.

**Expected process:**
- Check transcript availability: No captions found
- Assess environment: Local with disk space and compute available
- Decision: Suggest Whisper as optional heavy dependency
- Warning: Flag model download sizes (75 MB to 3 GB), significant processing time
- Installation: `pip install openai-whisper` and `brew install ffmpeg`
- Execute: Provide Whisper transcription workflow with model size guidance (reference table in Step 4B)
- Alternative: Suggest waiting for YouTube auto-captions or external service

**Success criteria:** Clearly flags Whisper as heavy dependency, provides accurate resource requirements using the model size table, gives processing time expectations, suggests lighter alternatives.

### Scenario 4: Extract Multilingual Transcript with Translation

**Task:** User needs to extract German transcript from video that only has English captions.

**Expected process:**
- Parse video ID from URL
- Check transcript availability: English manual captions found, no German
- Decision: Use youtube-transcript-api with translation feature
- Installation: `pip install youtube-transcript-api`
- Execute: Provide translation workflow code (list, find_transcript, translate, fetch chain)
- Note: Translation available for auto-generated and manual captions
- Limitation: Translation quality depends on YouTube's service

**Success criteria:** Identifies translation capability, provides correct API usage for translation (demonstrates list → find_transcript → translate → fetch chain), explains limitations.

---

## Success Indicators

This skill succeeds when:
- Users reach clear tool recommendations within one decision tree traversal
- Tool selection accounts for environment constraints (cloud vs local), transcript availability, resource limits
- Video ID parsing handles common URL format variations
- Fallback chains prevent workflow failures when preferred tools unavailable
- Environment detection happens before recommendation (not after installation fails)
- Cloud provider IP blocking is flagged before recommending youtube-transcript-api
- Whisper is correctly positioned as optional heavy fallback with accurate resource requirements, not primary tool
- Output format matches user needs (plain text, JSON, SRT, VTT)
- Users complete YouTube transcript extraction without external guidance beyond this skill

---
