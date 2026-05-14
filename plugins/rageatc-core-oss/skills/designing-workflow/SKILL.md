---
name: designing-workflow
description: Defines the canonical six-phase workflow structure (Preparation, Planning, Research, Production, Learning, Finalisation) and provides guidance on phase selection based on task characteristics. Explains when phases are mandatory versus optional, introduces three workflow patterns (Minimal, Research-Driven, Thorough), and clarifies how to subset the workflow menu for specific tasks. Covers workflow design and structure, including phase sequence, phase optionality, and context management between phases. Use when planning workflow structure, determining which phases to include or skip, selecting workflow patterns, or understanding the six-phase workflow menu. Complements orchestrating-work skill which handles workflow execution.
---

# Designing Workflow

## Purpose

This skill defines the canonical six-phase workflow menu for rageatc-core-oss and provides guidance on phase selection based on task characteristics. All workflows subset from this menu.

**Scope:** This skill covers workflow structure (what phases exist and when to use them). For workflow execution (agent coordination, logging, validation), see `orchestrating-work` skill.

## When to Use

Use this skill when:
- Planning a multi-agent workflow
- Determining which phases to include or skip
- Understanding phase purpose and outputs
- Establishing workflow patterns for new task types

Do NOT use for:
- Agent invocation mechanics (see `orchestrating-work`)
- Orchestration logging procedures (see `orchestrating-work`)
- Work acceptance criteria (see `orchestrating-work`)
- File naming conventions (see `orchestrating-work`)

## Inputs Required

- Task description or requirements
- Task complexity assessment (simple, novel, complex)
- Any constraints on workflow duration or resources

## Outputs Produced

- Phase sequence for the task (e.g., Preparation → Planning → Production → Finalisation)
- Rationale for phase selection
- Guidance on when to include/skip optional phases

## Canonical Phase Menu

All rageatc-core-oss workflows subset from these six phases. Custom workflows select relevant phases based on task characteristics.

### Phase 1: Preparation

**Purpose:** Understand requirements, explore context, identify execution approach.

**When to include:** Always. This is the foundational phase.

**Key activities:**
- Use `ideating` skill to generate, capture, and explore ideas when the user doesn't yet have a clear task (optional, explicitly invoked)
- Use `understanding-the-ask` skill to explore user intent through structured dialogue
- Use `solutioning` skill to explore solution options when approach is unclear (optional, explicitly invoked)
- Conduct exploratory research (using subagents)
- Read initial documents referenced by user
- Clarify ambiguities and constraints

**Outputs:** Clear understanding of requirements, directional ideas on execution. Decision record if solutioning was used. Captured ideas if ideation was used.

**Notes:** This is where orchestrator builds shared understanding with user before planning execution. The full Preparation arc is: Ideate → Understand → Solution → Brief (each optional). The `ideating` skill helps when the user needs to generate or explore ideas before committing to a direction. The `understanding-the-ask` skill provides frameworks for structured questioning and readiness criteria. The `solutioning` skill helps when the problem is clear but the solution direction needs exploration.

### Phase 2: Planning ⭐ CRITICAL

**Purpose:** Create thorough execution plan for orchestrator and user.

**When to include:** Always. This is where most time should be spent with user.

**Key activities:**
- Leverage plan agent to create execution plan
- Review plan with user (iterate if needed)
- Identify decision points and dependencies
- Specify agent sequence and file paths

**Outputs:** Plan document (`work/<task-id>/plan.md`) with phase sequence, decision points, dependencies, file paths.

**Notes:** Plan is for orchestrator and user, NOT for agents (they receive instructions at invocation). If planning is done right, everything else flows smoothly.

### Phase 3: Research (Optional)

**Purpose:** Background investigation, fact-finding, evidence gathering.

**When to include:**
- Novel tasks requiring domain knowledge
- Unfamiliar problem spaces
- Factual claims requiring verification
- Decisions requiring evidence evaluation

**When to skip:**
- Routine tasks with well-understood requirements
- Time-critical work where exploration risk is acceptable
- Tasks where all necessary knowledge already exists in context

**Sub-steps:**
1. Create research brief (briefer agent, can iterate with critic)
2. Execute research (researcher/source-collector agents)
3. Fact-check research outputs (fact-checker, optional but recommended)
4. Review research quality (critic agent, iterate if needed)

**Outputs:** Research document, source index (thorough mode), fact-check report.

**Notes:** Research is the primary fact-checking checkpoint. Verify claims here to prevent error propagation to artefacts.

### Phase 4: Production

**Purpose:** Create primary deliverable through iterative refinement.

**When to include:** Always. This is the core value-creation phase.

**Sub-steps:**
1. Create artefact brief (briefer agent, can iterate with critic)
2. Produce initial version (producer agent using applicable skills)
3. Review (critic agent)
4. Iterate until satisfactory
5. Verify new claims if introduced (fact-checker, sub-step only if Production introduces new claims beyond Research)

**Outputs:** Artefact versions (v1, v2, v3...), review versions (matching artefact versions), approved final version.

**Notes:** Iteration occurs within Production through Producer-Critic cycles (sub-phase iteration). This is low-cost quality refinement, not phase-level rework.

### Phase 5: Learning (Optional)

**Purpose:** Extract system improvements from iteration patterns, identify skill gaps, propose workflow enhancements.

**When to include:**
- After significant or complex work
- When building new capabilities
- Multiple iterations occurred with interesting patterns
- Work that establishes patterns for future tasks

**When to skip:**
- One-off tasks with no future repetition
- Time-constrained work
- Trivial tasks where iteration patterns reveal nothing novel

**Key activities:**
- Learner agent analyses iteration history (all artefact and review versions)
- Identifies patterns in critique feedback
- Proposes skill improvements or workflow enhancements

