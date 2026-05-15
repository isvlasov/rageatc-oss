# rageatc-design-oss

> **A direct port of [interface-design](https://github.com/Dammyjay93/interface-design) by Damola Akinleye (MIT licensed).** The skill and its references are copied, not adapted — this plugin simply repackages that work as a rageatc-oss plugin so it can be loaded alongside the rest of the rageatc toolkit.

Interface design with craft and consistency for Claude Code projects.

## What Is This?

rageatc-design-oss provides the design discipline layer for software with a user interface. It guides the orchestrator through domain exploration, design direction, token architecture, and design system creation — producing a `.interface-design/system.md` that developers implement against.

It integrates with rageatc-code-oss as Stage 4 (Interface Design) in the software development lifecycle, sitting between Architecture and Decomposition. It depends on rageatc-core-oss for workflow infrastructure.

## Scope

**Use for:** Dashboards, admin panels, SaaS apps, tools, settings pages, data interfaces — any software with a UI.

**Not for:** Marketing sites, landing pages, campaigns. Also not for pure APIs, CLIs, or libraries (rageatc-code-oss skips this stage when there is no UI).

## Skills

| Skill | Purpose |
|-------|---------|
| **designing-interfaces** | Orchestrator-led interface design — domain exploration, direction proposal, token architecture, design system creation |

## How It Fits

```
rageatc-code-oss Stage 3 (Architecture)  →  rageatc-design-oss Stage 4 (Interface Design)  →  rageatc-code-oss Stage 5 (Decomposition)
(ARCHITECTURE.md)                            (.interface-design/system.md)                     (ROADMAP.md)
```

The design system feeds into:
- **Enrichment** — UI chunk acceptance criteria reference design tokens
- **Build** — developer-agent receives system.md as input for UI chunks
- **Review** — reviewer-agent applies the design-compliance perspective

## Relationship to Other Plugins

- **rageatc-code-oss** — Software creation lifecycle. rageatc-design-oss provides the design stage that rageatc-code-oss orchestrates.
- **rageatc-core-oss** — Workflow infrastructure. rageatc-design-oss operates within core workflows.
- **rageatc-tech-oss** — Technical capabilities. Complementary — tech handles tool selection, design handles visual craft.
