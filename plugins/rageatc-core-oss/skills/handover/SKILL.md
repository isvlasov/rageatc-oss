---
name: handover
description: Session handover — end a session by systematically updating project state files for continuity. Use this when the session is ending, the user asks for a "handover", or when significant progress needs to be recorded.
---

# Handover (Write State)

Update project files so the next session can pick up exactly where this one left off.

## Step 1: Review the session

Before touching any files, reflect: what was created or significantly changed? What decisions were made? What was discovered or learned? Were new key files created (e.g. in `work/`) that a fresh session would need to know about?

## Step 2: Update root files

Check every `.md` file in the project root. Follow each file's own update instructions (found at the top of the file); if a file has none, update it whenever this session's work has made it stale.

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

## Step 3: Follow CLAUDE.md pointers

For each file CLAUDE.md references beyond the root (e.g. `work/` artefacts, orchestration logs): does the pointer still point to the right location? Has this session's work made the file stale? Update if needed.

## Step 4: Hygiene checks

Structural checks only — don't deep-read files.

- **CLAUDE.md compliance** — lean pointer file standard: one-line project identity; points to key files without absorbing their content; no embedded architecture, requirements, status, or workflow descriptions; no stale sections duplicating files it points to. Fix non-compliance now.
- **Dangling pointers** — every file path referenced in CLAUDE.md and STATUS.md exists. Flag broken references to the user — don't silently remove; the file may have been moved.
- **Git hygiene** — run `git status`: junk files (`.DS_Store`, `*.swp`, `__pycache__/`, `.pyc`) → add to `.gitignore`; untracked files that don't look like this session's work → flag to the user, don't delete.

## Step 5: Report

Tell the user: which files were checked; which were updated and briefly what changed; hygiene issues found (with actions taken or flagged); anything that needs the user's judgement.
