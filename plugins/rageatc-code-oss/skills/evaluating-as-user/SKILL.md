---
name: evaluating-as-user
description: Evaluates software quality from an end user's perspective. Use when emulating a real user to assess a running web app, CLI tool, or API.
---

# Evaluating as a User

## Purpose

Teach the methodology and judgement needed to evaluate a running product as a real user would. Defines how to derive what to test from the PRD, how to structure the evaluation, what quality dimensions to assess, and how to format findings.

This skill covers **what to evaluate and how to think about quality**. Browser interaction mechanics are in playwright-cli (preloaded). Agent role, inputs, status codes, and handoff are in the agent definition.

## Scope

**Applies to:** web applications, CLI tools, APIs.

**Does not cover:** source code review (reviewing-code), automated test generation, accessibility audits (WCAG), or performance benchmarking.

## Workflow

### Step 1: Derive user journeys from the PRD

Read the PRD. For each P0 requirement, derive one user journey using this structure:

| Field | Description |
|-------|-------------|
| **Starting point** | Where the user begins (URL, command, state) |
| **Actions** | Step-by-step sequence the user would take |
| **Observable outcome** | What confirms the requirement is satisfied |

**How to derive actions:** Treat the requirement as a goal, not a task. Ask: what would a person with this goal actually do? Start from the entry point a new user would reach, not the most direct technical path.

**Priority:** P0 requirements first. Add P1 journeys only if time permits after all P0 journeys and universal checks are complete.

**Non-web projects:** For CLI tools, the starting point is the terminal and the actions are command sequences. For APIs, the starting point is an endpoint and the actions are the sequence of requests a user of the API would make. The journey structure is the same.

### Step 2: Run PRD-derived journeys

Attempt each derived journey in sequence. As you go:

- Execute each action in the journey
- Record what you observe at each step in `walkthrough.md` (what you did, what you expected, what you saw)
- Take a screenshot at each meaningful state transition (web projects)
- Note any friction, confusion, missing feedback, or failure

When a journey succeeds, note which quality dimensions (Step 4) were satisfied or strained along the way. When a journey fails, record at what step and what the failure was.

**If a severity-4 issue is encountered mid-journey:** record it, then attempt to continue or skip to the next journey. Do not abandon the evaluation.

### Step 3: Apply universal checks

After PRD journeys, run these checks on every product regardless of what the PRD specifies:

| Check | What to do | What to look for |
|-------|-----------|-----------------|
| **First landing** | Load the primary screen fresh | Does the product communicate its purpose within 5 seconds? Is there a clear visual hierarchy? Does the user know what to do next? |
| **First-time empty state** | Access the product as a new user with no data | Are empty views explained and actionable, or blank and confusing? |
| **Error paths** | Submit invalid input, trigger validation, attempt impossible actions | Are errors in plain language with a clear fix suggestion? Do they appear where the user is looking? |
| **Zero-results** | Search or filter for something that will not exist | Is there a clear message that the search worked but found nothing? Is there an actionable next step? |
| **Visual consistency** | Navigate to three or more different views | Do colour, spacing, typography, and interaction patterns hold consistent throughout? |
| **Feedback absence** | Trigger any async action (form submission, data save, deletion) | Does the product visibly confirm that the action happened? |

**Non-web CLI tools:** Replace first landing with "first run of the tool with no arguments or `--help`". Replace visual consistency with "consistency of output format, flag naming, and error message style". Skip screenshot-dependent checks.

**APIs:** Replace first landing with "calling the root endpoint or documentation endpoint". Replace visual checks with "consistency of response envelope structure, error format, and status code usage".

### Step 4: Assess quality dimensions

**Note:** These dimensions are a lens you apply throughout Steps 2, 3, and 5 — not a separate sequential activity. Return here as a reference when assessing findings, not as a distinct pass after universal checks.

For each journey and each universal check, assess the product across these five dimensions. You do not need a score per check — use the dimensions as a lens to ensure findings cover the full experience, not just functional failures.

| Dimension | The question | What failure looks like |
|-----------|-------------|------------------------|
| **Communicativeness** | Does the product tell me what's happening? | Silent submissions, missing loading states, absent feedback, cryptic error codes |
| **Learnability** | Can I figure out how to use it without help? | Jargon, non-standard navigation patterns, no contextual guidance, forcing users to memorise |
| **Reliability feel** | Does it feel trustworthy and consistent? | Visual inconsistencies, unpredictable behaviour, poor error recovery, performance anxiety |
| **Efficiency** | Does it respect my time? | Unnecessary steps, buried primary actions, no defaults, repetitive data entry |
| **Emotional tone** | Does it feel crafted or careless? | Unstyled edge states, ignored empty states, missing microinteraction feedback, placeholder text in production |

**Treat feedback absence as severity 3 by default.** If a user action produces no visible response, that is a major finding unless there is a clear reason it does not need one.

### Step 5: Exploratory evaluation

After journeys and universal checks, use the product freely as a real person would. Navigate, go back, try things the PRD did not specify, use it at an unexpected pace. This layer surfaces issues no checklist captures.

Focus exploratory time on:
- Flows that felt hesitant during journey evaluation
- States you were unable to trigger intentionally
- Anything that prompted a moment of uncertainty

Record what you try and what you notice. Not all observations become findings — use judgement to decide what matters.

### Step 6: Check design compliance (when system.md provided)

If a design system file was provided, compare the rendered product against it:

