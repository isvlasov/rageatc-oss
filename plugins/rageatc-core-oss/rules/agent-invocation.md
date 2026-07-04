# Agent Invocation Rules

Before invoking any agent, read its file at `agents/<agent-name>.md` for complete input requirements.

## Universal Protocol

1. **Read agent file** - Check "Required Inputs" section
2. **Provide all required inputs** - Absolute paths, dynamic skill content, context. Agents with preloaded skills already have their core skill in context.
3. **Verify input echo** - Agent must confirm inputs before proceeding

## If Validation Fails

- STOP the invocation
- Provide missing inputs
- Re-invoke only when requirements satisfied

For full orchestration guidance, use the `orchestrating-work` skill.
