---
name: orchestrating-work
description: Principles for multi-agent workflow execution. Use when coordinating agents, accepting or rejecting agent work, executing producer-critic-learner cycles, or running any multi-phase orchestrated task.
---

# Orchestrating Work

Execution principles for multi-agent workflows: input validation, work acceptance, file organisation, and phase transitions. Workflow structure (which phases to run) lives in `designing-workflow`.

## 1. Validate Inputs Before Invocation

Agents need complete context to work independently — every missing input costs a clarification round-trip.

Universal requirements for ALL agents (read `agents/<agent-name>.md` for agent-specific ones):

- Absolute path to `work/<task-id>/` directory
- Absolute output path for the deliverable
- All dynamic skills provided as file paths or inline content, never just names. Preloaded skills (listed in the agent's `skills` frontmatter) are injected automatically.
- All agent-specific required inputs present
- All paths absolute (no `./` or `../`)

Before invoking: check universal requirements, read the agent's file for specific ones, then wait for the agent to echo its inputs.

If validation fails: STOP, identify and provide the missing inputs, re-validate before re-invoking. If the agent does not echo inputs: STOP — silence indicates malformed or truncated instructions; verify and re-invoke.

## 2. Accept or Reject Work Deliberately

Rejecting work during review costs one iteration cycle; accepting substandard work costs post-deployment rollback and rework.

Universal criteria for all artefacts:

- [ ] Output file exists at declared path; not empty or truncated
- [ ] Basic structure present; assigned task addressed completely, not partially or tangentially
- [ ] No TODO markers or placeholders (unless explicitly planned for next iteration)
- [ ] Brief requirements addressed (cross-reference the brief checklist if one exists)

Then apply artefact-type standards from the governing skill:

| Artefact type | Reference skill |
|---------------|-----------------|
| Skills (SKILL.md) | writing-skills |
| Research outputs | conducting-research |
| Reviews (critic outputs) | assessing-quality |
| Briefs | creating-briefs |

Base the decision on the checklists, not impressions. On rejection: give the agent clear, actionable guidance on the specific issues plus the path to the previous version, re-invoke, and do NOT advance to the next phase until work is accepted.

## 3. Organise Files Systematically

Consistent naming lets a workflow be reconstructed from its artefacts alone: `artefact_v1 → review_v1 → artefact_v2 → review_v2` is the iteration history.

**Task ID:** `{type}-{subject}` (e.g. `skill-api-documentation`, `report-q4-summary`) — lowercase letters, numbers, hyphens; under 64 characters; specific enough to distinguish from similar tasks.

**Work directory:**

```
work/<task-id>/
├── brief.md
├── research_brief.md (optional)
├── source_index.md (optional)
├── sources/ (optional)
├── research_v1.md (optional)
├── artefact_v1.md
├── artefact_v2.md
├── review_v1.md
├── review_v2.md
└── learning_proposals.md
```

**File naming:**

| File type | Format |
|-----------|--------|
| Artefacts | `artefact_v{N}.{ext}` |
| Artefact reviews | `review_v{N}.md` (version matches artefact) |
| Research | `research_v{N}.md` |
| Research reviews | `review_research_v{N}.md` |
| Briefs | `brief.md` / `research_brief.md` |
| Source index | `source_index.md` |
| Learning proposals | `learning_proposals.md` |

**Versioning:** start at v1; sequential integers, no gaps, no decimals; never overwrite — create a new version instead. Each artefact version gets a matching review version. New version = new review cycle (after critic feedback or a significant requirement change) — not for typo fixes or internal refinement before first review.

## 4. Verify Phase Prerequisites Before Transitions

Advancing without completing prerequisites bakes wrong assumptions into downstream work.

- [ ] Current phase deliverables complete and accepted (per work acceptance criteria)
- [ ] Next phase inputs identified and available
- [ ] User approval obtained where required (e.g. deployment approval before Finalisation)

Common sequence: Setup → Research (optional) → Production (iterate until approved) → Learning (optional) → Finalisation.
