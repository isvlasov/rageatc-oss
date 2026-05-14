# Orchestration Logging Rules

Log every workflow step in `work/<task-id>/ORCHESTRATION-LOG.md`.

For complete logging guidance including entry format, what to log, and what NOT to log, use the `orchestrating-work` skill.

## Quick Reference - Entry Format

```markdown
## Step N: <Step Name>

- **Agent:** <agent-name> (or "orchestrator")
- **Inputs:** <files and skills provided>
- **Sufficient inputs check:** <passed or failed>
- **Task:** <one-line summary>
- **Output:** <file(s) created>
- **Notes:** <errors, decisions, or "none">
```

**Core principles:**
1. Create log during Setup phase
2. Append-only (never edit previous entries)
3. Log immediately after each agent invocation
4. Log facts, not opinions