**Outputs:** Learning proposals document.

**Notes:** Learning comes BEFORE Finalisation. Proposals are reviewed and approved by user before updating skills or workflows.

### Phase 6: Finalisation

**Purpose:** Deploy results, update project state, make commits.

**When to include:**
- Deliverable requires deployment to production location
- Formal handoff required
- Work must be published or released

**When to skip:**
- Internal work products that remain in work directory
- Exploratory work not requiring formal release

**Key activities:**
- Deploy results of work
- Update root-level project files (STATUS.md always; others if stale)
- Make commits (when explicitly requested by user)

**Outputs:** Deployed artefact, updated project files.

**Notes:** Always the last step. Human approval gates typically belong here (at irreversible actions like deployment or commits).

## Workflow Patterns

Three common patterns emerge from phase selection.

### Pattern 1: Minimal (Simple Tasks)

**Phases:** Preparation → Planning → Production → Finalisation

**Use when:** Requirements clear, domain familiar, low iteration expected.

**Example:** Update documentation with known changes.

### Pattern 2: Research-Driven (Novel Tasks)

**Phases:** Preparation → Planning → Research → Production → Finalisation

**Use when:** Unfamiliar domain requires investigation, evidence needed for decisions, factual claims need verification.

**Example:** Create skill for new domain requiring background research.

### Pattern 3: Thorough (Complex Work)

**Phases:** Preparation → Planning → Research → Production → Learning → Finalisation

**Use when:** High-stakes work, building new capabilities, complex work with learning opportunities.

**Example:** Create foundational skill with novel patterns requiring research and learning extraction.

## Decision Framework

Use this framework to select phases for a task.

**Step 1: Start with mandatory phases**
- Preparation (always)
- Planning (always)
- Production (always)
- Finalisation (always unless work stays in work directory)

**Step 2: Evaluate Research phase**
- Novel domain or unfamiliar concepts? → Include
- Factual claims requiring verification? → Include
- Time-critical with acceptable exploration risk? → Skip
- Well-understood routine work? → Skip

**Step 3: Evaluate Learning phase**
- Significant or complex work? → Include
- Building new capabilities for future reuse? → Include
- Multiple iterations with interesting patterns? → Include
- One-off trivial task? → Skip
- Time-constrained? → Skip

**Result:** Phase sequence (e.g., Preparation → Planning → Research → Production → Learning → Finalisation)

**Default when uncertain:** Use Research-Driven pattern (include Research, skip Learning). Research prevents costly Production rework; Learning can be added post-hoc if valuable patterns emerge.

## Design Principles

Seven principles govern effective workflow design:

1. **Canonical phase menu as SSOT** - rageatc-core-oss workflows subset from these six phases. Domain plugins (e.g., rageatc-code-oss) may define their own stage models tailored to their domain.

2. **Phase optionality** - Each phase serves distinct purpose and can be included/skipped based on task characteristics. Phases are tools, not monolithic requirements.

3. **Separation of design from execution** - Workflow structure (this skill) is separate from workflow coordination (orchestrating-work skill).

4. **Quality integration throughout** - Quality validation occurs continuously within Production (Producer-Critic cycles) rather than only at workflow endpoints.

5. **Strategic human oversight** - Position human decision gates at irreversible actions (deployment, commits) rather than routine checkpoints.

6. **Explicit context management** - Workflows must specify what state persists between phases, how context transfers at handoffs, what gets stored externally.

7. **Iteration within structure** - Distinguish sub-phase iteration (Producer-Critic cycles, low-cost refinement) from phase-level iteration (repeating phases, signals fundamental issues).

## Context Management

Workflows must specify context handling:

**What persists between phases:**
- Task requirements and constraints
- Research findings (if Phase 3 executed)
- Artefact brief (defines success criteria)
- File paths and locations

**What resets between phases:**
- Working context (compiled view shipped to agents)
- Agent-specific state (each agent starts fresh)

**Handoff protocols:**
Workflow design specifies *what* context transfers at phase boundaries. See `orchestrating-work` for *how* to log and validate handoffs during execution.

**Phase boundaries requiring explicit handoffs:**
- Research → Production: Research findings, fact-check report, research brief
- Production → Learning: All artefact versions, all review versions, iteration count
- Production → Finalisation: Approved artefact, deployment path

## Integration with Orchestrating-Work

This skill defines workflow structure; `orchestrating-work` defines execution.

**designing-workflow provides:**
- Phase definitions and purposes
- Phase selection criteria
- Workflow patterns
- Context management principles

**orchestrating-work provides:**
- Agent invocation validation
- Work acceptance criteria
- Orchestration logging procedures
- File naming and versioning rules
- Phase transition prerequisites

**Usage pattern:**
1. Use `designing-workflow` to plan phase sequence
2. Use `orchestrating-work` to coordinate agent execution within phases

## Quality Checklist

A workflow design is complete when:

- [ ] Phase selection justified based on task characteristics
- [ ] Mandatory phases included (Preparation, Planning, Production)
- [ ] Optional phases included only when they add value
- [ ] Research included for novel domains or factual verification needs
- [ ] Learning included for significant work or capability-building
- [ ] Context management strategy specified (what persists, handoff protocols)
- [ ] Phase sequence follows logical dependencies (Preparation first, Finalisation last, Learning before Finalisation)
- [ ] Workflow matches standard pattern (Minimal, Research-Driven, Thorough) or has clear rationale

## Success Indicators

Workflow design is effective when:
- Phase selection matches task complexity (no over/under-engineering)
- Context boundaries and handoff protocols clearly specified
- Human oversight positioned strategically (not as bottleneck)
- Workflow reconstructable from phase sequence alone
- Iteration occurs within Production (sub-phase) rather than requiring phase-level rework
- Learning phase extracts actionable improvements when included
