# rageatc-oss

> **Rage Against The C** - pick your own C to rage against.

Two plugins for Claude Code / Cowork, built on the idea that we're using AI wrong: the speed of its output tricks us into rushing the input. These plugins slow you down on the inputs - proper briefing, good questions asked back, review before anything reaches you - so the outputs are worth keeping.

## What's inside

Skills and agents to help you with your work or life. Each plugin works alone, but they fit together. Software work uses both; for non-coding work you only need core.

| Plugin | Purpose |
|---|---|
| **rageatc-core-oss** | To tackle even the most challenging thinking work. Ideate, structure the problem, then solve it with an agentic loop that reviews its own outputs and learns from them. |
| **rageatc-code-oss** | For building software the slow way. Tests come first, architecture is designed before coding starts, work is broken into small chunks, code is reviewed. Adapts to project size, from a one-line fix to a multi-week build. When your software has a UI, builds a design system from scratch or extracts one from existing code, then keeps the build aligned to it. Also carries tools that extend what your AI agent can reach: browse websites, read and write PDFs, hand tasks to a local model or Codex. |

For a detailed description of what's inside and how to use it - see [WHATS-INSIDE.md](WHATS-INSIDE.md).

## Install

You need Claude Code (desktop app or terminal) or Claude Cowork (app) installed.

### Through the desktop app

Works for Claude Code (desktop) and Cowork.

1. Press **Customize**.
2. Under **Personal plugins**, choose **Create plugin**.
3. Choose **Add marketplace** and point it at `isvlasov/rageatc-oss`.
4. Both `rageatc-*-oss` plugins appear in the list. Install whichever ones you want.

### With commands

The commands below are typed inside a Claude Code or Cowork session, not in your terminal.

Add the marketplace (you only do this once):

```
/plugin marketplace add isvlasov/rageatc-oss
```

Then install whichever plugins you want:

```
/plugin install rageatc-core-oss@rageatc-oss
/plugin install rageatc-code-oss@rageatc-oss
```

To check it worked, run `/plugin` - installed plugins show under the **Plugins** tab.

### Updating

To update a plugin manually:

```
/plugin update rageatc-core-oss@rageatc-oss
```

Same for `rageatc-code-oss`. Or enable auto-updates - they're off by default for third-party marketplaces like this one:

1. Run `/plugin` to open the plugin manager.
2. Go to the **Marketplaces** tab.
3. Select `rageatc-oss`.
4. Choose **Enable auto-update**.

From then on, Claude refreshes the marketplace and updates installed plugins at startup. If anything updated, you'll see a prompt to run `/reload-plugins`.

## Your first session

No setup after install - skills load themselves when the situation matches. Some ways to start:

- **Dump your raw thinking into `/shaping`.** Type `/shaping` and pour out whatever's in your head - a half-formed idea, a problem you can't quite name, three thoughts that might be one thing. Claude becomes a thinking partner: expands the idea with you, interviews you until the real problem is clear, weighs the options, and ends with a concept document you've shaped together. The most used command in this whole toolkit.
- **Just describe a task.** "I need to decide whether to switch suppliers" or "something's wrong with how we onboard clients" - the right skill picks it up and starts asking questions back. Vague is fine; that's the point.
- **Put AI's work through `/critic`.** When Claude produces something - a document, a plan, a spec - `/critic` hands it to a review agent that knows how to assess AI output properly: against the brief, against standards, with actionable feedback instead of applause.
- **Ask for research.** "Research the current state of X" runs a structured research workflow and synthesises the findings - with fact-checking of the claims if you want it.
- **Build something.** Describe the software you want - often the natural next step once `/shaping` has turned an idea into a concept. The workflow scales itself: a one-line fix stays quick, a real project gets a PRD, architecture, and a roadmap you approve step by step.

For ongoing projects, two commands bookend your sessions: `/prime` at the start (orients Claude in the project) and `/finalise-session` at the end (records state so the next session resumes cleanly).

The full catalogue of skills and agents is in [WHATS-INSIDE.md](WHATS-INSIDE.md).

## Why I built this - written by a meatbag, not an AI

Hi all,

I'm Ilya. I have decades of structured problem-solving and management experience - starting from growing up in Russia in the 90s (lots of problems to solve, trust me), to leading large guilds in online MMOs, to building and restructuring businesses, to hiring and firing people, to working in strategy consulting, to being obsessed with science and understanding how things work under the hood, including AI.

I feel we're not using AI the right way. The speed at which AI produces output has misled us into thinking that giving AI directions could be fast too. Wrong.

So I built rageatc to make AI work the way I'd work with good people on a team - briefed properly, asked good questions back, given time on the parts that matter. The frameworks behind it come from science and best practices from industries where things matter, not consulting. You've likely heard of those, but are too lazy to apply them in real life (me too) - AI isn't.

Started with one skill (`writing-skills`) for what I actually needed. Grew one skill or agent at a time as new real problems showed up. I use it daily - not every part of it, but there is no dead weight.

I've been using it personally for almost 5 months, and that's the best thinking setup I've seen so far. I want to share it with you.

This might look overwhelming, but it is in fact simple. Use a single skill or the full stack - your way. Trust the recommended workflows the AI will guide you towards, or build your own.

## Principles

**1. Slow is fast - own the understanding.** Working with AI is about managing others. Same as with people, rushed instructions generate low quality outputs. Time invested up front, defining the task properly, pays back many times over during execution.

**2. Bad communication kills results.** Applies to all of these: human-to-human, human-to-AI, and often overlooked - human-to-self. We assume the other party understands us, but that's a trick - don't fall for it. If you're into aviation, you know how many communication rules that look stupid at first glance were written in blood - and they work. Clear messaging, and clear understanding of what you actually want, is critical.

**3. We don't know what we don't know.** We all live in our own bubbles. You can't ask a question about something you don't know exists, and that limits what you can do. Luckily, the bubble of modern LLMs is massive - they can help you explore the unknowns. AI helps you see outside your bubble, gain fresh perspectives, even on things you thought you knew. Use humanity's knowledge to your advantage - especially from industries you're less familiar with.

**4. Any computer task is doable by AI if AI is properly organised.** AI solves simple, well-defined tasks reliably, especially when given a guide. Any large task can be broken down into smaller chunks. Combine these two and you get AI working reliably on pretty much anything.

**5. Solve for problems that exist now, not for theoretical ones.** It's extremely easy to get carried away by AI's capabilities and try to find a solution for a problem you might encounter in future. That's dangerous. My approach is to solve what I have at hand now. Makes the plugins practical - problem first, solution next.

**6. Context is king.** Shit in = shit out, same applies for AI. The quality of your context (the input AI gets) is the main driver of the quality of output. So protect the orchestrator's context window. Store what was produced in files, not inline. Delegate token-heavy work to subagents - and make sure the orchestrator manages them the same way a good manager would manage you.

**7. AI can help you deal with AI.** LLMs are great at reviewing, including stuff produced by other LLMs. They can turn the boring task of providing sufficient context into an interesting one by interviewing you. And they follow instructions much better than humans - so codify your work.

## Acknowledgements

This marketplace draws on:

- [interface-design](https://github.com/Dammyjay93/interface-design) by Damola Akinleye (MIT) - for the `designing-interfaces` skill in `rageatc-code-oss`
- [Superpowers](https://github.com/obra/superpowers) by Jesse Vincent (MIT) - for `rageatc-code-oss`

## Status

Active development. Issues and PRs welcome - see [`CONTRIBUTING.md`](CONTRIBUTING.md).

## License

MIT. See [`LICENSE`](LICENSE).
