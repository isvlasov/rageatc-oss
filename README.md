# rageatc-oss

Claude Code plugins for sharper thinking and structured problem-solving.

## What's inside

Four plugins covering different layers of agentic work:

| Plugin | Purpose |
|---|---|
| **rageatc-core-oss** | Workflow infrastructure — orchestration, research, quality assessment, artefact production, learning extraction. The Producer–Critic–Learner workflow. |
| **rageatc-tech-oss** | Technical capabilities — browser automation (Playwright), PDF handling, transcript extraction, with environment-aware fallback. |
| **rageatc-code-oss** | Scale-adaptive software development — TDD, verification, architecture, decomposition, code review. Five agents and fifteen skills across the full lifecycle. |
| **rageatc-design-oss** | Interface design — domain-driven design systems, token architecture, design-compliance review. |

Each plugin is independent but composes naturally with the others. Most software work uses core, code, and (where there's a UI) design together.

## Installation

`rageatc-oss` is a Claude Code marketplace. Install whichever plugins you want:

```
/plugin marketplace add isvlasov/rageatc-oss
/plugin install rageatc-core-oss@rageatc-oss
```

Repeat for `rageatc-tech-oss`, `rageatc-code-oss`, `rageatc-design-oss` as needed.

## Acknowledgements

This marketplace draws on:

- [interface-design](https://github.com/Dammyjay93/interface-design) by Damola Akinleye (MIT) — for `rageatc-design-oss`
- [Superpowers](https://github.com/obra/superpowers) by Jesse Vincent (MIT) — for `rageatc-code-oss`

## Status

Under active development. Public-facing copy and usage examples are still being polished. Issues and PRs welcome but no service-level commitments — see [`CONTRIBUTING.md`](CONTRIBUTING.md).

## License

MIT. See [`LICENSE`](LICENSE).
