---
name: writing-skills
description: Creates and updates Claude Code Agent Skills. Use when creating a skill, revising SKILL.md, improving a skill's name or description, or adding progressive disclosure files.
---

# Writing Skills

## Purpose

Create or update high-quality Claude Code Agent Skills that Claude can reliably discover and use, and that remain maintainable as your library grows.

This Skill governs:
- Creating a new Skill package (folder + SKILL.md + optional files)
- Updating an existing Skill package without bloating it
- Ensuring each Skill is discoverable via a strong description
- Keeping Skills concise, structured, and testable

## Operating Principles

- **Treat the context window as a shared resource**: Every token in a Skill competes with conversation history, other Skills, and the user's request. Before adding content, ask: "Does Claude already know this?" and "Does this paragraph justify its token cost?" Prefer concise examples over verbose explanations.
- **Prefer one clear default** over many options; add escape hatch only when truly needed
- **Treat SKILL.md as an overview**: Put details in supporting files when they get long
- **Make the Skill verifiable**: Define success cases and test them

## Required Knowledge About How Skills Work

- Skills are model-invoked. Claude decides when to apply them based largely on the `description` field
- At startup, Claude loads only each Skill's name and description
- Claude reads SKILL.md only when the Skill is relevant
- Keep this in mind when writing names, descriptions, and the amount of content in SKILL.md

## Inputs to Gather (Only If Missing)

When asked to create or update a Skill, collect these inputs. If any are missing, ask targeted questions.

1. **Skill intent**: One-sentence purpose ("This Skill helps Claude do X")
2. **User trigger phrases**: 5 to 15 phrases a user might naturally say that should activate the Skill
   - Examples: "write a Skill", "create SKILL.md", "improve this Skill description", "standardise my Skill library"
3. **Scope and location**: Default to personal Skills in `~/.claude/skills/` unless the user explicitly wants project scope in `.claude/skills/`
4. **Tool boundaries**: Should the Skill be read-only, or allowed to write/edit files? Is Bash allowed for scaffolding?
5. **Success criteria**: At least 3 evaluation scenarios (small, concrete tasks) that the Skill should handle well

## Outputs to Produce

For each Skill request, produce:

1. **Skill folder skeleton**: `~/.claude/skills/<skill-name>/` or `.claude/skills/<skill-name>/`
2. **Complete SKILL.md** including:
   - YAML frontmatter: `name`, `description` (required)
   - Clear instructions in Markdown
3. **Optional supporting files** if needed:
   - `references/*.md` for deeper guidance
   - `assets/*.md` for strict output formats (templates)
   - `examples.md` for worked examples
   - `scripts/*.py` for deterministic validation or transformation (optional)
4. **Short change note** (for versioning):
   - "What changed"
   - "Why"
   - "How to test"

## Step-by-Step Workflow

### Step 0: Decide Whether to Create or Update

**If the user provides an existing Skill:**
- Read the current SKILL.md first
- Identify where it fails in real usage (not imagined usage)
- Prefer small edits that increase discoverability and reduce ambiguity

**If no existing Skill exists:**
- Create a minimal v1 that passes the evaluation scenarios
- Add supporting files only when the body approaches length limits or becomes hard to navigate

### Step 1: Choose the Skill Name

Follow these rules:
- Use lowercase letters, numbers, and hyphens only
- Keep under 64 characters
- Prefer consistent naming. Gerund form (verb + "-ing") is usually best
- Avoid vague names like "helper", "utils", "tools"

**Output:**
- Proposed `name`
- 2 to 3 alternative names if needed, but always recommend one default

### Step 2: Write a Discoverable Description

The `description` field drives discovery, so write it carefully.

**Rules:**
- Write in third person
- Include both what the Skill does AND when to use it (trigger contexts and keywords)
- Include key terms users will say (from the trigger phrase list)
- Be specific. Avoid generic descriptions like "helps with documents"
- Stay under 1024 characters total
- Avoid `colon-space` (`: `) inside the description text — YAML parsers can misinterpret it as a key-value separator, breaking skill discovery. Use em-dashes (—) or rephrase instead
- If the Skill could plausibly over-trigger, add explicit exclusions ("Do NOT use for X")

