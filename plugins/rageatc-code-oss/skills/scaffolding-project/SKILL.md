---
name: scaffolding-project
description: Creates the standard project file structure for a software project. Use when starting a new software project, initialising project files, or setting up a project workspace before architecture and decomposition begin.
---

# Scaffolding a Project

Creates the standard file structure for a rageatc-code-oss project — run once per new project, before architecture and decomposition. The scaffold creates empty templates and a pre-populated CLAUDE.md; content is filled in by later skills (managing-product → PRD, architecting-software → ARCHITECTURE, decomposing-work/enriching-roadmap → ROADMAP, planning-software → ORCHESTRATION-PLAN). Not for projects with files already in place — check first.

## Inputs Required

1. **Project root path** — absolute path where files will be created
2. **Project name** — used to populate CLAUDE.md heading
3. **Workflow tier** — Quick, Standard, or Thorough (determines whether docs/decisions/ is created)

## Outputs Produced

```
<project-root>/
├── CLAUDE.md               # Pre-populated orchestrator orientation file
├── STATUS.md               # Living project state — current position, decisions, next steps
├── PRD.md                  # Empty template — managed by managing-product
├── ARCHITECTURE.md         # Empty template — managed by architecting-software
├── ROADMAP.md              # Empty template — managed by decomposing-work / enriching-roadmap
├── ORCHESTRATION-PLAN.md   # Empty template — managed by planning-software
├── LEARNINGS.md            # Empty, updated only when noteworthy
└── docs/
    └── decisions/          # Created only for Thorough tier (for ADRs)
```

## Workflow

### Step 1: Confirm inputs

Check that you have:
- [ ] Project root path (absolute)
- [ ] Project name
- [ ] Workflow tier (Quick / Standard / Thorough)

If any are missing, ask before proceeding.

### Step 2: Check for existing files

Before creating anything, check whether the project root already contains any of the target files. If existing files are present, stop and confirm with the orchestrator which files to create. Do not overwrite without explicit approval.

### Step 3: Create the directory structure

Create the project root if it does not exist. For Thorough tier only, also create `docs/decisions/`.

### Step 4: Create empty document files

Create these files with their minimal template content:

**PRD.md:**
```markdown
<!-- Update: revise when requirements shift. Owned by managing-product. -->

# PRD — [Project Name]
```

**ARCHITECTURE.md** (the full template is owned by the architecting-software skill at `architecting-software/references/architecture-template.md`):
```markdown
<!-- Update: revise when architectural decisions change. Owned by architecting-software. -->

# ARCHITECTURE — [Project Name]
```

**ROADMAP.md:**
```markdown
<!-- Update: mark chunks completed, add or reorder as needed. Owned by decomposing-work / enriching-roadmap. -->

# Roadmap — [Project Name]
```

**ORCHESTRATION-PLAN.md:**
```markdown
<!-- Update: mark completed chunks, update build progress. Owned by planning-software. -->

# Orchestration Plan — [Project Name]
```

**LEARNINGS.md:**
```markdown
<!--
Update: append observations when something noteworthy happens. Do not rewrite — this file is append-only. One exception: /codify sweeps append a `Codified →` marker line to processed entries.

Include only durable insights — something a future session would act differently for knowing (a system behaviour, a failure mode, a constraint). No session notes, task status, or resolved one-offs without a reusable insight.

Entry format:
## YYYY-MM-DD — Short descriptive title

What happened and why, written so a future reader can understand without session context.
One to five sentences. Include the likely cause if known; say "Cause unclear" if not.
-->

# Learnings — [Project Name]
```

**STATUS.md:**
```markdown
<!-- Update: rewrite entirely with current state. This file is always current, not history. -->

# Status

## Current position

Project scaffolded. Awaiting product definition (PRD).

## Recent decisions

- None yet

## Next steps

1. Define product requirements (PRD.md)

## Open questions

- None
```

For Thorough tier, also create `docs/decisions/.gitkeep`. ADR documents will be created in this directory by the architecting-software skill (template at `architecting-software/references/adr-template.md`).

### Step 5: Create the pre-populated CLAUDE.md

Use the reference template at `references/claude-md-template.md`. Substitute:
- `[Project Name]` — the project name provided
- `[Quick / Standard / Thorough]` — the selected workflow tier

Do not add project-specific process details. CLAUDE.md points to documents; it does not describe procedures.

### Step 6: Confirm completion

List the created files and confirm the structure matches the expected output for the selected tier.

## Reference Templates

- `references/claude-md-template.md` — CLAUDE.md content (pre-populated, stable across projects)

Templates owned by other skills (referenced, not duplicated):
- `architecting-software/references/architecture-template.md` — full ARCHITECTURE.md template (used by architecting-software when filling in content)
- `architecting-software/references/adr-template.md` — ADR document template (used by architecting-software for Thorough tier)

## Edge Cases

**Existing project root with some files already present:** Stop and list what exists. Ask which files to create. Never overwrite without explicit approval.

**Project name contains special characters:** Use the name as-is in the heading. Do not normalise.

**Tier changes after scaffolding:** If the tier is upgraded to Thorough after initial scaffolding, create `docs/decisions/` at that point.

**Quick tier with existing architecture:** ARCHITECTURE.md is still created — it is always present, even if shallow. Depth is determined by architecting-software, not by scaffolding.
