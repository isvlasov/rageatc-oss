# rageatc-oss

> **Rage Against The C** - pick your own C to rage against.

Thinking plugins for Claude Code. Install these to make your AI help you give it better inputs, so its outputs get better. Focused on problem-solving. If the solution turns out to be software, they help you build that too.

## Quickstart

Four plugins. Install whichever you want - they work alone or together.

**Add the marketplace:**

```
/plugin marketplace add isvlasov/rageatc-oss
```

**Install plugins:**

```
/plugin install rageatc-core-oss@rageatc-oss
/plugin install rageatc-tech-oss@rageatc-oss
/plugin install rageatc-code-oss@rageatc-oss
/plugin install rageatc-design-oss@rageatc-oss
```

## What's inside

| Plugin | Purpose |
|---|---|
| **rageatc-core-oss** | Skills and agents that help you tackle even the most challenging thinking work. Ideate, structure the problem, then solve it with an agentic loop that reviews its own outputs and learns from them. |
| **rageatc-tech-oss** | Tools that extend what your AI agent can reach: browse websites, read and write PDFs, pull YouTube transcripts. With fallbacks when the primary tool isn't available. |
| **rageatc-code-oss** | For building software the slow way. Tests come first, architecture is designed before coding starts, work is broken into small chunks, code is reviewed. Adapts to project size, from a one-line fix to a multi-week build. |
| **rageatc-design-oss** | For when your software has a UI. Builds a design system from scratch or extracts one from existing code, then keeps the build aligned to it. |

Each plugin works alone, but they fit together. Most software work uses core, code, and (where there's a UI) design together.

## Why I built this - from a meatbag, not an AI

Hi all,

I'm Ilya. I have decades of structured problem-solving experience - starting from growing up in Russia in the 90s (lots of problems to solve, trust me), to leading large guilds in online MMOs, to building and restructuring businesses, to hiring and firing people, to working in strategy consulting, to being obsessed with science and understanding how things work under the hood, including AI.

I feel we're not using AI the right way. The speed at which AI produces output has misled us into thinking that giving AI directions could be fast too. Wrong.

Taking things slow, especially when making irreversible decisions, is the fastest way to get where you wanted to go. And often, your true destination is not the one you thought you knew.

Another focal point of rageatc is helping you step out of your bubbles. We don't know what we don't know, and that bothers me a lot. The system will often help you expand your bubble by exploring areas you weren't aware of.

I created these plugins to somewhat mimic the way I think and the way I work with other people. AI isn't the same as humans, but it does have very similar properties - which lets me use my experience managing teams to manage AI effectively.

I want to share it with you.

The frameworks, methodologies and workflows are based on science and best practices from industries where things matter, not consulting. You've likely heard of those, but too lazy to apply these frameworks in real life (me too) - but AI is not.

This might look overwhelming, but it is in fact simple. Use a single skill or the full stack - your way. Trust the recommended workflows the AI will guide you towards, or build your own.

## What it can do for you

A few examples of how I use it. You can use it your way:

- Understand what the problem really is
- Structure it and deep-dive into root causes
- Conduct deep research
- Find the right solution
- Execute in a structured way, where AI helps AI produce better outputs through feedback loops, self-learning, and a simple memory system
- Build simple apps that are genuinely useful (I'm sure you can build complex ones too)
- Improve the system itself
- Produce other artefacts: presentations, written documents, websites, and more

## Acknowledgements

This marketplace draws on:

- [interface-design](https://github.com/Dammyjay93/interface-design) by Damola Akinleye (MIT) - for `rageatc-design-oss`
- [Superpowers](https://github.com/obra/superpowers) by Jesse Vincent (MIT) - for `rageatc-code-oss`

## Status

Under active development. Public-facing copy and usage examples are still being polished. Issues and PRs welcome but no service-level commitments - see [`CONTRIBUTING.md`](CONTRIBUTING.md).

## License

MIT. See [`LICENSE`](LICENSE).
