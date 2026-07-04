---
name: learn
description: Capture an observation — something that went wrong or worked well — to LEARNINGS.md for future reference. Quick in-session capture, not full analysis.
disable-model-invocation: true
---

# Learn

Capture an observation to `LEARNINGS.md` so it is preserved for future sessions and later `/codify` sweeps.

This is **quick capture, not analysis** — root cause analysis happens later, when the user runs `/codify`. Record what happened clearly enough that a future reader can understand it without this session's context.

## Steps

1. **Locate or create `LEARNINGS.md`** in the project root. If it does not exist, create it using the LEARNINGS.md template in the scaffolding-project skill (current frontmatter format lives there).
2. **Draft the entry from session context.** With no arguments, the user is signalling "that was noteworthy — record it": draft your best understanding and ask "Here's what I'd capture — does this match how you see it?". With an argument, fold the user's pointer or perspective into the draft. Either way you write the entry; the user confirms or corrects — they should not have to explain the event from scratch.
3. **Append the entry** following the format in the file's frontmatter comment. Distil, do not transcribe.
4. **Confirm** — tell the user what was recorded and where. Nothing else needed.
