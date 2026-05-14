---
name: prime
description: Session prime — start a fresh session by reading project state to orient yourself. Use this when you have no project context yet or the user asks to "prime the session", "read state", or start work.
disable-model-invocation: true
---

# Prime Session Context

## Purpose

Orient yourself in a fresh session by reading the project's key state and structure. Do this before answering questions or proposing actions.

## Workflow

1. Read `CLAUDE.md` — this is the lean pointer file that defines the project identity, structure, and tells you where the key files are.
2. Read `STATUS.md` — this contains the current position, recent decisions, and immediate next steps.
3. Read any other files `CLAUDE.md` points to that are necessary to understand the current task (e.g., specific briefs, learning logs, or orchestration plans).
4. Do not act on the next steps yet. Summarise the current position and the pending next steps to the user to confirm alignment before proceeding.
