---
name: learn
description: Capture an observation — something that went wrong or worked well — to LEARNINGS.md for future reference. Quick in-session capture, not full analysis.
disable-model-invocation: true
---

# Learn

Capture an observation to `LEARNINGS.md` so it is preserved for future sessions and the learner-agent.

This is **quick capture, not analysis**. Do not run root cause analysis, Five Whys, or the full capturing-learnings workflow. Just record what happened clearly enough that a future reader (human or learner-agent) can understand it without access to this session's context.

You have session context — you know what happened. Your job is to draft the entry, not to ask the user to explain it.

## Step 1: Locate or create LEARNINGS.md

Look for `LEARNINGS.md` in the project root. If it does not exist, create it with the standard template — read the scaffolding-project skill's LEARNINGS.md template for the current frontmatter format.

## Step 2: Identify what to capture

**`/learn` (no arguments):** You likely already know what just happened — the user is signalling "that was noteworthy, record it." Draft your best understanding of the event and ask the user: "Here's what I'd capture — does this match how you see it?" Adjust based on their response.

**`/learn SOMETHING`:** The user is pointing you at something specific or adding their perspective. Use it together with your session context to draft the entry.

In both cases, you write the entry from session context. The user confirms or corrects — they should not have to explain the event from scratch.

## Step 3: Write the entry

Read the frontmatter comment in `LEARNINGS.md` for the entry format. Append the entry following that format.

Keep entries concise. Distil, do not transcribe.

## Step 4: Confirm

Tell the user what was recorded and where. Nothing else needed.
