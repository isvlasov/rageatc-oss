# Status Tracking

Every project should have a `STATUS.md` at the root - the living state of the project. CLAUDE.md says what the project is and where things live; STATUS.md says where things stand right now.

Four fixed sections: **current position**, **recent decisions** (last 3-5), **next steps** (priority order), **open questions**. Everything else lives in dedicated files that CLAUDE.md points to.

- **Rewrite, don't append** - always current state, never history (history lives in git)
- **Keep it brief** - readable in under 30 seconds

Update via `/handover` when state changes; `/finalise-session` at session end runs it then commits and pushes.
