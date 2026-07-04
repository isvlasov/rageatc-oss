# Perspective: Whole-Project Review

Reviews the **entire codebase** against the **PRD success criteria** — it answers: "Does the complete system deliver what the PRD promised?"

## What to Examine

### PRD Success Criteria

Go through each success criterion in PRD.md line by line:
- Is it demonstrably met by the implementation?
- Can you verify it by running the system or reading tests?
- If a criterion is partially met, what is missing?

### System Integration

- Do all components connect and communicate correctly end-to-end?
- Are there gaps between chunks where integration was assumed but not tested?
- Does the walking skeleton still work with all chunks merged?

### Consistency

- Are patterns consistent across the codebase? (Same error handling, same response format, same naming conventions)
- Are there conflicting approaches introduced by different chunks?

### Completeness

- Are all PRD user stories implemented?
- Are MoSCoW "Must Have" items all present?
- Are "Won't Have" items genuinely absent (no scope creep)?

## Severity Guidance

| Finding | Severity |
|---------|----------|
| PRD success criterion not met | **Critical** |
| Integration gap between components | **Critical** |
| "Must Have" feature missing or incomplete | **Critical** |
| Inconsistent patterns across codebase | **Major** |
| "Won't Have" item partially implemented (scope creep) | **Major** |
| Minor gap in non-critical user story | **Minor** |

## Output Differences

Unlike per-chunk reviews, the whole-project review summarises overall system health, not just findings, and explicitly states which PRD success criteria pass and which don't.

## Key Principle

This is the last gate before the project is considered done. Be thorough but fair — if the system delivers what the PRD defined, accept it even if you'd design parts differently.
