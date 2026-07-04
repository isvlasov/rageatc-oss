# Core Craft Principles — Specifics

Specific values, code patterns, and implementation detail behind the SKILL.md principles.

## Surface Elevation Hierarchy

Build a numbered system:

```
Level 0: Base background (the app canvas)
Level 1: Cards, panels (same visual plane as base)
Level 2: Dropdowns, popovers (floating above)
Level 3: Nested dropdowns, stacked overlays
Level 4: Highest elevation (rare)
```

Higher elevation = slightly lighter in dark mode; slightly lighter or shadowed in light mode. Elevated surfaces need visual distinction from what is beneath them.

## Surface & Border Values

Study Vercel, Supabase, Linear — surfaces barely different but still distinguishable, borders light but not invisible.

**Surfaces:** a few percentage points of lightness per elevation step. In dark mode: surface-100 ≈ 7% lighter than base, surface-200 ≈ 9%, surface-300 ≈ 12%. You can barely see it, but you feel it.

**Borders:** low-opacity rgba — 0.05–0.12 alpha in dark mode, slightly higher in light. The border should disappear when you are not looking for it, but be findable when you need to understand the structure.

## Context-Aware Bases

Different areas can start the surface hierarchy from a different base — marketing pages darker/richer, dashboard neutral, sidebar differing from canvas. The hierarchy works the same way; it just starts elsewhere.

## Alternative Backgrounds for Depth

An inset background makes content feel recessed. Useful for empty states in data grids, code blocks, inset panels, and visual grouping without borders.

## Symmetrical Padding

TLBR must match. If top padding is 16px, left/bottom/right must also be 16px. Exception: when content naturally creates visual balance.

```css
/* Good */
padding: 16px;
padding: 12px 16px; /* Only when horizontal needs more room */

/* Bad */
padding: 24px 16px 12px 16px;
```

## Border Radius Scale

Sharper corners feel technical, rounder corners feel friendly. Build a scale — small radius for inputs and buttons, medium for cards, large for modals or containers — and use it consistently. Inconsistent radius is as jarring as inconsistent spacing.

## Depth Strategy CSS

**Borders-only** — Linear, Raycast, many developer tools: almost no shadows, subtle borders define regions.
**Subtle single shadow** — `0 1px 3px rgba(0,0,0,0.08)` is enough for gentle lift.
**Layered shadows** — Stripe, Mercury: multiple layers, cards feel like physical objects.
**Surface colour shifts** — a `#fff` card on `#f8fafc` already feels elevated, no shadow needed.

```css
/* Borders-only approach */
--border: rgba(0, 0, 0, 0.08);
--border-subtle: rgba(0, 0, 0, 0.05);
border: 0.5px solid var(--border);

/* Single shadow approach */
--shadow: 0 1px 3px rgba(0, 0, 0, 0.08);

/* Layered shadow approach */
--shadow-layered:
  0 0 0 0.5px rgba(0, 0, 0, 0.05),
  0 1px 2px rgba(0, 0, 0, 0.04),
  0 2px 4px rgba(0, 0, 0, 0.03),
  0 4px 8px rgba(0, 0, 0, 0.02);
```

## Isolated Controls

UI controls deserve container treatment — date pickers, filters, dropdowns should feel like crafted objects.

**Never use native form elements for styled UI.** Native `<select>`, `<input type="date">`, and similar render OS-native dropdowns that cannot be styled. Build custom components:

- Custom select: trigger button + positioned dropdown menu
- Custom date picker: input + calendar popover
- Custom checkbox/radio: styled div with state management

Custom select triggers must use `display: inline-flex` with `white-space: nowrap` to keep text and chevron icons on the same row.

## Iconography

Icons clarify, not decorate — if removing an icon loses no meaning, remove it. Choose one icon set and stick with it. Give standalone icons presence with subtle background containers. Icons next to text align optically, not mathematically.

## Animation

Fast and functional. Micro-interactions (hover, focus) feel instant — around 150ms. Larger transitions (modals, panels) 200–250ms. Smooth deceleration easing (ease-out variants). Avoid spring/bounce in professional interfaces — playful, not serious.

## Colour Carries Meaning

Gray builds structure. Colour communicates — status, action, emphasis, identity. Unmotivated colour is noise; colour that reinforces the product's world is character.
