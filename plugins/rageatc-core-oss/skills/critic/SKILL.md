---
name: critic
description: Invokes the critic-agent to review the latest produced output. Use when the user runs /critic to request a quality review of the most recent artefact or deliverable from the current workflow.
---

# Critic

The user wants the latest output reviewed by the critic-agent.

## What to do

1. **Identify the latest output** — the most recent artefact produced in the current workflow
2. **Invoke the critic-agent** with complete context:
   - The output file(s) to review
   - The brief or requirements the output was produced against
   - Any applicable standards
   - Relevant background — what the artefact is for, where it fits, what problem it solves
3. **Report the verdict** — share the critic's accept/revise decision and key findings with the user

## Context rule

The critic-agent works in isolation. It only knows what you give it. Provide enough context for an informed review — the brief, the standards, and the purpose — not just the file.
