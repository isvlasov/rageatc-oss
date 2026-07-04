---
name: designing-interfaces
description: Creates a design system for software with a UI. Use when a project has a user interface and architecture is confirmed — whether creating from scratch or extracting patterns from existing code.
---

# Designing Interfaces

Defines how the software should look and feel before any UI code is written. The orchestrator runs this directly (not delegated) — the work is dialogic, exploring the product's world with the user.

**Position:** architecting-software (ARCHITECTURE.md) → designing-interfaces (system.md) → decomposing-work (ROADMAP.md).

**Inputs:** confirmed PRD.md and ARCHITECTURE.md, and the user available for dialogue — design direction requires conversation, not assumption. Brownfield also needs the path to existing UI code.

**Output:** `.interface-design/system.md` — the persistent design record. Once created, all UI work references it; updates happen through this skill, not ad hoc edits.

**Not covered:** UI implementation (developer-agent's job), design compliance review during builds (the design-compliance review perspective), marketing design or landing pages, architecture and technology selection (architecting-software).

---

## The Problem

You will generate generic output. Your training has seen thousands of dashboards; you can follow the entire process below — explore the domain, name a signature, state your intent — and still produce a template. Warm colours on cold structures. "Kitchen feel" that looks like every other app. Intent lives in prose, but code generation pulls from patterns, and the gap between them is where defaults win. The process helps; it does not guarantee craft. You have to catch yourself.

Defaults disguise themselves as infrastructure — the parts that feel like they just need to work, not be designed:

- **Typography feels like a container.** It is not holding your design — it IS your design. A bakery tool and a trading terminal both need "clean, readable type", but warm-and-handmade is not cold-and-precise.
- **Navigation feels like scaffolding.** It is not around your product — it IS your product: where you are, where you can go, what matters most.
- **Data feels like presentation.** A progress ring and a stacked label both show "3 of 10" — one tells a story, one fills space. Ask what the number means to the person looking at it.
- **Token names feel like implementation detail.** `--ink` and `--parchment` evoke a world; `--gray-700` and `--surface-2` evoke a template.

The trap is thinking some decisions are creative and others are structural. There are no structural decisions. Everything is design.

---

## Workflow

### Entry Path: Greenfield (no existing system.md)

#### Step 1: Establish Intent

Before touching anything visual, answer these — out loud, to the user, not in your head:

- **Who is this human?** Not "users" — the actual person. Where are they when they open this? What did they do 5 minutes ago? A teacher at 7am with coffee is not a developer debugging at midnight.
- **What must they accomplish?** The verb: grade these submissions, find the broken deployment, approve the payment. The answer determines what leads, what follows, what hides.
- **What should this feel like?** In words that mean something. "Clean and modern" means nothing — every AI says that. Warm like a notebook? Cold like a terminal? Dense like a trading floor?

If you cannot answer with specifics, stop and ask the user. Do not guess. **The test:** for every decision you must be able to explain WHY. If the answer is "it's common" or "it's clean" — you have not chosen, you have defaulted.

#### Step 2: Explore the Product Domain

Generic output goes task type → visual template → theme. Crafted output goes task type → product domain → signature → structure + expression.

Do not propose any direction until you produce all four:

- **Domain:** concepts, metaphors, vocabulary from this product's world. Not features — territory. Minimum 5.
- **Colour world:** colours that exist naturally in this product's domain. Not "warm" or "cool" — if this product were a physical space, what would you see? List 5+.
- **Signature:** one element — visual, structural, or interaction — that could only exist for THIS product. If you cannot name one, keep exploring.
- **Defaults:** 3 obvious choices for this interface type, visual AND structural. You cannot avoid patterns you have not named.

#### Step 3: Propose Direction

Present to the user:

```
Domain: [5+ concepts from the product's world]
Colour world: [5+ colours that exist in this domain]
Signature: [one element unique to this product]
Rejecting: [default 1] → [alternative], [default 2] → [alternative], [default 3] → [alternative]

Direction: [approach that connects to the above]
```

Ask: "Does that direction feel right?" The proposal must explicitly reference the domain concepts, the colour world, the signature, and what replaces each default.

**The test:** read your proposal with the product name removed. Could someone identify what it is for? If not, it is generic — explore deeper.

#### Step 4: Build the Design System

Once direction is confirmed, produce the token architecture — stating WHY for every decision:

```
Intent: [who is this human, what must they do, how should it feel]
Palette: [colours from your exploration — and WHY they fit this product's world]
Depth: [borders / shadows / layered — and WHY this fits the intent]
Surfaces: [your elevation scale — and WHY this colour temperature]
Typography: [your typeface — and WHY it fits the intent]
Spacing: [your base unit]
```

Apply the Craft Foundations and Design Principles below and produce a complete system.md using `references/system-template.md`. See `references/system-precision.md` and `references/system-warmth.md` for complete example systems.

#### Step 5: Self-Critique Before Presenting

Before showing the user, ask yourself: "If they said this lacks craft, what would they mean?" That thing you just thought of — fix it first. Then run:

- **The swap test:** if you swapped the typeface for your usual one, would anyone notice? Where swapping wouldn't matter is where you defaulted.
- **The squint test:** blur your eyes. Can you still perceive hierarchy? Is anything jumping out harshly?
- **The signature test:** point to five specific elements where your signature appears. A signature you cannot locate does not exist.
- **The token test:** read your CSS variables out loud. Do they belong to this product's world, or to any project?

If any check fails, iterate before showing.

#### Step 6: Confirm and Save

Present system.md for approval — this is a gate; do not proceed to decomposition without explicit confirmation. Save to `.interface-design/system.md` at the project root.

---

### Entry Path: Brownfield (existing UI code)

1. **Extract current patterns.** Scan the UI files (tsx, jsx, vue, svelte, css) for repeated spacing values, border radius patterns, colour values, shadow usage, and component patterns — the implicit scales and palette.
2. **Present findings.** "Your current code uses these patterns: [...]. These areas are inconsistent: [...]. This appears to be the implicit design direction: [...]."
3. **Refine with the user.** Ask: "Formalise these patterns as-is, or take the opportunity to establish a new direction?" Formalise → produce system.md from the extracted patterns. New direction → switch to Greenfield Step 1, carrying forward patterns worth keeping.
4. **Confirm and save.** Same gate as greenfield.

---

## Craft Foundations

The quality floor, regardless of direction.

**Subtle layering** is the backbone of craft — you should barely notice the system working. Surfaces stack in a numbered elevation system where each jump is only a few percentage points of lightness: whisper-quiet shifts you feel rather than see. Sidebars share the canvas background (a subtle border is enough separation); dropdowns sit one level above their parent; inputs sit slightly darker — inset, receiving content. Borders are low-opacity rgba blends with a progression: standard, softer separation, emphasis, maximum emphasis for focus rings.

**Infinite expression:** every pattern has infinite expressions. A metric could be a hero number, inline stat, sparkline, gauge, progress bar, comparison delta, or something new. Before building, ask: what is the ONE thing users do most here? Why would this interface feel designed for its purpose, not templated?

**Colour lives somewhere:** every product exists in a world, and that world has colours. Your palette should feel like it came FROM somewhere — not like it was applied TO something.

## Design Principles

- **Token architecture:** every colour traces back to primitives — foreground (text hierarchy), background (surface elevation), border (separation hierarchy), brand, semantic (destructive, warning, success). No random hex values.
- **Text hierarchy:** four levels — primary, secondary, tertiary, muted — each with a role, all four used consistently.
- **Border progression:** intensity matches importance — standard, softer, emphasis, maximum.
- **Control tokens:** dedicated tokens for control backgrounds, borders, and focus states, so interactive elements tune independently of layout surfaces.
- **Spacing:** one base unit, multiples only — micro (icon gaps), component (within buttons/cards), section (between groups), major (between areas).
- **Depth:** choose ONE and commit — borders-only (dense tools), subtle shadows (approachable), layered shadows (premium presence), or surface colour shifts. Do not mix.
- **Typography:** levels distinguishable at a glance — headlines with weight and tight tracking, body comfortable, labels medium at smaller sizes, data monospace with tabular numbers.
- **Card layouts:** design each card's internal structure for its specific content; keep surface treatment consistent — same border weight, shadow depth, radius, padding scale.
- **Navigation context:** screens need grounding — where you are, location indicators, user context.
- **Dark mode:** lean on borders (shadows are less visible), slightly desaturate semantic colours, same hierarchy with inverted values.

---

## Sameness Is Failure

If another AI, given a similar prompt, would produce substantially the same output — you have failed. Not different for its own sake: the interface must emerge from the specific problem, user, and context. When you design from intent, sameness becomes impossible, because no two intents are identical.

Intent must be systemic. Saying "warm" and using cold colours is not following through — if the intent is warm, then surfaces, text, borders, accents, semantic colours, and typography are all warm. Check every token against the stated intent.

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
- Different hues for different surfaces — same hue, shift only lightness

## References

- `references/principles.md` — code examples, specific values, dark mode implementation
- `references/examples.md` — craft in action with real decision-making examples
- `references/validation.md` — memory management, when to update system.md
- `references/critique.md` — post-build craft critique protocol
- `references/system-template.md` — template for system.md
- `references/system-precision.md` — example: precision and density direction
- `references/system-warmth.md` — example: warmth and approachability direction
