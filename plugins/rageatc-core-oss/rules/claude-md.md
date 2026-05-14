# CLAUDE.md Discipline

CLAUDE.md is a **lean pointer file** — orientation for a fresh session, not a knowledge base.

## What belongs in CLAUDE.md

- Project identity (one-line description)
- Pointers to key files (PRD, ARCHITECTURE, STATUS, roadmap, etc.)
- Workflow tier or approach (when applicable)
- Session resumption steps (which files to read, in what order)
- Working conventions specific to this project (e.g. "British English", "no auto-commits")

## What does NOT belong in CLAUDE.md

- Architecture or design decisions → ARCHITECTURE.md, docs/decisions/
- Requirements or feature lists → PRD.md
- Current status or progress → STATUS.md
- Workflow phase descriptions → skills handle this
- Build instructions or scripts → README.md or docs/
- Historical context or session logs → git history
- Content that duplicates information in files CLAUDE.md already points to

## Principle

If the information lives (or should live) in another file, CLAUDE.md **points to it** — never absorbs it. CLAUDE.md changes when project structure changes, not when project state changes.
