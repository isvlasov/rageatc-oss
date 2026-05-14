---
name: plan
description: Plan the orchestration approach for a task
disable-model-invocation: true
---

# Plan Orchestration

Create an orchestration plan for the current task. Use the `designing-workflow` skill to select appropriate phases.

## Before Writing the Plan

1. **Confirm task-id** with the user (or propose one)
2. **Create workspace:** `work/<task-id>/`
3. **Create orchestration log:** `work/<task-id>/ORCHESTRATION-LOG.md`

## Plan Checklist

Every plan must include:

- [ ] **Full absolute paths** for all file inputs and outputs (no relative paths)
- [ ] **Agent sequence** with the specific skills each agent needs
- [ ] **Agent inputs** listed explicitly per step (files, skill content, context)
- [ ] **Decision points** with clear branching conditions
- [ ] **Dependencies** between steps
- [ ] **To-do list** created via TaskCreate to track plan execution

## Plan Must NOT Include

- Content recommendations (what the artefact should say)
- Quality criteria (skills define these)
- Procedural steps within agents (agents own their process)

## Plan Template

```markdown
# Plan: <task-id>

## Phases
1. [Phase]: [agents] -> [outputs]
2. [Phase]: [agents] -> [outputs]

## Decision Points
- After [step]: [condition] -> [branch A] OR [branch B]

## Dependencies
- [step N] requires [step M] outputs
```

## Output

1. Save the approved plan to `work/<task-id>/plan.md`
2. Create to-do items matching the plan steps
3. Present plan summary to user for approval
