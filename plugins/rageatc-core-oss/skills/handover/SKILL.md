---
name: handover
description: Session handover — end a session by systematically updating project state files for continuity. Use this when the session is ending, the user asks for a "handover", or when significant progress needs to be recorded.
---

# Handover (Write State)

## Purpose

Update project files so the next session can pick up exactly where this one left off.

## Workflow

### Step 1: Review the session

Before touching any files, reflect on what happened this session:

- What files were created or significantly changed?
- What decisions were made?
- What was discovered or learned?
- Were any new key files created (e.g. in `work/`) that a fresh session would need to know about?

Hold this in mind for the steps that follow.

### Step 2: Update root files

Check every `.md` file in the project root. For each one, follow its update instructions (found at the top of the file). If a file has no explicit instructions, apply the default: check whether this session's work has made it stale, and update if so.

**Common root files and their update logic:**

| File | How to update |
|------|---------------|
| STATUS.md | Rewrite with current state (current position, recent decisions, next steps, open questions) |
| LEARNINGS.md | Append insights that need codifying later (e.g. system behaviours, agent failure modes that need rules). Do NOT use as a session log. |
| BACKLOG.md | Move new granular tasks or unresolved issues here. Keep `STATUS.md` "next steps" focused only on immediate session continuity. |
| CLAUDE.md | Update pointers — add new key files, remove stale pointers, update descriptions |
| README.md | Update if project description, status, or structure changed |
| PRD.md | Update if requirements shifted |
| ARCHITECTURE.md | Update if architectural decisions changed |
| ROADMAP.md | Update if chunks were completed, added, or reordered |
| ORCHESTRATION-PLAN.md | Mark completed chunks, update build progress |

Not every project has all of these. Check what exists.

### Step 3: Follow CLAUDE.md pointers

CLAUDE.md points to key files beyond the root (e.g. `work/` artefacts, orchestration logs). For each file CLAUDE.md references:

- Does the pointer still point to the right location?
- Has this session's work made the referenced file stale?
- Update if needed.

### Step 4: Hygiene checks

Lightweight structural checks to keep the project clean. Do not deep-read files — just verify structure and existence.

**CLAUDE.md compliance** — check against the lean pointer file standard:

- Contains project identity (one-line description)
- Points to key files, does not absorb their content
- No architecture decisions, requirements, status, or workflow descriptions embedded
- No stale sections that duplicate information from files it points to
- If non-compliant, fix during this step (it was already updated in Step 2)

**Dangling pointers** — verify every file path referenced in CLAUDE.md and STATUS.md:

- Does each referenced file actually exist?
- Flag any broken references to the user (do not silently remove — the file may have been moved)

**Git hygiene** — run `git status` and check for:

- Junk files that should be ignored (`.DS_Store`, `*.swp`, `__pycache__/`, `.pyc`, etc.) — if found, add them to `.gitignore`
- Untracked files that look like they don't belong to the current session's work — flag to the user, do not delete

### Step 5: Report

Tell the user:
- Which files were checked
- Which files were updated (and briefly what changed)
- Any hygiene issues found and actions taken (or flagged for user judgement)
- Any files that need the user's judgement to update