**Output:**
- A final proposed `description` that includes clear triggers

### Step 3: Set the Right Degree of Freedom

Match the instruction strictness to task fragility:
- **High freedom**: Heuristics and judgement calls are acceptable
- **Medium freedom**: Preferred pattern with some parameters
- **Low freedom**: Fragile sequence, exact steps, strong guardrails

Choose one default level for the Skill and state it explicitly in the instructions.

### Step 4: Write the SKILL.md Body

Keep SKILL.md as the "how to apply this Skill" guide.

Write all instructions in imperative form ("Run the script", "Check the output") rather than descriptive form ("The script should be run").

Use this structure as a default (adapt as needed):

1. **Purpose** (1 to 3 sentences)
2. **Scope and constraints** (what this Skill covers and does not cover)
3. **Inputs required** (what the user must provide)
4. **Outputs produced** (what files or sections will be created)
5. **Workflow** (clear, sequential steps)
6. **Templates** (only if format must be consistent)
7. **Examples** (at least 1 good example)
8. **Edge cases and constraints**
9. **Testing and iteration** (evaluation scenarios)

Write steps as checklists when the workflow is complex so Claude can copy and tick them off.

### Step 5: Apply Progressive Disclosure When Content Grows

If SKILL.md gets long or dense:
- Split details into supporting files
- Keep references one level deep. Link directly from SKILL.md to the file the model should read
- If a supporting file is long, add a table of contents and clear section headings

Use forward slashes in all paths.

**Recommended multi-file structure:**
- `SKILL.md` (overview and workflow)
- `references/` (deep standards)
- `assets/` or `templates/` (output formats)
- `scripts/` (validators or deterministic transforms)

### Step 6: Add a Feedback Loop (Quality Improvement)

Embed a repeatable loop inside the Skill instructions.

**Default loop:**
- Produce artefact draft
- Validate against rubric or checklist
- Fix gaps
- Re-validate
- Repeat until pass criteria met

If you include scripts, prefer:
- Run validator script → fix errors → repeat

### Step 7: Define Evaluation Scenarios Before Expanding

Use evaluation-driven development:

1. Identify gaps: run without the Skill and record failures
2. Create 3 evaluation scenarios that test those gaps
3. Establish a baseline (without the Skill)
4. Write minimal instructions that address the gaps
5. Iterate based on evaluation results

Aim for measurable outcomes where possible: "triggers without explicit invocation", "completes without user correction", or reduced tool-call count versus baseline. Quantitative baselines make it easier to judge whether a revision actually helped.

If the Skill will be used across different model tiers, test with each. What works for Opus may need more explicit detail for Haiku.

In SKILL.md, include the evaluation scenarios explicitly so they can be re-run.

### Step 8: Optional Guardrails

If the workflow is security-sensitive or should be read-only:
- Add `allowed-tools` in the frontmatter to restrict tools
- Otherwise, omit `allowed-tools` and rely on normal tool permission prompts

Only add restrictions when they serve a clear purpose.

## Quality Checklist (Use Before Finalizing Any Skill)

A Skill is ready when:

- [ ] Name follows rules and is consistent with your library
- [ ] Description is specific, third person, and contains obvious trigger keywords
- [ ] SKILL.md is concise and structured
- [ ] The workflow is step-by-step and easy to follow
- [ ] Supporting files exist only when useful
- [ ] References are not deeply nested
- [ ] At least 3 evaluation scenarios exist and are realistic
- [ ] There is a clear default approach (not many competing options)
- [ ] No concept is stated in more than one section (avoid inline + standalone duplication)
- [ ] No time-sensitive guidance unless isolated in an "Old patterns" section
- [ ] Consistent terminology throughout (one term per concept, no synonyms)

## Update Discipline (For Ongoing Improvement)

