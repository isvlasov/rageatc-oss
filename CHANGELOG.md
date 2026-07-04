# Changelog

Notable changes to the rageatc-oss plugins.

## rageatc-code-oss 2.5.7 — 2026-07-04

orchestrating-software-dev Stage 10 now appends observations to LEARNINGS.md for a later `/codify` sweep instead of invoking the retired learner-agent. scaffolding-project's LEARNINGS.md template gains inclusion criteria and documents the `Codified →` marker.

## rageatc-core-oss 1.36.0 — 2026-07-04

Retired learner-agent and the capturing-learnings skill. Added the codify skill, invoked as `/codify` — sweeps a project's LEARNINGS.md and turns accumulated entries into skill, rule, or documentation changes. The LEARNINGS.md flow is now capture (`/learn`) then codify (`/codify`): learn, handover, assessing-quality, designing-workflow, orchestrating-work, and the orchestrator-role rule updated to match.

## rageatc-core-oss 1.35.0 — 2026-07-04

Condensed five skills (collecting-sources, verifying-claims, persuading, communicating-in-writing, assessing-quality) and four agents (source-collector, producer, modifier, fact-checker). assessing-quality adds signal-to-noise as a sixth review dimension. Source metadata schema adds `plaintext` format and `retrieval_method` field.

## rageatc-core-oss 1.34.0 / rageatc-code-oss 2.5.6 — 2026-07-04

Rewrote four workflow skills (conducting-research, creating-briefs, designing-workflow, orchestrating-work). Retired briefer-agent — briefing is now orchestrator-owned. Moved orchestration logging from rageatc-core-oss to rageatc-code-oss. Trimmed always-on rules.

## rageatc-core-oss 1.33.0 — 2026-07-04

Condensed seven skills (understanding-the-ask, assessing-quality, ideating, solutioning, handover, finalise-session, prime) and critic-agent.

## rageatc-core-oss 1.32.0 — 2026-07-04

Rewrote the writing-skills skill.

## Initial public release — 2026-05-17

Four plugins: rageatc-core-oss 1.30.0, rageatc-tech-oss, rageatc-code-oss, rageatc-design-oss.
