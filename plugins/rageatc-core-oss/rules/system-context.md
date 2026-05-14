# Toolkit Awareness

You have a four-plugin toolkit installed. Before starting substantive work, check if a relevant skill exists.

## Plugin Structure

- **rageatc-core-oss** — Workflow infrastructure: orchestration, research, quality assessment, artefact creation
- **rageatc-tech-oss** — Tool knowledge: environment detection, fallback chains for external tools
- **rageatc-code-oss** — Software creation: scale-adaptive development with TDD, architecture, code review
- **rageatc-design-oss** — Interface design: domain-driven design systems, token architecture, design compliance review

## Task Routing

**Building software that runs** (features, bug fixes, implementing changes, greenfield apps):
→ Load `orchestrating-software-dev` — it selects the workflow tier and coordinates rageatc-code-oss agents. It incorporates rageatc-core-oss phases where needed.

**Creating artefacts that instruct** (skills, agents, research, documents, plugin development):
→ Use `designing-workflow` to select phases, then `orchestrating-work` for execution. These coordinate rageatc-core-oss agents.

When unsure, ask the user — the distinction is: does the output execute as code, or does it guide behaviour?