When updating an existing Skill:

- Make the smallest change that fixes the observed failure
- Prefer tightening descriptions and adding missing triggers over adding lots of content
- Record a short change note and how to test

After deployment, observe how Claude uses the Skill. Watch for: files it never reads (may be unnecessary), sections it re-reads (may belong in SKILL.md), and reference chains it fails to follow (may be too deep). These usage patterns reveal structural problems that static review misses.

If a new pattern applies broadly, prefer updating the shared Skill rather than creating many near-duplicates.

## Skill Naming Rules Reference

- **Format**: `lowercase-with-hyphens`
- **Length**: Maximum 64 characters
- **Style**: Prefer gerund form (e.g., `writing-skills`, `reviewing-code`, `generating-commits`)
- **Avoid**: Generic terms like "helper", "utils", "tools", "manager"

## YAML Frontmatter Format

**Required fields:**
```yaml
---
name: skill-name
description: What this Skill does and when to use it
---
```

**Optional fields:**
```yaml
---
name: skill-name
description: What this Skill does and when to use it
allowed-tools: Read, Grep, Glob
model: claude-sonnet-4-20250514
context: fork
compatibility: Requires Python 3.10+ and poppler-utils
metadata:
  author: Team Name
  version: 1.0.0
---
```

**Security restrictions:** Do not use XML angle brackets (`<` `>`) in any frontmatter field — frontmatter appears in the system prompt and angle brackets can cause parsing issues. Skill names must not contain "claude" or "anthropic" (reserved terms).

## File Structure Examples

**Single-file Skill (recommended for most Skills):**
```
my-skill/
└── SKILL.md
```

**Multi-file Skill (for complex Skills with lots of reference material):**
```
my-skill/
├── SKILL.md                 # Overview and workflow
├── references/              # Detailed documentation
│   ├── api-reference.md
│   └── standards.md
├── assets/                  # Output templates
│   └── template.md
├── examples.md              # Worked examples
└── scripts/                 # Validators/transforms
    └── validate.py
```

## Bundled Resource Reasoning

When adding files to a Skill folder, choose the right type based on how Claude will use each resource.

**`scripts/`** — Include when the same code would be rewritten on every invocation, or when deterministic reliability matters. Scripts can be executed without loading into context: only their output consumes tokens. State clearly whether Claude should execute the script or read it as reference.

**`references/`** — Documentation Claude consults while working (schemas, API docs, standards). Loaded into context on demand. For files longer than roughly 10 000 words, include grep patterns in SKILL.md so Claude can extract only what it needs. Information lives in SKILL.md or references — not both.

**`assets/`** — Files used in output (templates, images, boilerplate). Never loaded into context; used directly in output. Zero context cost.

**Core principle:** Information lives in one place. Duplication across sections or files inflates token cost and creates drift.

## Evaluation Scenarios

Test this Skill with these scenarios:

1. **Create new skill from scratch**: User says "create a skill for reviewing pull requests"
   - Expected: Skill asks for intent, triggers, scope, and produces complete SKILL.md with proper frontmatter

2. **Update existing skill**: User provides a skill with poor description and asks to improve it
   - Expected: Skill reads existing file, improves description with trigger keywords, maintains existing structure

3. **Standardise skill library**: User asks to review and standardize naming across multiple skills
   - Expected: Skill reviews naming conventions, suggests improvements following gerund form, ensures consistency

## Common Pitfalls to Avoid

- **Over-engineering**: Don't add features the user hasn't requested
- **Vague descriptions**: Ensure triggers are explicit and discoverable
- **Deep nesting**: Keep references one level deep from SKILL.md
- **Bloated main file**: Move details to supporting files when SKILL.md exceeds ~400 lines
- **Missing evaluation**: Always define success criteria before expanding the Skill
- **Generic names**: Avoid "helper", "utils", "tools" in skill names
- **Extraneous files**: Do not create README.md, CHANGELOG.md, or similar files inside the skill folder. All documentation goes in SKILL.md or `references/`
