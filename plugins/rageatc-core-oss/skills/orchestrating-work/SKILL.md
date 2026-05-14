---
name: orchestrating-work
description: Principles for effective multi-agent workflow execution and coordination. Covers input validation (universal and agent-specific requirements), work acceptance criteria and quality gates, file organisation conventions (versioning with v1/v2/v3, task directory structure), orchestration logging format and audit trails, and phase transition prerequisites. Use when coordinating agents in multi-agent workflows, validating agent inputs before invocation, accepting or rejecting agent work, organising task directories and naming files, creating or updating ORCHESTRATION-LOG.md entries, checking phase prerequisites before transitions, or executing producer-critic-learner cycles, research workflows, or any multi-phase orchestrated task.
---

# Orchestrating Work

## Purpose

Effective orchestration enables agents to work independently with minimal clarification loops, produces auditable workflows, and prevents premature phase transitions that cause rework. This skill articulates principles for agent coordination, input validation, work acceptance, file organisation, and orchestration logging.

## When to Use

Use this skill when:
- Coordinating multi-agent workflows (producer-critic-learner, research, deployment)
- Validating inputs before agent invocation
- Evaluating agent output for acceptance
- Organising work directories and files
- Determining if phase prerequisites are met
- Creating or maintaining orchestration audit trails

Do NOT use for:
- Single-agent tasks that don't require orchestration
- Content creation (use producer-agent)
- Quality assessment (use critic-agent)

## Core Principles

### 1. Complete Context Prevents Clarification Loops

**Principle:** Agents require complete context to work independently. Incomplete inputs trigger clarification requests, wasting orchestration cycles and fragmenting the audit trail.

**Why it matters:** Every missing input requires an additional round-trip (orchestrator invocation → agent clarification → orchestrator response → agent re-start). Three missing inputs can turn a single-step invocation into four steps, quadrupling the orchestration overhead.

**Indicators of complete context:**

