---
name: designing-interfaces
description: Creates a design system for software with a UI. Use when a project has a user interface and architecture is confirmed — whether creating from scratch or extracting patterns from existing code.
---

# Designing Interfaces

## Purpose

This skill guides the orchestrator through defining *how the software should look and feel* before any UI code is written. It sits between architecture (how to build it) and decomposition (what chunks to build in) — ensuring every UI decision is intentional, domain-rooted, and systematic.

The orchestrator runs this directly (not delegated) because it is dialogic — exploring the product's world with the user to produce a design system that compounds across the entire build.

## Scope and Constraints

**This skill covers:**
- Exploring the product domain to derive design direction
- Proposing and confirming a design direction with the user
- Producing a token architecture and design system
- Creating `.interface-design/system.md` as the persistent design record
- Extracting patterns from existing code (brownfield entry)

**This skill does NOT cover:**
- Implementation of UI components (that is the developer-agent's job)
- Design compliance review during builds (that is the design-compliance review perspective)
- Marketing design, landing pages, or campaigns
- Architecture or technology selection (that is architecting-software)

**Handoff position:**

```
architecting-software  →  designing-interfaces  →  decomposing-work
(ARCHITECTURE.md)          (system.md)              (ROADMAP.md)
```

Receive from upstream: a confirmed ARCHITECTURE.md and PRD.md (who the users are, what they need to accomplish).

Hand off downstream: a `.interface-design/system.md` that decomposition and enrichment can reference, and that developers implement against.

## Inputs Required

Before starting, confirm you have:

- [ ] Confirmed PRD.md — who the users are, what problem is being solved, success criteria
- [ ] Confirmed ARCHITECTURE.md — tech stack, frontend framework, component structure
- [ ] The user available for dialogue — design direction requires conversation, not assumption

For brownfield projects, also:
- [ ] Path to existing UI code — to extract current patterns before refining

## Outputs Produced

- `.interface-design/system.md` — the design system record (see Template section)

This file persists across sessions. Once created, all UI work references it. Updates happen through this skill, not ad hoc edits.

---

## The Problem

You will generate generic output. Your training has seen thousands of dashboards. The patterns are strong.

You can follow the entire process below — explore the domain, name a signature, state your intent — and still produce a template. Warm colours on cold structures. Friendly fonts on generic layouts. "Kitchen feel" that looks like every other app.

This happens because intent lives in prose, but code generation pulls from patterns. The gap between them is where defaults win.

The process below helps. But process alone does not guarantee craft. You have to catch yourself.

### Where Defaults Hide

Defaults do not announce themselves. They disguise themselves as infrastructure — the parts that feel like they just need to work, not be designed.

**Typography feels like a container.** Pick something readable, move on. But typography is not holding your design — it IS your design. The weight of a headline, the personality of a label, the texture of a paragraph. These shape how the product feels before anyone reads a word. A bakery management tool and a trading terminal might both need "clean, readable type" — but the type that is warm and handmade is not the type that is cold and precise.

**Navigation feels like scaffolding.** Build the sidebar, add the links, get to the real work. But navigation is not around your product — it IS your product. Where you are, where you can go, what matters most.

**Data feels like presentation.** You have numbers, show numbers. But a number on screen is not design. The question is: what does this number mean to the person looking at it? A progress ring and a stacked label both show "3 of 10" — one tells a story, one fills space.

**Token names feel like implementation detail.** But your CSS variables are design decisions. `--ink` and `--parchment` evoke a world. `--gray-700` and `--surface-2` evoke a template.

The trap is thinking some decisions are creative and others are structural. There are no structural decisions. Everything is design.

---

## Workflow

### Entry Path: Greenfield (no existing system.md)

#### Step 1: Establish Intent

Before touching anything visual, answer these — out loud, to the user. Not in your head.

**Who is this human?**
Not "users." The actual person. Where are they when they open this? What is on their mind? What did they do 5 minutes ago, what will they do 5 minutes after? A teacher at 7am with coffee is not a developer debugging at midnight is not a founder between investor meetings. Their world shapes the interface.

**What must they accomplish?**
Not "use the dashboard." The verb. Grade these submissions. Find the broken deployment. Approve the payment. The answer determines what leads, what follows, what hides.

**What should this feel like?**
Say it in words that mean something. "Clean and modern" means nothing — every AI says that. Warm like a notebook? Cold like a terminal? Dense like a trading floor? Calm like a reading app?

If you cannot answer these with specifics, stop. Ask the user. Do not guess. Do not default.

**The test:** For every decision, you must be able to explain WHY. Why this layout and not another? Why this colour temperature? Why this typeface? If your answer is "it's common" or "it's clean" — you have not chosen. You have defaulted.

#### Step 2: Explore the Product Domain

This is where defaults get caught — or do not.

Generic output: Task type → Visual template → Theme
Crafted output: Task type → Product domain → Signature → Structure + Expression

**Do not propose any direction until you produce all four required outputs:**

**Domain:** Concepts, metaphors, vocabulary from this product's world. Not features — territory. Minimum 5.

**Colour world:** What colours exist naturally in this product's domain? Not "warm" or "cool" — go to the actual world. If this product were a physical space, what would you see? List 5+.

**Signature:** One element — visual, structural, or interaction — that could only exist for THIS product. If you cannot name one, keep exploring.

**Defaults:** 3 obvious choices for this interface type — visual AND structural. You cannot avoid patterns you have not named.

#### Step 3: Propose Direction

Present to the user:

```
Domain: [5+ concepts from the product's world]
Colour world: [5+ colours that exist in this domain]
Signature: [one element unique to this product]
Rejecting: [default 1] → [alternative], [default 2] → [alternative], [default 3] → [alternative]

Direction: [approach that connects to the above]
```

Ask: "Does that direction feel right?"

The proposal must explicitly reference domain concepts, colours from the colour world exploration, the signature element, and what replaces each default.

**The test:** Read your proposal. Remove the product name. Could someone identify what this is for? If not, it is generic. Explore deeper.

#### Step 4: Build the Design System

Once direction is confirmed, produce the token architecture:

**For every decision, state WHY:**

```
Intent: [who is this human, what must they do, how should it feel]
Palette: [colours from your exploration — and WHY they fit this product's world]
Depth: [borders / shadows / layered — and WHY this fits the intent]
Surfaces: [your elevation scale — and WHY this colour temperature]
Typography: [your typeface — and WHY it fits the intent]
Spacing: [your base unit]
```

Apply the craft foundations (see Craft Foundations section below) and produce a complete system.md using the template in `references/system-template.md`. Reference `references/system-precision.md` and `references/system-warmth.md` for examples of complete systems.

#### Step 5: Self-Critique Before Presenting

**Before showing the user, look at what you made.** Ask yourself: "If they said this lacks craft, what would they mean?" That thing you just thought of — fix it first.

Run these checks:

- **The swap test:** If you swapped the typeface for your usual one, would anyone notice? The places where swapping would not matter are the places you defaulted.
- **The squint test:** Blur your eyes. Can you still perceive hierarchy? Is anything jumping out harshly?
- **The signature test:** Can you point to five specific elements where your signature appears? A signature you cannot locate does not exist.
- **The token test:** Read your CSS variables out loud. Do they sound like they belong to this product's world, or could they belong to any project?

If any check fails, iterate before showing.

#### Step 6: Confirm and Save

Present system.md to the user for approval. This is a gate — do not proceed to decomposition without explicit confirmation.

Save to `.interface-design/system.md` at the project root.

---

### Entry Path: Brownfield (existing UI code)

#### Step 1: Extract Current Patterns

Scan the existing UI files (tsx, jsx, vue, svelte, css) for:
- Repeated spacing values → identify the implicit spacing scale
- Border radius patterns → identify the implicit radius scale
- Colour values → identify the implicit palette
- Shadow usage → identify the implicit depth strategy
- Component patterns → identify buttons, cards, controls

#### Step 2: Present Findings

Show the user what you found:
- "Your current code uses these patterns: [extracted patterns]"
- "These areas are inconsistent: [conflicts found]"
- "This appears to be the implicit design direction: [inferred direction]"

#### Step 3: Refine With User

Ask: "Do you want to formalise these patterns as-is, or take this opportunity to establish a new direction?"

- If formalise → produce system.md from extracted patterns
- If new direction → switch to Greenfield Step 1, carrying forward any patterns worth keeping

#### Step 4: Confirm and Save

Same gate as greenfield — present for approval, save to `.interface-design/system.md`.

---

## Craft Foundations

These apply regardless of design direction. This is the quality floor.

### Subtle Layering

This is the backbone of craft. You should barely notice the system working. When you look at Vercel's dashboard, you do not think "nice borders." You just understand the structure. The craft is invisible — that is how you know it is working.

**Surface Elevation:** Surfaces stack. Build a numbered system — base, then increasing elevation levels. Each jump should be only a few percentage points of lightness. Whisper-quiet shifts that you feel rather than see.

**Key decisions:**
- Sidebars: Same background as canvas, not different. A subtle border is enough separation.
- Dropdowns: One level above their parent surface.
- Inputs: Slightly darker than surroundings — they are "inset," receiving content.

**Borders:** Low opacity rgba blends with the background — defines edges without demanding attention. Build a progression: standard, softer separation, emphasis, maximum emphasis for focus rings.

### Infinite Expression

Every pattern has infinite expressions. No interface should look the same. A metric display could be a hero number, inline stat, sparkline, gauge, progress bar, comparison delta, or something new.

**Before building, ask:** What is the ONE thing users do most here? What products solve similar problems brilliantly? Why would this interface feel designed for its purpose, not templated?

### Colour Lives Somewhere

Every product exists in a world. That world has colours. Before reaching for a palette, spend time in the product's world. Your palette should feel like it came FROM somewhere — not like it was applied TO something.

---

## Design Principles

### Token Architecture

Every colour traces back to primitives: foreground (text hierarchy), background (surface elevation), border (separation hierarchy), brand, and semantic (destructive, warning, success). No random hex values.

### Text Hierarchy

Four levels — primary, secondary, tertiary, muted. Each serves a different role. Use all four consistently.

### Border Progression

Scale matching intensity to importance — standard separation, softer separation, emphasis, maximum emphasis.

### Control Tokens

Dedicated tokens for control backgrounds, control borders, and focus states. Tune interactive elements independently from layout surfaces.

### Spacing

Pick a base unit and stick to multiples. Build a scale: micro (icon gaps), component (within buttons/cards), section (between groups), major (between distinct areas).

### Depth

Choose ONE approach and commit:
- **Borders-only** — Clean, technical. For dense tools.
- **Subtle shadows** — Soft lift. For approachable products.
- **Layered shadows** — Premium, dimensional. For cards that need presence.
- **Surface colour shifts** — Background tints establish hierarchy without shadows.

Do not mix approaches.

### Typography

Build distinct levels distinguishable at a glance. Headlines need weight and tight tracking. Body needs comfortable weight. Labels need medium weight at smaller sizes. Data needs monospace with tabular number spacing.

### Card Layouts

Design each card's internal structure for its specific content — but keep surface treatment consistent: same border weight, shadow depth, corner radius, padding scale.

### Navigation Context

Screens need grounding. Include navigation showing where you are, location indicators, and user context.

### Dark Mode

Shadows are less visible on dark backgrounds — lean on borders. Semantic colours often need slight desaturation. Same hierarchy system, inverted values.

---

## Sameness Is Failure

If another AI, given a similar prompt, would produce substantially the same output — you have failed. This is not about being different for its own sake. It is about the interface emerging from the specific problem, the specific user, the specific context. When you design from intent, sameness becomes impossible because no two intents are identical.

Intent must be systemic. Saying "warm" and using cold colours is not following through. If the intent is warm: surfaces, text, borders, accents, semantic colours, typography — all warm. Check your output against your stated intent. Does every token reinforce it?

---

## Avoid

- Harsh borders — if borders are the first thing you see, they are too strong
- Dramatic surface jumps — elevation changes should be whisper-quiet
- Inconsistent spacing — the clearest sign of no system
- Mixed depth strategies — pick one approach and commit
- Missing interaction states — hover, focus, disabled, loading, error
- Dramatic drop shadows
- Large radius on small elements
- Pure white cards on coloured backgrounds
- Multiple accent colours — dilutes focus
- Different hues for different surfaces — keep the same hue, shift only lightness

---

## References

For more detail on specific topics:
- `references/principles.md` — Code examples, specific values, dark mode implementation
- `references/examples.md` — Craft in action with real decision-making examples
- `references/validation.md` — Memory management, when to update system.md
- `references/critique.md` — Post-build craft critique protocol
- `references/system-template.md` — Template for system.md
- `references/system-precision.md` — Example: precision and density direction
- `references/system-warmth.md` — Example: warmth and approachability direction

---

## Evaluation Scenarios

### Scenario 1: Greenfield Dashboard — Standard Tier

**Context:** User wants to build a recipe management dashboard. PRD confirmed, architecture uses React + Tailwind. Orchestrator invokes designing-interfaces at Stage 4.

**Expected outcome:**
- Step 1: Establish intent — who (home cook, morning/evening), what (find recipe fast, plan meals), feel (warm kitchen, not clinical)
- Step 2: Domain exploration — kitchen concepts, ingredient colours, handwritten signature element, reject generic dashboard grid
- Step 3: Propose direction referencing all four outputs, user confirms
- Step 4: Produce system.md with warm stone palette, subtle shadows, soft radius, Inter font
- Step 5: Self-critique catches generic card layout, redesigns metric display
- Step 6: User approves, saved to `.interface-design/system.md`

### Scenario 2: Brownfield Admin Panel — Thorough Tier

**Context:** Existing admin panel with inconsistent UI. User wants to formalise patterns before adding new features.

**Expected outcome:**
- Extract: finds 3 different spacing scales, mixed shadow/border depth, 2 different radius scales
- Present: shows inconsistencies, infers "precision" direction from majority patterns
- Refine: user wants to keep precision direction but fix inconsistencies
- Produce: system.md formalising the intended patterns, noting what to migrate

### Scenario 3: Quick Tier — Skip

**Context:** Bug fix to an existing feature. Quick tier selected.

**Expected outcome:** Stage 4 is skipped entirely. If `.interface-design/system.md` exists, developer-agent uses it; if not, no design system is created for a bug fix.

## Success Indicators

This skill succeeds when:
- The design direction is rooted in the product's domain, not generic templates
- system.md contains enough detail for a developer-agent to implement UI without asking design questions
- The swap test passes — choices are specific to this product
- The user confirms the direction feels right for their product
- Subsequent UI chunks reference system.md tokens consistently
