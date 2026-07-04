# What's inside

A closer look at what rageatc-oss does and how to use it.

## A few examples of how I use it

- Understand what the problem really is
- Structure problems and identify true root causes
- Conduct deep research or collect sources for your work
- Find the right solution to your problem
- Execute in a structured, controllable way
- Build tools that are genuinely useful (I'm sure you can build complex ones too)
- Improve the system itself
- Produce other artefacts: presentations, written documents, websites, and more

You can and absolutely should use it your way.

## The full menu

The diagrams below show an example of a workflow `rageatc-core-oss` and `rageatc-code-oss` can do. In practice most work uses only select stages.

### rageatc-core-oss

```
ideating                  ┐
 │                        │
 ▼                        │
understanding-the-ask     ├─  shaping
 │                        │   (orchestrator-led,
 ▼                        │    dialogue with you)
solutioning               ┘
 │
 ▼
briefing       ─────►  critic        (review brief)
 │
 ▼
researching    ─────►  fact-checker  (verify claims)
 │
 ▼
producing      ◄════►  critic        (iterate until accept)
 │
 ▼
learning       ─────►  critic        (review proposals)
```

### rageatc-code-oss (Thorough mode)

```
shaping                    ┐    (← rageatc-core-oss entry,
 │                         │       when direction is unclear)
 ▼                         │
managing-product           │
 │                         │
 ▼                         ├─  planning
architecting-software      │   (orchestrator-led,
 │                         │    you approve every artefact)
 ▼                         │
designing-interfaces       │   (only if UI exists)
 │                         │
 ▼                         │
decomposing-work           │
 │                         │
 ▼                         │
enriching-roadmap          │
 │                         │
 ▼                         │
planning-software          ┘
 │
 ▼
building            ◄════►  reviewer    (iterate per chunk)
 │
 ▼
completion-review   ─────►  reviewer  +  user-emulation
 │
 ▼
learning            ─────►  critic     (review proposals)
```

Each planning step produces an artefact (PRD, architecture, design system, roadmap, plan) that you approve before the next stage runs.

## Skills and agents

A one-liner per skill and per agent, grouped by plugin. Each name links to its source file.

Conventions:

- `/name` - you type this as a slash command.
- `name` - loads automatically when the situation matches, or can be loaded by you directly if you know that's needed. Agents get spawned by orchestration skills, not by you directly. Some skills are pre-loaded to agents by default to ensure they behave.

### rageatc-core-oss

Skills you invoke yourself:

- [`/eli40`](plugins/rageatc-core-oss/skills/eli40/SKILL.md) - when you want something explained in simpler terms, but not like to a five-year-old. Re-explains the previous message, or use `/eli40 <topic>` for something new.
- [`/critic`](plugins/rageatc-core-oss/skills/critic/SKILL.md) - when you want the latest produced artefact reviewed against the brief and standards.
- [`/roast`](plugins/rageatc-core-oss/skills/roast/SKILL.md) - when you want your reasoning challenged. Sharp, direct, constructive. Use `/roast` to target the last proposal, or `/roast <claim>` for something specific.
- [`/prime`](plugins/rageatc-core-oss/skills/prime/SKILL.md) - at the start of a session, to orient Claude by reading CLAUDE.md and STATUS.md before doing anything else.
- [`/handover`](plugins/rageatc-core-oss/skills/handover/SKILL.md) - to update STATUS.md and the other root files so the next session can resume cleanly.
- [`/learn`](plugins/rageatc-core-oss/skills/learn/SKILL.md) - to capture an in-session observation to LEARNINGS.md. Use `/learn` to let Claude propose an entry, or `/learn <note>` to dictate.
- [`/codify`](plugins/rageatc-core-oss/skills/codify/SKILL.md) - to sweep LEARNINGS.md and turn accumulated entries into skill, rule, or documentation changes. Run when you're ready to process the inbox.
- [`/finalise-session`](plugins/rageatc-core-oss/skills/finalise-session/SKILL.md) - at the end of a session: runs `/handover`, then does a basic clean-up, commits and pushes.

Skills that load when relevant:

- [`ideating`](plugins/rageatc-core-oss/skills/ideating/SKILL.md) - when you want to brainstorm, capture loose thoughts, or explore a problem space before committing.
- [`understanding-the-ask`](plugins/rageatc-core-oss/skills/understanding-the-ask/SKILL.md) - when you want to understand what are you solving for. Pulls intent through structured dialogue. My most used skill.
- [`solutioning`](plugins/rageatc-core-oss/skills/solutioning/SKILL.md) - when the problem is clear but the approach isn't. Helps you choose between options.
- [`shaping`](plugins/rageatc-core-oss/skills/shaping/SKILL.md) - the umbrella skill that takes a raw idea through ideating, understanding, and solutioning, ending with a concept document.
- [`creating-briefs`](plugins/rageatc-core-oss/skills/creating-briefs/SKILL.md) - when a task needs a formal brief before substantive work starts. Used for new skills, agents, research, and documents.
- [`designing-workflow`](plugins/rageatc-core-oss/skills/designing-workflow/SKILL.md) - when planning a multi-stage task and choosing which phases to include.
- [`orchestrating-work`](plugins/rageatc-core-oss/skills/orchestrating-work/SKILL.md) - the execution handbook for any multi-agent workflow. Covers logging, gates, file conventions.
- [`collecting-sources`](plugins/rageatc-core-oss/skills/collecting-sources/SKILL.md) - when you want a curated library of sources with quality scoring before synthesis.
- [`conducting-research`](plugins/rageatc-core-oss/skills/conducting-research/SKILL.md) - when you ask AI to investigate, compare options, or learn an unfamiliar domain.
- [`verifying-claims`](plugins/rageatc-core-oss/skills/verifying-claims/SKILL.md) - when you need facts checked or sources triangulated against claims.
- [`assessing-quality`](plugins/rageatc-core-oss/skills/assessing-quality/SKILL.md) - when reviewing or critiquing a written artefact against standards.
- [`communicating-in-writing`](plugins/rageatc-core-oss/skills/communicating-in-writing/SKILL.md) - when writing or improving emails, reports, documents, presentations, website copy, or books.
- [`persuading`](plugins/rageatc-core-oss/skills/persuading/SKILL.md) - when producing LinkedIn posts, pitch narratives, cover letters, proposals, or anything that needs to land with a specific audience.
- [`writing-skills`](plugins/rageatc-core-oss/skills/writing-skills/SKILL.md) - when creating or revising a Claude Code Skill.

Internal:

- [`understanding-rageatc`](plugins/rageatc-core-oss/skills/understanding-rageatc/SKILL.md) - behavioural frame preloaded by every rageatc agent. Not user-invocable; sets scope discipline and shared protocols.

Agents:

- [`producer-agent`](plugins/rageatc-core-oss/agents/producer-agent.md) - the universal artefact creator. Produces documents, guides, specs, skills. Invoked by orchestration skills.
- [`critic-agent`](plugins/rageatc-core-oss/agents/critic-agent.md) - rigorous quality assessment of an artefact against the brief and standards. Invoked by `/critic` or during producer-critic cycles.
- [`researcher-agent`](plugins/rageatc-core-oss/agents/researcher-agent.md) - runs research and produces a synthesis. Invoked when you ask for research.
- [`source-collector-agent`](plugins/rageatc-core-oss/agents/source-collector-agent.md) - discovers, evaluates, and stores research sources with RADAR quality scores.
- [`fact-checker-agent`](plugins/rageatc-core-oss/agents/fact-checker-agent.md) - verifies claims against sources, either live (web search) or retrospective (against pre-collected sources). Used before research findings propagate into production.
- [`modifier-agent`](plugins/rageatc-core-oss/agents/modifier-agent.md) - mechanical bulk edits across many files: spelling fixes, reference updates after renames, version bumps. No architectural judgement.

### rageatc-tech-oss

Skills that load when relevant:

- [`playwright-cli`](plugins/rageatc-tech-oss/skills/playwright-cli/SKILL.md) - when you want AI to drive a browser: open pages, fill forms, click around, scrape data, or test a web-app you just developed.
- [`working-with-pdfs`](plugins/rageatc-tech-oss/skills/working-with-pdfs/SKILL.md) - when you need to read, build, merge, split, or otherwise handle PDFs.


### rageatc-code-oss

Skills that load when relevant:

- [`orchestrating-software-dev`](plugins/rageatc-code-oss/skills/orchestrating-software-dev/SKILL.md) - the entry point for any software work. Picks the right tier (Quick, Standard, Thorough) and coordinates the rest.
- [`managing-product`](plugins/rageatc-code-oss/skills/managing-product/SKILL.md) - when you need a PRD before architecture. Extracts requirements through structured dialogue.
- [`architecting-software`](plugins/rageatc-code-oss/skills/architecting-software/SKILL.md) - when a PRD exists and you need an architecture before implementation. Produces ARCHITECTURE.md and ADRs.
- [`scaffolding-project`](plugins/rageatc-code-oss/skills/scaffolding-project/SKILL.md) - when starting a new software project. Creates the standard file structure (PRD, ARCHITECTURE, ROADMAP, STATUS, CLAUDE.md).
- [`decomposing-work`](plugins/rageatc-code-oss/skills/decomposing-work/SKILL.md) - when architecture is approved and work needs to be broken into dependency-ordered chunks.
- [`enriching-roadmap`](plugins/rageatc-code-oss/skills/enriching-roadmap/SKILL.md) - when the structural roadmap exists and chunks need acceptance criteria and contextual notes before implementation.
- [`planning-software`](plugins/rageatc-code-oss/skills/planning-software/SKILL.md) - when the enriched roadmap is ready and you need an executable orchestration plan that survives session loss.
- [`test-driven-development`](plugins/rageatc-code-oss/skills/test-driven-development/SKILL.md) - enforces red-green-refactor: no production code without a failing test first. Loaded for every implementation.
- [`verifying-work`](plugins/rageatc-code-oss/skills/verifying-work/SKILL.md) - gates completion claims with evidence. No "should work" without fresh command output. Loaded for every implementation.
- [`using-worktrees`](plugins/rageatc-code-oss/skills/using-worktrees/SKILL.md) - when running implementation chunks in isolated git worktrees for safe parallel work and clean merges.
- [`reviewing-code`](plugins/rageatc-code-oss/skills/reviewing-code/SKILL.md) - when reviewing implementation against the chunk, the architecture, and code quality standards. Supports perspective selection (spec, quality, security, design, whole-project).
- [`evaluating-as-user`](plugins/rageatc-code-oss/skills/evaluating-as-user/SKILL.md) - when emulating a real end user to assess software quality. Covers web apps, CLI tools, and APIs.
- [`systematic-debugging`](plugins/rageatc-code-oss/skills/systematic-debugging/SKILL.md) - when debugging or diagnosing failures. Mandates root cause investigation before any fix.
- [`finding-docs`](plugins/rageatc-code-oss/skills/finding-docs/SKILL.md) - when you ask about a library, framework, SDK, or CLI tool. Pulls current documentation via Context7 rather than relying on training data.
- [`building-telegram-bots`](plugins/rageatc-code-oss/skills/building-telegram-bots/SKILL.md) - when writing or debugging Telegram bot code in python-telegram-bot, aiogram, grammY, or Telegraf. Verifies API and version before generating code.

Agents:

- [`architect-agent`](plugins/rageatc-code-oss/agents/architect-agent.md) - designs software architecture from a confirmed PRD. Produces ARCHITECTURE.md and ADRs.
- [`breakdown-agent`](plugins/rageatc-code-oss/agents/breakdown-agent.md) - decomposes ARCHITECTURE.md into dependency-ordered implementation chunks.
- [`developer-agent`](plugins/rageatc-code-oss/agents/developer-agent.md) - implements code per chunk inside the architectural boundaries. Has TDD and verification built in.
- [`reviewer-agent`](plugins/rageatc-code-oss/agents/reviewer-agent.md) - reviews implementation against the chunk and quality standards. Returns accept or revise.
- [`user-emulation-agent`](plugins/rageatc-code-oss/agents/user-emulation-agent.md) - emulates a real end user interacting with the built product. Catches broken flows, missing states, and PRD gaps.

### rageatc-design-oss

Skills that load when relevant:

- [`designing-interfaces`](plugins/rageatc-design-oss/skills/designing-interfaces/SKILL.md) - when a project has a UI and architecture is confirmed. Produces a design system through dialogue (greenfield) or by extracting patterns from existing code (brownfield).
