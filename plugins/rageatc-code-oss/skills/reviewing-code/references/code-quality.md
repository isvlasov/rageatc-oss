# Perspective: Code Quality

**Load when:** Standard and Thorough tiers. Covers correctness, simplicity, readability, and test quality.

## Correctness

- Logic errors, off-by-one errors, incorrect conditions
- Unhandled edge cases (null, empty, boundary values)
- Error handling — are errors caught, reported, and recovered from appropriately?
- Race conditions or concurrency issues (if applicable)
- Resource leaks (unclosed connections, file handles, listeners)

## Simplicity

- Over-engineering — abstractions, patterns, or configurability beyond current requirements
- Dead code — unused variables, unreachable branches, commented-out code
- Unnecessary complexity — could this be simpler while meeting acceptance criteria?
- Naming — do names communicate intent clearly?

## Readability

- Control flow — can someone unfamiliar follow the logic?
- Function and method length — are units focused on a single responsibility?
- Comments — present where logic is non-obvious, absent where code is self-documenting
- Consistency — does the code follow patterns from ARCHITECTURE.md and the existing codebase?

## Test Quality

- Coverage — are the important paths tested?
- Meaningful assertions — do tests verify behaviour, not implementation details?
- Edge cases — do tests cover boundary conditions, error paths, empty inputs?
- Independence — do tests run reliably without depending on order or external state?
- Test independence from implementation — do tests describe behaviour rather than mirroring internal function names or private method structure? Tests that mirror implementation suggest testing after the fact.

## Severity Guidance

| Finding | Severity |
|---------|----------|
| Logic error producing wrong results | **Critical** |
| Unhandled error causing user-facing failure | **Major** |
| Missing test for core logic path | **Major** |
| Over-engineered pattern (works but disproportionate) | **Major** |
| Naming could be clearer | **Minor** |
| Minor duplication (2-3 lines) | **Minor** |
| Missing edge case test for non-critical path | **Minor** |
| Dead code (commented-out, unreachable) | **Minor** |
