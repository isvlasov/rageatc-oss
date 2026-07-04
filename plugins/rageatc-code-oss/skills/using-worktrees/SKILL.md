---
name: using-worktrees
description: Manages git worktree isolation for implementation chunks. Use when setting up isolated workspaces, creating worktrees for chunks, or merging completed chunk branches.
---

# Using Worktrees

## Overview

Git worktrees create isolated workspaces sharing the same repository, allowing work on multiple branches simultaneously without switching.

**Core principle:** Systematic directory selection + safety verification = reliable isolation.

## Scope

This skill covers git worktree setup, lifecycle, and known limitations for rageatc-code-oss workflows. It does NOT cover process-level isolation (Docker sandboxes), CI/CD pipeline isolation, or worktree usage outside of chunk-based development.

## When to Use

- **Standard/Thorough workflows:** Each implementation chunk gets its own worktree for isolation
- **Parallel chunks (Thorough only):** Multiple worktrees enable simultaneous work on chunks with non-overlapping file sets
- **Quick workflow:** Optional — branch-based isolation may suffice for single small changes

## Approach: Orchestrator-Managed Worktrees

The orchestrator creates and manages worktrees manually using `git worktree add`, then points developer-agents to the worktree directory.

**Why manual, not automated:** Claude Code's `isolation: "worktree"` subagent frontmatter had critical bugs when this approach was chosen (Feb 2026; GitHub #29110, closed unresolved) — permission bypass ineffective and silent data loss on cleanup. The manual approach is reliable regardless. Re-verify the frontmatter route against current Claude Code behaviour before relying on it; see Known Limitations.

```
Orchestrator:
  1. git worktree add <path> -b <branch>
  2. Run setup in worktree
  3. Launch developer-agent pointed at worktree path
  4. After review + accept: merge branch, remove worktree
```

## Directory Selection

Follow this priority order:

### 1. Check Existing Directories

```bash
ls -d .worktrees 2>/dev/null     # Preferred (hidden)
ls -d worktrees 2>/dev/null      # Alternative
```

**If found:** Use that directory. If both exist, `.worktrees` wins.

### 2. Check CLAUDE.md

```bash
grep -i "worktree.*director" CLAUDE.md 2>/dev/null
```

**If preference specified:** Use it.

### 3. Ask User

If no directory exists and no CLAUDE.md preference:

```
No worktree directory found. Where should I create worktrees?

Recommended: .worktrees/ (project-local, hidden)
```

## Safety Verification

### Verify Directory is Ignored

**MUST verify before creating any project-local worktree:**

```bash
git check-ignore -q .worktrees 2>/dev/null
```

**If NOT ignored:**
1. Add `.worktrees/` to .gitignore
2. Commit the change
3. Proceed with worktree creation

**Why critical:** Prevents accidentally committing worktree contents to repository.

## Worktree Lifecycle

### 1. Create Worktree

```bash
# Name branch after chunk for traceability
git worktree add .worktrees/chunk-003 -b chunk-003/recipe-service
```

### 2. Run Project Setup

Auto-detect and run appropriate setup:

```bash
# Node.js
if [ -f package.json ]; then npm install; fi

# Rust
if [ -f Cargo.toml ]; then cargo build; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f pyproject.toml ]; then poetry install; fi

# Go
if [ -f go.mod ]; then go mod download; fi
```

### 3. Verify Clean Baseline

Run tests to ensure worktree starts clean:

```bash
# Use project-appropriate command
npm test
```

**If tests fail:** Report failures, ask whether to proceed or investigate.

**If tests pass:** Worktree is ready for the developer-agent.

### 4. Assign to Developer

Orchestrator launches developer-agent with the worktree path as the working directory.

### 5. After Review + Accept

```bash
# Merge the chunk branch back to main
git checkout main
git merge chunk-003/recipe-service

# Clean up
git worktree remove .worktrees/chunk-003
git branch -d chunk-003/recipe-service
```

### 6. After Review + Reject (iteration cap reached)

```bash
# Discard the worktree — main is untouched
git worktree remove --force .worktrees/chunk-003
git branch -D chunk-003/recipe-service
```

## Known Limitations

Reported against Claude Code's `isolation: "worktree"` frontmatter (Feb 2026, GitHub #29110 — closed without a stated fix; re-verify against current behaviour):

- **Subagent permissions:** agents in frontmatter-isolated worktrees could not run bash (tests, git commit) — `permissionMode: "bypassPermissions"` was ineffective. Workaround if a developer-agent reports BLOCKED on permissions: orchestrator reviews the code output, runs tests, and commits from the main session.
- **Silent data loss:** frontmatter-created worktrees could be deleted during cleanup, destroying uncommitted work. Always commit before exiting a worktree session; manual `git worktree add` avoids auto-cleanup entirely.
- **Background agents:** `background: true` + `isolation: "worktree"` did not compose — background agents ran in the main repository.
- **Branch naming:** frontmatter isolation generates opaque branch names (`worktree-agent-{hash}`); manual creation lets you name branches after chunks.

## When to Use Worktrees vs Branches

| Scenario | Recommendation |
|----------|---------------|
| Quick workflow (1-3 files) | Branch — simpler, no setup overhead |
| Standard workflow (sequential chunks) | Worktree per chunk — isolation without switching |
| Thorough workflow (parallel chunks) | Worktree per chunk — enables true parallelism |
| Single developer, small project | Branch may suffice — worktree overhead not always justified |

## Red Flags

**Never:**
- Create worktree without verifying it's gitignored (project-local)
- Skip baseline test verification
- Use `isolation: "worktree"` with `permissionMode: "bypassPermissions"` (broken)
- Use `isolation: "worktree"` with `background: true` (ignored)
- Trust auto-cleanup — commit before exiting

**Always:**
- Follow directory priority: existing > CLAUDE.md > ask
- Name branches after chunks for traceability
- Verify clean test baseline before assigning to developer
- Merge to main only after review accepts
