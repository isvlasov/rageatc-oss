# Changelog

Notable changes to the rageatc-oss plugins.

## rageatc-code-oss 3.0.0 / rageatc-core-oss 1.39.0 — 2026-07-04

The marketplace is consolidated from four plugins to two. rageatc-code-oss absorbs the contents of rageatc-tech-oss (the playwright-cli and working-with-pdfs skills and the bash-safety-guard hook) and rageatc-design-oss (the designing-interfaces skill); those two plugins are removed from the marketplace. Skill content is unchanged. rageatc-core-oss updates its system-context rule for the two-plugin structure.

**If you have rageatc-tech-oss or rageatc-design-oss installed:** uninstall them (`/plugin uninstall rageatc-tech-oss@rageatc-oss` and `/plugin uninstall rageatc-design-oss@rageatc-oss`), then update rageatc-code-oss to 3.0.0 — the same skills now load from there.

## rageatc-code-oss 2.9.0 / rageatc-tech-oss 1.8.0 / rageatc-design-oss 1.2.0 — 2026-07-04

Condensed 16 reference files across three plugins: reviewing-code's five review perspectives, systematic-debugging's three technique guides, test-driven-development's testing anti-patterns, architecting-software's architecture template, building-telegram-bots' two framework references, working-with-pdfs' tool-installation guide, and designing-interfaces' principles, examples, and validation references. building-telegram-bots references updated to current framework versions (python-telegram-bot 22.8, aiogram 3.29.1, grammY 1.44.0, Bot API 10.1; verified 2026-07-04) and its documentation-URL pointer corrected. reviewing-code aligns its severity rule with the security perspective's calibration: security findings are never below Major, exploitable vulnerabilities are Critical. designing-interfaces' system template makes the Personality field free text derived from domain exploration. bash-safety-guard now catches rm with split or long-form recursive and force flags (`rm -r -f`, `rm --recursive --force`). Fixed an invalid qpdf compress flag in tool-installation.

## rageatc-code-oss 2.8.0 / rageatc-tech-oss 1.7.0 — 2026-07-04

planning-software's ORCHESTRATION-PLAN template now points to orchestrating-software-dev's per-chunk protocol and Stage 9 completion review instead of restating them; the plan keeps the tier-resolved review perspectives. This also corrects the template's completion steps, which omitted user emulation. developer-agent defers status-code definitions to its preloaded verifying-work skill. using-worktrees records a 2026-07-04 re-verification of automated worktree isolation: the permission, data-loss, and background-composition issues from the Feb 2026 reports are fixed; opaque branch naming remains, and the manual approach stays for orchestrator lifecycle control. rageatc-tech-oss 1.7.0 is a version-only release with no content changes.

## rageatc-core-oss 1.38.0 — 2026-07-04

Condensed the four verifying-claims reference files (source-evaluation-radar, hallucination-detection, evidence-hierarchy, edge-cases-and-pitfalls) from 1,618 to 265 lines. Evidence-hierarchy's numeric confidence adjustments are replaced with directional weighting guidance, matching the skill's qualitative calibration model. All criteria, protocols, edge cases, and pitfalls are retained.

## rageatc-core-oss 1.37.0 / rageatc-tech-oss 1.6.0 / rageatc-code-oss 2.6.0 / rageatc-design-oss 1.1.0 — 2026-07-04

Condensed skills across all four plugins: four core skills (roast, eli40, learn, critic) and two core agents (producer, modifier); working-with-pdfs and playwright-cli in tech; fifteen code skills; designing-interfaces in design. playwright-cli updated for the current upstream CLI — adds `attach`/`detach`, `drop`, `--cdp`, and `--hires`, and corrects the npm package name to `@playwright/cli`. using-worktrees dates its Claude Code worktree-isolation caveats to the Feb 2026 reports.

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
