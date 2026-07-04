---
name: finalise-session
description: Run /handover then commit and push changes to git
disable-model-invocation: true
---

# Finalise Session

Run `/handover` (write mode) to update project files, then commit and push.

## Step 1: Handover

Run `/handover` — review the session, update root files, sync CLAUDE.md pointers, check referenced files.

## Step 2: Commit and push

Run `git status` first; if nothing changed, skip this step. Otherwise: stage the relevant files, commit with a message that reflects the session's work (no approval needed — the user asked by invoking this skill), and push. If push fails (e.g. no remote configured), report it but don't block.

## Step 3: Report

- Files updated by handover (from its report)
- Committed and pushed: yes / no / no changes
