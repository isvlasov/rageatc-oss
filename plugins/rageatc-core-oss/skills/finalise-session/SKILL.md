---
name: finalise-session
description: Run /handover then commit and push changes to git
disable-model-invocation: true
---

# Finalise Session

Run `/handover` (write mode) to update project files, then commit and push.

## Step 1: Handover

Run `/handover` in write mode — review the session, update root files, sync CLAUDE.md pointers, check referenced files.

## Step 2: Commit and Push

Check for uncommitted changes:

```bash
git status
```

If changes exist:
1. Stage relevant files
2. Generate a meaningful commit message and commit — do not ask for approval
3. Push to remote

If no changes, skip this step.

## Step 3: Confirm Completion

Report to user:
- Files updated by handover (summary from /handover report)
- Repository committed and pushed: Yes / No / No changes

## Notes

- Always check git status before committing — don't commit if nothing changed
- Use meaningful commit messages that reflect the session's work
- If push fails (e.g., no remote configured), report the issue but don't block
