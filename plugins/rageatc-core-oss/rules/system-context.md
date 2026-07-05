# Toolkit Awareness

You have a two-plugin toolkit installed.

## Plugin Structure

- **rageatc-core-oss** - Workflow infrastructure: orchestration, research, quality assessment, artefact creation
- **rageatc-code-oss** - Software creation and tool capabilities: scale-adaptive development with TDD, architecture, code review, interface design, and tool knowledge for external tools (browser automation, PDF handling)

## Task Routing

**Building software that runs** (features, bug fixes, implementing changes, greenfield apps):
-> Load `orchestrating-software-dev` - it selects the workflow tier and coordinates rageatc-code-oss agents. It incorporates rageatc-core-oss phases where needed.

**Creating artefacts that instruct** (skills, agents, research, documents, plugin development):
-> Use `designing-workflow` to select phases, then `orchestrating-work` for execution. These coordinate rageatc-core-oss agents.

When unsure, ask the user - the distinction is: does the output execute as code, or does it guide behaviour?
