---
name: codify
description: Sweep the project's LEARNINGS.md inbox and turn accumulated entries into durable skill, rule, or documentation changes. Run when ready to process learnings — not mid-task.
disable-model-invocation: true
---

# Codify

## Step 1 — Read the inbox

Read `LEARNINGS.md` at the project root. Candidates are entries without a `Codified →` marker. If there are none, report that and stop. If the file doesn't follow the standard `## YYYY-MM-DD — Title` entry format (e.g. a numbered takeaways list), treat each discernible item as an entry and place markers where they unambiguously attach to the item.

## Step 2 — Cluster

Group candidate entries that share a root cause or a target file. A pattern across several entries is stronger evidence than any single entry — codify the pattern, not each instance.

## Step 3 — Find the structural fix

The entry recorded the symptom and (usually) the likely cause at capture time. Now do the analysis the capture deliberately skipped: ask why the system allowed the failure, and what change prevents recurrence.

Test every proposed fix: **would it have prevented the original incident even if nobody remembered the learning?** "Be more careful" or "remember to X" fails this test — put the knowledge where the future reader will already be looking (the skill they will load, the rule that is always in context, the template they will copy). Prefer the smallest change that passes.

Some entries need no fix: a durable technical fact (version pin, API quirk) with no better home is already serving its purpose where it is. Others are not ready — a single incident with an unclear cause stays in the inbox until the pattern repeats.

## Step 4 — Choose the target

| Learning kind | Target |
|---|---|
| Workflow or process failure in plugin-orchestrated work | rageatc skill, agent, or rule — record as a proposal; implement in the rageatc workshop, never in the installed plugin |
| Project-specific convention or constraint | Project `CLAUDE.md` or `.claude/rules/` |
| Technical fact about the project's stack | Project docs (`ARCHITECTURE.md`, reference docs) — or the entry itself if no better home exists |
| Behaviour that should apply across all projects | `~/.claude/CLAUDE.md` |

## Step 5 — Get approval

Present the proposals as a compact list — entries covered, root cause, proposed change, target file — and get a decision on each. Implement only what is approved.

## Step 6 — Apply and annotate

Apply approved changes to in-reach targets now. rageatc proposals are handed to the user for the workshop — do not edit plugin files from a consuming project.

Append a marker line to each processed entry:

- `_Codified → <target file> (YYYY-MM-DD)_` — change applied
- `_Codified → proposal: <target> (YYYY-MM-DD)_` — rageatc proposal recorded, pending workshop
- `_Codified → retained in place (YYYY-MM-DD)_` — the entry is itself the durable record

This marker is the one sanctioned exception to the file's append-only rule.

## Step 7 — Report

Summarise per entry: codified where, proposed for what, or left in the inbox and why.