- Are the defined colour tokens applied correctly throughout?
- Does spacing follow the system's scale?
- Does typography use the specified families and weights?
- Are interactive states (hover, active, disabled, focus) handled consistently with the system's patterns?
- Does visual hierarchy match the design direction?

Report deviations as findings. Use severity 2 for cosmetic drift, severity 3 for systematic token violations or broken interactive states.

### Step 7: Structure findings

Write each finding using this format:

```
**[SEVERITY-N]** Location (screen, view, component, or command)

_Finding:_ What the issue is, described as a user would experience it.

_Impact:_ Why it matters — what the user loses or cannot do.

_Suggestion:_ A specific, actionable fix the developer can implement.
```

Group findings in `findings.md` by severity, highest first. Include references to walkthrough steps and screenshots.

## Severity Reference

| Level | Meaning | Example |
|-------|---------|---------|
| **4 Catastrophic** | Prevents task completion | Core feature does not work; user cannot achieve their goal |
| **3 Major** | Significant user impact — important to fix | Confusing flow leads users to a dead end; form submits silently; primary action is hidden |
| **2 Minor** | Causes friction but does not block | Missing loading indicator; inconsistent button labels; empty state with no guidance |
| **1 Cosmetic** | Fix if time permits | Slightly inconsistent spacing; minor colour drift from design system |

**Honesty rule:** Do not inflate severity. A cosmetic issue is not catastrophic because it is frequent. A major issue is not cosmetic because it is hard to fix.

## Finding Format: What Makes a Finding Actionable

A finding is actionable when a developer reading it knows exactly what to change. Test your findings against these criteria:

- **Specific:** Names the location and describes the behaviour, not a general observation
- **Impact-clear:** Explains what the user loses, not just that something is "wrong"
- **Fixable:** Suggests a concrete change, not "improve this" or "make it better"
- **Evidence-linked:** References a walkthrough step or screenshot

Vague finding (not actionable): "The onboarding experience is confusing."

Actionable finding: `**[SEVERITY-3]** Onboarding — Step 2 (account setup) — After clicking "Create account", no confirmation or loading indicator appears for ~3 seconds. _Impact:_ Users assume the click did not register and click again, creating duplicate submissions. _Suggestion:_ Show a spinner or disabled state on the button immediately on click; display a "Creating your account..." message.`

## Evaluation Scenarios

### Scenario 1: Web app with clear PRD

PRD has three P0 requirements. The app is running at localhost.

**Expected:** Agent derives three user journeys (one per P0), runs each in the browser using playwright-cli, applies all six universal checks, assesses all five quality dimensions during the walk, runs exploratory evaluation, and produces a walkthrough.md and findings.md with severity-rated, actionable findings.

**Example walkthrough entry (Step 2):**

```
Journey 1, Step 3 — Submit registration form
Did: Filled in name, email, and password fields; clicked "Create account"
Expected: Loading state on button, then redirect to dashboard or confirmation screen
Saw: Button remained active with no visual change for ~4 seconds, then page refreshed to the same form with no error message
Quality lens: Communicativeness failure (no feedback); Reliability feel strained (unpredictable outcome)
```

### Scenario 2: CLI tool with no design system

PRD describes a CLI utility with two core commands. No system.md.

**Expected:** Agent derives journeys as command sequences, runs them in the terminal, applies universal checks adapted for CLI (first run with no args, error message quality, output consistency, feedback on completion). Skips design compliance step. Produces findings with terminal output evidence in walkthrough.md instead of screenshots.

**Example finding (CLI-adapted format):**

```
**[SEVERITY-3]** CLI — first run with no arguments

_Finding:_ Running `mytool` with no arguments exits silently with code 1. No usage information, no hint that `--help` exists.

_Impact:_ A new user has no way to discover how to use the tool without consulting external documentation. Standard CLI convention is to print usage on invocation with no args.

_Suggestion:_ When invoked with no arguments, print a short usage summary (same output as `--help`) before exiting. Exit code 0 for informational output; exit code 1 only for genuine errors.

_Evidence:_ walkthrough.md step 1 — terminal output:
$ mytool
$ echo $?
1
```

### Scenario 3: Product with a severity-4 issue mid-evaluation

During journey 1, the primary feature crashes with an unhandled exception.

**Expected:** Agent records the severity-4 finding, notes the step at which evaluation was blocked, attempts any remaining steps or alternative paths, continues with remaining journeys and universal checks (rather than abandoning entirely), and returns DONE_WITH_CONCERNS with the catastrophic finding highlighted.

## Common Traps

**Evaluating the code, not the product.** If you find yourself reasoning about implementation, stop. You are the user — you observe what happens, not why.

**Judging intent, not experience.** "The developer clearly intended X" is not relevant. "As a user, I encountered Y" is.

**Over-inflating severity.** Reserve 4 for genuine task blockers. Reserve 3 for issues that meaningfully harm the experience or cause user error. Not everything is major.

**Skipping empty states because you filled them with test data.** Explicitly test the zero-data view: create a new account, clear your test data, or access the product as a fresh user.

**Only reporting failures.** The walkthrough should document what works too — both as context for findings and as confirmation that the evaluation was thorough.

**Dismissing visual inconsistency as cosmetic.** Research shows visual quality is a proxy for product quality — users who see inconsistent spacing or mismatched colours assume the underlying product is unreliable too. Rate visual coherence issues at severity 2 minimum.
