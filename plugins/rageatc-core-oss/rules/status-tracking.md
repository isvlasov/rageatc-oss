# Status Tracking

Every project should have a `STATUS.md` at the root — the living state of the project.

## Purpose

STATUS.md answers: **"Where are we right now and what's happening?"**

CLAUDE.md tells you what the project is and where things live. STATUS.md tells you the current state.

## Structure

STATUS.md has four fixed sections:

1. **Current position** — one or two lines on what's actively happening or where the project stands
2. **Recent decisions** — last 3-5 decisions a new session needs to know (drop older ones)
3. **Next steps** — what's queued, in priority order
4. **Open questions** — unresolved things blocking or influencing direction

Everything else (pipeline details, domain versions, gap registers, architecture notes) lives in dedicated project files that CLAUDE.md points to.

## Principles

- **Rewrite, don't append.** STATUS.md is always current state, not history. History lives in git.
- **Update when state changes.** Progress, direction change, key decision — rewrite the relevant section.
- **Keep it brief.** A new session should be able to read STATUS.md in under 30 seconds.

## When to update

Use `/handover` to update STATUS.md (along with other root files). Use `/finalise-session` at session end — it runs `/handover` then commits and pushes.
