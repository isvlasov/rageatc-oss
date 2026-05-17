# What's inside

A closer look at what rageatc-oss does and how to use it.

## What it can do for you

A few examples of how I use it. You can use it your way:

- Understand what the problem really is
- Structure problems and identify true root causes
- Conduct deep research or collect sources for your work
- Find the right solution to your problem
- Execute in a structured, controllable way
- Build tools that are genuinely useful (I'm sure you can build complex ones too)
- Improve the system itself
- Produce other artefacts: presentations, written documents, websites, and more

## The full menu

The diagrams below show an example of a workflow `rageatc-core` and `rageatc-code` can do. In practice most work uses only select stages.

### rageatc-core

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

### rageatc-code (Thorough mode)

```
shaping                    ┐    (← rageatc-core entry,
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

Per-skill and per-agent catalogue coming soon. For now, browse [`plugins/`](plugins/) to see what each plugin ships with.
