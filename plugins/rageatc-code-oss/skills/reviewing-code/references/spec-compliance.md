# Perspective: Spec Compliance

## What to Examine

- Does the code satisfy **each** acceptance criterion in the brief or enriched roadmap chunk?
- Does it stay within the specified file set? Files modified outside the declared set need justification.
- Does it do anything **beyond** what the brief requires? Scope creep is a finding.
- Are all required interfaces and contracts implemented as specified in ARCHITECTURE.md?
- Does the implementation introduce regressions in existing functionality?

## Severity Guidance

| Finding | Severity |
|---------|----------|
| Acceptance criterion not met | **Critical** |
| Files modified outside declared file set (without justification) | **Major** |
| Scope creep — functionality beyond brief | **Major** (if it introduces complexity) or **Minor** (if benign) |
| Interface contract partially implemented | **Critical** (if other chunks depend on it) or **Major** |
| Regression in existing tests | **Critical** |

## Common Traps

- **Passing tests ≠ spec compliance.** Tests may not cover all acceptance criteria. Check each criterion explicitly.
- **"Close enough" acceptance.** If the criterion says "returns 404 for missing resources" and the code returns 400, that's a finding, not a style preference.
- **Ignoring scope creep.** Extra features seem helpful but increase review surface, maintenance burden, and test requirements.