Read each agent's file at `agents/<agent-name>.md` for specific requirements. Universal requirements apply to ALL agents:
- Absolute path to `work/<task-id>/` directory provided
- Absolute output path for deliverable specified
- All dynamic skills provided (as file paths or inline content, never just names). Agents with preloaded skills (via `skills` frontmatter) already have their core skill in context.
- All agent-specific required inputs present (documented in agent's file)
- All paths are absolute (no relative paths like `./` or `../`)

**Validation approach:**

Before invoking any agent:
- [ ] Check universal requirements first
- [ ] Read agent's file to identify agent-specific requirements
- [ ] Verify all paths are absolute
- [ ] Ensure dynamic skills are provided as content or paths, not just names (e.g., `skills/writing-skills/SKILL.md` or inline content, not "writing-skills"). Preloaded skills (listed in agent's `skills` frontmatter) are injected automatically.
- [ ] Log validation check in `ORCHESTRATION-LOG.md` with "passed" or "failed" status
- [ ] Wait for agent to echo inputs before confirming receipt

**If validation fails:**
- STOP the invocation immediately
- Identify specific missing inputs
- Log the failure with details of what's missing
- Provide missing inputs before proceeding
- Re-validate before re-invoking

**If agent does not echo inputs:**
- STOP immediately (silence indicates malformed or truncated instructions)
- Verify inputs were received correctly
- Check for formatting issues or truncation
- Re-invoke with corrected inputs if necessary

### 2. Work Acceptance Prevents Premature Phase Transitions

**Principle:** Accepting incomplete or substandard work creates downstream problems that are costlier to fix than rejecting and clarifying upfront. Premature phase transitions are the primary cause of deployment-stage rework.

**Why it matters:** Deploying an artefact with unresolved issues discovered post-deployment wastes effort on rollback, correction, and re-deployment. Rejecting work during review costs only an iteration cycle within the same phase.

**Indicators of acceptable work:**

**Universal criteria (all artefacts):**
- [ ] Output file exists at declared path
- [ ] File is not empty (no zero-byte or truncated files)
- [ ] Basic structure present (headings, sections, logical flow)
- [ ] Agent addressed the assigned task completely (not partial, tangential, or off-topic)
- [ ] No TODO markers or placeholders remain (unless explicitly planned for next iteration)
- [ ] Brief requirements addressed (cross-reference brief checklist if brief exists)

**Artefact-type-specific criteria:**

Different artefact types have different quality standards. Reference the governing skill for type-specific validation:

| Artefact Type | Reference Skill | Location |
|---------------|-----------------|----------|
| Skills (SKILL.md) | writing-skills | `skills/writing-skills/SKILL.md` |
| Research outputs | conducting-research | `skills/conducting-research/SKILL.md` |
| Reviews (critic outputs) | assessing-quality | `skills/assessing-quality/SKILL.md` |
| Briefs | creating-briefs | `skills/creating-briefs/SKILL.md` |

**Quality gate:**
- [ ] Completeness: All sections from brief or scope present
- [ ] Clarity: Language is clear, unambiguous, actionable
- [ ] Consistency: Terminology and style consistent throughout
- [ ] Standards adherence: Artefact meets applicable skill standards

**Acceptance protocol:**

When receiving output from an agent:
- Apply universal criteria first
- Apply artefact-type-specific criteria second
- Log acceptance or rejection in `ORCHESTRATION-LOG.md` with specific rationale (not "looks good" - cite checklist items)

**If work is rejected:**
- Document specific issues in log (e.g., "Missing 'Success Indicators' section required by brief line 15")
- Provide agent with clear, actionable guidance on what to change
- Include path to previous version if applicable
- Re-invoke agent with clarifications
- Do NOT proceed to next phase until work is accepted

### 3. Systematic File Organisation Enables Workflow Reconstruction

**Principle:** Consistent file naming and directory structure allow workflows to be reconstructed from artefacts alone. Adhoc organisation obscures the sequence of events and complicates audit trails.

**Why it matters:** When a user asks "Why did we need three versions?", the orchestrator should be able to point to `artefact_v1.md`, `review_v1.md`, `artefact_v2.md`, `review_v2.md`, `artefact_v3.md`, `review_v3.md` with clear file sequence indicating iteration history. Without systematic organisation, this audit trail is lost.

**Task ID Format:**

**Pattern:** `{type}-{subject}` (e.g., `skill-api-documentation`, `report-q4-summary`)

**Rules:**
- Lowercase letters, numbers, and hyphens only
- Under 64 characters
- Specific enough to distinguish from similar tasks

**Work Directory Structure:**

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
├── ORCHESTRATION-LOG.md
└── learning_proposals.md
```

**File Naming Conventions:**

| File Type | Format | Notes |
|-----------|--------|-------|
| Artefacts | `artefact_v{N}.{ext}` | v1, v2, v3... with appropriate extension |
| Artefact reviews | `review_v{N}.md` | Version matches artefact; always Markdown |
| Research reviews | `review_research_v{N}.md` | Version matches research |
| Research | `research_v{N}.md` | Optional; only when research conducted |
| Brief | `brief.md` | Artefact production brief |
| Research brief | `research_brief.md` | Optional; defines research scope |
| Source index | `source_index.md` | Optional; source catalogue with metadata |
| Learning proposals | `learning_proposals.md` | System improvement proposals |
| Orchestration log | `ORCHESTRATION-LOG.md` | Step-by-step workflow record |

**Versioning Rules:**

1. **Start at v1** - Never use v0
2. **Sequential only** - No gaps (v1 → v2 → v3, not v1 → v3)
3. **One-to-one** - Each artefact version has a matching review version
4. **Integers only** - No decimals (v1, v2, not v1.1, v1.2)
5. **No overwrites** - Create new version instead of modifying existing

**When to Increment Version:**

Create new version when:
- Producer addresses critic feedback
- Requirements change significantly
- Approach changes fundamentally

Do NOT create new version for:
- Typo fixes before first review
- Minor formatting adjustments
- Internal refinement before first review

**Rule of thumb:** New version = new review cycle

### 4. Orchestration Logs Provide Auditable Decision History

**Principle:** Orchestration logs capture the sequence of agent invocations, work acceptance decisions, and phase transitions. Without logs, workflows cannot be reconstructed, errors cannot be diagnosed, and learning cannot be extracted.

**Why it matters:** When an artefact requires unexpected iterations, the log documents what changed between versions and why. When an agent clarification loop occurs, the log reveals whether inputs were incomplete or instructions were malformed. Logs enable post-mortem learning and continuous improvement.

**Log location:** `work/<task-id>/ORCHESTRATION-LOG.md`

**Logging principles:**

1. **Create log during Setup phase** (first step of workflow)
2. **Append-only** (never edit previous entries to preserve history)
3. **Log immediately** after each agent invocation or key decision (not in batches at end)
4. **Log facts, not opinions** (e.g., "artefact passes work acceptance checklist", not "artefact looks good")

**Entry Format:**

```markdown
## Step N: <Step Name>

- **Agent:** <agent-name> (or "orchestrator")
- **Inputs:** <files and skills provided>
- **Sufficient inputs check:** <passed or failed>
- **Task:** <one-line summary>
- **Output:** <file(s) created>
- **Notes:** <errors, decisions, or "none">
```

**What to Log:**

- Agent invocations (with validation result and input echo confirmation)
- Work acceptance or rejection decisions (with specific reasons referencing checklist criteria)
- Phase transitions (with prerequisites met and decision rationale)
- Errors or blockers encountered (with resolution or escalation)
- User approvals or feedback (timestamp and content)

**What NOT to Log:**

- Opinions or subjective assessments (use checklist-based rationale instead)
- Detailed content summaries (reference files, don't duplicate content)
- Redundant information already captured in agent outputs
- Process descriptions (log actions taken, not how orchestration works)

### 5. Phase Prerequisites Prevent Rework

**Principle:** Each workflow phase produces deliverables that serve as prerequisites for the next phase. Advancing without completing prerequisites causes downstream errors that require expensive rollback and re-execution.

**Why it matters:** Starting Production without completing Research means assumptions baked into artefacts may be incorrect, requiring artefact rework after research is completed. Moving to Finalisation before Production iterations complete means deploying substandard work that requires rollback and re-deployment.

**Indicators of phase readiness:**

- [ ] Current phase deliverables complete and accepted (per work acceptance criteria)
- [ ] All agent outputs logged in `ORCHESTRATION-LOG.md`
- [ ] Next phase inputs identified and available
- [ ] Prerequisites for target phase met (e.g., research approved before starting production)
- [ ] User approval obtained if required (e.g., deployment approval before Finalisation)
- [ ] Phase transition logged in `ORCHESTRATION-LOG.md` with rationale

**Common phase sequence:** Setup → Research (optional) → Production (iterate until approved) → Verification (rarely needed) → Finalisation → Learning (optional)

## Success Indicators

Orchestration is effective when:
- All agent invocations pass input validation on first attempt (no missing inputs)
- Work acceptance decisions documented with specific, checklist-based rationale
- Phase transitions occur only after prerequisites met (no premature advancement)
- Orchestration log provides complete audit trail (workflow reconstructable from log alone)
- Agents execute independently without follow-up clarification requests
- User intervention required only for approval decisions, not correcting orchestrator errors

## Evaluation Scenarios

### Scenario 1: Good orchestration (complete pre-invocation validation)
- Orchestrator prepares to invoke producer-agent
- Validates universal requirements: work directory `/Users/.../work/skill-api-docs/`, output path `/Users/.../work/skill-api-docs/artefact_v1.md`, skills provided as inline content
- Reads `agents/producer-agent.md` to identify agent-specific requirements
- Validates agent-specific inputs: brief path provided, artefact-type skill content included (note: agent's core skill is preloaded via frontmatter and does not need manual provision)
- Confirms all paths absolute (checked), skills as content not names
- Logs validation check with "passed" status in ORCHESTRATION-LOG.md
- Invokes producer-agent
- Producer-agent echoes inputs and confirms receipt
- Orchestrator confirms receipt and allows agent to proceed

**Why this works:** Complete input validation upfront eliminates clarification loops. Agent receives sufficient context to execute independently.

### Scenario 2: Problematic orchestration (missing universal requirements)
- Orchestrator invokes critic-agent
- Provides artefact path and brief path but forgets work directory path
- Agent requests missing input
- Orchestrator provides work directory path but logs validation as "passed" (incorrect)
- No audit trail of the error for future learning

**Issue:** Universal requirements not checked first; validation check logged incorrectly despite failure. This obscures the error and prevents learning extraction.

### Scenario 3: Problematic orchestration (premature phase transition)
- Orchestrator coordinates producer-critic cycle
- Critic-agent reviews artefact v1, recommends ITERATE with 3 high-priority issues
- Orchestrator moves from Production to Finalisation without creating v2
- Artefact deployed with unresolved issues
- User discovers problems post-deployment
- Rollback and re-deployment required

**Issue:** Phase prerequisites not verified. Critic recommendation ignored. Moving to Finalisation requires Production approval, which was not obtained. Cost of fixing issue post-deployment far exceeds cost of one iteration cycle.

### Scenario 4: Good orchestration (work rejection with clear rationale)
- Producer-agent delivers artefact v1
- Orchestrator applies work acceptance checklist
- Universal criteria pass (file exists, not empty, structure present)
- Artefact-type criteria evaluated against writing-skills standards
- Identifies: "Required section 'Success Indicators' missing (brief requirement line 15)"
- Logs rejection in ORCHESTRATION-LOG.md: "Rejected v1: missing Success Indicators section (brief line 15, writing-skills requirement)"
- Re-invokes producer-agent with clarification and v1 path for reference
- Does not proceed until v2 accepted

**Why this works:** Work acceptance applied rigorously. Rejection documented with specific, actionable rationale. Agent receives clear guidance for iteration.

### Scenario 5: Problematic orchestration (incomplete logging)
- Orchestrator coordinates 3-iteration producer-critic cycle (v1 → v2 → v3)
- Logs only final step for v3 acceptance
- User later asks: "Why did we need 3 versions?"
- No audit trail of what changed between versions or why iterations occurred
- Learning cannot be extracted

**Issue:** Failed to log each agent invocation and work acceptance decision. Workflow cannot be reconstructed. History lost.

### Scenario 6: Good orchestration (phase transition with prerequisites)
- Orchestrator completes Research phase (research document delivered and fact-checked)
- Prepares to transition to Production phase
- Verifies phase readiness:
  - [x] Research complete and accepted (fact-check passed, no claims rejected)
  - [x] Research logged in ORCHESTRATION-LOG.md
  - [x] Production inputs identified: research path, artefact brief
  - [x] Prerequisites met: research approved by orchestrator
- Logs phase transition: "Research → Production: research approved (fact-check passed), proceeding to artefact brief creation"
- Proceeds with briefer-agent invocation for artefact brief

**Why this works:** Phase prerequisites verified before transition. Decision logged with rationale. Downstream agents receive approved research as input.

### Scenario 7: Problematic orchestration (artefact-type checks skipped)
- Producer-agent delivers Skill SKILL.md v1
- Orchestrator applies only universal checks (file exists, not empty, structure present)
- Skips artefact-type-specific checks (YAML frontmatter, required sections, evaluation scenarios per writing-skills)
- Accepts artefact despite missing evaluation scenarios (required by writing-skills standard)
- Critic-agent later identifies missing scenarios as high-priority issue
- Iteration required that could have been caught earlier

**Issue:** Work acceptance checklist partially applied. Artefact-type checks critical for catching standards violations early. Skipping them defers quality issues to critic phase, wasting a cycle.
